
function mix(x, xs)
    p = indexin(x, xs)[1]
    dest = mod(p+xs[p]-1, length(xs)-1)+1
    println(x, "moves from ", p , " to ", dest)
    if dest > p
        vcat(xs[1:p-1],xs[p+1:dest], x, xs[dest+1:end])
    elseif  dest == 1
        vcat(xs[1:p-1], xs[p+1:end] , x)
    else 
        vcat(xs[1:dest-1], x, xs[dest:p-1], xs[p+1:end])
    end
end

function main(xs)
    y = copy(xs)
    for x in xs
        y = mix(x, y)
        display(y')
    end
    println(sum([kth(1000, y), kth(2000, y), kth(3000,y)]))
end

function kth(k, xs)
    p = indexin(0, xs)[1]
    i = p + k
    xs[mod(i-1, length(xs))+1]
end


small = [1, 2, -3, 3, -2, 0, 4]

main(small)  

#large =  parse.(Int, readlines(open("input.txt")))
#main(large)

# -21179 wrong