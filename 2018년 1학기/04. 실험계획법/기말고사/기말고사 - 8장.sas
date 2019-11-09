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
RANDOM temp material*temp / TEST;
TEST H=material temp E=material*temp;
MEANS material / SNK E=material*temp;

Contrast 'LIN_m' material -1 0 1 / E=material*temp;
Contrast 'QUAD_m' material 1 -2 1 / E=material*temp;
Estimate 'LIN_m' material -1 0 1;
Estimate 'QUAD_m' material 1 -2 1;

PROC VARCOMP method=type1;
CLASS material temp;
MODEL sales = Material | temp / FIXED=1;
RUN;
