#region Camera
dir = 0;
pitch = 0;
spd = 0; m_spd = 2;
z = 0;

m_Identity = matrix_build_identity();
m_Proj = matrix_build_projection_perspective_fov(90, 1024 / 540, 1, 32000 / 1.25);
show_debug_message(m_Proj);

var w = 1024 * 1;
var _z = 0;
var _w = w / tesselationLevel;
var _h = w / tesselationLevel;

#region Tessalated plane
VBUFF = vertex_create_buffer();
vertex_begin(VBUFF, global.vft_simple_3d);
    
    /*
        0----2
        |    |
        | x  |
        |    |
        1----f
    */
    /*vertex_buffer_quad(-w, -w, _z, 
                       -w,  w, _z, 
                        w, -w, _z, c_white, 1);*/
    
    /*
        f----0
        |    |
        | x  |
        |    |
        2----1
    */
    /*vertex_buffer_quad( w, -w, _z, 
                        w,  w, _z, 
                       -w, -w, _z, c_white, 1);*/
    
    for( var i = 0; i < tesselationLevel; i++ ) {
        for( var j = 0; j < tesselationLevel; j++ ) {
            // 1
            var n = cross_product_normalised((i + 1) * _w - (i + 0) * _w, (j + 0) * _h - (j + 0) * _h, _z - _z, 
                                             (i + 1) * _w - (i + 0) * _w, (j + 1) * _h - (j + 0) * _h, _z - _z);
            var nx = n[0], 
                ny = n[1], 
                nz = n[2];
            
            // Top Left
            vertex_position_3d(VBUFF, (i + 0) * _w, (j + 0) * _h, _z);
            vertex_texcoord(VBUFF, (i + 0) / tesselationLevel, (j + 0) / tesselationLevel);
            vertex_color(VBUFF, c_white, 1);
            vertex_normal(VBUFF, nx, ny, nz);
            
            // Top Right
            vertex_position_3d(VBUFF, (i + 1) * _w, (j + 0) * _h, _z);
            vertex_texcoord(VBUFF, (i + 1) / tesselationLevel, (j + 0) / tesselationLevel);
            vertex_color(VBUFF, c_white, 1);
            vertex_normal(VBUFF, nx, ny, nz);
            
            // Bottom Right
            vertex_position_3d(VBUFF, (i + 1) * _w, (j + 1) * _h, _z);
            vertex_texcoord(VBUFF, (i + 1) / tesselationLevel, (j + 1) / tesselationLevel);
            vertex_color(VBUFF, c_white, 1);
            vertex_normal(VBUFF, nx, ny, nz);
            
            // 2
            var n = cross_product_normalised((i + 1) * _w - (i + 0) * _w, (j + 1) * _h - (j + 0) * _h, _z - _z, 
                                             (i + 0) * _w - (i + 0) * _w, (j + 1) * _h - (j + 0) * _h, _z - _z);
            var nx = n[0], 
                ny = n[1], 
                nz = n[2];
            
            // Top Left
            vertex_position_3d(VBUFF, (i + 0) * _w, (j + 0) * _h, _z);
            vertex_texcoord(VBUFF, (i + 0) / tesselationLevel, (j + 0) / tesselationLevel);
            vertex_color(VBUFF, c_white, 1);
            vertex_normal(VBUFF, nx, ny, nz);
            
            // Bottom Right
            vertex_position_3d(VBUFF, (i + 1) * _w, (j + 1) * _h, _z);
            vertex_texcoord(VBUFF, (i + 1) / tesselationLevel, (j + 1) / tesselationLevel);
            vertex_color(VBUFF, c_white, 1);
            vertex_normal(VBUFF, nx, ny, nz);
            
            // Bottom Left
            vertex_position_3d(VBUFF, (i + 0) * _w, (j + 1) * _h, _z);
            vertex_texcoord(VBUFF, (i + 0) / tesselationLevel, (j + 1) / tesselationLevel);
            vertex_color(VBUFF, c_white, 1);
            vertex_normal(VBUFF, nx, ny, nz);
            
            /*vertex_buffer_quad(+i * _w, -j * _h, _z, 
                               +i * _w, +j * _h, _z, 
                               -i * _w, -j * _h, _z, c_white, 1);*/
        }
    }
    
vertex_end(VBUFF);
#endregion

// 
BUFF = buffer_create_from_vertex_buffer(global.VB_BOX_1, buffer_grow, 1);
vertex_freeze(global.VB_BOX_1);
#endregion

