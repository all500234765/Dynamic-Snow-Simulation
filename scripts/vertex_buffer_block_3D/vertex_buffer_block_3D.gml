/// @arg vbuff
/// @arg x1
/// @arg y1
/// @arg z1
/// @arg x2
/// @arg y2
/// @arg z2
/// @arg hrep
/// @arg vrep
/// @arg hoffset
/// @arg voffset
var ind, x1, y1, z1, x2, y2, z2, hrep, vrep, hoffset, voffset, n, ns;
ind = argument0;
x1 = argument1;
y1 = argument2;
z1 = argument3;
x2 = argument4;
y2 = argument5;
z2 = argument6;
hrep = argument7;
vrep = argument8;
hoffset = argument9;
voffset = argument10;

//East side
vertex_buffer_triangle_3D(ind, x2,y2,z1, x2,y2,z2, x2,y1,z2, hoffset,voffset+vrep,   hoffset,voffset,              hoffset+hrep,voffset)
vertex_buffer_triangle_3D(ind, x2,y1,z2, x2,y1,z1, x2,y2,z1, hoffset+ hrep,voffset,  hoffset+ hrep,voffset+ vrep,  hoffset,voffset+vrep)

//West side
vertex_buffer_triangle_3D(ind, x1,y1,z1, x1,y1,z2, x1,y2,z2, hoffset,voffset+vrep,   hoffset,voffset,              hoffset+hrep,voffset)
vertex_buffer_triangle_3D(ind, x1,y2,z2, x1,y2,z1, x1,y1,z1, hoffset+ hrep,voffset,  hoffset+ hrep,voffset+ vrep,  hoffset,voffset+vrep)  

//South size
vertex_buffer_triangle_3D(ind, x1,y2,z1, x1,y2,z2, x2,y2,z2, hoffset,voffset+vrep,   hoffset,voffset,              hoffset+hrep,voffset)
vertex_buffer_triangle_3D(ind, x2,y2,z2, x2,y2,z1, x1,y2,z1, hoffset+ hrep,voffset,  hoffset+ hrep,voffset+ vrep,  hoffset,voffset+vrep)

//North size
vertex_buffer_triangle_3D(ind, x2,y1,z1, x2,y1,z2, x1,y1,z2, hoffset,voffset+vrep,   hoffset,voffset,              hoffset+hrep,voffset)
vertex_buffer_triangle_3D(ind, x1,y1,z2, x1,y1,z1, x2,y1,z1, hoffset+ hrep,voffset,  hoffset+ hrep,voffset+ vrep,  hoffset,voffset+vrep)

//Top size
vertex_buffer_triangle_3D(ind, x1,y2,z2, x1,y1,z2, x2,y1,z2, hoffset,voffset+vrep,   hoffset,voffset,              hoffset+hrep,voffset)
vertex_buffer_triangle_3D(ind, x2,y1,z2, x2,y2,z2, x1,y2,z2, hoffset+ hrep,voffset,  hoffset+ hrep,voffset+ vrep,  hoffset,voffset+vrep)

//Bottom size
vertex_buffer_triangle_3D(ind, x1,y1,z1, x1,y2,z1, x2,y2,z1, hoffset,voffset+vrep,   hoffset,voffset,              hoffset+hrep,voffset)
vertex_buffer_triangle_3D(ind, x2,y2,z1, x2,y1,z1, x1,y1,z1, hoffset+ hrep,voffset,  hoffset+ hrep,voffset+ vrep,  hoffset,voffset+vrep)       
