from collections import defaultdict

def demo():
    t = open("small.txt","r").readlines()
    s = defaultdict(int)
    path = []
    level = -1
    for l in t:
        depth = l.index("-")//2
        rest =  l[2*depth+2:].strip()
        xx = rest.split(" ")
        name = xx[0]
        if xx[1].startswith("(file"):
            ws = xx[2][5:].split(")")
            sz = int(ws[0])
        else:
            sz = 0
        if depth > level:
            path.append(name)
            level = level+1
        if depth < level:
            path.pop()
            level = level -1
        print(path)
        for d in path:
            s[d] += sz

    L = [s[d] for d in s if s[d]<=100000]
    print(sum(L))

t = open("input.txt","r").readlines()
s = defaultdict(int)
seen = set()
path = ["."]
for l in t:
    assert len(path)>0
    if l.startswith("$ cd /"):
        path = ["."] 
    elif l.startswith("$ cd .."):
        path.pop()
    elif l.startswith("$ cd"):
        name = l[4:].strip()
        print(name)   
        path.append(name)
    elif l.strip() == "$ ls":
        pass
    elif not l.startswith("dir"):
        print(l)
        xx = l.split(" ")
        sz = int(xx[0])
        tp = "/".join(path + [xx[1]])
        if tp not in seen:
            seen.add(tp)
            for k in range(len(path)):
                kp = "/".join(path[0:k+1])
                s[kp] += sz

    print (l, "/".join(path), s)
L = [s[d] for d in s if s[d]<=100000]
print(sum(L))
print("\n".join(f"{d} {s[d]}" for d in s))

