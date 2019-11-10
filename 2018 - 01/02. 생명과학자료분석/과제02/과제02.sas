DATA amino;
DO gender = 'male' , 'female' ;
DO trt = 'trt1' , 'trt2' , 'trt3' ;
DO rep = 1,2,3,4 ;
INPUT amino @@ ;
OUTPUT ;
END;
END;
END;
CARDS;
21.5   19.6   20.9   22.8
14.5   17.4   15.0   17.8
16.0   20.3   18.5   19.3
14.8   15.6   13.5   16.4
12.1   11.4   12.7   14.5
14.4   14.7   13.8   12.0
;
RUN;

PROC ANOVA data=amino ;
CLASS gender trt ;
MODEL amino = gender trt gender*trt ;
MEANS trt / TUKEY;
RUN;




PROC GLM ;
CLASS gender trt ;
MODEL amino = gender | trt ;
OUTPUT R=resid P=yhat ;
RUN;

PROC UNIVARIATE NORMAL ;
VAR resid ;




PROC GLM ;
CLASS gender trt ;
MODEL amino = gender | trt ;
OUTPUT OUT=out1 R=resid P=pred ;
RUN;

PROC PLOT;
PLOT resid*pred/ VREF=0;
