fn = "small.txt"


function readg(fn)
    V = Set()
    R = Dict()
    E = Dict()
    for l in eachline(open(fn))
        # Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
        m = match(r"Valve (.+) has flow rate=(.+); tunnel.* lead.* to valve(.?) (.*)",l)
        println(m)
        v = m[1]
        push!(V, v)
        E[v] = Set([String(strip(s)) for s in split(m[4],",")])
        R[v] = parse(Int,m[2]) 
    end
    (V,E,R)
end

function adj(x, V, E, R)
    e, vv, t, g = x
    ADJ = []
    if t > 30 
        return ADJ
    end
    if !(e in vv) && R[e] > 0
        if length(vv) == 0 
            ww = tuple(e)
        else
            r = collect(vv)
            push!(r, e)
            ww  = tuple(sort(r)...)
        end
        push!(ADJ, (e, ww, t+1, g + (30-t-1)*R[e])) # Hahn aufdrehen
    end
    for ee in E[e]
        push!(ADJ, (ee, vv, t+1, g)) # just move
    end
    ADJ
end

function part1(V, E, R)
    x = ("AA",tuple(),0,0) # wo, offen/zu, zeit, globales ziel
    Q = Any[x]
    seen = Dict()
    while length(Q)>0
        x = popfirst!(Q)
        seen[x[1], join(x[2])] = (x[3], x[4])
        # println(x, " ", length(Q))
        for y in adj(x, V,E,R)
            if !haskey(seen, (y[1],join(y[2]))) 
                push!(Q, y)
            else
                tt1, gg1 = seen[y[1],join(y[2])]
                if gg1 < x[4]
                    push!(Q, y)
                end
            end
        end
    end
    seen
end
(V,E,R) = readg(fn)

seen = part1(V,E,R)