data ex3_1;
 input drug $ result $ count;
 datalines;
 aspirin my_y 139
 aspirin my_n 10898
 placebo my_y 239
 placebo my_n 10795
 ;
proc freq;
 tables drug*result/chisq measures;
 weight count;
run;

data ex3_2;
 input drug $ result $ count;
 datalines;
 yes my_y 73
 yes my_n 18
 no my_y 141
 no my_n 196
 ;
proc freq;
 tables drug*result/chisq measures;
 weight count;
run;
data ex3_2_1;
 input drug $ result $ count;
 datalines;
 drug m_d 73
 drug m_n 18
 no m_d 141
 no m_n 196
 ;
proc freq;
 tables drug*result/chisq measures;
 weight count;
run;

data ex3_5;
 input before $ after $ count;
 datalines;
 sat sat 23
 sat uns 7
 uns sat 18
 uns uns 12
 ;
proc freq;
 tables before*after/chisq agree;
 weight count;
run;

DATA ex3_6;
INPUT hospital $ trt $ recovery $ count @@;
CARDS;
A old yes 9 A old no 5
A new yes 11 A new no 6
B old yes 7 B old no 5
B new yes 8 B new no 3
C old yes 4 C old no 6
C new yes 7 C new no 5
D old yes 18 D old no 11
D new yes 26 D new no 4
;
PROC FREQ;
WEIGHT count;
TABLES trt*recovery/chisq;
RUN;
PROC FREQ;
WEIGHT count;
TABLES hospital*trt*recovery/CMH NOROW NOCOL;
RUN;
PROC FREQ;
WEIGHT count;
TABLES hospital*trt*recovery/CMH1 NOROW NOCOL;
RUN;
