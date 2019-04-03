 
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
