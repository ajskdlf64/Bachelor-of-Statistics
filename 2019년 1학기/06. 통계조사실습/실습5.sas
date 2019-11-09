* 영구 저장을 위한 라이브러리 설정;
libname bbb "C:\Users\user\Desktop\University\통계조사실습\다변량분석실습자료";

* 엑셀데이터 불러오기;
proc import datafile="C:\Users\user\Desktop\University\통계조사실습\다변량분석실습자료\다변량분석설명자료_17.xlsx" 
     dbms=xlsx out=bbb.data replace;
     getnames=yes;
run;

* 중요도 계산;
ods graphics on;
proc corr data=bbb.data plots=matrix(histogram);
 var c_2_1 -- c_2_18 c_3;
run;
ods graphics off;

proc corr data=bbb.data outp=bbb.data_corr;
 var c_2_1 -- c_2_18;
 with c_3;
run;
proc print data=bbb.data_corr;
run;

* 주성분분석;
proc princomp data=bbb.data ;
 var d_1 -- d_24;
run;

proc princomp data=bbb.data n=7;
 var d_1 -- d_24;
run;

* 요인분석/회전;
proc factor data=bbb.data /* priors=smc */ rotate=varimax;
 var d_1 -- d_24;
run;

proc factor data=bbb.data n=7 score;
   var d_1 -- d_24;
*   ods output StdScoreCoef=Coef;
run;

* 신뢰도분석;
proc corr data=bbb.data alpha plots;
 fact1:  var d_3 d_8 d_9 d_12 -- d_15 d_21;
run;
proc corr data=bbb.data alpha plots;
 fact2:  var d_1 d_5 -- d_7 d_22;
run;
proc corr data=bbb.data alpha plots;
 fact3:  var d_23 d_24;
run;
proc corr data=bbb.data alpha plots;
 fact4:  var d_11 d_16 d_19 d_20;
run;
proc corr data=bbb.data alpha plots;
 fact1_1:  var d_8 d_9 d_12 -- d_14 d_21;
run;

* 요인분석 자료값 생성;
proc factor data=bbb.data rotate=varimax score;
 var d_1 -- d_24;
run;

* fact1 fact2 fact3를 갖는 새로운 데이터 만들기!!!;
data bbb.data_1;
 set bbb.data;
 fact1=mean(d_8, d_9, d_12, d_13, d_14, d_21);
 fact2=mean(d_1, d_5, d_6, d_7, d_22);
 fact3=mean(d_23, d_24);
run;

* fact1 fact2 fact3 의 상관관계 확인하기 -> 독립이 아니다!!!;
proc corr data=bbb.data_1;
var fact1 fact2 fact3;
run;


* 군집분석;
/* method = ward 통계적으로 분산이 가장 작게 묶어라. */
proc cluster data=bbb.data_1 method=ward print=15 ccc pseudo;
   var fact1 fact2 b_9 c_3;
   copy id;
run;

proc tree noprint ncl=3 out=out;
   copy fact1 fact2 b_9 c_3 id;
run;

*군집별 특성 분석;
proc sort data=bbb.data_1 out=bbb.data_1s;
  by id;
run;

proc sort data=out out=out_s;
  by id;
run;

data bbb.data_cl;
  merge bbb.data_1s out_s;
  by id;
  drop _name_ clusname;
run;

proc means data=bbb.data_cl;
 class cluster;
 var  fact1 fact2 fact3 a_3 b_9 c_3 ;
run;
