def f(a,b):
    return b+1 + (6 if (a,b) in [(0,1),(1,2),(2,0)] else (3 if b == a else 0) )

p = 0
for l in open("input.txt","r").readlines():
    a, b = l.strip().split(" ")
    a = ord(a)-ord('A')
    b = ord(b)-ord('X')
    if b == 0:
        b = [2,0,1][a]
    elif b == 1:
        b = a
    else:
        b = [1,2,0][a]
    p += f(a,b)

print(p)
