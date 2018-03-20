var buff = [DepthBuffer, DiffuseBuffer, NormalBuffer, SceneBuffer, DirLightBuffer];
var l = array_length_1d(buff);
var w = 1024 / l;

for( var i = 0; i < l; i++ ) {
    draw_surface_stretched(buff[i], i * w, 0, w, w / 2);
}

draw_set_color(c_red);
draw_rectangle(0, 0, 1024, w / 2, 1);
