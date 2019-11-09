PROC GLM;
CLASS Material Temp;
MODEL Voltage = Material Temp Material*Temp;
RANDOM Temp Temp*Material	  / TEST;
TEST H=Material Temp	  E=Material*Temp;
MEANS Method / SNK;

PROC VARCOMP method=type1;
CLASS Material Temp;
MODEL Voltage = Material Temp Material*Temp; / FIXED=1;
RUN;
