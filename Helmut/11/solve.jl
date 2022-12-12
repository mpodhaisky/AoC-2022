using DataStructures 

const PP = 2*7*3*19*5*13*11*17*23
struct Monkey
    items :: Vector{Int}
    f :: Function
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
    items = []
    f = x->x
    p = 0
    to1 = 0
    to2 = 0

    for line in eachline(open(fn))
        m = match(r"Monkey (.):", line)
        if !isnothing(m) 
            i = parse(Int,m[1])
        end
        m = match(r"Starting items: (.*)",line)
        if !isnothing(m)
            items = parse.(Int,split(m[1],","))
        end
        m = match(r"Operation: new = old (.*) (.*)",line)
        if !isnothing(m)
            if m[1] == "*" && m[2] == "old"
                f = x->x*x
            elseif m[1] == "*" 
                f = mul(parse(Int,m[2]))
            elseif m[1] == "+"
                f = add(parse(Int,m[2]))
            else 
                error("not implemented")
            end
        end
        m = match(r"Test: divisible by (.*)",line)
        if !isnothing(m)
            p = parse(Int, m[1])
        end
        m = match(r"If true: throw to monkey (.*)",line)
        if !isnothing(m)
            to1 = parse(Int, m[1])
        end 
        m = match(r"If false: throw to monkey (.*)",line)
        if !isnothing(m)
            to2 = parse(Int, m[1])
            monkey[i] = Monkey(items, f, p, to1, to2)
        end

    end
    monkey
end

function rd(m,ni,part)
    for i in 0:length(m)-1
        a = m[i]
        while length(a.items)>0 
            x = popfirst!(a.items)
            ni[i] += 1
	    y = mod(a.f(x), PP)
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

    ni = DefaultDict(0)
    for iter in 1:20
       rd(m, ni,1)
       if iter == 1
           println(m)
           println(ni)
       end
    end
    
        println(prod(sort(collect(values(ni)))[end-1:end])) # 100345
end
function part2()
    m = getinput("input.txt")

    ni = DefaultDict(0)
    for _ in 1:10000
       rd(m, ni,2)
    end
    ni |> display
    println(prod(sort(collect(values(ni)))[end-1:end]))
end

part1()
part2() # 26748929184 too low
