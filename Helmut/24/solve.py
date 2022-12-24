from collections import deque

cs = set([">", "<", "v", "^"])

path = set()


def onBoard(ij):
    i, j = ij
    if ij in ((0, 1), (ny - 1, nx - 2)):
        return True
    return (0 < i < ny - 1) and (0 < j < nx - 1)


def adj(m, ijt):
    i, j, t = ijt
    blizzard = bliz(m)

    yy = []
    for (di, dj) in ((0, 0), (-1, 0), (1, 0), (0, 1), (0, -1)):
        iijj = (i + di, j + dj)
        if (iijj not in blizzard) and onBoard(iijj):
            ii, jj = iijj
            yy.append((ii, jj, t +1))
    return yy


def readInput(fn):
    m = []
    for i, l in enumerate(open(fn, "r")):
        for (j, c) in enumerate(l):
            if c in cs:
                m.append((i, j, c))
    return m, i + 1, len(l) - 1


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
    cc = {(i, j): c for (i, j, c) in m}
    blizzard = bliz(m)

    print(pos, blizzard)
    def c(ij):
        i, j = ij
        if ij in blizzard:
            return cc[ij]
        elif ij == pos:
            return "X"
        else:
            return "." if onBoard(ij) else "#"

    z0 = "  " + "".join(f"{j%10}" for j in range(nx))
    b = (
        z0
        + "\n"
        + "\n".join(
            f"{i%10}|" + "".join(c((i, j)) for j in range(nx)) for i in range(ny)
        )
    )
    print(b)


m0, ny, nx = readInput("small.txt")
m = m0.copy()

q = deque()
t = 0
q.append((0,1,t))

prev = dict()
post = dict()
while True:
    x = q.popleft()
    i,j, tx = x
    if (i,j) == (ny - 1, nx - 2):
        print("Wir sind gewonnen!")
        break

    if tx > t:
        m = step(m)
        bild(m, (i,j))
        t = tx

    print(x, len(q), q)
    for y in adj(m, x):
        if y not in q:
            prev[y]=x
            q.append(y)
    
    (i,j,t) = x
    post[t] = (i,j)
    while t > 0:
        x = prev[x]
        (i,j,t) = x
        post[t] = (i,j)

tend = max(post.keys())
m = m0.copy()
for t in range(tend+1):
    bild(m, post[t])
    m = step(m)
    input()

