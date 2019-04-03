*------------------------------------------------------------*;
* Generating Bins for interval variables;
*------------------------------------------------------------*;
if IMP_CLAGE eq . then BIN_IMP_CLAGE= .;
else do;
if IMP_CLAGE < 118.57 then BIN_IMP_CLAGE=1;
else if IMP_CLAGE < 179.57 then BIN_IMP_CLAGE=2;
else if IMP_CLAGE < 226.86 then BIN_IMP_CLAGE=3;
else if IMP_CLAGE >= 226.86 then BIN_IMP_CLAGE=4;
end;
if IMP_CLNO eq . then BIN_IMP_CLNO= .;
else do;
if IMP_CLNO < 15 then BIN_IMP_CLNO=1;
else if IMP_CLNO < 21 then BIN_IMP_CLNO=2;
else if IMP_CLNO < 26 then BIN_IMP_CLNO=3;
else if IMP_CLNO >= 26 then BIN_IMP_CLNO=4;
end;
if IMP_DEBTINC eq . then BIN_IMP_DEBTINC= .;
else do;
if IMP_DEBTINC < 30.4 then BIN_IMP_DEBTINC=1;
else if IMP_DEBTINC < 33.79 then BIN_IMP_DEBTINC=2;
else if IMP_DEBTINC < 38.07 then BIN_IMP_DEBTINC=3;
else if IMP_DEBTINC >= 38.07 then BIN_IMP_DEBTINC=4;
end;
if IMP_MORTDUE eq . then BIN_IMP_MORTDUE= .;
else do;
if IMP_MORTDUE < 48273 then BIN_IMP_MORTDUE=1;
else if IMP_MORTDUE < 68959 then BIN_IMP_MORTDUE=2;
else if IMP_MORTDUE < 89226 then BIN_IMP_MORTDUE=3;
else if IMP_MORTDUE >= 89226 then BIN_IMP_MORTDUE=4;
end;
if IMP_NINQ eq . then BIN_IMP_NINQ= .;
else do;
if IMP_NINQ < 0 then BIN_IMP_NINQ=1;
else if IMP_NINQ < 1 then BIN_IMP_NINQ=2;
else if IMP_NINQ < 2 then BIN_IMP_NINQ=3;
else if IMP_NINQ >= 2 then BIN_IMP_NINQ=4;
end;
if IMP_VALUE eq . then BIN_IMP_VALUE= .;
else do;
if IMP_VALUE < 66692 then BIN_IMP_VALUE=1;
else if IMP_VALUE < 90000 then BIN_IMP_VALUE=2;
else if IMP_VALUE < 120724 then BIN_IMP_VALUE=3;
else if IMP_VALUE >= 120724 then BIN_IMP_VALUE=4;
end;
if INDELINQ eq . then BIN_INDELINQ= .;
else do;
if INDELINQ < 0 then BIN_INDELINQ=1;
else if INDELINQ < 1 then BIN_INDELINQ=2;
else if INDELINQ >= 1 then BIN_INDELINQ=3;
end;
if INDEROG eq . then BIN_INDEROG= .;
else do;
if INDEROG < 0 then BIN_INDEROG=1;
else if INDEROG >= 0 then BIN_INDEROG=2;
end;
if INYOJ eq . then BIN_INYOJ= .;
else do;
if INYOJ < 1 then BIN_INYOJ=1;
else if INYOJ >= 1 then BIN_INYOJ=2;
end;
if LOAN eq . then BIN_LOAN= .;
else do;
if LOAN < 11100 then BIN_LOAN=1;
else if LOAN < 16200 then BIN_LOAN=2;
else if LOAN < 23200 then BIN_LOAN=3;
else if LOAN >= 23200 then BIN_LOAN=4;
end;
drop
IMP_CLAGE
IMP_CLNO
IMP_DEBTINC
IMP_MORTDUE
IMP_NINQ
IMP_VALUE
INDELINQ
INDEROG
INYOJ
LOAN
;
