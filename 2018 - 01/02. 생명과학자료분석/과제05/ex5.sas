DATA ex5;
DO trt = 10 , 15 , 20;
DO i = 1 to 12;
INPUT x1 x2 y @@;
OUTPUT;
END;
END;
CARDS;
23.5 15.0 5.0     24.0 15.5 4.5     23.0 14.0 5.0
24.5 13.5 4.5     22.5 13.5 5.5     24.5 13.5 3.0
25.5 13.0 5.0     25.0 14.0 5.0     23.0 14.5 5.5
23.0 14.0 4.5     22.5 14.0 6.5      23.0 15.0 5.5
28.5 16.0 7.0     26.0 15.5 9.0     28.5 17.0 8.5
26.5 16.0 8.5     27.0 18.5 6.0     28.0 14.5 8.0
26.5 17.5 7.0     29.0 13.5 7.0     27.0 16.5 7.0
27.0 16.5 11.0     27.0 17.5 9.0     27.0 18.5 8.0
25.6 12.0 6.6     23.1 11.6 9.2     20.8 18.2 5.6
19.2 11.9 4.2     21.3 20.2 4.6     26.6 13.1 4.5
25.5 16.2 4.5     18.9 11.9 6.1     29.3 10.5 6.3
30.2 11.3 8.1     18.9 10.9 4.9     25.3 12.2 6.2
;

/*분산분석*/
PROC GLM;
class trt;
model y = trt / solution;
run;

/*교호작용 효과 존재 여부 확인*/
PROC GLM;
class trt;
model y = trt x1 X2 trt*x1 trt*x2;
run;

/*공분산분석*/
PROC GLM;
class trt;
model y = trt x1 x2 / solution;
lsmeans trt / tdiff;
run;

PROC GLM;
class trt;
model y = trt x1 x2 / solution;
means trt;
lsmeans trt / stderr tdiff;
run;
