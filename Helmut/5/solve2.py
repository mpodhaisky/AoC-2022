from collections import defaultdict

ex = "small.txt"
ex = "big.txt"
t = open(ex,"r").readlines()
n = t.index("\n")-1
m = max(len(s) for s in t[0:n])//4
x = defaultdict(list)
for i in range(m):
    for j in range(n):
        c = t[n-j-1][4*i+1]
        if c!=' ':
            x[i].append(c)
print(x)
for l in t[n+1:]:
    if l.startswith("move"):
        k,a,b = map(int, l.strip().split(" ")[1::2])
        tmp = []
        for _ in range(k): 
            c = x[a-1].pop()
            tmp.append(c)
        for _ in range(k):
            c = tmp.pop()
            x[b-1].append(c)


print("".join(x[k].pop() for k in range(m)))
