function addSand(m)
   q = (500,0)
   k = maximum(xy[2] for xy in keys(m))
   while q[2] <= k 
      if !((q[1],q[2]+1) in keys(m))
          q = (q[1],q[2]+1)
      elseif !((q[1]-1,q[2]+1) in keys(m))
          q = (q[1]-1,q[2]+1)
      elseif !((q[1]+1,q[2]+1) in keys(m))
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
    b = fill(' ', 10, 10)
    for i in 1:10, j in 1:10
        ii = i+494
        jj = j-1
        if (ii,jj) in keys(m) 
             b[j,i] = m[ii,jj]
        end
    end

    for i in 1:10
        println(join(b[i,:]))
    end
end

function read2(xy)
    x,y = split(xy, ",")
    [parse(Int, x), parse(Int, y)]
end

m = Dict()
for l in eachline(open("input.txt"))
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

while addSand(m)
    bildchen(m)
end

println(length([v for v in values(m) if v =='o']))




    
