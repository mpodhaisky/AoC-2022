using LinearAlgebra
using Printf 
tend = 32

S0 = fill(0, tend, 4)
S1 = fill(0, tend, 4)
S0[:,1] .= 0:tend-1
S1[:,1] .= 1

M = fill(0, tend,tend)
K = fill(0, tend, tend)
K1 = fill(0, tend, tend)
for i in 3:tend
    M[i,1:i-2] .= i-2:-1:1
end
for i in 1:tend
    K[i,1:i] .= 1
end
for i in 2:tend
    K1[i,1:i-1] .= 1
end

function b2c(ll)
    C = fill(0, 4, 4)
    pats = [r"(\d+) ore", r"(\d+) clay", r"(\d+) obsidian", r"(\d+) geode"]
    for (i, l) in enumerate(split(ll, "cost")[2:end])
       for j in 1:4
           m = match(pats[j], l)
           if !isnothing(m)
              C[i,j] = parse(Int,m[1])
           end
        end
    end
    return C
end

function readInput(fn)
    ll = readlines(open(fn))
end


function cond(C, X)
   A = M*X-K*X*C+S0
   R = A+K1*X + S1
   (A, R)
end

function Xij(i,j) 
   X = fill(0,tend, 4)
   X[i,j] = 1
   X
end

function ampl(C)
    open("job.ampl", "w") do out
        write(out, "var x {t in 1.." * string(tend) * ", i in 1..4} binary;\n\n")
        U = Dict()
        Z = String[]
        X0 = zeros(Int, tend, 4)
        A0, R0 = cond(C, X0)
        r0 = R0[end,4]
        if r0!=0
            push!(Z, string(r0))
        end
        for ii in 1:tend
            for jj in 1:4
                U[ii,jj] = [string(A0[ii,jj])]
            end
        end

        for i in 1:tend
            for j in 1:4
                A1, R1 = cond(C, Xij(i,j))
                A = A1-A0
                r1 = R1[end, 4]
                r = r1-r0
                if r != 0
                    push!(Z, @sprintf "%d * x[%d, %d]" r i j)
                end
                for ii in 1:tend
                    for jj in 1:4
                        if A[ii,jj] != 0 
                            push!(U[ii,jj], @sprintf "%d * x[%d, %d]" A[ii,jj] i j )
                        end
                    end
                end
            end
        end
        write(out, "maximize z: " * join(Z, " + ")*" ;\n\n")
        for ii in 1:tend
            for jj in 1:4
                write(out, @sprintf "subject to u%d_%d: %s" ii jj join(U[ii,jj]," + ")*">=0 ;\n")
            end
            write(out, @sprintf "subject to only%d: x[%d,1]+x[%d,2]+x[%d,3]+x[%d,4]<=1;\n" ii ii ii ii ii)
        end 
        write(out, 
        """
        solve; 
        for {i in 1.."""*string(tend)*"""} { for {j in 1..4} {printf "%1d ",x[i,j];}printf "\\n";} 
        printf "\\n\\nz = %d\\n", z;\n
	end; 
        """)
    end
end


function main()
    cs = map(b2c, readInput("input.txt"))
    total = 0
    for (i, C) in enumerate(cs)
        ampl(C)
        output = readchomp(`glpsol "--math" "job.ampl"`)
        res = split(output,"\n")[end-1]
        println(res)
        total += parse(Int, res[4:end])*i
    end
    println(total)
end
main()
