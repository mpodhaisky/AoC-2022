def getC():
    cubes = []
    for l in open("inputdönne.txt", "r"):
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
    faces = [(c, s) for c in cubes for s in hex(c) if s in cubes]
    print(6 * len(cubes) - len(faces))


def ok(p):
    bd = 21
    x, y, z = p
    return (-1 <= x <= bd + 1) and (-1 <= y <= bd + 1) and (-1 <= z <= bd + 1)


def part2():
    cubes = set(getC())
    water = [(-1, -1, -1)]
    seen = set(water)
    while len(water) > 0:
        print(len(seen), len(water))
        water = set(
            [
                p
                for w in water
                for p in hex(w)
                if p not in cubes and p not in seen and ok(p)
            ]
        )
        seen.update(water)
    faces = [(c,w) for c in cubes for w in hex(c) if w in seen]
    print(len(faces))

part1()
part2()
