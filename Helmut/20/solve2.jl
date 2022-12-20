
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

function right(x, k, xs)
    i = fd(x,xs)
    for _ in 1:k
        ip = mod(i, length(xs))+1
        xs[i], xs[ip] = xs[ip], xs[i]
        i = ip
    end
end

function left(x, k, xs)
    i = fd(x,xs)
    for _ in 1:k
        im = mod(i-2, length(xs))+1
        xs[i], xs[im] = xs[im], xs[i]
        i = im
    end
end

function find0(xs, k)
    i = fd0(xs)
    for _ in 1:k
        i = mod(i, length(xs))+1
    end
    xs[i]
end

function part1()
    xs = collect(enumerate(parse.(Int, readlines(open("input.txt")))))
    #xs = collect(enumerate([1, 2, -3, 3, -2, 0, 4]))
    ys = copy(xs)
    for x in ys
        if x[2] > 0
            right(x, x[2], xs)
        elseif x[2]<0
            left(x,-x[2], xs)
        end
    end
    lsg = [find0(xs, 1000)[2],find0(xs,2000)[2],find0(xs,3000)[2]]
    println(lsg, sum(lsg))
    display(xs)
end
# -3886 wrong
part1()