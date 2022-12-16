from itertools import permutations, combinations


import re

def getGraph(fn):
    V = set()
    E = dict(set())
    R = dict()
    pat = r"Valve (.*) has flow rate=(.*); .* valve.? (.*)"
    for s in open(fn,"r").readlines():
        m = re.match(pat,s)
        if m is None:
            print(s)
        else:
            v,r,ee=m.groups()
            V.add(v)
            E[v] = set(e.strip() for e in ee.split(","))
            R[v] = int(r)
    return (V, E, R)

def maleGraph(V, E, R):
    with open("graph.dot", "w") as dot:
        dot.write("digraph G{\n")
        for v in V:
            dot.write(f"{v} [label=\"{v} {R[v]}\"];\n")
            for w in E[v]:
                dot.write(f"{v}->{w};\n")
        dot.write("}")

def floyd(V,E):
    n = len(V)
    infty = 1_000_000
    D = dict()
    for i in V:
        for j in V:
            if i == j:
                D[i,i] = 0
            else:
                D[i,j] = infty
    for v in V:
        for e in E[v]:
            D[v,e] = 1
            D[e,v] = 1
    for w in V:
        for i in V:
            for j in V:
                D[i,j] = min(D[i,j], D[i,w]+D[w,j])
                D[j,i] = D[i,j]
    
    for i in V:
        for j in V:
            D[i,j] = D[i,j] + 1
    return D 

def zf(q, D, R):
    z = 0
    t = 0
    for i in range(len(q)-1):      # laufe vom Knoten i zum Knoten i+1
        t += D[q[i],q[i+1]]        # öffne Ventil
        z += (30-t)*R[q[i+1]]
    return (z, t)

def best(a, omega, b, D, R):
    bestSoFar = (-100000, 0)
    for pi in permutations(omega):
        q = (a,) + pi #  + (b,)
        z,t =  zf(q, D, R)
        if z > bestSoFar[0]:
            print(pi)
            bestSoFar = (z,t)
    return bestSoFar

def gurobi(V, d, r):
    n = len(V)
    with open("small.ampl", "w") as ampl:
        ampl.write("""
param n:= 7;
set V := 0..n;
set T := 0..27;
set ET := {i in V, j in V, t in T};
var x {(i,j,t) in ET} binary;
maximize Z:  """)
        zf = " + ".join((f"{r[j]*(30-t-d[i,j])}*x[{i},{j},{t}]" for i in V for j in V for t in range(28) if i!=j)) + ";"
        ampl.write(zf)
        ampl.write("""
subject to start: sum{j in V} x[0,j,0] = 1;
subject to flow {t in T, i in V}: sum{j in V, tt in (t+1)..27} x[i,j,tt] <= sum {j in V, tt in 0..t} x[j,i,t];
subject to bd {i in V}: sum{j in V, t in T} x[i,j,t] <=1 ;

solve;
display x;
display Z;
end;
    """)
if __name__ == "__main__":
    V, E, R = getGraph("small.txt")
    D = floyd(V, E)
    N = dict()
    for (i,v) in enumerate(["AA"] + [v for v in V if R[v]>0]):
        N[v] = i

    V = list(range(len(N))) 
    DD = dict()
    RR = dict()
    for v in N.keys():
        RR[N[v]] = R[v]
        for w in N.keys():
            DD[N[v],N[w]] = D[v,w]

    print(best(0, V[1:], -1, DD, RR))
    gurobi(V, DD, RR)

    # G = dict()
    # for omega in combinations(V[1:],6):
    #     print(omega)
    #     for b in V:
    #         G[omega, b] = best(30, 0, b, omega, DD, RR)

    