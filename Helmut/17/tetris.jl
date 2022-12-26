using Base.Iterators

function readPieces()
    [Set([(0,0),(1,0),(2,0),(3,0)]), Set([(1,0),(0,1),(1,1),(2,1),(1,2)]), 
    Set([(0,0),(1,0),(2,0), (2,1),(2,2)]), Set([(0,0),(0,1),(0,2),(0,3)]),
    Set([(0,0),(1,0),(1,1),(0,1)])]
end



function tetris(flow, P, npieces)
    flow = Iterators.Stateful(cycle(flow))
    pp = Iterators.Stateful(cycle(P))
    board = Set{Tuple{Int,Int}}()
    for i in 0:6
        push!(board, (i,-1))
    end
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
    end
    maximum([y for (x,y) in board])+1
end

fn = "input.txt"
flow = strip(read(open(fn), String))

P = readPieces()

tetris(flow, P, 2022)

