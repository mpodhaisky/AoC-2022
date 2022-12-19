# glpsol --math mini.ampl

param n := 2;
set P  := 1..n;
set PP := {i in P, j in P};
param A {PP};
	
var x {(i,j) in PP } binary;

subject to one: sum {(i,j) in PP} x[i,j] <= 1;
maximize peak: sum {(i,j) in PP } A[i,j]*x[i,j];

data;
param: A :=
  1 1 2
  1 2 3 
  2 1 7
  2 2 4;
