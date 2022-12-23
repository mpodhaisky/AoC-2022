cost = Int[4 0 0 0; 2 0 0 0; 3 14 0 0; 2 0 7 0]

tend = 18

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
    rr = r + bots
    t1 = t + 1
    # println(t, " ", r, bots)
    # w = readline()
    # println(w)
    best = backtrack(t1, rr, bots, bestsofar)
    for k = 1:4
	rr = r + bots - cost[k,:]
	bbots = copy(bots)
	bbots[k] += 1
	if all(rr.>=0)
            best = max(best, backtrack(t1, rr, bbots, best))
        end
    end
    return best
end

backtrack(0, Int[0, 0, 0, 0], Int[1, 0, 0, 0], Int[0, 0, 0, 0])
