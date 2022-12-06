def f(a,b):
    return b+1 + (6 if (a,b) in [(0,1),(1,2),(2,0)] else (3 if b == a else 0) )

p = 0
for l in open("input","r").readlines():
    a, b = l.strip().split(" ")
    a = ord(a)-ord('A')
    b = ord(b)-ord('X')
    p += f(a,b)

print(p)
