using LinearAlgebra
using Printf 

S0 = fill(0, 24, 4)
S1 = fill(0, 24, 4)
S0[:,1] .= 0:23
S1[:,1] .= 1

M = fill(0, 24, 24)
K = fill(0, 24, 24)
for i in 3:24
    M[i,1:i-2] .= i-2:-1:1
end
for i in 1:24
    K[i,1:i] .= 1
end



C = [4 0 0 0; 2 0 0 0; 3 14 0 0 ; 2 0 7 0]


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
   A = M*X-K*X*C+S0
   R = A+K*X + S1
  # r = A[end,:]+vcat(ones(Int, 23),0)*X + [1,0,0,0]
   (A, R)
end

function Xij(i,j) 
   X = fill(0, 24, 4)
   X[i,j] = 1
   X
end
 
X = demo()
