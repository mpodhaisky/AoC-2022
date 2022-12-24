cs = set([">", "<", "v", "^"])


# def adj(ijt):
#     i,j,t = ijt


def readInput(fn):
    m = []
    for i, l in enumerate(open(fn, "r")):
        for (j, c) in enumerate(l):
            if c in cs:
                m.append((i, j, c))
    return m, i+1, len(l)-1

def bliz(m):
    return set((i, j) for (i, j, _) in m)

def step(m):
    mm = []
    for (i, j, c) in m:
        if c == ">":
            mm.append((i, j % (nx - 2) + 1, c))
        if c == "<":
            mm.append((i, (j - 2) % (nx - 2) + 1, c))
        if c == "v":
            mm.append((i % (ny - 2) + 1, j, c))
        if c == "^":
            mm.append(((i - 2) % (ny - 2) + 1, j, c))
    return mm 


def bild(m, pos):
    cc = {(i,j):c for (i,j,c) in m}
    blizzard = bliz(m)
    def c(ij):
        i, j = ij
        if ij in blizzard:
            return cc[ij]
        elif ij == pos:
            return "X"
        elif i == 0 or i == ny - 1 or j == 0 or j == nx - 1:
            return "#"
        else:
            return "."

    b = "\n".join("".join(c((i, j)) for j in range(nx)) for i in range(ny))
    print(b)


m, ny, nx = readInput("tiny2.txt")

for _ in range(10):
    bild(m, (0, 1))
    input()
    m = step(m)
