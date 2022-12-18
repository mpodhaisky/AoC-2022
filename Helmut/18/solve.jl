fn = "small.txt"
cubes = Set(map(l->tuple(parse.(Int,split(l,','))...), readlines(open(fn,"r"))))

function hexagon(xyz)
    x,y,z = xyz
    [(x+1,y,z),(x-1,y,z),(x,y+1,z),(x,y-1,z),(x,y,z+1),(x,y,z-1)]
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

(x0,y0,z0) = minimum(cubes)
f0 = Set([(x0,y0,z0),((x0-1), y0, z0)])

function zwoelf(u, x, y, z)
    [Set([(x,y+1,z),(u,y+1,z)]),Set([(x,y-1,z),(u,y-1,z)]),
        Set([(x,y,z+1),(u,y,z+1)]), Set([(x,y,z-1),(u,y,z-1)]),
        Set([(x,y,z), (x,y+1,z)]),Set([(x,y,z), (x,y-1,z)]),
        Set([(x,y,z), (x,y,z-1)]),Set([(x,y,z), (x,y,z+1)]),
        Set([(u,y,z), (u,y,z-1)]),Set([(u,y,z), (u,y,z+1)]),
        Set([(u,y,z), (u,y,z-1)]),Set([(u,y,z), (u,y,z+1)]),
        ] 
end

function t12(cd)
    c, d = cd
    (x,y,z) = c
    (u,v,w) = d
    Set([(y,x,z),(v,u,w)])
end

function t13(cd)
    c, d = cd
    (x,y,z) = c
    (u,v,w) = d
    Set([(z,y,x),(w,v,u)])
end


function adj(cd)
    c, d = cd
    (x,y,z) = c
    (u,v,w) = d
    
    if x!=u
        r  = zwoelf(u,x,y,z)
    elseif y!=v
        r = [t12(cd) for cd in zwoelf(v,y,x,z)]
    elseif z!=w
        r = [t13(cd) for cd in zwoelf(w,z,y,x)]
    end
    [f for f in r if isouter(f)]
end

seen = Set()
q = [f0]
while length(q)>0
    f = popfirst!(q)
    push!(seen, f)
    for g in adj(f)
        if !(g in seen)
            push!(q, g)
        end
    end
end


