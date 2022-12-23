cost = Int[4 0 0 0; 2 0 0 0; 3 14 0 0; 2 0 7 0]

tend = 20

function backtrack(t, r, bots, bestsofar)
    rr = copy(r) + bots
    if t == tend
        nbest = reverse(rr)
        if nbest > bestsofar
            println(nbest)
            return nbest
        else
            return bestsofar
        end
    end
    t1 = t + 1
    best = backtrack(t1, rr, bots, bestsofar)
    for k in 1:4
        rr = copy(r) + bots
        ck = cost[k,:]
        bbots = copy(bots)
        # println(rr, ck, "kann ", k, "kaufen ", all(rr.>=ck))
        if all(rr.>=ck)
            bbots[k] +=1
            best = max(best, backtrack(t1, rr-ck, bbots, best))
        end
    end
    return best
end

backtrack(0, Int[0, 0, 0, 0], Int[1, 0, 0, 0], Int[0, 0, 0, 0])
