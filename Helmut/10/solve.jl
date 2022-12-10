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
v = inst()[1:end-1]
x = cumsum(v)
s = (1:length(v)).*x
println(sum(s[[20,60,100,140,180,220]]))
crt = mod.(0:239,40)

m = fill(' ',6,40)
for i in 0:239
    p = mod(i,40)
    if x[i+1] in [p-1,p,p+1]
        m[div(i,40)+1,mod(i,40)+1] = '#'
    end
end

println(join([join(m[i+1,:]) for i in 0:5 ],"\n"))
