m_ProjOld = matrix_get(matrix_projection);
m_ViewOld = matrix_get(matrix_view);

matrix_set(matrix_projection, m_Proj);
matrix_set(matrix_view, m_View);
