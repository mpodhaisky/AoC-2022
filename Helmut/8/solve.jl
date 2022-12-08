m = readlines(open("input","r"))
n = length(m)
A = zeros(Int,n,n)

for i in 1:n
    for j in 1:n
        A[i,j] = parse(Int, m[i][j])
    end
end
D = zeros(Int, n, n)
B = zeros(Bool, n,n)
for i in 1:n
    for j in 1:n
        a = A[i,j]
        B[i,j] = (((i > 1) && (a > maximum(A[1:i-1,j])) ) ||
            ((i < n) && (a > maximum(A[i+1:end,j]))) ||
            ((j > 1) && (a > maximum(A[i,1:j-1]))) ||
            ((j < n) && (a > maximum(A[i,j+1:end]))) )
        d1 = 0
        d2 = 0
        d3 = 0
        d4 = 0
        for ii in i + 1:n
            if A[ii,j] < a
                d1 += 1
            else
                d1 +=1 
                break
            end
        end
        for ii in i-1:-1:1
            if A[ii,j] < a
                d2 += 1
            else
                d2 +=1 
                break
            end
        end
        for jj in j + 1:n
            if A[i,jj] < a
                d3 += 1
            else
                d3 += 1
                break
            end
        end
        for jj in j-1:-1:1
            if A[i,jj] < a
                d4 += 1
            else
                d4 += 1
                break
            end
        end
        D[i,j] = d1*d2*d3*d4
    end
end
B[1,:] .= true
B[end,:] .= true
B[:,1] .= true
B[:, end] .= true

println(sum(B))
println(maximum(D))