*------------------------------------------------------------* ;
* EM: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    BAD(DESC) GRP_IMP_CLAGE(ASC) GRP_IMP_DEBTINC(ASC) GRP_IMP_NINQ(ASC)
   GRP_INDELINQ(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* EM: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;

%mend DMDBVar;
*------------------------------------------------------------*;
* EM: Create DMDB;
*------------------------------------------------------------*;
libname _spdslib SPDE "C:\Users\jmmorr01\AppData\Local\Temp\SAS Temporary Files\_TD7284_COB-MBA048_\Prc2";
proc dmdb batch data=EMWS1.BINNING_TRAIN
dmdbcat=WORK.EM_DMDB
maxlevel = 101
out=_spdslib.EM_DMDB
;
class %DMDBClass;
target
BAD
;
run;
quit;
*------------------------------------------------------------* ;
* Varsel: Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INPUTS;
    GRP_IMP_CLAGE GRP_IMP_DEBTINC GRP_IMP_NINQ GRP_INDELINQ
%mend INPUTS;
*------------------------------------------------------------* ;
* Varsel: Ordinal Input Variables Macro ;
*------------------------------------------------------------* ;
%macro ORDINALINPUTS;
    GRP_IMP_CLAGE GRP_IMP_DEBTINC GRP_IMP_NINQ GRP_INDELINQ
%mend ORDINALINPUTS;
proc dmine data=_spdslib.EM_DMDB dmdbcat=WORK.EM_DMDB
minr2=0.005 maxrows=3000 stopr2=0.0005 NOAOV16 NOINTER USEGROUPS OUTGROUP=EMWS1.Varsel_OUTGROUP outest=EMWS1.Varsel_OUTESTDMINE outeffect=EMWS1.Varsel_OUTEFFECT outrsquare =EMWS1.Varsel_OUTRSQUARE
NOMONITOR
PSHORT
;
var %INPUTS;
ordinal %ORDINALINPUTS;
target BAD;
code file="J:\JMMORR01\CIS 445\CIS 445 Project 3\Workspaces\EMWS1\Varsel\EMFLOWSCORE.sas";
code file="J:\JMMORR01\CIS 445\CIS 445 Project 3\Workspaces\EMWS1\Varsel\EMPUBLISHSCORE.sas";
run;
quit;
/*      proc print data =EMWS1.Varsel_OUTEFFECT;      proc print data =EMWS1.Varsel_OUTRSQUARE;      */
run;
