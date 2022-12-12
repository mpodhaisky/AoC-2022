function adj(ij, maze)
    i,j = ij
    A = []
    n,m = size(maze)
    x = maze[ij...]
    if i>1 && maze[i-1,j]>= x - 1
        push!(A, (i-1,j))
    end 
    if i<n && maze[i+1,j]>= x - 1
        push!(A, (i+1,j))
    end 
    if j>1 && maze[i,j-1]>= x - 1
        push!(A, (i,j-1))
    end 
    if j<m && maze[i,j+1]>= x - 1
        push!(A, (i,j+1))
    end 
    A
end

function main()
    maze = Int.(hcat(collect.(readlines(open("input.txt")))...)).-Int('a')
    println(maze)
    n,m = size(maze)
    s = (0,0)
    e = (0,0)
    for i in 1:n, j in 1:m 
        if maze[i,j]== -14
            maze[i,j] = 0
            s = (i,j)
            println(s)
        elseif maze[i,j] == -28
            maze[i,j] = 26       
            e = (i,j) 
        end
    end
    
    dist = Dict()
    dist[e] = 0
    Q = [e]
    while length(Q) > 0 
        ij = popfirst!(Q)
        for y in adj(ij, maze)
            if !(y in keys(dist)) 
                dist[y] = dist[ij] + 1
                push!(Q, y)
            end
        end
    end
    
    println(dist[s])
    dist, maze    
end

d, m = main()

println(minimum([d[x[1],x[2]] for x in findall(m .== 0) if (x[1],x[2]) in keys(d)]))