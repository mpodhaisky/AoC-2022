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

bd = 4000000

function checkline(z, seg)
    pts = sort(collect(Set(vcat(seg...))))
    aa = Set(xy[1] for xy in seg)
    bb = Set(xy[2] for xy in seg)
    for i  in 2:length(pts)
        p = pts[i]-1 
        if !contains(p, seg) && 0<=p<= bd
            println(z + 4000000 * p)
        end
    end
end
        

function main(z, M)
    seg = Set()
    bacons = []
    for (x,y,px,py) in M
        p = [px,py]
        if py == z
            push!(bacons, px)
        end
        d = sum(abs.([x,y] .- p))
        rd = d-abs(z-y)
        if rd >= 0
            ab = [x-rd,x+rd]
            push!(seg, ab)
        end
    end 
    checkline(z, seg)
end

function small()
    M = readmap("small.txt")
    for z in 0:20
        main(z, M)
    end
end

function part2()
    M = readmap("input.txt")
    for z in 0:4_000_000
        if mod(z,100_000) == 0
            println("#")
         end
        main(z, M)
    end
end

part2()

