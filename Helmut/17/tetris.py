def flow_():
    r = open("input.txt","tr").readline()
    pat = r.strip()
    epoch = 0
    while True:
        yield pat[epoch % len(pat)]
        epoch += 1


def nextp_():
    teile = [set([(0,0),(1,0),(2,0),(3,0)]), set([(1,0),(0,1),(1,1),(2,1),(1,2)]), 
    set([(0,0),(1,0),(2,0), (2,1),(2,2)]), set([(0,0),(0,1),(0,2),(0,3)]),
    set([(0,0),(1,0),(1,1),(0,1)])]
    ep = 0
    while True:
        yield teile[ep % 5]
        ep += 1

nextp = nextp_()
flow = flow_()


def move(s, p):
    shifts = {'>': (1,0), '<': (-1,0), 'v': (0,-1)}
    dx, dy = shifts[s]
    return set((x+dx, y+dy) for (x,y) in p)

def top(S):
    return 0 if len(S) == 0 else max(y for (_,y) in S)

def fingerprint(S):
    ny = 50
    topy = top(S)
    return set((x,y-topy+ny) for (x,y) in S if topy-y < ny)

def bildchen(S):
    ny = 50
    topy = top(S)
    B = [['.']*ny for i in range(7)]
    for (x,y) in S:
            if topy-y<ny:
                B[x][topy-y] = '#'
    return ("\n".join(["".join(B[i]) for i in range(7)]))

def collides(p, S):
    links = min(x for (x,_) in p)<0
    rechts = max(x for (x,_) in p)>6
    return any((x,y) in S for (x,y) in p) or links or rechts

def addPiece(S):
    p = nextp.__next__()
    topy = top(S)
    dy = topy + 4
    p = set((x+2,y+dy) for (x,y) in p)

    for c in flow:
        # print("-------",c, top(S))
        # bildchen(S,p)
        # input()
        q = move(c, p)
        if not(collides(q, S)):
            p = q
        q = move('v', p)
        if collides(q, S):
            break
        else:
            p = q
        if min(y for (_,y) in p) == 0:
            break
    S.update(p)
    S = set((x,y) for (x,y) in S if topy - y<100)
    return S 

def dectectCycleLength(S):
    for k in range(1,20):
        z0 = bildchen(S)
        top0 = top(S)
        print("checke nun auf Zyklus der Länge <= ", 2**k)
        for t in range(2**k):
            S = addPiece(S)
            z1 = bildchen(S)
            if z0 == z1:
                d = top(S)-top0
                print("Aha", t, d)
                return t+1, d 

S = set()

T, d = dectectCycleLength(S)

t0 = 5000
tt = 10**12

# nextp = nextp_()
# flow = flow_()
# S = set()
# for _ in range(tt):
#     S = addPiece(S)
# print(top(S))

nextp = nextp_()
flow = flow_()
S = set()
for _ in range(t0+(tt-t0)%T):
    S = addPiece(S)
ss = ((tt - t0) // T)
speedup = d * ss  
print(top(S) + speedup+1)
