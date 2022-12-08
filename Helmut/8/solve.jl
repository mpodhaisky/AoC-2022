m = readlines(open("input","r"))
n = length(m)
A = hcat(map(l->parse.(Int,collect(l)),m)...)

D = zeros(Int, n, n)
B = zeros(Bool, n,n)
for i in 1:n
    for j in 1:n
        a = A[i,j]
        B[i,j] = (((i > 1) && (a > maximum(A[1:i-1,j])) ) ||
            ((i < n) && (a > maximum(A[i+1:end,j]))) ||
            ((j > 1) && (a > maximum(A[i,1:j-1]))) ||
            ((j < n) && (a > maximum(A[i,j+1:end]))) )
        dd = 1
        d = 0
        for ii in i + 1:n
            d += 1
            if A[ii,j] >= a
                break
            end
        end
        dd *= d
        d = 0
        for ii in i-1:-1:1
            d += 1
            if A[ii,j] >= a
                break
            end
        end
        dd *= d
        d = 0
        for jj in j + 1:n
            d += 1
            if A[i,jj] >= a
                break
            end
        end
        dd *= d
        d = 0
        for jj in j-1:-1:1
            d += 1
            if A[i,jj] >= a
                break
            end
        end
        D[i,j] = dd*d
    end
end
B[1,:] .= true
B[end,:] .= true
B[:,1] .= true
B[:, end] .= true

println(sum(B))
println(maximum(D))
