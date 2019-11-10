* ���� ������ ���� ���̺귯�� ����;
libname bbb "C:\Users\user\Desktop\University\�������ǽ�\�ٺ����м��ǽ��ڷ�";

* ���������� �ҷ�����;
proc import datafile="C:\Users\user\Desktop\University\�������ǽ�\�ٺ����м��ǽ��ڷ�\�ٺ����м������ڷ�_17.xlsx" 
     dbms=xlsx out=bbb.data replace;
     getnames=yes;
run;

* �߿䵵 ���;
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

* �ּ��км�;
proc princomp data=bbb.data ;
 var d_1 -- d_24;
run;

proc princomp data=bbb.data n=7;
 var d_1 -- d_24;
run;

* ���κм�/ȸ��;
proc factor data=bbb.data /* priors=smc */ rotate=varimax;
 var d_1 -- d_24;
run;

proc factor data=bbb.data n=7 score;
   var d_1 -- d_24;
*   ods output StdScoreCoef=Coef;
run;

* �ŷڵ��м�;
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

* ���κм� �ڷᰪ ����;
proc factor data=bbb.data rotate=varimax score;
 var d_1 -- d_24;
run;

* fact1 fact2 fact3�� ���� ���ο� ������ �����!!!;
data bbb.data_1;
 set bbb.data;
 fact1=mean(d_8, d_9, d_12, d_13, d_14, d_21);
 fact2=mean(d_1, d_5, d_6, d_7, d_22);
 fact3=mean(d_23, d_24);
run;

* fact1 fact2 fact3 �� ������� Ȯ���ϱ� -> ������ �ƴϴ�!!!;
proc corr data=bbb.data_1;
var fact1 fact2 fact3;
run;


* �����м�;
/* method = ward ��������� �л��� ���� �۰� �����. */
proc cluster data=bbb.data_1 method=ward print=15 ccc pseudo;
   var fact1 fact2 b_9 c_3;
   copy id;
run;

proc tree noprint ncl=3 out=out;
   copy fact1 fact2 b_9 c_3 id;
run;

*������ Ư�� �м�;
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
