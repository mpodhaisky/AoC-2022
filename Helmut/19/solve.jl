cost = Int[4 0 0 0; 2 0 0 0; 3 14 0 0; 2 0 7 0]

tend = 24

function backtrack(t, r, bots, bestsofar)
    if t == tend
        nbest = reverse(r)
        if nbest > bestsofar
            println(nbest)
            return nbest
        else
            return bestsofar
        end
    end
    rr = tuple(collect(r) + collect(bots)...)
    t1 = t + 1
    println(t, " ", r, bots)
    w = readline()
    println(w)
    best = bestsofar
    if length(w) == 0
        best = backtrack(t1, rr, bots, bestsofar)
    else
    kk = parse(Int, w)+1
    println("KK", kk)
    for k = kk:kk
	rr = collect(r) + collect(bots)-cost[k,:]
        bbots = collect(bots)
	bbots[k] += 1
	println(rr, all(rr.>0))
	if all(rr.>=0)
            best = max(best, backtrack(t1, rr, bbots, best))
        end
    end
    end
    return best
end

backtrack(0, (0, 0, 0, 0), (1, 0, 0, 0), (0, 0, 0, 0))
