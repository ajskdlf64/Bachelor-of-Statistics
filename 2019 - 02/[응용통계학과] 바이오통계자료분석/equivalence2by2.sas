data dose_equivalence;
	input sub seq AUC period formula$ ;
	logAUC = log(AUC) ;
datalines;
 1 2 228.04 1 T
 1 2 288.79 2 R
 2 1 329.76 2 T
 2 1 339.03 1 R
 3 2 288.21 1 T
 3 2 343.37 2 R
 4 1 242.64 1 R
 4 1 258.19 2 T
 5 1 201.56 2 T
 5 1 249.94 1 R
 6 2 217.97 1 T
 6 2 225.77 2 R
 7 2 133.13 1 T
 7 2 235.89 2 R
 8 1 184.32 1 R
 8 1 249.64 2 T
 9 2 213.78 1 T
 9 2 215.14 2 R
10 2 245.48 2 R
10 2 248.98 1 T
11 2 134.89 2 R
11 2 163.93 1 T
12 1 209.3  1 R
12 1 231.98 2 T
13 1 207.4  1 R
13 1 234.19 2 T
14 2 223.39 2 R
14 2 245.92 1 T
15 1 239.84 1 R
15 1 241.25 2 T
16 1 211.24 1 R
16 1 255.6  2 T
17 2 169.7  2 R
17 2 188.05 1 T
18 1 230.36 1 R
18 1 256.55 2 T
run; 
proc glm data = dose_equivalence;
	class sub seq period formula;
	model logAUC = seq sub(seq) period formula/E;
	random sub(seq) / test ;
	lsmeans formula/pdiff cl alpha = 0.1;
    lsmeans period/pdiff cl alpha = 0.1;
run ;

