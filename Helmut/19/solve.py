from random import random

Ore, Clay, Obsidian, Geode = (0, 1, 2, 3)
cost = {
    Ore: (4, 0, 0, 0),
    Clay: (2, 0, 0, 0),
    Obsidian: (3, 14, 0, 0),
    Geode: (2, 0, 7, 0),
}

family = {0: "Ore", 1: "Clay", 2: "Obsidian", 3: "Geode"}


def add4(xs, ys):
    return tuple(x + y for (x, y) in zip(xs, ys))


def sub4(xs, ys):
    return tuple(x - y for (x, y) in zip(xs, ys))


def isbigger(xs, ys):
    return all(x >= y for (x, y) in zip(xs, ys))


def e(k):
    return tuple([0] * (k) + [1] + [0] * (3 - k))


tend = 18

def backtrack(t, r, bots, bestsofar):
    if t == tend:
        nbest = r[3]
        if nbest > bestsofar:
            print(nbest)
            return nbest
        else:
            return bestsofar

    rr = add4(r, bots)
    t1 = t + 1
    best = backtrack(t1, rr, bots, bestsofar)
    for k in reversed(range(4)):
        ck = cost[k]
        if isbigger(rr, ck):
            best = max(best, backtrack(t1, sub4(rr, ck), 
                                        add4(bots, e(k)), best))
    return best


def simulation():
    r = (0, 0, 0, 0)
    bots = (1, 0, 0, 0)
    for t in range(24):
        r = add4(r, bots)
        for k, c in cost.items():
            if isbigger(r, c) and random() < 0.5:
                print("kaufe ", family[k])
                r = sub4(r, c)
                bots = add4(bots, e(k))
    print(r)


# simulation()
best = backtrack(0, (0, 0, 0, 0), (1, 0, 0, 0),  0)
print(best)
