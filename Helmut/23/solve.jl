using DataStructures

function getinput(fn)
    m = readlines(open(fn))
    nx = length(m[1])
    ny = length(m)
    elves = Set()
    for i in 1:ny
        for j in 1:nx
            if m[i][j]=='#'
                push!(elves, (i,j))
            end
        end
    end
    elves
end

function bild(elves)
    elves |> display
    xs = [j for (_,j) in elves]
    ys = [i for (i,_) in elves]
    x0 = minimum(xs)
    y0 = minimum(ys)
    x1 = maximum(xs)
    y1 = maximum(ys)
    (x0,x1,y0,y1) |> display
    M = fill('.', y1-y0+1, x1-x0+1)
    for p in elves
        i, j = p
        M[i-y0+1, j-x0+1]='#'
    end

    println(join([join(M[i-y0+1,:]) for i in y0:y1],"\n"))
end



function main(fn)
    elves = getinput(fn)
    bild(elves)
    println(elves, "  ---")
    elves_ = Set()
    for p in elves
        (i,j) = p
        N = (i-1,j)
        NE = (i-1, j+1)
        NW = (i-1, j-1)
        S = (i+1, j)
        SE = (i+1, j+1)
        SW = (i+1, j-1)
        W = (i, j-1)
        E = (i, j+1)
        if isdisjoint(elves, Set([N, NE, NW]))
            q = N
        elseif isdisjoint(elves, Set([S, SE, SW]))
            q = S
        elseif isdisjoint(elves, Set([W, NW, SW]))
            q = W
        elseif isdisjoint(elves, Set([E, NE, SE]))
            q = E
        else
            q = p
        end
        println(p , " -> ", q)
        push!(elves_, q)
    end
    elves = elves_
    println(elves)
    bild(elves)
end

main("tiny.txt")
