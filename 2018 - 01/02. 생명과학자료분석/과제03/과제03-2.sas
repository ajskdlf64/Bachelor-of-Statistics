DATA;
INPUT cancer $ drug $ count;
datalines;
1_yes a_yes 273
1_yes b_no 716
2_no a_yes 2641
2_no b_no 7260
;
PROC freq;
TABLES drug*cancer / MEASURES;
WEIGHT count;
RUN;
