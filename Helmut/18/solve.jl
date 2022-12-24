fn = "input.txt"
cubes = Set(map(l->tuple(parse.(Int,split(l,','))...), readlines(open(fn,"r"))))


bd = maximum(vcat((cubes...)...)) + 1

function hexagon(xyz)
    x,y,z = xyz
    [(x+1,y,z),(x-1,y,z),(x,y+1,z),(x,y-1,z),(x,y,z+1),(x,y,z-1)]
end


function fix(ss)
    while true
        uu = expand(ss)
        println(length(uu))
        if length(uu) == length(ss)
            break
        end
        ss = uu
    end
    ss
end

ss = fix(Set([(0,0,0)]))
sol1 = Set([(s,y) for s in ss for y in hexagon(s) if y in cubes])
println(length(sol1))

function isshadow(xyz)
    !(xyz in cubes) &&  any(c in cubes for c in hexagon(xyz))
end


function incidence(face)
    c, d = face
    (c in cubes) + (d in cubes)
end 

function isouter(face)
    incidence(face) == 1
end

# part 1:

faces = Set([Set([xyz, uvw]) for xyz in cubes for uvw in hexagon(xyz)])

outside = [f for f in faces if isouter(f)]

println(length(outside))

# part 2

function isok(w)
    (x,y,z) = w
    (-1<=x<=bd) && (-1<=y<=bd) && (-1<=z<=bd) && !(w in cubes)
end

function adj(c) 
    [w for w in hexagon(c) if isok(w)]
end

function expand(ss)
    union(ss, Set(x for s in ss for x in adj(s)))
end

sol = Set()
f0 = (0,0,0)
seen = fill(false, bd+1,bd+1,bd+1)
q = [f0]
seen[1,1,1] = true
while length(q)>0
    s = popfirst!(q)
    for y in hexagon(s)
        if y in cubes
            push!(sol, (s, y))
        end
    end
    for y in adj(s)
        (u,v,w) = y
        if !seen[u+1,v+1,w+1]
            seen[u+1,v+1,w+1] = true
            push!(q,y)
        end
    end
end


function drawcubes(cc)
    join(["Cube[{"*string(x)*","*string(y)*","*string(z)*"},0.8]" for (x,y,z)
 in cc], ",\n")
end


function polygon(f)
    c, d = f
    (x,y,z) = c
    (u,v,w) = d
    a = (x+u)/2
    b = (y+v)/2
    c = (z+w)/2
    "Sphere[{"*string(a)*","*string(b)*","*string(c)*"}"*",0.08]"
end

# faces = Set(vcat([[(x,y) for y in hexagon(x) if y in cubes ] for x  in seen]...))

#=
io = open("graph", "w")
write(io, "Graphics3D[{Opacity[0.15],"* drawcubes(seen) 
            *", Opacity[0.8], "
            * drawcubes(cubes)
            * ",Opacity[1], Red," * join([polygon(f) for f in faces],",\n")
            *  "}]")
close(io)
=#

println(length(sol))

# 2263 too low
# 2424 too low
