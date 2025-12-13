# Just to try out ITDS stuff

mat <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)
mat

row_major <- as.vector(t(mat))
row_major

column_major <- as.vector(mat)
column_major

mat[2,3]

row_major[1 + 1 * (4 * (2 - 1) + (3 - 1))]
column_major[1 + 1 * ((2 - 1) + 3 * (3 - 1))]
