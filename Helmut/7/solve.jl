using DataStructures 

function main()
    sz = DefaultDict(0)
    p = ["."]
    for w in eachline("input.txt") 
        if startswith(w,raw"$ cd ..") 
            pop!(p)
        elseif startswith(w,raw"$ cd /")
            p = ["."]
        elseif startswith(w,raw"$ cd ") 
            push!(p, strip(w[5:end]))
        elseif startswith(w,raw"$ ls")
            # 
        elseif !startswith(w,raw"dir ")
            s, dd = split(w," ")
            for k in 1:length(p)
                pp = join(p[1:k],"/")
                sz[pp] += parse(Int, s)
            end
        end
    end
    v = values(sz)
    println(sum(x for x in v if x<=100000))
    bd = 70000000 - sz["."]
    println(minimum(x for x in v if x+bd>= 30000000))
end

main()

