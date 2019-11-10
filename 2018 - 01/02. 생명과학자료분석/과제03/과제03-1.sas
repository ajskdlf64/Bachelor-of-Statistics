DATA;
INPUT risk $ postpartum_depression $ count;
datalines;
1_yes a_yes 5
1_yes b_no 21
2_no a_yes 8
2_no b_no 82
;
PROC freq;
TABLES risk*postpartum_depression / MEASURES;
WEIGHT count;
RUN;
