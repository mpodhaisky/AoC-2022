from collections import defaultdict

t = open("input.txt", "r").readlines()
s = defaultdict(int)
path = ["."]
for l in t:
    if l.startswith("$ cd /"):
        path = ["."]
    elif l.startswith("$ cd .."):
        path.pop()
    elif l.startswith("$ cd"):
        name = l[4:].strip()
        path.append(name)
    elif l.strip() == "$ ls":
        pass
    elif not l.startswith("dir"):
        xx = l.split(" ")
        sz = int(xx[0])
        tp = "/".join(path + [xx[1]])
        for k in range(len(path)):
            kp = "/".join(path[0 : k + 1])
            s[kp] += sz

print(sum(s[d] for d in s if s[d] <= 100000))
bd = 70000000 - s["."]
print(min(s[d] for d in s if s[d] + bd >= 30000000))
