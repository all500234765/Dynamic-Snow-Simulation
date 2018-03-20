SetMatrix();

// Render snow
shader_set(shDynamicSnow);
    
    texture_set_stage(_DisplacementSamp, surface_get_texture(DirLightBuffer));
    ShaderSetResourcesFromFragmentToVertex;
    
    texture_set_stage(_TextureSampl, sprite_get_texture(sprSnow, -1));
    
    vertex_submit(VBUFF, keyboard_check(vk_shift) ? pr_linelist : pr_trianglelist, -1);
    
shader_reset();

RenderWorld();
