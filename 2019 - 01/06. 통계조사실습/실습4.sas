
* 영구 저장을 위한 라이브러리 설정;
libname aaa "C:\Users\user\Desktop\University\통계조사실습\2015GOMS1";
libname stat2019 "C:\Users\user\Desktop\University\통계조사실습\2016GOMS1";

proc surveyfreq data=stat2019.data;
  table g161province*g161school*g161sex*g161majorcat;
  weight g161wt;
run;
