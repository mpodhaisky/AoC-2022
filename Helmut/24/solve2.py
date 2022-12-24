from collections import deque

tmax = 2000
bliz = dict()
bliz1 = dict()
frame = [0,0]
cs = set([">", "<", "v", "^"])


def onBoard(ijt):
    i, j, t = ijt
    ny, nx = frame
    if (i,j) in ((0, 1), (ny - 1, nx - 2)):
        return True
    return (0 < i < ny - 1) and (0 < j < nx - 1)

def step(m):
    mm = []
    ny, nx = frame
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

def adj(x):
    i, j, t = x

    yy = []
    for (di, dj) in ((0, 0), (-1, 0), (1, 0), (0, 1), (0, -1)):
        ii, jj = (i+di, j + dj)
        y = (ii, jj, t+1)
        isfree = (ii,jj) not in bliz1[t+1]
        if isfree and onBoard(y):
            yy.append(y)
    return yy

def readInput(fn):
    m = []
    for i, l in enumerate(open(fn, "r")):
        for (j, c) in enumerate(l):
            if c in cs:
                m.append((i, j, c))
    frame[0] = i + 1
    frame[1] = len(l) - 1
    for t in range(tmax):
        bliz[t] = m
        bliz1[t] = frozenset([(i,j) for (i,j,_) in m ])
        m = step(m)

def amZiel(x):
    ny, nx = frame
    i,j,t = x
    return (i,j) == (ny-1, nx-2)

def bild(ijt):
    ny, nx = frame
    i,j,t = ijt
    pos = (i,j)
    bb = {(i, j): c for (i, j, c) in bliz[t]}

    def c(ij):
        i, j = ij
        if ij in bb:
            return bb[ij]
        else:
            return "." if onBoard((i,j,0)) else "#"

    z0 = "  " + "".join(f"{j%10}" if j!= pos[1] else 'v' for j in range(nx))
    b = (
        z0
        + "\n"
        + "\n".join(
            (f"{i%10}|" if i!= pos[0] else '>|') + "".join(c((i, j)) for j in range(nx)) for i in range(ny)
        )
    )
    print(b)

def game():    
    a = (0,1,0)
    while True:
        print(a)
        bild(a)
        print("----")
        b = (a[0],a[1],a[2]+1)
        bild(b)
        yy = adj(a)
        print(f"which? v>^< {yy}")
        w = input()
        i,j,t = a
        if len(w) == 0:
            a = (i,j,t+1)
        elif w == "v":
            a = (i+1, j, t+1)
        elif w == "^":
            a = (i-1, j, t+1)
        elif w == ">":
            a = (i, j+1, t+1)
        elif w == "<":
            a = (i, j-1, t+1)
        else:
            a = (i,j,t+1)

def bfs():
    q = deque()
    aa = (0,1,0)
    q.append(aa)
    iter = 0
    while True:
        x = q.popleft()
        iter += 1
        if amZiel(x):
            print("Wir sind gewonnen!")
            print(x)
            break

        if iter % 10 == 0:
            print(x, len(q))
        for y in adj(x):
            if y not in q:
                q.append(y)
    return x[2]

readInput("input.txt")
print(bfs())
# game()