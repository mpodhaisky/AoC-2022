function inst()
    cmds = readlines(open("input"))
    v = [1]
    for c in cmds
        push!(v,0)
        if startswith(c,"addx")
           push!(v, parse(Int, c[5:end]))
        end
    end
    v
end
v = inst()
s = (1:length(v)).*cumsum(v)
sum(s[[20,60,100,140,180,220]])
