/// @description  GenBuffer(surf, [w], [h]);
/// @function  GenBuffer
/// @param surf
/// @param [w]
/// @param [h]
var s = argument[0];

if( !surface_exists(s) ) {
    var q = (argument_count == 1);
    var z = (argument_count == 3);
    
    var t = surface_create(q ? 1024 : argument[1], 
                           q ? 540  : (z ? argument[2] : argument[1]));
    
    if( argument_count > 3 && argument[3] ) {
        surface_set_target(t);
            
            draw_clear(0);
            
        surface_reset_target();show_debug_message(t);
    }
    
    return t;
}

return s;
