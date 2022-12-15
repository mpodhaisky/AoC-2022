function contain1(x, ab) 
    a,b = ab
    a<=x<=b
end

function contains(x, seg)
    any(s->contain1(x, s), seg)
end


function main()
    seg = Set()
    fn = "small.txt"; z = 10
    fn = "input.txt"; z = 2000000
    bacons = []

    for l in eachline(open(fn))
        m = match(r"x=(.+),.*y=(.+):.*x=(.+),.*y=(.+)",l)
        x,y = parse.(Int,[m[1],m[2]])
        p = parse.(Int,[m[3],m[4]])
        if p[2] == z
            push!(bacons, p[1])
        end
        d = sum(abs.([x,y] .- p))
        rd = d-abs(z-y)
        if rd >= 0
            ab = [x-rd,x+rd]
            println(x," ",y," ",p," ",ab)
            push!(seg, ab)
        end
    end 

    aa = minimum(xy[1] for xy in seg)
    bb = maximum(xy[2] for xy in seg)
    L = sort([x for x in aa:bb if contains(x, seg) && !(x in bacons)])
    println(length(L))
end
main()


