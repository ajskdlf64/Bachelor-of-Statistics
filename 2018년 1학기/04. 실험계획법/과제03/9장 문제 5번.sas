DATA;
DO Temp= 10, 20, 30;
DO Speed = 150, 200, 225, 300;
DO Press = 50, 70, 85;
DO i = 1,2;
INPUT Power @@;
OUTPUT;
END; END; END; END;
CARDS;
-2	 -3	-6 4		-1 -2
0 -9		-5 -1	-4 -8
-1 -8	-8 -2	  0 -7 
 4 4		-3 -7	  -2 4
14 14	 22 24 	 20 16
6 0 		  8 6 			2 0
1 2 		  6 2			3 0
 -7 6		-5 2 		 -5 -1
-8 -8 	-8 3		 -2 -1
-2 20 	1 -7	   	-1 -2
-1 -2 	-9 -8	 -4 -7
-2 1 		-8 3			 1 3
;
PROC VARCOMP method=type1;
CLASS Temp Speed Press;
MODEL Power = Temp | Speed | Press / FiXED= 1;
RUN;
