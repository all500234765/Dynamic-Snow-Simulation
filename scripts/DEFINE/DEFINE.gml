gml_pragma("global", "DEFINE();");

#region Compiling options
#macro DEBUG 1
#macro RELEASE 0

show_debug_message("Release mode: " + (RELEASE ? "enabled" : "disabled"));
show_debug_message("Debug mode: " + (DEBUG ? "enabled" : "disabled"));

if( RELEASE && DEBUG ) {
    show_debug_message(
        "Warning: [Debug] mode and [Release] modes are both turned on!\n\t[Some errors can show not at all]"
    );
    
}

gml_release_mode(RELEASE);
#endregion

#region Formats
vertex_format_begin();
    vertex_format_add_position_3d();
    vertex_format_add_normal();
    vertex_format_add_color();
    vertex_format_add_textcoord();
global.VoxelFormat = vertex_format_end();

vertex_format_begin();
    vertex_format_add_position_3d();
    vertex_format_add_textcoord();
    vertex_format_add_color();
    vertex_format_add_normal();
global.vft_simple_3d = vertex_format_end();
#endregion

#region VBuffers
global.q = 32;
global.VB_SPHERE = vertex_buffer_build_sphere(
    global.q, global.q, global.q, -global.q, -global.q, -global.q, 2, 2, 64
);

global.VB_SPHERE_1 = vertex_buffer_build_sphere(
    -1, -1, -1, 1, 1, 1, 2, 2, 64
);

global.VB_BOX_1 = vertex_create_buffer();
vertex_begin(global.VB_BOX_1, global.vft_simple_3d);
    
    vertex_buffer_block_3D(
        global.VB_BOX_1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0
    );
    
vertex_end(global.VB_BOX_1);
#region

#endregion

#region Create Crossing Quads VBuffer VBuffer
VBUFF = vertex_create_buffer();
vertex_begin(VBUFF, global.vft_simple_3d);
    
    // Top view
    // 1-----y
    // |     |
    // z-----2
    // Side view
    // 1-----x
    // |     |
    // 3-----2
    vertex_buffer_quad(
        0, 0, 0, 
        32, 32, 0, 
        0, 0, 32, 
        c_white, 1, 
        false
    );
    
    // Top view
    // f-----2
    // |     |
    // 1-----x
    // 1-----x
    // |     |
    // 3-----2
    vertex_buffer_quad(
        32, 0, 0, 
        0, 32, 0, 
        32, 0, 32, 
        c_white, 1, 
        false
    );
    
vertex_end(VBUFF);
global.VBCrossingQuads = VBUFF;
#endregion
#endregion

