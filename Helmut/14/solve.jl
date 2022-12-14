function addSand(m,k, part)
   q0 = (500,0)
   q = q0
   p1 = part == 1
   while (q[2] <= k + 2) && !(q0 in keys(m))
      y = q[2]
      if (p1 || (y<k+1)) && !((q[1],q[2]+1) in keys(m))
          q = (q[1],q[2]+1)
      elseif (p1||(y<k+1)) && !((q[1]-1,q[2]+1) in keys(m))
          q = (q[1]-1,q[2]+1)
      elseif (p1 ||(y<k+1)) && !((q[1]+1,q[2]+1) in keys(m))
          q = (q[1]+1,q[2]+1)
      else
          m[q] = 'o'
          return true
      end
   end
   false
end

function bildchen(m)
    println(length(m))
    sz = 20
    b = fill(' ', sz, sz)
    for i in 1:sz, j in 1:sz
        ii = i+500-div(sz,2)
        jj = j-1
        if (ii,jj) in keys(m) 
             b[j,i] = m[ii,jj]
        end
    end

    for i in 1:sz
        println(join(b[i,:]))
    end
end

function read2(xy)
    x,y = split(xy, ",")
    [parse(Int, x), parse(Int, y)]
end

function readm(fn) 
    m = Dict()
    for l in eachline(open(fn))
        pt = read2.(split(l,"->"))
        q = pt[1]
        for p in pt[2:end]
            dir = sign.(p.-q)
            m[(q[1],q[2])] = '#'
            while q != p 
                q += dir
                m[(q[1],q[2])] = '#'
            end
        end 
    end
    m
end 

function part(fn, p)
    m = readm(fn)
    k = maximum(xy[2] for xy in keys(m))
    while addSand(m,k,p)
    end
    bildchen(m)
    println(length([v for v in values(m) if v =='o']))
end

for fn in ("small.txt", "input.txt"),  p in (1,2)
    part(fn, p)
end