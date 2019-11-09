DATA;
INPUT sales cost adver$ @@;
CARDS;
33 1 A 35 2 A 36 3 A 40 4 A
31 1 B 35 2 B 36 3 B 38 4 B
32 1 C 32 2 C 36 3 C 36 4 C
;
PROC GLM;
CLASS cost adver;
MODEL sales = cost adver;
MEANS cost adver/ LSD ALPHA=0.01;

CONTRAST 'LIN_cost' cost -3 -1 1 3;
CONTRAST 'QUAD_cost' cost 1 -1 -1 1;
CONTRAST 'CUBIC_cost' cost -1 3 -3 1;
CONTRAST 'LIN_adver' adver -1 0 1;
CONTRAST 'QUAD_adver' adver 1 -2 1;

ESTIMATE 'LIN_cost' cost -3 -1 1 3;
ESTIMATE 'QUAD_cost' cost 1 -1 -1 1;
ESTIMATE 'CUBIC_cost' cost -1 3 -3 1;
ESTIMATE 'LIN_adver' adver -1 0 1;
ESTIMATE 'QUAD_adver' adver 1 -2 1;
RUN; 

