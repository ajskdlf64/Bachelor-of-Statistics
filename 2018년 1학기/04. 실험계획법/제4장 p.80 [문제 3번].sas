DATA;
DO machine = 1,2,3,4;
DO velocity = 5,10,15,20;
INPUT power @@;
OUTPUT;
END;
END;
CARDS;
8 14 14 17
4 5 6 9
5 6 9 3
6 9 2 6
;

PROC GLM;
CLASS machine velocity;
MODEL power = machine velocity;
OUTPUT OUT=out1 R=resid P=pred;
MEANS machine velocity / LSD;

CONTRAST 'LIN_machine' machine -3 -1 1 3;
CONTRAST 'QUAD_machine' machine 1 -1 -1 1;
CONTRAST 'CUBIC_machine' machine -1 3 -3 1;
CONTRAST 'LIN_velocity' velocity -1 0 1;
CONTRAST 'QUAD_velocity' velocity 1 -2 1;
CONTRAST 'CUBIC_velocity' velocity -1 3 -3 1;

PROC UNIVARIATE normal;
VAR resid;

PROC RANK;
VAR resid;
RANKS rresid;

PROC PLOT hpercent=50 vpercent=50;
PLOT resid*rresid;
PLOT resid*pred / VREF=0;
PLOT resid*machine / VREF=0;
PLOT resid*velocity / VREF=0;

PROC PRINT;
var resid power pred;
RUN;
