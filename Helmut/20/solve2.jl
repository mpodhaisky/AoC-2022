function right(x, k, xs)
    i = fd(x,xs)
    n = length(xs)
    for _ in 0: k-1
        ip = mod(i, length(xs))+1
        xs[i], xs[ip] = xs[ip], xs[i]
        i = ip
    end
end

function fd(x,xs)
    for (i,y) in enumerate(xs)
        if y == x
            return i
        end
    end
end

function fd0(xs)
    for (i,y) in enumerate(xs)
        if y[2] == 0
            return i
        end
    end
end


function find0(xs, k)
    i = fd0(xs)
    for _ in 1:k
        i = mod(i, length(xs))+1
    end
    xs[i]
end

function solve(part)
    fac, nrepeat = Dict(1=>(1,1), 2=>(811589153,10))[part]
    xs = collect(enumerate(fac*parse.(Int, readlines(open("input.txt")))))
    #xs = collect(enumerate(fac*[1, 2, -3, 3, -2, 0, 4]))
    ys = copy(xs)
    n = length(xs)
    for _ in 1:nrepeat
        for x in ys
            right(x, mod(x[2], n-1), xs)
        end
    end
    lsg = [find0(xs, k*1000)[2] for k in 1:3]
    println(lsg, " ", sum(lsg))
end

solve(1)
solve(2)