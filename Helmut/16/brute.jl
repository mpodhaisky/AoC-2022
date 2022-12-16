using Combinatorics

#=
const d = [1 3 2 2 3 3 6
3 1 4 2 3 5 4
2 4 1 3 2 4 7
2 2 3 1 2 4 5
3 3 2 2 1 5 6
3 5 4 4 5 1 8
6 4 7 5 6 8 1]

const r = [0 3 13 20 2 21 22]

=#

const d = [ 1 5 6 3 10 8 3 8 7 8 3 8 6 5 4 4
5 1 6 5 12 10 5 10 11 4 3 9 8 7 8 3
6 6 1 6 13 11 6 11 12 9 4 4 9 4 9 6
3 5 6 1 8 6 4 6 7 8 5 6 4 3 6 3
10 12 13 8 1 3 10 5 8 15 12 13 5 10 7 10
8 10 11 6 3 1 8 3 6 13 10 11 3 8 5 8
3 5 6 4 10 8 1 8 7 8 3 9 6 6 4 4
8 10 11 6 5 3 8 1 6 13 10 11 3 8 5 8
7 11 12 7 8 6 7 6 1 14 9 12 4 9 4 9
8 4 9 8 15 13 8 13 14 1 6 12 11 10 11 6
3 3 4 5 12 10 3 10 9 6 1 7 8 7 6 3
8 9 4 6 13 11 9 11 12 12 7 1 9 4 11 8
6 8 9 4 5 3 6 3 4 11 8 9 1 6 3 6
5 7 4 3 10 8 6 8 9 10 7 4 6 1 8 5
4 8 9 6 7 5 4 5 4 11 6 11 3 8 1 7
4 3 6 3 10 8 4 8 9 6 3 8 6 5 7 1 ]

const r = [0 16 22 5 20 11 4 18 10 21 9 19 13 17 7 8]

function w(v)
     z = 0
     t = 0
     dr = 0
     for i in 1:length(v)-1
         dt = d[v[i],v[i+1]]
         t += d[v[i],v[i+1]]
         dr += r[v[i+1]]
         z += (30-t)*r[v[i+1]]
     end
     (z,t,dr)
end
function brute()
    best = (0,0)
    for omega in combinations(2:length(r), 5)
        for p in permutations(omega)
            q = vcat(1,p)
            z = w(q)
            if z > best
                println(z, q)
                best = z
            end
        end
    end
end

function add1(pp, tfinal)
    r = []
    for p in pp
        yy,t = p
        y = yy[end]
        for x in setdiff(1:15,yy)
            d1 = d[y,x]
            tt = t + d1
            if tt <= tfinal
                push!(r, (tuple(vcat(yy...,x)...), tt))
            end
        end
    end
    r
end

function p15()
    set15 = Set()
    q = [((1,),0)]
    set15 = union(set15,q)
    while length(q)>0
        q = add1(q, 30)
        set15 = union(set15, q)
    end
    set15
end

s15 = p15()
maximum([w(x)[1] for (x,t) in s15])


