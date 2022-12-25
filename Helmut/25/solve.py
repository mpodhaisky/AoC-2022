val = {'=':-2,'-':-1,'2':2,'1':1,'0':0}

t = {2:"2",-1:"-",-2:"=",0:"0",1:"1"}

xx = [2, -1, -2, 0, -1, -2, -1, 2, -2, 1, 1, 1, -2, 2, 2, 0, -2, 1, 0, 0]
def u2d(uu):
    z = 0
    for d in uu:
        z = 5*z + d
    return z


def fu(x):
    w =[]
    while x > 0:
        d = x%5
        w = [d] + w
        x = x//5
    return w


def s2d(w):
    z = 0
    for d in w:
        z = 5*z + val[d]
    return z


zz = sum(s2d(w.strip()) for w in open("input.txt","r"))

print(fu(zz))

print("".join(t[d] for d in xx))