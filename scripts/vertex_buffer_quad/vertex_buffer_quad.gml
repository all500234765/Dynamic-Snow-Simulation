/// @param x1
/// @param y1
/// @param z1
/// @param x2
/// @param y2
/// @param z2
/// @param x3
/// @param y3
/// @param z3
/// @param colour
/// @param alpha
/// @param UV/CreateBuff
var _x1     = argument[0];
var _y1     = argument[1];
var _z1     = argument[2];    
var _x2     = argument[3];
var _y2     = argument[4];
var _z2     = argument[5];   
var _x3     = argument[6];
var _y3     = argument[7];
var _z3     = argument[8];
var _colour = argument[9];
var _alpha  = argument[10];

var _x4 = _x3-_x1 + _x2;
var _y4 = _y3-_y1 + _y2;
var _z4 = _z3-_z1 + _z2;

var _normal = cross_product_normalised( _x2-_x1, _y2-_y1, _z2-_z1,
                                        _x3-_x1, _y3-_y1, _z3-_z1 );
var _nx = _normal[0];
var _ny = _normal[1];
var _nz = _normal[2];

NORMAL = _normal;

var UV = ( argument_count > 11 && is_array(argument[11]) ) ? argument[11] : [0, 0, 
                                                                             4, 0, 
                                                                             0, 4, 
                                                                             
                                                                             4, 0, 
                                                                             4, 4, 
                                                                             0, 4];

var q = ((argument_count > 11 && !is_array(argument[11])) ? argument[11] : !variable_instance_exists(id, "VBUFF"));
var _vbuff = q ? vertex_create_buffer() : VBUFF;
if( q ) vertex_begin( _vbuff, global.vft_simple_3d );
vertex_position_3d( _vbuff, _x1, _y1, _z1 ); vertex_texcoord( _vbuff, UV[0], UV[1] ); vertex_colour( _vbuff, _colour, _alpha ); vertex_normal( _vbuff, _nx, _ny, _nz );
vertex_position_3d( _vbuff, _x2, _y2, _z2 ); vertex_texcoord( _vbuff, UV[2], UV[3] ); vertex_colour( _vbuff, _colour, _alpha ); vertex_normal( _vbuff, _nx, _ny, _nz );
vertex_position_3d( _vbuff, _x3, _y3, _z3 ); vertex_texcoord( _vbuff, UV[4], UV[5] ); vertex_colour( _vbuff, _colour, _alpha ); vertex_normal( _vbuff, _nx, _ny, _nz );

vertex_position_3d( _vbuff, _x2, _y2, _z2 ); vertex_texcoord( _vbuff, UV[6], UV[7] ); vertex_colour( _vbuff, _colour, _alpha ); vertex_normal( _vbuff, _nx, _ny, _nz );
vertex_position_3d( _vbuff, _x4, _y4, _z4 ); vertex_texcoord( _vbuff, UV[8], UV[9] ); vertex_colour( _vbuff, _colour, _alpha ); vertex_normal( _vbuff, _nx, _ny, _nz );
vertex_position_3d( _vbuff, _x3, _y3, _z3 ); vertex_texcoord(_vbuff, UV[10], UV[11]); vertex_colour( _vbuff, _colour, _alpha ); vertex_normal( _vbuff, _nx, _ny, _nz );
if( q ) vertex_end( _vbuff );

return _vbuff;
