DATA ONE ;
	INPUT X1-X3 ;
			LABEL  X1 = "PLANT CALCIUM"
						X2 = "AVAILABLE CALCIUM"
						X3 = "EXCHANGEABLE CALCIUM" ;

			D1 = X1 - 2.85 ;
			D2 = X2 - 15 ;
			D3 = X3 - 6 ;
			Z0 = 1 ;
CARDS ;
2.11 10.1 3.4                    /* be careful about data input */
2.36 35.0 4.1
2.13 2.0 1.9
2.78 6.0 3.8
2.17 2.0 1.7
RUN;

PROC GLM DATA = ONE ;
		MODEL D1 D2 D3 = Z0 / NOINT SOLUTION P ;
		MANOVA H = Z0 / PRINTE ;
RUN;
