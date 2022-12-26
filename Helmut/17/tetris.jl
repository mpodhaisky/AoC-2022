using Base.Iterators

function readPieces()
    [Set([(0,0),(1,0),(2,0),(3,0)]), Set([(1,0),(0,1),(1,1),(2,1),(1,2)]), 
    Set([(0,0),(1,0),(2,0), (2,1),(2,2)]), Set([(0,0),(0,1),(0,2),(0,3)]),
    Set([(0,0),(1,0),(1,1),(0,1)])]
end

function fingerprint(board)
    nn = top(board)
    M = fill('.',7,80)
    for j in 1:80
        for i in 1:7
            if (i-1, nn-j) in board 
                M[i,j] = '#'
            end
        end
    end
    join([join(M[i,:]) for i in 1:7],'\n')
end

function top(board)
    maximum([y for (x,y) in board])
end

function tetris(flow, P, npieces)
    flow = Iterators.Stateful(cycle(flow))
    pp = Iterators.Stateful(cycle(P))
    board = Set{Tuple{Int,Int}}()
    for i in 0:6
        push!(board, (i,-1))
    end
    fp = ""
    top1 = 0
    for k = 1 : npieces
        y0 = maximum([y for (x,y) in board])+4
        x0 = 2
        p = Set([(x+x0,y+y0) for (x,y) in popfirst!(pp)])
        while true
            f = popfirst!(flow)
            if f == '>'
                p1 = Set([(x+1,y) for (x,y) in p])
                x1 = maximum(x for (x,_) in p1)
                if isempty(intersect(board,p1)) && x1<=6
                    p = p1
                end
            else 
                p1 = Set([(x-1,y) for (x,y) in p])
                x1 = minimum(x for (x,_) in p1)
                if isempty(intersect(board,p1)) && 0<=x1
                    p = p1
                end
            end
            p1 = Set([(x,y-1) for (x,y) in p])
            if isempty(intersect(p1, board)) 
                p = p1 
            else
                union!(board, p)
                break
            end    
        end       
        if k == 3000 
            fp = fingerprint(board)
            top1 = top(board)
        elseif k > 3000
            if fp == fingerprint(board)
                println("Zyklus ", k-3000)
                println("dH = ", top(board)-top1)
            end
        end
    end
    board
end

fn = "input.txt"
flow = strip(read(open(fn), String))

P = readPieces()

println("part1=", 1+ top(tetris(flow, P, 2022)))

tetris(flow, P, 5000)

big = 1000000000000

T = 1745
dH = 2750

# ref1 = tetris(flow, P, big) |> top
b1 = 3000 + mod(big-3000, T)
b = tetris(flow, P, b1) |> top
q = div(big-b1, T)
ref = b + q * dH 

println(ref+1)

# 1576834862364 too high

