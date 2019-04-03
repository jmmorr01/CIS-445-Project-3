 
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
