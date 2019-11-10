DATA;
DO advertise = 'A1', 'A2';
DO service = 'B1', 'B2';
Do i = 1,2;
INPUT profit @@;
OUTPUT;
END;
END;
END;
CARDS;
10 50   40 60
60 80   80 100
;

PROC GLM;
CLASS advertise service;
MODEL profit = advertise | service;
RUN;
