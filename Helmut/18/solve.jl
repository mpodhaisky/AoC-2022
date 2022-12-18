fn = "small.txt"
cubes = Set(map(l->tuple(parse.(Int,split(l,','))...), readlines(open(fn,"r"))))

function adj(c)
    (x,y,z) = c
    filter(xyz->xyz in cubes, [(x+1,y,z),(x-1,y,z),(x,y+1,z),(x,y-1,z),(x,y,z+1),(x,y,z-1)])
end

edges = [(c,d) for c in cubes for d in adj(c)]

println(6*length(cubes)-length(edges))

