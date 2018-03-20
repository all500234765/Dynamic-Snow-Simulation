var x2 = x + dcos(dir), y2 = y - dsin(dir), z2 = z + dtan(pitch);
var l = sqrt(sqr(x2) + sqr(y2) + sqr(z2));
xn = x2 / l;
yn = y2 / l;
zn = z2 / l;

var l = sqrt(sqr(x) + sqr(y) + sqr(z));
x1n = x / l;
y1n = y / l;
z1n = z / l;

m_View = matrix_build_lookat(x, y, z, x2, y2, z2, 0, 0, 1);
m_ViewN = matrix_build_lookat(x1n, y1n, z1n, xn, yn, zn, 0, 0, 1);

//show_debug_message(m_ViewN);
//show_debug_message([dir, pitch]);
// -.3; 92.8
// dcos(0) = 1
// dsin(0) = 0
// dtan(90) = NaN = 0
