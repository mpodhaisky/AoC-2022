function getinput(fn) 
    E = Dict{String, Set{String}}()
    R = Dict{String, Integer}()
    for l in readlines(open(fn))
        pat = r"Valve (..) .* rate=(\d+); .*valve.? (.*)"
        m = match(pat, l)
        if !isnothing(m)
            v = m[1]
            R[v] = parse(Int, m[2])
            E[v] = Set(string(strip(s)) for s in split(m[3],","))
        else
            error("input komisch")
        end
    end
    infty  = 1_000_0000
    D = Dict{Tuple{String,String}, Integer}()
    for e in keys(E)
        for f in keys(E)
            if e == f 
                D[e,f] = 0
            elseif f in E[e]
                D[e,f] = 1
            else
                D[e,f] = infty
            end 
        end
    end
    for v in keys(E)
        for e in keys(E)
            for f in keys(E)
                D[e,f] = min(D[e,f], D[e,v] + D[v,f])
            end
        end
    end
    V = Dict(1=>"AA")
    for (l, v) in enumerate([v for v in keys(R) if R[v]>0])
        V[l+1] = v 
    end 
    n = length(V)
    D1 =  zeros(Int, n,n)
    for i in 1:n, j in 1:n
        D1[i,j] = D[V[i],V[j]]+1
    end
    return D1, [R[V[i]] for i in 1:n]
end

function backtrack(v, seen, t, V, D, R, pr, bestSoFar)
    pr = pr + R[v] * (30-t)
    seen1 = copy(seen)
    push!(seen1, v)
    best = bestSoFar
    for w in V
        dt = D[v,w]
        if (w in seen) || t + dt >30 
            continue
        end
        best = backtrack(w,seen1, t+dt, V, D, R, pr, best)  
    end

    if pr > best
        println(seen1, pr)
        return pr
    else 
        return best
    end
end 

function pfade(omega, tfinal)
    set15 = Set()
    q = [((1,),0)]
    while length(q)>0
        q = add1(q, omega, tfinal)
        set15 = union(set15, q)
    end
    set15
end

function w(v)
    z = 0
    t = 0
    dr = 0
    for i in 1:length(v)-1
        dt = D[v[i],v[i+1]]
        t += D[v[i],v[i+1]]
        dr += R[v[i+1]]
        z += (30-t)*R[v[i+1]]
    end
    (z,t,dr)
end

function add1(pp, omega, tfinal)
    r = []
    for p in pp
        yy,t = p
        y = yy[end]
        for x in setdiff(omega, yy)
            d1 = D[y,x]
            tt = t + d1
            if tt <= tfinal
                push!(r, (tuple(vcat(yy...,x)...), tt))
            end
        end
    end
    r
end

function part1()
    omega = collect(2:15)
    println(maximum([w(x)[1] for (x,t) in pfade(omega, 30)]))
end

D, R = getinput("input.txt")
part1()

# backtrack("AA", Set(), 0, V, D, R, 0, 0)