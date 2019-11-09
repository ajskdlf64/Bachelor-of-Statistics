* ========================================================================= ;
* ���� ������ ���� ���̺귯�� ����;
libname stat2019 "C:\Users\user\Desktop\University\�������ǽ�\2016GOMS1";

* ���������� �ҷ�����;
proc import datafile="C:\Users\user\Desktop\University\�������ǽ�\2016GOMS1\GP16_2017.xlsx" 
     dbms=xlsx out=stat2019.data replace;
     getnames=yes;
run;

* ������� �Է� �Ӽ� ����;
proc contents data=stat2019.data;
run;

* ========================================================================= ;
* 1. �󵵺м��� ���ǥ: �Ϲݺм�, ����ġ �̹ݿ� Ȥ�� ����ġ�� ������ ���, SRS;
proc freq data=stat2019.data;
  table g161majorcat g161province g161area g161graduy g161sex;
run;
proc freq data=stat2019.data;
  table (g161majorcat g161province g161area g161graduy)*g161sex/nocol nopercent;
run;

* �󵵺м��� ���ǥ : �Ϲݺм�, ����ġ�� �ݿ�, ǥ�ؿ��� ����(���� ����);
proc freq data=stat2019.data;
  table g161majorcat g161province g161area g161graduy g161sex;
  weight g161wt;
run;
proc freq data=stat2019.data;
  table (g161majorcat g161province g161area g161graduy)*g161sex/nocol nopercent;
  weight g161wt;
run;

* �󵵺м��� ���ǥ : ǥ�������ڷ�м�, ����ġ �ݿ�, ǥ������ �̹ݿ�, ǥ�ؿ��� ���� ������;
proc surveyfreq data=stat2019.data;
  tables g161majorcat g161province g161area g161graduy g161sex;
  weight g161wt;
run;
proc surveyfreq data=stat2019.data;
  tables (g161majorcat g161province g161area g161graduy)*g161sex/nopercent;
  weight g161wt;
run;

* �󵵺м��� ���ǥ : ǥ�������ڷ�м�, ����ġ �ݿ�, ǥ������ �ݿ�, ǥ�ؿ��� ������;
proc surveyfreq data=stat2019.data;
  strata g161area g161majorcat; /* ��ȭ����� ��ȭ ���� ���� */
  * cluster ; /* ��������� �ݿ�, �ش���׾���*/
  table g161province g161graduy g161sex;  /* ��ȭ������ ��ǥ�� ������ �� ���� */
  weight g161wt;
run;
proc surveyfreq data=stat2019.data;
  strata g161area g161majorcat/list; /* ��ȭ����� ��ȭ ���� ���� */
  table (g161province g161graduy)*g161sex/nopercent;
  weight g161wt;
run;

* ========================================================================= ;
* 2. �����跮�м��� ���ǥ: �Ϲݺм�, ����ġ �̹ݿ� Ȥ�� ����ġ�� ������ ���, SRS;
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

* �����跮�м��� ���ǥ : �Ϲݺм�, ����ġ�� �ݿ�, ǥ�ؿ��� ����(���� ����);
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


* �����跮�м��� ���ǥ : ǥ�������ڷ�м�, ����ġ �ݿ�, ǥ������ �̹ݿ�, ǥ�ؿ��� ���� ������;
proc surveymeans data=stat2019.data;
  class g161majorcat;
  var g161a122 g161a125;
  weight g161wt;
run;

 /* SRS �� ��� ������ �� �����ϸ� ���Ѹ�����  fpc �ݿ�*/
proc surveymeans data=stat2019.data total=520547;
  class g161majorcat;
  var g161a122 g161a125;
  weight g161wt;
run;

* ��ȭ����;
proc surveymeans data=stat2019.data;
  class g161majorcat;
  var g161a122 g161a125;
    strata g161area g161majorcat; /* ��ȭ����� ��ȭ ���� ���� */
  * cluster ; /* ��������� �ݿ�, �ش���׾���*/
  weight g161wt;
run;

* �����跮�� ���ǥ : ǥ�������ڷ�м�, ����ġ �ݿ�, ǥ������ �ݿ�, ǥ�ؿ��� ������;
proc surveymeans data=stat2019.data; /* ��ȭ������ ���� �θ����� ũ�� ���� �ʿ� , total=�θ�����ũ�� dataset �ʿ� */
  strata g161area g161majorcat; /* ��ȭ����� ��ȭ ���� ���� */
  var g161a122 g161a125;
  weight g161wt;
run;

proc surveymeans data=stat2019.data;
  class g161majorcat; /* ���ֺ� ���� �м� �� ��� */
  var g161a122 g161a125 g161majorcat;
  weight g161wt;
run;

proc sort data=stat2019.data;
by g161majorcat;
run;

/* ���ֺ� �����Ͽ� �м�, by ��� �� �ش� ���ֿ� ���� ����(sort)�� �ʿ���*/
proc surveymeans data=stat2019.data;
  by g161majorcat; 
  var g161a122 g161a125;
  weight g161wt;
run;

proc surveymeans data=stat2019.data;
  domain g161sex; /* ������ �м� �� ���*/
  var g161a122 g161a125;
  weight g161wt;
run;

proc surveymeans data=stat2019.data;
  class g161sex; /* ������ �м� �� ���*/
  var g161a122 g161a125;
  weight g161wt;
run;

* �����跮�� ���ǥ : ǥ�������ڷ�м�, ����ġ �ݿ�, ǥ������ �ݿ�, ǥ�ؿ��� ������;
proc surveymeans data=stat2019.data; /* ��ȭ������ ���� �θ����� ũ�� ���� �ʿ� , total=�θ�����ũ�� dataset �ʿ� */
  strata g161area g161majorcat; /* ��ȭ����� ��ȭ ���� ���� */
  var g161a122 g161a125;
  weight g161wt;
run;
proc surveymeans data=stat2019.data;
  strata g161area g161majorcat; /* ��ȭ����� ��ȭ ���� ���� */
  domain g161majorcat; /* ��ȭ������ ���� �м� ���� */
  var g161a122 g161a125;
  weight g161wt;
run;


* ========================================================================= ;
* 3. ������;
proc surveymeans data=stat2019.data;
  domain g161sex;
  var g161a122 g161a125;
  ratio g161a122/g161a125;
  weight g161wt;
run;


* ========================================================================= ;
* 4. t-����;
proc ttest data=stat2019.data;
  class g161sex;
  var g161a122 g161a125;
run;
proc ttest data=stat2019.data;/*�м� �����*/
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
  domain g161majorcat/diffmeans; /* 3���� �̻� 2���ܾ� t����, �л�м��� �ʿ� */
  var g161a122 g161a125;
  weight g161wt;
run;

/* ����Ǿ� �ִ� ���� �ҷ����� �̸��� �ƹ��ų�  */
libname aaa "C:\Users\user\Desktop\University\�������ǽ�\2016GOMS1\GP16_2017.xlsx";
run;
