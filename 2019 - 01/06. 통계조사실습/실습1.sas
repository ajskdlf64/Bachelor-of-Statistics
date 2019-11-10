* ========================================================================= ;
* 영구 저장을 위한 라이브러리 설정;
libname stat2019 "C:\Users\user\Desktop\University\통계조사실습\2016GOMS1";

* 엑셀데이터 불러오기;
proc import datafile="C:\Users\user\Desktop\University\통계조사실습\2016GOMS1\GP16_2017.xlsx" 
     dbms=xlsx out=stat2019.data replace;
     getnames=yes;
run;

* 변수명과 입력 속성 보기;
proc contents data=stat2019.data;
run;

* ========================================================================= ;
* 1. 빈도분석과 통계표: 일반분석, 가중치 미반영 혹은 가중치가 동일한 경우, SRS;
proc freq data=stat2019.data;
  table g161majorcat g161province g161area g161graduy g161sex;
run;
proc freq data=stat2019.data;
  table (g161majorcat g161province g161area g161graduy)*g161sex/nocol nopercent;
run;

* 빈도분석과 통계표 : 일반분석, 가중치만 반영, 표준오차 편향(과소 추정);
proc freq data=stat2019.data;
  table g161majorcat g161province g161area g161graduy g161sex;
  weight g161wt;
run;
proc freq data=stat2019.data;
  table (g161majorcat g161province g161area g161graduy)*g161sex/nocol nopercent;
  weight g161wt;
run;

* 빈도분석과 통계표 : 표본조사자료분석, 가중치 반영, 표본설계 미반영, 표준오차 거의 비편향;
proc surveyfreq data=stat2019.data;
  tables g161majorcat g161province g161area g161graduy g161sex;
  weight g161wt;
run;
proc surveyfreq data=stat2019.data;
  tables (g161majorcat g161province g161area g161graduy)*g161sex/nopercent;
  weight g161wt;
run;

* 빈도분석과 통계표 : 표본조사자료분석, 가중치 반영, 표본설계 반영, 표준오차 비편향;
proc surveyfreq data=stat2019.data;
  strata g161area g161majorcat; /* 층화추출시 층화 변수 선언 */
  * cluster ; /* 집락추출시 반영, 해당사항없음*/
  table g161province g161graduy g161sex;  /* 층화변수는 빈도표에 포함할 수 없음 */
  weight g161wt;
run;
proc surveyfreq data=stat2019.data;
  strata g161area g161majorcat/list; /* 층화추출시 층화 변수 선언 */
  table (g161province g161graduy)*g161sex/nopercent;
  weight g161wt;
run;

* ========================================================================= ;
* 2. 기술통계량분석과 통계표: 일반분석, 가중치 미반영 혹은 가중치가 통일한 경우, SRS;
proc means data=stat2019.data;
  var g161a122 g161a125;
run;
proc means data=stat2019.data;
  class g161majorcat;
  var g161a122 g161a125;
run;
proc means data=stat2019.data;
  class g161majorcat g161sex;
  var g161a122 g161a125;
run;

proc tabulate data=stat2019.data;
  class g161majorcat g161sex;
  var   g161a122 g161a125;
  table g161majorcat,(g161a122 g161a125)*(mean stddev stderr);
  table g161sex,(g161a122 g161a125)*(mean stddev stderr);
run;
proc tabulate data=stat2019.data;
  class g161majorcat g161sex;
  var  g161a122 g161a125;
  table g161majorcat, g161sex*(g161a122 g161a125)*(mean stddev stderr);
run;
proc tabulate data=stat2019.data;
  class g161majorcat g161sex g161a021;
  var  g161a122 g161a125;
  table g161majorcat, (g161a122 g161a125)*g161sex*(mean stddev stderr);
run;

* 기술통계량분석과 통계표 : 일반분석, 가중치만 반영, 표준오차 편향(과소 추정);
proc means data=stat2019.data;
  var g161a122 g161a125;
  weight g161wt;
run;
proc means data=stat2019.data;
  class g161majorcat;
  var g161a122 g161a125;
  weight g161wt;
run;
proc means data=stat2019.data;
  class g161majorcat g161sex;
  var g161a122 g161a125;
  weight g161wt;
run;

proc tabulate data=stat2019.data;
  class g161majorcat g161sex;
  var  g161a122 g161a125;
  table g161majorcat,(g161a122 g161a125)*(mean stddev stderr);
  table g161sex,(g161a122 g161a125)*(mean stddev stderr);
  weight g161wt;
