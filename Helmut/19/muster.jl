using LinearAlgebra
using Printf 

S = fill(0, 24, 4)
S[:,1] .= 0:23
M = fill(0, 24, 24)
for i in 2:24
    M[i,1:i-1] .= i-1:-1:1
end


function demo()
    X = fill(0, 24, 4)
    for (i,s) in enumerate(readlines(open("muster.txt")))
        if length(s)>0
            X[i, parse(Int, s)+1] = 1
        end
    end
    X
end

function cond(X)
    C = [4 0 0 0; 2 0 0 0; 3 14 0 0 ; 2 0 7 0]

    R[24,4],  M*X-X*C+S
    
end


function ampl()
    z = join([(@sprintf "%d*x[%d,4]" M[24,j] j) for j in 1:24],"+")
    z
end

X = demo()
z, R = cond(X)
