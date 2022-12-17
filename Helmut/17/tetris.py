def flow_():
    r = open("input.txt","tr").readline()
    pat = r.strip()
    print(len(pat))
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

def bildchen(S, p):
    ny = 15
    topy = top(S.union(p))
    B = [['.']*7 for i in range(ny)]
    for e, c in zip((S,p),('#','@')):
        for (x,y) in e:
            if topy-y<ny:
                B[topy-y][x] = c
    print("\n".join(["".join(B[i]) for i in range(ny)]))

def collides(p, S):
    links = min(x for (x,_) in p)<0
    rechts = max(x for (x,_) in p)>6
    return any((x,y) in S for (x,y) in p) or links or rechts

def addPiece(S):
    p = nextp.__next__()
    dy = top(S) + 4
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

S = set()

for _ in range(2022):
    addPiece(S)

print(top(S)+1)