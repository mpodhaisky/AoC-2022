function right(x, k, xs)
    i = fd(x,xs)
    n = length(xs)
    for _ in 0: k-1
        ip = mod(i, length(xs))+1
        xs[i], xs[ip] = xs[ip], xs[i]
        i = ip
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
    n = length(xs)
    for x in ys
        right(x, mod(x[2], n-1), xs)
    end
    lsg = [find0(xs, 1000)[2],find0(xs,2000)[2],find0(xs,3000)[2]]
    println(lsg, sum(lsg))
end

function part2()
    xs = collect(enumerate(811589153 * [1, 2, -3, 3, -2, 0, 4]))
    xs = collect(enumerate(811589153 * parse.(Int, readlines(open("input.txt")))))
    ys = copy(xs)
    n = length(xs)
    for _ in 1:10
        for x in ys
            right(x, mod(x[2], n-1), xs)
        end
        end
    lsg = [find0(xs, 1000)[2],find0(xs,2000)[2],find0(xs,3000)[2]]
    println(lsg, sum(lsg))
end

# -3886 wrong
part1()
part2()
