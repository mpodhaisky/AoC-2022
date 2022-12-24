def getC():
    cubes = []
    for l in open("input.txt", "r"):
        cubes.append(tuple(map(int, l.split(","))))
    return cubes


def hex(c):
    (x, y, z) = c
    return [
        (x + 1, y, z),
        (x - 1, y, z),
        (x, y + 1, z),
        (x, y - 1, z),
        (x, y, z - 1),
        (x, y, z + 1),
    ]

def part1():
    cubes = set(getC())
    faces = [(c,s) for c in cubes for s in hex(c) 
               if s in cubes]
    print(6*len(cubes)-len(faces))           

part1()

