function follow(t, h)
    d = h - t
    tt = t
    if maximum(abs.(d))>1 
        if abs(d[1]) > 0
            tt[1] += div(d[1], abs(d[1]))
        end
        if abs(d[2]) > 0
            tt[2] += div(h[2] - t[2], abs(h[2] - t[2]))
        end
    end
    tt
end

function run(fn, lenSnake)
    m = readlines(open(fn))
    h = collect([0,0] for _ in 1:lenSnake)
    seen = Set()
    push!(seen, tuple(h[lenSnake]...))
    dd = Dict("R" => [1, 0], "L" => [-1, 0], "U" => [0, 1], "D" => [0, -1])
    for (c, l) in split.(m)
        for iter in 1:parse(Int, l)
            h[1] += dd[c]
            for s in 2:lenSnake
                h[s] = follow(h[s],h[s-1])
            end
            push!(seen, tuple(h[end]...))
         end
    end
    println(length(seen))
end

run("small.txt",2)
run("input",2)
run("medium.txt",10)
run("input",10)
