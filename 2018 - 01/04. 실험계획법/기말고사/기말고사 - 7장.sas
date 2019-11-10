DATA;
DO material = 1 to 3;
DO temp = 10 to 30 by 10;
DO i = 1 to 4;
INPUT sales @@;
OUTPUT;
END; END; END;
CARDS;
130	155	74		180		34		40		80		75			20		70		82		58
150	188	159	126		136	122	106	115		25		70		58		45
138	110	168	160		174	120	150	139		96		104	82		60
;
PROC GLM;
CLASS material temp;
MODEL sales = Material | temp;
RANDOM material temp material*temp / TEST;
TEST H=material temp E=material*temp;

PROC VARCOMP method=type1;
CLASS material temp;
MODEL sales = Material | temp / FIXED=0;
RUN;
