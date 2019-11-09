DATA;
DO machine = 1 to 4;
DO i = 1 to 4;
INPUT strength @@;
OUTPUT;
END;
END;
CARDS;
98	97	99	96
91	90	93	92
96	95	97	95
95	96	99	98
;
PROC GLM;
CLASS machine;
MODEL strength = machine;
RANDOM machine;

PROC VARCOMP method=type1;
CLASS machine;
MODEL strength = machine;

RUN;
