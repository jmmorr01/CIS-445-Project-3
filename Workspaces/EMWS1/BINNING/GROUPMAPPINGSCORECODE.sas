 length _LABEL_ $200;
 label _LABEL_="%sysfunc(sasmsg(sashelp.dmine, rpt_groupvalues_vlabel , NOQUOTE))";
 
if DISPLAY_VAR='IMP_CLAGE' and _GROUP_ = 2 then do;
_LABEL_='IMP_CLAGE< 118.57';
UB=118.57;
end;
else
if DISPLAY_VAR='IMP_CLAGE' and _GROUP_ = 3 then do;
_LABEL_='118.57<= IMP_CLAGE< 179.57';
UB=179.57;
end;
else
if DISPLAY_VAR='IMP_CLAGE' and _GROUP_ = 4 then do;
_LABEL_='179.57<= IMP_CLAGE< 226.86';
UB=226.86;
end;
else
if DISPLAY_VAR='IMP_CLAGE' and _GROUP_ = 5 then do;
_LABEL_='226.86<= IMP_CLAGE';
UB=.;
end;
 
if DISPLAY_VAR='IMP_CLNO' and _GROUP_ = 2 then do;
_LABEL_='IMP_CLNO< 15';
UB=15;
end;
else
if DISPLAY_VAR='IMP_CLNO' and _GROUP_ = 3 then do;
_LABEL_='15<= IMP_CLNO< 21';
UB=21;
end;
else
if DISPLAY_VAR='IMP_CLNO' and _GROUP_ = 4 then do;
_LABEL_='21<= IMP_CLNO< 26';
UB=26;
end;
else
if DISPLAY_VAR='IMP_CLNO' and _GROUP_ = 5 then do;
_LABEL_='26<= IMP_CLNO';
UB=.;
end;
 
if DISPLAY_VAR='IMP_DEBTINC' and _GROUP_ = 2 then do;
_LABEL_='IMP_DEBTINC< 30.4';
UB=30.4;
end;
else
if DISPLAY_VAR='IMP_DEBTINC' and _GROUP_ = 3 then do;
_LABEL_='30.4<= IMP_DEBTINC< 33.79';
UB=33.79;
end;
else
if DISPLAY_VAR='IMP_DEBTINC' and _GROUP_ = 4 then do;
_LABEL_='33.79<= IMP_DEBTINC< 38.07';
UB=38.07;
end;
else
if DISPLAY_VAR='IMP_DEBTINC' and _GROUP_ = 5 then do;
_LABEL_='38.07<= IMP_DEBTINC';
UB=.;
end;
 
if DISPLAY_VAR='IMP_MORTDUE' and _GROUP_ = 2 then do;
_LABEL_='IMP_MORTDUE< 48273';
UB=48273;
end;
else
if DISPLAY_VAR='IMP_MORTDUE' and _GROUP_ = 3 then do;
_LABEL_='48273<= IMP_MORTDUE< 68959';
UB=68959;
end;
else
if DISPLAY_VAR='IMP_MORTDUE' and _GROUP_ = 4 then do;
_LABEL_='68959<= IMP_MORTDUE< 89226';
UB=89226;
end;
else
if DISPLAY_VAR='IMP_MORTDUE' and _GROUP_ = 5 then do;
_LABEL_='89226<= IMP_MORTDUE';
UB=.;
end;
 
if DISPLAY_VAR='IMP_NINQ' and _GROUP_ = 1 then do;
_LABEL_='IMP_NINQ< 1';
UB=1;
end;
else
if DISPLAY_VAR='IMP_NINQ' and _GROUP_ = 2 then do;
_LABEL_='1<= IMP_NINQ< 2';
UB=2;
end;
else
if DISPLAY_VAR='IMP_NINQ' and _GROUP_ = 3 then do;
_LABEL_='2<= IMP_NINQ< 2.5';
UB=2.5;
end;
else
if DISPLAY_VAR='IMP_NINQ' and _GROUP_ = 4 then do;
_LABEL_='2.5<= IMP_NINQ';
UB=.;
end;
 
if DISPLAY_VAR='IMP_VALUE' and _GROUP_ = 2 then do;
_LABEL_='IMP_VALUE< 66692';
UB=66692;
end;
else
if DISPLAY_VAR='IMP_VALUE' and _GROUP_ = 3 then do;
_LABEL_='66692<= IMP_VALUE< 90000';
UB=90000;
end;
else
if DISPLAY_VAR='IMP_VALUE' and _GROUP_ = 4 then do;
_LABEL_='90000<= IMP_VALUE< 120724';
UB=120724;
end;
else
if DISPLAY_VAR='IMP_VALUE' and _GROUP_ = 5 then do;
_LABEL_='120724<= IMP_VALUE';
UB=.;
end;
 
if DISPLAY_VAR='INDELINQ' and _GROUP_ = 2 then do;
_LABEL_='INDELINQ< 0';
UB=0;
end;
else
if DISPLAY_VAR='INDELINQ' and _GROUP_ = 3 then do;
_LABEL_='0<= INDELINQ< 1';
UB=1;
end;
else
if DISPLAY_VAR='INDELINQ' and _GROUP_ = 4 then do;
_LABEL_='1<= INDELINQ';
UB=.;
end;
 
if DISPLAY_VAR='INDEROG' and _GROUP_ = 2 then do;
_LABEL_='INDEROG< 0';
UB=0;
end;
else
if DISPLAY_VAR='INDEROG' and _GROUP_ = 3 then do;
_LABEL_='0<= INDEROG';
UB=.;
end;
 
if DISPLAY_VAR='INYOJ' and _GROUP_ = 2 then do;
_LABEL_='INYOJ< 1';
UB=1;
end;
else
if DISPLAY_VAR='INYOJ' and _GROUP_ = 3 then do;
_LABEL_='1<= INYOJ';
UB=.;
end;
 
if DISPLAY_VAR='LOAN' and _GROUP_ = 2 then do;
_LABEL_='LOAN< 11100';
UB=11100;
end;
else
if DISPLAY_VAR='LOAN' and _GROUP_ = 3 then do;
_LABEL_='11100<= LOAN< 16200';
UB=16200;
end;
else
if DISPLAY_VAR='LOAN' and _GROUP_ = 4 then do;
_LABEL_='16200<= LOAN< 23200';
UB=23200;
end;
else
if DISPLAY_VAR='LOAN' and _GROUP_ = 5 then do;
_LABEL_='23200<= LOAN';
UB=.;
end;
 
if DISPLAY_VAR='IMP_JOB' and _GROUP_ = 2 then
_LABEL_='OTHER';
else
if DISPLAY_VAR='IMP_JOB' and _GROUP_ = 3 then
_LABEL_='PROFEXE';
else
if DISPLAY_VAR='IMP_JOB' and _GROUP_ = 4 then
_LABEL_='OFFICE';
else
if DISPLAY_VAR='IMP_JOB' and _GROUP_ = 5 then
_LABEL_='MGR';
else
if DISPLAY_VAR='IMP_JOB' and _GROUP_ = 6 then
_LABEL_='SELF';
else
if DISPLAY_VAR='IMP_JOB' and _GROUP_ = 7 then
_LABEL_='SALES';
 
if DISPLAY_VAR='IMP_REASON' and _GROUP_ = 2 then
_LABEL_='DEBTCON';
else
if DISPLAY_VAR='IMP_REASON' and _GROUP_ = 3 then
_LABEL_='HOMEIMP';
