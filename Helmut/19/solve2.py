import numpy as np

te = 24
M = np.zeros((te,te), dtype=int)
N = np.zeros((te,te), dtype=int)
S = np.zeros((te,4), dtype=int)

C = np.array([[4, 0, 0, 0], [2, 0, 0, 0], [3, 14, 0, 0], [2, 0, 7, 0]])

for i in range(te):
    M[i,0:i]=list(reversed(range(0,i)))
    N[i,0:i+1]=[1]*(i+1)
S[:,0] =  list(range(1,te+1))

def demo():
    X = np.zeros((24,4), dtype=int)

    for i,l in enumerate(open("muster.txt", "r")):
        if len(l)>1:
            j = int(l)
            X[i,j] = 1
    return X

def cond(X):
    R = M @ X - N @ X @ C + S
    return R

def r(X, i, j):
    return (M @ X - N @ X @ C + S)[i,j]

def X(i,j):
    xx = np.zeros((24,4), dtype=int)
    xx[i,j] = 1
    return xx

