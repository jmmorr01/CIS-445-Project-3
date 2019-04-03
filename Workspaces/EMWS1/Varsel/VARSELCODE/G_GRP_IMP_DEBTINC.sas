/*----G_GRP_IMP_DEBTINC begin----*/
length _NORM12 $ 12;
_NORM12 = put( GRP_IMP_DEBTINC , BEST12. );
%DMNORMIP( _NORM12 )
drop _NORM12;
select(_NORM12);
when('2' ) G_GRP_IMP_DEBTINC = 0;
when('3' ) G_GRP_IMP_DEBTINC = 1;
when('4' ) G_GRP_IMP_DEBTINC = 2;
when('5' ) G_GRP_IMP_DEBTINC = 2;
otherwise substr(_WARN_, 2, 1) = 'U';
end;
label G_GRP_IMP_DEBTINC="Grouped Levels for  GRP_IMP_DEBTINC";
/*----GRP_IMP_DEBTINC end----*/
