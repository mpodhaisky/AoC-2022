fn = "input.txt"
cubes = Set(map(l->tuple(parse.(Int,split(l,','))...), readlines(open(fn,"r"))))

function hexagon(xyz)
    x,y,z = xyz
    [(x+1,y,z),(x-1,y,z),(x,y+1,z),(x,y-1,z),(x,y,z+1),(x,y,z-1)]
end

function incidence(face)
    c, d = face
    (c in cubes) + (d in cubes)
end 


#= 
woelf ) (u, x, y, z)
    [Set([(x,y+1,z),(u,y+1,z)]),Set([(x,y-1,z),(u,y-1,z)]),
        Set([(x,y,z+1),(u,y,z+1)]), Set([(x,y,z-1),(u,y,z-1)]),
        Set([(x,y,z), (x,y+1,z)]),Set([(x,y,z), (x,y-1,z)]),
        Set([(x,y,z), (x,y,z-1)]),Set([(x,y,z), (x,y,z+1)]),
        Set([(u,y,z), (u,y,z-1)]),Set([(u,y,z), (u,y,z+1)]),
        Set([(u,y,z), (u,y,z-1)]),Set([(u,y,z), (u,y,z+1)]),
        ] 
end
#=

faces = Set([Set([xyz, uvw]) for xyz in cubes for uvw in hexagon(xyz)])

outside = [f for f in faces if incidence(f) == 1]

(x0,y0,z0) = minimum(cubes)
f0 = Set([(x0,y0,z0),((x0-1), y0, z0)])


# part 1:
println(length(outside))
