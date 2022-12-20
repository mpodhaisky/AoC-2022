function right(x, k, xs)
    i = indexin(x,xs)[1]
    for _ in 1:k
        ip = mod(i, length(xs))+1
        xs[i], xs[ip] = xs[ip], xs[i]
        i = ip
    end
end

function left(x, k, xs)
    i = indexin(x,xs)[1]
    for _ in 1:k
        im = mod(i-2, length(xs))+1
        xs[i], xs[im] = xs[im], xs[i]
        i = im
    end
end

function find0(xs, k)
    i = indexin(0, xs)[1]
    for _ in 1:k
        i = mod(i, length(xs))+1
    end
    xs[i]
end

function part1()
    xs = parse.(Int, readlines(open("input.txt")))
    xs = [1, 2, -3, 3, -2, 0, 4]
    ys = copy(xs)
    for x in ys
        if x > 0
            right(x, x, xs)
        elseif x<0
            left(x,-x, xs)
        end
    end
    lsg = [find0(xs, 1000),find0(xs,2000),find0(xs,3000)]
    println(lsg, sum(lsg))
    display(xs)
end
# -3886 wrong
part1()