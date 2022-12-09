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

function echo(m)
    for k in 1:size(m)[1]
        println(join(m[k,:],""))
    end
end

const kk = 10
const nd = 40
function main()
    m = readlines(open("input"))
    x0 = [20,20]
    h = collect(copy(x0) for _ in 1:kk)
    seen = Set()
    push!(seen, tuple(h[kk]...))
    dd = Dict("R" => [1, 0], "L" => [-1, 0], "U" => [0, 1], "D" => [0, -1])
    for (c, l) in split.(m)
        println(c,"")
        # m = fill('.',(nd,nd))
        for iter in 1:parse(Int, l)
            h[1] += dd[c]
            for s in 2:kk
                h[s] = follow(h[s],h[s-1])
            end
            push!(seen, tuple(h[kk]...))

         end
        #  for s in 1:kk
        #     m[nd+1-h[s][2],h[s][1]] = Char(47+s)
        #  end
        # #  echo(m)

    end
    print(length(seen))
end
main()
