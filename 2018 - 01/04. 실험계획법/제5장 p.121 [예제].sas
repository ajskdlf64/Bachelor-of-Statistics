DATA;
DO color = "B", "W";
DO price = 150, 120, 100;
DO area = 1 to 5;
DO i = 1 to 2;
INPUT sales @@;
OUTPUT;
END;
END;
END;
END;
CARDS;
122 110  108 160  108 185  166 250  180 260
286 265  218 230  233 230  372 250  399 390
340 200  243 150  312 200  312 310  396 310
192 170  122 185  186 130  108 230  136 250
232 230  148 195  176 210  148 175  276 210
310 325  410 350  379 320  393 360  320 340
;
PROC GLM;
CLASS color price area;
MODEL sales = color | price | area;
OUTPUT R=resid P=yhat;
MEANS color price area / SCHEFFE;

CONTRAST "LIN_price"  price -1 0 1;
CONTRAST "QUAD_price" price 1 -2 1;
CONTRAST "LIN_area" area -2 -1 0  1 2;
CONTRAST "QUAD_area" area 2 -1 -2 -1 2;
CONTRAST "CUBIC_area" area  -1 2 0 -2 1;
CONTRAST "QUARATIC_area" area 1 -4 6 -4 1;
TITLE "Three - Way ANOVA";

PROC UNIVARIATE normal;
VAR resid;

PROC GPLOT;
PLOT resid*yhat="E" /VREF=0;
PLOT resid*color="E" /VREF=0;
PLOT resid*price="E" /VREF=0;
PLOT resid*area="E" /VREF=0;

PROC PRINT;
VAR resid sales yhat;

PROC VARCOMP method=type1;
CLASS color price area;
MODEL sales = color | price | area;


PROC GLM;
CLASS color price area;
MODEL sales = color | price | area;
RANDOM color price area color*price color*area price*area color*area*price/ TEST;

RUN;