#region GBuffer
SceneBuffer        = noone;
DepthBuffer        = noone;
NormalBuffer       = noone;
DiffuseBuffer      = noone;
DirLightBuffer     = noone;
#endregion

_DisplacementSamp = shader_get_sampler_index(shDynamicSnow, "_DisplacementSamp");
_TextureSampl     = shader_get_sampler_index(shDynamicSnow, "_TextureSampl");

#region GPU State
//gpu_set_tex_repeat(true);
/*gpu_set_tex_repeat_ext(_Diffuse, false);
gpu_set_tex_repeat_ext(_Normal , false);
gpu_set_tex_repeat_ext(_Depth  , false);*/

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
//gpu_set_tex_mip_enable(true);
/*gpu_set_tex_mip_filter(tf_anisotropic);
gpu_set_tex_max_aniso(16);*/
//gpu_set_tex_max_mip(6);

show_debug_message(json_encode(gpu_get_state()));
#endregion

TanAspect = [tan(60 / 2), 1024 / 540 * tan(60 / 2)];
//Tangent(degtorad(fovY) / 2) and aspect * Tangent(degtorad(fovY) / 2)

m_Dir = matrix_build_lookat(-200, -200, -200, 0, 0, 0, 0, 0, 1);
//_Dir = shader_get_uniform(shGPass, "_Dir");

m_proj2 = matrix_build_projection_ortho(w, w, 1, 4000);
m_view2 = matrix_build_lookat(w / 2, w / 2, _z + w / 2, 
                              w / 2 + 1, w / 2, _z - w / 2, 0, 0, 1);

m_wrld = matrix_build(w / 2, w / 2, _z, 0, 0, 0, 1, 1, 1)

/*x = w / 2;
y = w / 2;
//z = _z;

dir = 0;
pitch = 90;*/

//file_text_close(file_text_open_write("Test.shader"));

#region
#macro SHDLL "Tesellation.dll"

global.__SHFree           = external_define(SHDLL, "Free", dll_cdecl, ty_real, 0);
global.__SHReset          = external_define(SHDLL, "ShaderReset", dll_cdecl, ty_real, 0);
global.__SHHullCreate     = external_define(SHDLL, "ShaderHullCreate", dll_cdecl, ty_real, 1, ty_string);
global.__SHDomainCreate   = external_define(SHDLL, "ShaderDomainCreate", dll_cdecl, ty_real, 1, ty_string);
global.__SHGeometryCreate = external_define(SHDLL, "ShaderGeometryCreate", dll_cdecl, ty_real, 1, ty_string);
global.__SHComputeCreate  = external_define(SHDLL, "ShaderComputeCreate", dll_cdecl, ty_real, 1, ty_string);

global.__SHHullSet      = external_define(SHDLL, "ShaderHullSet", dll_cdecl, ty_real, 1, ty_real);
global.__SHDomainSet    = external_define(SHDLL, "ShaderDomainSet", dll_cdecl, ty_real, 1, ty_real);
global.__SHGeometrySet  = external_define(SHDLL, "ShaderGeometrySet", dll_cdecl, ty_real, 1, ty_real);
global.__SHComputeSet   = external_define(SHDLL, "ShaderComputeSet", dll_cdecl, ty_real, 1, ty_real);


global.__SHShaderSetResourcesFromFragmentToVertex = external_define(SHDLL, "ShaderSetResourcesFromFragmentToVertex", dll_cdecl, ty_real, 0);
global.__SHInstanced = external_define(SHDLL, "Instanced", dll_cdecl, ty_real, 2, ty_real, ty_real);
global.__SHBind      = external_define(SHDLL, "Bind", dll_cdecl, ty_real, 1, ty_string);

global.__SHInit = external_define(SHDLL, "Init", dll_cdecl, ty_real, 2, ty_string, ty_string);

devMap = os_get_info();
device = devMap[? "video_d3d11_device"];
context = devMap[? "video_d3d11_context"];

#macro SHFree external_call(global.__SHFree)
#macro SHReset external_call(global.__SHReset)
#macro SHInit external_call(global.__SHInit, device, context)

enum ShaderType {
    Hull, Domain, Geometry, Compute
}

#macro SHLocalPath environment_get_variable("LOCALAPPDATA") + "\\" + game_project_name + "\\"
#macro ShaderSetResourcesFromFragmentToVertex external_call(global.__SHShaderSetResourcesFromFragmentToVertex);

SHInit;

/*_id = external_call(global.__SHComputeCreate, SHLocalPath + "Test.shader");
show_debug_message(_id);*/
#endregion

started = !true;
_WUT = shader_get_uniform(shCulledDepth, "_WUT");
