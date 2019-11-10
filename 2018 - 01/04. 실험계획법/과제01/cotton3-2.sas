data ;
  DO cotton=15 to 35 by 5;
    input strength @@;
	output;
  END;
cards;
 7  12  14  19   7
 7  17  18  25  10
15  12  18  22  11
11  18  19  19  15
 9  18  19  23  11
;
PROC GLM ;
  class cotton;
  model strength=cotton/ p;
  output  R=resid P=pred;
  means cotton/  HOVTEST DUNCAN TUKEY LSD;

 CONTRAST 'LIN' cotton -2 -1 0 1 2;  
 CONTRAST 'QUAD' cotton 2 -1 -2 -1 2;
 CONTRAST 'CUB' cotton -1 2 0 -2 1; 
 CONTRAST 'QUAR' cotton 1 -4 6 -4 1; 


PROC UNIVARIATE normal plot ;
  var resid;


PROC RANK ;
  var resid ;
  ranks rresid ;

PROC  PLOT  vpercent=50 ;
  plot   resid*pred/ vref=0 ;
  plot   resid*cotton/ vref=0 ;
  plot   resid*rresid ; 
run;
