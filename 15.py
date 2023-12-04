from collections import defaultdict

bs = set()
xs = defaultdict(list)

for line in open(0):
    x, y, a, b = map(int, line.split(" "))
    bs.add((x, y))
    bs.add((a, b))
    d = abs(x - a) + abs(y - b)
    for i in range(d + 1):
        xs[y + i].append((x - (d - i), x + (d - i)))
        xs[y - i].append((x - (d - i), x + (d - i)))

for m in range(4000001):
    tmp = sorted(xs[m], key=lambda x: x[0])
    res = tmp[0][1] - tmp[0][0]
    cur = tmp[0][1]
    for n in tmp[1:]:
        if n[0] - 1 <= cur and n[1] > cur:
            res += n[1] - cur
            cur = n[1]
        elif n[1] <= cur:
            pass
        else:
            print(f"result: {m+4000000*(n[0]-1)}")
            break
        if cur > 4000000:
            break
