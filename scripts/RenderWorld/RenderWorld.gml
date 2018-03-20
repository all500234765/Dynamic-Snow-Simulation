// Sphere
matrix_set(matrix_world, m_SW);
    
    shader_set_uniform_f(_WUT, false);
    vertex_submit(global.VB_SPHERE, pr_trianglelist, -1);
    
matrix_set(matrix_world, m_SW2);
    
    shader_set_uniform_f(_WUT, true);
    vertex_submit(global.VB_SPHERE, pr_trianglelist, -1);
    
matrix_set(matrix_world, m_wrld);
    
    shader_set_uniform_f(_WUT, false);
    vertex_submit(global.VB_SPHERE, pr_trianglelist, -1);
    
matrix_set(matrix_world, m_Identity);

/*if( shader_current() > -1 ) { exit; }

matrix_set(matrix_world, m_wrld);
shader_set(shRWTest);
    
    shader_set_uniform_f(0, current_time / 1000);
    
    external_call(global.__SHBind, buffer_get_address(BUFF));
    external_call(global.__SHInstanced, 4, vertex_get_number(global.VB_SPHERE));
    
shader_reset();
matrix_set(matrix_world, m_Identity);
*/
