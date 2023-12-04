from collections import defaultdict


def getInput(fn):
    elves = set()
    with open(fn, "r") as f:
        for i, l in enumerate(f):
            for j, c in enumerate(l):
                if c == "#":
                    elves.add((i, j))
    return elves


def bild(elves):
    ys = [i for (i, _) in elves]
    xs = [j for (_, j) in elves]
    x0 = min(xs)
    y0 = min(ys)
    x1 = max(xs)
    y1 = max(ys)
    print("  "+"".join(f"{j%10}" for j in range(x0, x1+1)))
    print(
        "\n".join(f"{i%10}|" + 
            "".join("." if (i, j) not in elves else "#" for j in range(x0, x1 + 1))
            for i in range(y0, y1 + 1)
        )
    )
    print(elves)
    print((y1 - y0 + 1) * (x1 - x0 + 1) - len(elves))


def step(elves, k):
    nelves = set()
    N = (-1, 0)
    S = (1, 0)
    E = (0, 1)
    W = (0, -1)
    SE = (1, 1)
    SW = (1, -1)
    NE = (-1, 1)
    NW = (-1, -1)
    propose = defaultdict(int)
    ssectors = (
        (set([NW, N, NE]), N),
        (set([SW, S, SE]), S),
        (set([NW, W, SW]), W),
        (set([NE, E, SE]), E),
    )
    for phase in (0, 1):
        for e in elves:
            (i, j) = e
            achter = set(
                [
                    (i + di, j + dj)
                    for di in [-1, 0, 1]
                    for dj in [-1, 0, 1]
                    if (di, dj) != (0, 0)
                ]
            )
            if elves.isdisjoint(achter):
                nelves.add(e)
                continue
            for l in range(4):
                sec, (qi, qj) = ssectors[(k + l) % 4]
                qq = set([(i + ii, j + jj) for (ii, jj) in sec])
                q = (i + qi, j + qj)
                if qq.isdisjoint(elves):
                    if phase == 0:
                        propose[q] += 1
                    elif propose[q] == 1:
                        nelves.add(q)
                    else:
                        nelves.add(e)
                    break
            else:
                nelves.add(e) # war überall blockiert!

    return nelves


if __name__ == "__main__":
    elves = getInput("inputdönne.txt")
    for k in range(10000):
        if k % 10 == 0:
            print(k)
        nelves = step(elves, k)
        if sorted(list(nelves)) == sorted(list(elves)):
            print(k+1)
            break
        elves = nelves
    print(k+1)
   