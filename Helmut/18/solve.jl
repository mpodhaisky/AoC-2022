fn = "small.txt"
cubes = Set(map(l->tuple(parse.(Int,split(l,','))...), readlines(open(fn,"r"))))

function hexagon(xyz)
    x,y,z = xyz
    [(x+1,y,z),(x-1,y,z),(x,y+1,z),(x,y-1,z),(x,y,z+1),(x,y,z-1)]
end

function octagon(xyz)
    x,y,z = xyz
    [(x+a,y+b,z+c) for a in (-1,0,1) for b in (-1,0,1) for c in (-1,0,1) if (a,b,c)!=(0,0,0)]
end


function isshadow(xyz)
    any(c in cubes for c in hexagon(xyz))
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

function adj(c) 
    [w for w in octagon(c) if isshadow(w)]
end


f0 = minimum(cubes)
seen = Set()
q = [f0]
while length(q)>0
    s = popfirst!(q)
    push!(seen, s)
    for y in adj(s)
        if !(y in seen)
            push!(q,y)
        end
    end
end


function drawcubes(cc)
    join(["Cube[{"*string(x)*","*string(y)*","*string(z)*"},0.8]" for (x,y,z)
 in cc], ",\n")
end


io = open("graph", "w")
write(io, "Graphics3D[{Opacity[0.2],"* drawcubes(seen) 
            *", Opacity[1], "
            * drawcubes(cubes)
            *  "}]")
close(io)

wrong = Set(vcat([[(x,y) for y in hexagon(x) if y in cubes ] for x  in seen]...))
