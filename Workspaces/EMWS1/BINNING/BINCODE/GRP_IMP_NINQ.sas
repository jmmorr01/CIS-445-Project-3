 
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
