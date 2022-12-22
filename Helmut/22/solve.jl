function getInput(fn)
    txt = readlines(open(fn))
    cmd = txt[end]
    nx = length(txt[1])
    ny = length(txt)-2
    println(nx, " ", ny)
    m = fill(' ', ny+2, nx+2)
    for i in 1:ny
        for j in 1:length(txt[i])
            println(i, " ", j)
            m[i+1,j+1] = txt[i][j]
        end
    end
    m, cmd
end

function bild(m, p, d)
    m = copy(m)
    ny, nx = size(m)
    m[p...] = 'X'
    println(p, d)
    println(join([join(m[i,:]) for i in 1:ny],"\n"))
end

function move(m, p, d)
    t = p + d
    i,j = p
    println(t, " ", p, " ", d)
    println(m[t...])
    if m[t...] == '#'
        return p
    elseif m[t...] == ' '
        if d == [0,1]
            ts = [i,findfirst(m[i,:].!=' ')]
            println("DEBUG 1")
        elseif d == [0,-1]
            ts = [i,findlast(m[i,:].!=' ')]
        elseif d == [1,0]
            ts = [findfirst(m[:,j].!=' '),j]
        elseif d == [-1,0]
            ts = [findfirst(m[:,j].!=' '),j]
        else
            error("komisches d")
        end
        println("DEBUG ", ts)
        if m[ts...]=='#'
            return p
        else
            return ts
        end
    else
        return t # . oder Buchstabe
    end
end


function rotr(d)
    [0 1; -1 0]*d
end

function rotl(d)
    [0 -1; 1 0]*d
end

function part1(fn) 
    m, cmd = getInput(fn)
    println(size(m))
    p = [2,findfirst(m[2,:].!=' ')]
    d = [0,1]
        cmd1 =  split(join([join(split(x,"R")," R ") 
         for x in split(cmd, "L")], " L "))
    for token in cmd1
        println("TOKEN = ", token)
        if token == "L"
            d = rotl(d)
        elseif token == "R"
            d = rotr(d)
        else 
            l = parse(Int, token)
            for _ in 1:l
                p = move(m, p, d)
            end
        end
    end
    facing = Dict([0,1]=>0, [1,0]=>1, [0,-1]=>2,[0,-1]=>3)[d]
    println(d, " ",facing)
    sum((p .- [1,1]) .* [1000,4])+facing |> display
end

part1("input.txt") #  5340 too low
