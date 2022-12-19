# glpsol --math mini.ampl

param tend := 5;

set T  := 1..tend;
set B  := 1..2;
set R  := 1..4;
set BRR := {j in B, k in R, i in R};

var x {t in T, i in R, j in B } binary;
var work {t in T, i in R} integer;

param c {BRR};
	
maximize total: sum {i in R} x[tend, i, 1];

subject to Work {t in 1..tend, i in R}: sum{s in 1..(t-1), j in B} x[s,i,j] = work[t,i];

data;
param: c :=
  1 1 1 4
  1 2 1 2
  1 3 1 3
  1 3 4 14
  1 4 1 2
  1 4 2 7
  2 1 1 2
  2 2 1 3
  2 3 1 3
  2 3 2 8
  2 4 1 3
  2 4 3 12 ;
 
 end
 
 
  
