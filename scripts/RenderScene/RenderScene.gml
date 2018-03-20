// Floor
gpu_set_cullmode(cull_counterclockwise);
//shader_set_uniform_f(_V, 1);
vertex_submit(VBUFF, pr_trianglelist, sprite_get_texture(sprTextures, 0));

// Sphere
/*
matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 100, 100, 100));
    
    vertex_submit(global.VB_SPHERE_1, pr_trianglelist, sprite_get_texture(sprTextures, 1));//*/
    

// Cube
var ax = sin(current_time / 300) * 15, 
    ay = cos(current_time / 300) * 15, 
    az = sin(current_time / 300) * 15;
var scale = 4 * 200;

//shader_set_uniform_f(_V, 0);
matrix_set(matrix_world, matrix_multiply(matrix_build(0, 0, 0, ax, ay, az, 1, 1, 1), 
                         matrix_multiply(matrix_build(0, 0, 0, 0, 0, 0, scale, scale, scale), 
                                         matrix_build(400 + ax, 400 + ay, 000 + az, 0, 0, 0, 1, 1, 1))));
    
    texture_set_stage(0, sprite_get_texture(sprTextures, 2));
    //external_call(global.__SInstancing, vertex_get_number(global.VB_BOX_1), 15, buffer_get_address(BUFF));
    vertex_submit(global.VB_BOX_1, pr_trianglelist, sprite_get_texture(sprTextures, 2));
    
matrix_set(matrix_world, m_Identity);
gpu_set_cullmode(cull_noculling);
