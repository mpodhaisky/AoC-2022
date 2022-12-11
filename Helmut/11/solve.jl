

mutable struct Monkey
    items :: Vector{Int}
    operation :: Function
    p :: Int
    to1 :: Int
    to2 :: Int
end

function add(x)
    y -> x + y
end

function mul(x)
    y -> x * y
end


function getinput(fn)
    monkey = Dict()
    i = 0

    for line in eachline(open(fn))
        m = match(r"Monkey (.):", line)
        if !isnothing(m) 
            i = parse(Int,m[1])
            monkey[i] = Monkey([], x->x, 0, 0, 0)
        end
        m = match(r"Starting items: (.*)",line)
        if !isnothing(m)
            append!(monkey[i].items, parse.(Int,split(m[1],",")))
        end
        m = match(r"Operation: new = old (.*) (.*)",line)
        if !isnothing(m)
            if m[1] == "*" && m[2] == "old"
                monkey[i].operation = x->x*x
            elseif m[1] == "*" 
                monkey[i].operation = mul(parse(Int,m[2]))
            elseif m[1] == "+"
                monkey[i].operation = add(parse(Int,m[2]))
            else 
                error("not implemented")
            end
        end
        m = match(r"Test: divisible by (.*)",line)
        if !isnothing(m)
            monkey[i].p = parse(Int, m[1])
        end
        m = match(r"If true: throw to monkey (.*)",line)
        if !isnothing(m)
            monkey[i].to1 = parse(Int, m[1])
        end 
        m = match(r"If false: throw to monkey (.*)",line)
        if !isnothing(m)
            monkey[i].to2 = parse(Int, m[1])
        end

    end
    monkey
end

function rd(m,ni,dd)
    for i in sort(collect(keys(m)))
        a = m[i]
        while length(a.items)>0 
            x = popfirst!(a.items)
            ni[i] += 1
            y = a.operation(x)
            # y = div(y, 3) 
            if mod(y, a.p) == 0 
                push!(m[a.to1].items,y)
            else
                push!(m[a.to2].items,y)
            end
        end
    end
end        
function rd(m,ni,part)
    for i in 0:length(m)-1
        a = m[i]
        while length(a.items)>0 
            x = popfirst!(a.items)
            ni[i] += 1
            y = a.operation(x)
            if part == 1
                y = div(y, 3)
            end
            if mod(y, a.p) == 0 
                push!(m[a.to1].items,y)
            else
                push!(m[a.to2].items,y)
            end
        end
    end
end        

function part1()
    m = getinput("input.txt")

    ni = Dict()
    for k in keys(m)
        ni[k] = 0
    end
    for _ in 1:20
       rd(m, ni,1)
    end
    
        println(prod(sort(collect(values(ni)))[end-1:end]))
end
function part2()
    m = getinput("small.txt")

    ni = Dict()
    for k in keys(m)
        ni[k] = 0
    end
    for _ in 1:20
       rd(m, ni,2)
    end
    ni |> display
    println(prod(sort(collect(values(ni)))[end-1:end]))
end

part1()
part2() # 26748929184 too low

