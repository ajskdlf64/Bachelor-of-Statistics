DATA knowledge;
INPUT  id knowledge1 knowledge2 @@;
d=knowledge2-knowledge1;
CARDS;
1 104 108             2 116 118          3 84 89
4 77 71                5 61 66              6 84 83
7 81 88                8 72 76              9 61 68
10 97 95             11 84 81 
; 
PROC TTEST data=knowledge;
     PAIRED knowledge2*knowledge1;
RUN;
