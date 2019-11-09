DATA ex1;
DO trt = "A", "B";
DO i = 1 to 10;
INPUT x y @@;
OUTPUT;
END;
END;
D1= (trt="A");
CARDS;
5 20   10 23   12 30   9 25   23 34  
21 40   14 27   18 38   6 24   13 31
7 19   12 26   27 33   24 35   18 30  
22 31   26 34   21 28   14 23   9 22 
;

/*분산분석*/
PROC GLM;
class trt;
model y = trt / solution;
run;

/*회귀분석*/
PROC REG;
model y = trt  D1;
run;

/*교호작용 효과 존재 여부 확인*/
PROC GLM;
class trt;
model y = trt | x;
run;

/*공분산분석*/
PROC GLM;
class trt;
model y = trt x / solution;
lsmeans trt / tdiff;
run;

PROC GLM;
class trt;
model y = trt x / solution;
means trt;
lsmeans trt / stderr tdiff;
run;
