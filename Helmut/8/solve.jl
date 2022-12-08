m = readlines(open("input","r"))
n = length(m)
A = zeros(Int,n,n)

for i in 1:n
    for j in 1:n
        A[i,j] = parse(Int, m[i][j])
    end
end

B = zeros(Bool, n,n)
for i in 1:n
    for j in 1:n
        a = A[i,j]
        B[i,j] = (((i > 1) && (a > maximum(A[1:i-1,j])) ) ||
            ((i < n) && (a > maximum(A[i+1:end,j]))) ||
            ((j > 1) && (a > maximum(A[i,1:j-1]))) ||
            ((j < n) && (a > maximum(A[i,j+1:end]))) )
    end
end
B[1,:] .= true
B[end,:] .= true
B[:,1] .= true
B[:, end] .= true

println(sum(B))