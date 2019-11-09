data ex2018_2_10_1;
  input species $ gender $ amino@@; output;
datalines;
m1 m 21.5 m1 m 19.6 m1 m 20.9 m1 m 22.8 m1 f 14.8 m1 f 15.6 m1 f 13.5 m1 f 16.4
m2 m 14.5 m2 m 17.4 m2 m 15.0 m2 m 17.8 m2 f 12.1 m2 f 11.4 m2 f 12.7 m2 f 14.5
m3 m 16.0 m3 m 20.3 m3 m 18.5 m3 m 19.3 m3 f 14.4 m3 f 14.7 m3 f 13.8 m3 f 12.0
;

proc glm;
 class species;
 model amino=species;
 means species/ hovtest=bartlett welch;
run;

ods graphics on;
proc glm data=ex2018_2_10_1 plot=diagnostics;
   class species;
   model amino = species;
run;
ods graphics off;

proc glm;
 class species gender;
 model amino=gender species;
 means species/snk scheffe;
run;

ods graphics on;
proc glm data=ex2018_2_10_1 plot=diagnostics;
   class species gender;
   model amino = species gender;
run;
ods graphics off;

data ex2018_2_10;
do species='m1', 'm2', 'm3';
do gender='male', 'female';
do k=1 to 4;
  input amino@@; output;
  end; end; end;
datalines;
21.5 19.6 20.9 22.8 14.8 15.6 13.5 16.4
14.5 17.4 15.0 17.8 12.1 11.4 12.7 14.5
16.0 20.3 18.5 19.3 14.4 14.7 13.8 12.0
;
proc glm;
 class species gender;
 model amino=species gender species*gender;
run;
proc glm;
 class species gender;
 model amino=species gender;
run;
proc glm;
 class species gender;
 model amino=gender species;
 means species/ tukey duncan;
run;