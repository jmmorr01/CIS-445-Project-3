 
*------------------------------------------------------------*;
* Variable: IMP_DEBTINC;
*------------------------------------------------------------*;
LABEL GRP_IMP_DEBTINC =
'Grouped: Imputed DEBTINC';
 
if MISSING(IMP_DEBTINC) then do;
GRP_IMP_DEBTINC = 1;
end;
else if NOT MISSING(IMP_DEBTINC) then do;
if IMP_DEBTINC < 30.4 then do;
GRP_IMP_DEBTINC = 2;
end;
else
if 30.4 <= IMP_DEBTINC AND IMP_DEBTINC < 33.79 then do;
GRP_IMP_DEBTINC = 3;
end;
else
if 33.79 <= IMP_DEBTINC AND IMP_DEBTINC < 38.07 then do;
GRP_IMP_DEBTINC = 4;
end;
else
if 38.07 <= IMP_DEBTINC then do;
GRP_IMP_DEBTINC = 5;
end;
end;
