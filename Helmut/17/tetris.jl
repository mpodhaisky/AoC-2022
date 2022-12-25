using Base.Iterators

function readPieces()
    P = []
    for bl in split(read(open("pieces.txt"), String),"\n\n")
        s = Set{Tuple{Int, Int}}()
        for (i,l) in enumerate(split(bl,"\n"))
            for (j,c) in enumerate(reverse(l))
                if c == '#'
                    push!(s, (i-1,j-1))
                end
            end
        end
        push!(P, s)
    end
    P
end

function tetris(flow, P, k)
    fl = cycle(flow)
    pp = cycle(P)
end



flow = read(open("input.txt"), String)

P = readPieces()

tetris(flow, P, k)

