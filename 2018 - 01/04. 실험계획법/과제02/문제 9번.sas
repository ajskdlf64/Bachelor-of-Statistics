DATA;
DO area='A','B','C','D';
DO price=200,180,160;
DO i = 1,2,3,4;
INPUT result @@;
OUTPUT;
END;
END;
END;
CARDS;
49 39 40 50            55 50 45 43             60 58 65 64
50 58 48 55            65 60 55 56             90 80 82 86
43 40 38 39            53 42 40 45             62 66 70 60
53 57 48 50            80 72 76 70             83 87 98 80
;

PROC GLM;
CLASS area price;
MODEL result=area|price;
OUTPUT R=resid P=yhat;
MEANS area price / BON HOVTEST;

PROC UNIVARIATE normal;
VAR resid;

/*ÀÜÂ÷ºÐ¼®*/
PROC GPLOT;
PLOT resid*yhat='E' / VREF=0;
TITLE '(1) Plot of resid*yhat';

PROC GPLOT;
PLOT resid*area='E' / VREF=0;
TITLE '(2) Plot of resid*area';

PROC GPLOT;
PLOT resid*price='E' / VREF=0;
TITLE '(3) Plot of resid*price';

PROC RANK;
VAR resid;
RANKS rresid;

PROC PLOT;
PLOT resid*rresid;
TITLE "(4) resid*rresid";

PROC GLM;
CLASS area price;
MODEL result=area|price /P;
OUTPUT OUT=out1 R=resid;
RUN;
