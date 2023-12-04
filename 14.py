import math


grid = set()
xmin, ymin, xmax, ymax = math.inf, math.inf, 0, 0

for line in open(0):
    x = [list(map(int, p.split(","))) for p in line.strip().split(" -> ")]
    for (x1, y1), (x2, y2) in zip(x, x[1:]):
        xmin, ymin, xmax, ymax = (
            min(xmin, x1, x2),
            min(ymin, y1, y2),
            max(xmax, x1, x2),
            max(ymax, y1, y2),
        )
        x1, x2 = sorted([x1, x2])
        y1, y2 = sorted([y1, y2])
        for x in range(x1, x2 + 1):
            for y in range(y1, y2 + 1):
                grid.add(x + y * 1j)
sand = set()
for _ in range(30000):
    drop = 500
    while drop.imag <= 171:
        if (drop + 1j) not in grid and (drop + 1j) not in sand:
            drop = drop + 1j
        elif (drop - 1 + 1j) not in grid and (drop - 1 + 1j) not in sand:
            drop = drop - 1 + 1j
        elif (drop + 1 + 1j) not in grid and (drop + 1 + 1j) not in sand:
            drop = drop + 1 + 1j
        else:
            sand.add(drop)
            break
print(len(sand))
file = open("14out.txt", "w")
for j in range(ymax + 1):
    line = ""
    for i in range(xmin, xmax + 1):
        if i == 500 and j == 0:
            line += "+"
        elif (i + j * 1j) in grid:
            line += "#"
        elif (i + j * 1j) in sand:
            line += "o"
        else:
            line += "."
    file.write(line + "\n")
