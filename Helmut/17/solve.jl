pat = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

PX = Set{Tuple{Int64, Int64}}

p1 = Set([(0,0),(1,0),(2,0),(3,0)]) 
p2 = Set(([(1,0),(0,1),(1,1),(2,1),(1,2)]))

function bildchen(S, p)
    yh = 45
    M = fill('.', yh,7)
    top = maximum(y for (_,y) in union(S, p))
    y0 = top - 10

    for (x,y) in p
        i = yh + y0-y 
        j = x + 1
        if 1<=i<=yh 
            M[i,j] = '@'
        end
    end
    for (x,y) in S
        i = yh + y0-y 
        j = x + 1
        if 1<=i<=yh
            M[i,j] = '#'
        end
    end
    println(top)
    println(S)
    println(p)
    println(join((join(M[i,:]) for i in 1:yh),"\n"))
    readline()
end


function addPiece!(S, pat, p)
    
    if length(S) == 0
       y1 = 0 
    else
       y1 = maximum(y for (x,y) in S)
    end
    p = Set((x+2,y+y1+3) for (x,y) in p)
    bildchen(S, p)
    for d in pat
        println(d)
        q = move(d, p)
        if !collides(q, S)
            p = q
        end
        q = move('v', p)
        if !collides(q, S)
            p = q
        end
        bildchen(S, p)
    end
    for xy in p
        push!(S, xy)
    end
end

function collides(p, S)
    any(xy in S for xy in p)
end

function move(d, p)
    a = minimum(x for (x,_) in p)
    b = maximum(x for (x,_) in p) 
    if b < 6 && d == '>'
        q = Set((x+1,y) for (x,y) in p)
    elseif a>0 && d == '<'
        q = Set((x-1, y) for (x,y) in p)
    elseif d == 'v'
        q = Set((x,y-1) for (x,y) in p)
    else 
        p
    end
end


S = Set()
addPiece!(S, pat, p1)
addPiece!(S, pat, p2)

