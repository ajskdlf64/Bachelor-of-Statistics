
* ���� ������ ���� ���̺귯�� ����;
libname aaa "C:\Users\user\Desktop\University\�������ǽ�\2015GOMS1";
libname stat2019 "C:\Users\user\Desktop\University\�������ǽ�\2016GOMS1";

proc surveyfreq data=stat2019.data;
  table g161province*g161school*g161sex*g161majorcat;
  weight g161wt;
run;
