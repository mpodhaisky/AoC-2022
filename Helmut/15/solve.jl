function contain1(x, ab) 
    a,b = ab
    a<=x<=b
end

function contains(x, seg)
    any(s->contain1(x, s), seg)
end

function readmap(fn)
    M = []
    for l in eachline(open(fn))
        m = match(r"x=(.+),.*y=(.+):.*x=(.+),.*y=(.+)",l)
        push!(M, parse.(Int,[m[1],m[2],m[3],m[4]]))
    end
    M
end    

function main(z, M)
    seg = Set()
    bacons = []
    for (x,y,px,py) in M
        p = [px,py]
        if px == z
            push!(bacons, px)
        end
        d = sum(abs.([x,y] .- p))
        rd = d-abs(z-y)
        if rd >= 0
            ab = [x-rd,x+rd]
            push!(seg, ab)
        end
    end 

    aa = minimum(xy[1] for xy in seg)
    bb = maximum(xy[2] for xy in seg)
    L = sort([x for x in aa:bb if contains(x, seg) && !(x in bacons)])
    println(length(L))
    seg
end
M = readmap("small.txt")
seg = main(10, M)

