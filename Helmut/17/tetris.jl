using Base.Iterators

function readPieces()
    P = []
    for bl in split(read(open("pieces.txt"), String),"\n\n")
        s = Set{Tuple{Int, Int}}()
        for (i,l) in enumerate(split(bl,"\n"))
            for (j,c) in enumerate(reverse(l))
                if c == '#'
                    push!(s, (j-1,i-1))
                end
            end
        end
        push!(P, s)
    end
    P
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
            println("flow ", f)
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
                println("sink")
                p = p1 
            else
                println("stuck")
                union!(board, p)
                break
            end    
        end       
    end
    board
end



flow = read(open("small.txt"), String)

P = readPieces()

board = tetris(flow, P, 3)

M = fill('.', 20,7)
for (x,y) in board
    if y>= 0 
        M[20-y,x+1] = '#'
    end
end
println(join([join(M[i,:]) for i in 1:20],"\n"))

