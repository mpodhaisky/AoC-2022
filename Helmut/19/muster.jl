using LinearAlgebra
using Printf 

S0 = fill(0, 24, 4)
S1 = fill(0, 24, 4)
S0[:,1] .= 0:23
S1[:,1] .= 1

M = fill(0, 24, 24)
K = fill(0, 24, 24)
K1 = fill(0, 24, 24)
for i in 3:24
    M[i,1:i-2] .= i-2:-1:1
end
for i in 1:24
    K[i,1:i] .= 1
end
for i in 2:24
    K1[i,1:i-1] .= 1
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
   R = A+K1*X + S1
  # r = A[end,:]+vcat(ones(Int, 23),0)*X + [1,0,0,0]
   (A, R[end,4])
end

function Xij(i,j) 
   X = fill(0, 24, 4)
   X[i,j] = 1
   X
end

function ampl(i)
    open("job"*string(i)*".ampl", "w") do out
        write(out, "var x {t in 1..24, i in 1..4} binary;\n\n")
        U = Dict()
        Z = String[]
        X0 = zeros(Int, 24, 4)
        A0, r0 = cond(X0)
        if r0!=0
            push!(Z, string(r0))
        end
        for ii in 1:24
            for jj in 1:4
                U[ii,jj] = [string(A0[ii,jj])]
            end
        end

        for i in 1:24
            for j in 1:4
                A1, r1 = cond(Xij(i,j))
                A = A1-A0
                r = r1-r0
                if r != 0
                    push!(Z, @sprintf "%d * x[%d, %d]" r i j)
                end
                for ii in 1:24
                    for jj in 1:4
                        if A[ii,jj] != 0 
                            push!(U[ii,jj], @sprintf "%d * x[%d, %d]" A[ii,jj] i j )
                        end
                    end
                end
            end
        end
        write(out, "maximize z: " * join(Z, " + ")*" ;\n\n")
        for ii in 1:24
            for jj in 1:4
                write(out, @sprintf "subject to u%d_%d: %s" ii jj join(U[ii,jj]," + ")*">=0 ;\n")
            end
        end 
        write(out, 
        """
        solve; 
        for {i in 1..24} { for {j in 1..4} {printf "%1d ",x[i,j];}printf "\\n";} 
        printf "\\n\\nz = %d\\n", z;\n
        """)
    end
end

cs = readInput()
# ampl(1)
