DATA;
DO Temp= 300,400;
DO Time = 30, 40, 50;
DO Method = "A", "B", "C";
DO i = 1 to 3;
INPUT Power @@;
OUTPUT;
END; END; END; END;
CARDS;
23	24	25		27	28	26		31	32	29
36	35	36		34	38	39		33	34	35
28	24	27		35	35	34		26	27	25
24	23	28		38	36	35		34	36	39
37	39	35		34	38	36		34	36	31
26	29	25		36	37	34		28	26	24
;
PROC GLM;
CLASS Temp Time Method;
MODEL Power = Temp | Time | Method /P;
RANDOM Temp Time Temp*Time Temp*Method Time*Method Time*Temp*Method / TEST;
TEST H=Temp Time Method E=Method*Time*Temp;
OUTPUT R=resid P=yhat;
MEANS Method / SNK;

CONTRAST 'QUAD_Method'		Method 1 -2 1;
ESTIMATE 'QUAD_Method'		Method 1 -2 1;

PROC UNIVARIATE normal;
VAR resid;

PROC GPLOT;
PLOT resid*yhat='E' / vref=0;
PLOT resid*Temp='E' / vref=0;
PLOT resid*Time='E' / vref=0;
PLOT resid*Method='E' / vref=0;

PROC VARCOMP method=type1;
CLASS Temp Time Method;
MODEL Power = Temp | Time | Method /fixed=3;

PROC PRINT;
VAR resid power yhat;
RUN;
