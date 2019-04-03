length _UFormat $200;
drop _UFormat;
_UFormat='';

*------------------------------------------------------------*;
* Variable: IMP_CLAGE;
*------------------------------------------------------------*;
LABEL GRP_IMP_CLAGE =
'Grouped: Imputed CLAGE';

if MISSING(IMP_CLAGE) then do;
GRP_IMP_CLAGE = 1;
end;
else if NOT MISSING(IMP_CLAGE) then do;
if IMP_CLAGE < 118.57 then do;
GRP_IMP_CLAGE = 2;
end;
else
if 118.57 <= IMP_CLAGE AND IMP_CLAGE < 179.57 then do;
GRP_IMP_CLAGE = 3;
end;
else
if 179.57 <= IMP_CLAGE AND IMP_CLAGE < 226.86 then do;
GRP_IMP_CLAGE = 4;
end;
else
if 226.86 <= IMP_CLAGE then do;
GRP_IMP_CLAGE = 5;
end;
end;

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

*------------------------------------------------------------*;
* Variable: IMP_NINQ;
*------------------------------------------------------------*;
LABEL GRP_IMP_NINQ =
'Grouped: Imputed NINQ';

if MISSING(IMP_NINQ) then do;
GRP_IMP_NINQ = 1;
end;
else if NOT MISSING(IMP_NINQ) then do;
if IMP_NINQ < 1 then do;
GRP_IMP_NINQ = 1;
end;
else
if 1 <= IMP_NINQ AND IMP_NINQ < 2 then do;
GRP_IMP_NINQ = 2;
end;
else
if 2 <= IMP_NINQ AND IMP_NINQ < 2.5 then do;
GRP_IMP_NINQ = 3;
end;
else
if 2.5 <= IMP_NINQ then do;
GRP_IMP_NINQ = 4;
end;
end;

*------------------------------------------------------------*;
* Variable: INDELINQ;
*------------------------------------------------------------*;
LABEL GRP_INDELINQ = "Grouped: INDELINQ";

if MISSING(INDELINQ) then do;
GRP_INDELINQ = 1;
end;
else if NOT MISSING(INDELINQ) then do;
if INDELINQ < 0 then do;
GRP_INDELINQ = 2;
end;
else
if 0 <= INDELINQ AND INDELINQ < 1 then do;
GRP_INDELINQ = 3;
end;
else
if 1 <= INDELINQ then do;
GRP_INDELINQ = 4;
end;
end;
