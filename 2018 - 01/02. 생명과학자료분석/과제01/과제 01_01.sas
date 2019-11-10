DATA key;
INPUT fertilizer x @@;
CARDS;
1 48.2     1 54.6     1 58.3     1 47.8
1 51.4     1 52.0     1 55.2     1 49.1
1 49.9     1 52.6     2 52.3     2 57.4
2 55.6     2 53.2     2 61.3     2 58.0
2 59.8     2 54.8     2 51.2     2 46.2
; 
proc ttest;
     CLASS fertilizer;
     VAR x;
RUN;
