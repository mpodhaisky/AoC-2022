blocks = split(read(open("input.txt","r"), String),"\n\n")

println(blocks[1])

pat = r"Monkey (.*):\R.*Starting items: (.*)\R.*Operation: new = (.*)\R" # (?s). .* Starting items: (.*)"

m = match(pat, blocks[1])
println(m)
