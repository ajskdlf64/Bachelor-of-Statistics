data one ;
	input pretest posttest @@ ;
	Diff = pretest - posttest ;
	subject = _N_ ;
datalines;
100 115 110 125 90 105 110 130 125 140 130 140 105 125
run;

proc print data = one ;
run;

proc univariate data = one ;
	var Diff;
run;

proc ttest data = one ;
	paired pretest*posttest;
run;
/* long format data */

data two ;
	do treatment = "pretest", "posttest" ;
		input strength @@ ;
		subject = _N_ ;
		output ;
	end ;
datalines;
100 115 110 125 90 105 110 130 125 140 130 140 105 125
run ;

proc print data = two;
run;

proc glm data = two ;
	class treatment subject ;
	model  strength = subject treatment ;
run;
