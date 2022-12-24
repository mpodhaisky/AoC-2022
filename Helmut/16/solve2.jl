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
            D[e,f] = if f in E[e]; 1 else infty; end 
        end
    end
    for v in keys(E)
        for e in keys(E)
            for f in keys(E)
                D[e,f] = min(D[e,f], D[e,v] + D[v,f])
            end
        end
    end
    V = [v for v in keys(R) if R[v]>0 || v == "AA"]
    D1 =  Dict{Tuple{String,String}, Integer}()
    for v in V
        for w in V
            D1[v,w] = D[v,w] + 1
        end
    end
    return V, D1, R
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


V, D , R = getinput("input.txt")

backtrack("AA", Set(), 0, V, D, R, 0, 0)