/// @desc GPass / Camera controls
if( !window_has_focus() ) { exit; }
started ^= keyboard_check_pressed(vk_space);

#region Camera controls
var dx = (1024 / 2 - mouse_x) / 10;
var dy = (540  / 2 - mouse_y) / 10;

dir += dx;
pitch += dy;

window_mouse_set(1024 / 2, 540 / 2);

var move1 = (keyboard_check(ord("W")))
          - (keyboard_check(ord("S")));

var move2 = (keyboard_check(ord("D")))
          - (keyboard_check(ord("A")));

spd = lerp(spd, m_spd * max(abs(move1), abs(move2)), .2);

x += lengthdir_x(abs(move1) * spd, dir) * move1;
y += lengthdir_y(abs(move1) * spd, dir) * move1;
z += abs(move1) * spd * dtan(pitch) * move1;

x += lengthdir_x(abs(move2) * spd, dir - 90 * move2);
y += lengthdir_y(abs(move2) * spd, dir - 90 * move2); //*/
#endregion

#region Generate buffers
SceneBuffer    = GenBuffer(SceneBuffer   );
DepthBuffer    = GenBuffer(DepthBuffer   );
NormalBuffer   = GenBuffer(NormalBuffer  );
DiffuseBuffer  = GenBuffer(DiffuseBuffer );
DirLightBuffer = GenBuffer(DirLightBuffer, 1024, 540, true);
#endregion

BuildMatrix();

var t = max(started, 1) * current_time / 2000;
var s = 400, s2 = 40;
m_SW  = matrix_multiply(m_wrld, matrix_build(cos(t) * s, sin(t) * s, sin(t) * s2 - s2*0, 0, 0, 0, 1, 1, 1));
m_SW2 = matrix_multiply(m_wrld, matrix_build(200, 200, started*sin(t) * s2 * 4 - s2*0, 0, 0, 0, 1, 1, 1));

/*surface_set_target(DirLightBuffer);
    
    draw_clear_alpha(0, 0);
    
    shader_set(shUpdateTexture);
        
        draw_surface(DirLightBuffer, 0, 0);
        
    shader_reset();
    
surface_reset_target();*/

surface_set_target(DirLightBuffer);
    
    // We don't wanna clear texture
    // Otherwise it won't be snow 
    // any more
    //draw_clear(-1);
    
    shader_set(shCulledDepth); // P.S. Z and FarPlane values are hard coded
        
        m_ProjOld = matrix_get(matrix_projection);
        m_ViewOld = matrix_get(matrix_view);
        
        matrix_set(matrix_projection, m_proj2);
        matrix_set(matrix_view, m_view2);
        //SetMatrix();
            
            RenderWorld();
            
        ResetMatrix();
        
    shader_reset();
    
surface_reset_target();