run;
proc tabulate data=stat2019.data;
  class g161majorcat g161sex;
  var  g161a122 g161a125;
  table g161majorcat, g161sex*(g161a122 g161a125)*(mean stddev stderr);
  weight g161wt;
run;
proc tabulate data=stat2019.data;
  class g161majorcat g161sex;
  var  g161a122 g161a125;
  table g161majorcat, (g161a122 g161a125)*g161sex*(mean stddev stderr);
  weight g161wt;
run;


* 기술통계량분석과 통계표 : 표본조사자료분석, 가중치 반영, 표본설계 미반영, 표준오차 거의 비편향;
proc surveymeans data=stat2019.data;
  class g161majorcat;
  var g161a122 g161a125;
  weight g161wt;
run;

 /* SRS 인 경우 모집단 수 설정하면 유한모집단  fpc 반영*/
proc surveymeans data=stat2019.data total=520547;
  class g161majorcat;
  var g161a122 g161a125;
  weight g161wt;
run;

* 층화추출;
proc surveymeans data=stat2019.data;
  class g161majorcat;
  var g161a122 g161a125;
    strata g161area g161majorcat; /* 층화추출시 층화 변수 선언 */
  * cluster ; /* 집락추출시 반영, 해당사항없음*/
  weight g161wt;
run;

* 기술통계량과 통계표 : 표본조사자료분석, 가중치 반영, 표본설계 반영, 표준오차 비편향;
proc surveymeans data=stat2019.data; /* 층화추출은 층별 부모집단 크기 선언 필요 , total=부모집단크기 dataset 필요 */
  strata g161area g161majorcat; /* 층화추출시 층화 변수 선언 */
  var g161a122 g161a125;
  weight g161wt;
run;

proc surveymeans data=stat2019.data;
  class g161majorcat; /* 범주별 비율 분석 시 사용 */
  var g161a122 g161a125 g161majorcat;
  weight g161wt;
run;

proc sort data=stat2019.data;
by g161majorcat;
run;

/* 범주별 구분하여 분석, by 사용 전 해당 범주에 대한 정렬(sort)가 필요함*/
proc surveymeans data=stat2019.data;
  by g161majorcat; 
  var g161a122 g161a125;
  weight g161wt;
run;

proc surveymeans data=stat2019.data;
  domain g161sex; /* 영역별 분석 시 사용*/
  var g161a122 g161a125;
  weight g161wt;
run;

proc surveymeans data=stat2019.data;
  class g161sex; /* 영역별 분석 시 사용*/
  var g161a122 g161a125;
  weight g161wt;
run;

* 기술통계량과 통계표 : 표본조사자료분석, 가중치 반영, 표본설계 반영, 표준오차 비편향;
proc surveymeans data=stat2019.data; /* 층화추출은 층별 부모집단 크기 선언 필요 , total=부모집단크기 dataset 필요 */
  strata g161area g161majorcat; /* 층화추출시 층화 변수 선언 */
  var g161a122 g161a125;
  weight g161wt;
run;
proc surveymeans data=stat2019.data;
  strata g161area g161majorcat; /* 층화추출시 층화 변수 선언 */
  domain g161majorcat; /* 층화변수도 영역 분석 가능 */
  var g161a122 g161a125;
  weight g161wt;
run;


* ========================================================================= ;
* 3. 비추정;
proc surveymeans data=stat2019.data;
  domain g161sex;
  var g161a122 g161a125;
  ratio g161a122/g161a125;
  weight g161wt;
run;


* ========================================================================= ;
* 4. t-검정;
proc ttest data=stat2019.data;
  class g161sex;
  var g161a122 g161a125;
run;
proc ttest data=stat2019.data;/*분석 어려움*/
  class g161sex;
  var g161a122 g161a125;
  weight g161wt;
run;

proc surveymeans data=stat2019.data;
  domain g161sex/diffmeans;
  var g161a122 g161a125;
  weight g161wt;
run;

proc surveymeans data=stat2019.data;
  domain g161majorcat/diffmeans; /* 3집단 이상도 2집단씩 t검정, 분산분석이 필요 */
  var g161a122 g161a125;
  weight g161wt;
run;

/* 저장되어 있는 파일 불러오기 이름은 아무거나  */
libname aaa "C:\Users\user\Desktop\University\통계조사실습\2016GOMS1\GP16_2017.xlsx";
run;
