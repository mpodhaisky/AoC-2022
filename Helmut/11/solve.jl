

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


function main()
    monkey = Dict()
    i = 0

    for line in eachline(open("input.txt"))
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

function rd(m,ni)
    m |> display
    for i in sort(collect(keys(m)))
        println(i, " ---- ")
        a = m[i]
        while length(a.items)>0 
            x = popfirst!(a.items)
            ni[i] += 1
            println(x)
            y = a.operation(x)
            println(y)
            y = div(y, 3)
            if mod(y, a.p) == 0 
                push!(m[a.to1].items,y)
            else
                push!(m[a.to2].items,y)
            end
        end
    end
end        

m = main()

ni = Dict()
for k in keys(m)
    ni[k] = 0
end
for _ in 1:20
rd(m, ni)
end

println(prod(sort(collect(values(ni)))[end-1:end]))


