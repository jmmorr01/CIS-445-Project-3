***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4 
;
      label S_IMP_CLAGE = 'Standard: IMP_CLAGE' ;

      label S_IMP_CLNO = 'Standard: IMP_CLNO' ;

      label S_IMP_DEBTINC = 'Standard: IMP_DEBTINC' ;

      label S_IMP_DELINQ = 'Standard: IMP_DELINQ' ;

      label S_IMP_DEROG = 'Standard: IMP_DEROG' ;

      label S_IMP_MORTDUE = 'Standard: IMP_MORTDUE' ;

      label S_IMP_NINQ = 'Standard: IMP_NINQ' ;

      label S_IMP_VALUE = 'Standard: IMP_VALUE' ;

      label S_IMP_YOJ = 'Standard: IMP_YOJ' ;

      label S_LOAN = 'Standard: LOAN' ;

      label IMP_JOBMgr = 'Dummy: IMP_JOB=Mgr' ;

      label IMP_JOBOffice = 'Dummy: IMP_JOB=Office' ;

      label IMP_JOBOther = 'Dummy: IMP_JOB=Other' ;

      label IMP_JOBProfExe = 'Dummy: IMP_JOB=ProfExe' ;

      label IMP_JOBSales = 'Dummy: IMP_JOB=Sales' ;

      label IMP_REASONDebtCon = 'Dummy: IMP_REASON=DebtCon' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label I_BAD = 'Into: BAD' ;

      label U_BAD = 'Unnormalized Into: BAD' ;

      label P_BAD1 = 'Predicted: BAD=1' ;

      label P_BAD0 = 'Predicted: BAD=0' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for IMP_JOB ;
drop IMP_JOBMgr IMP_JOBOffice IMP_JOBOther IMP_JOBProfExe IMP_JOBSales ;
*** encoding is sparse, initialize to zero;
IMP_JOBMgr = 0;
IMP_JOBOffice = 0;
IMP_JOBOther = 0;
IMP_JOBProfExe = 0;
IMP_JOBSales = 0;
if missing( IMP_JOB ) then do;
   IMP_JOBMgr = .;
   IMP_JOBOffice = .;
   IMP_JOBOther = .;
   IMP_JOBProfExe = .;
   IMP_JOBSales = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   %DMNORMCP( IMP_JOB , _dm7 )
   _dm_find = 0; drop _dm_find;
   if _dm7 <= 'OTHER'  then do;
      if _dm7 <= 'OFFICE'  then do;
         if _dm7 = 'MGR'  then do;
            IMP_JOBMgr = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm7 = 'OFFICE'  then do;
               IMP_JOBOffice = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm7 = 'OTHER'  then do;
            IMP_JOBOther = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm7 <= 'SALES'  then do;
         if _dm7 = 'PROFEXE'  then do;
            IMP_JOBProfExe = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm7 = 'SALES'  then do;
               IMP_JOBSales = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm7 = 'SELF'  then do;
            IMP_JOBMgr = -1;
            IMP_JOBOffice = -1;
            IMP_JOBOther = -1;
            IMP_JOBProfExe = -1;
            IMP_JOBSales = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      IMP_JOBMgr = .;
      IMP_JOBOffice = .;
      IMP_JOBOther = .;
      IMP_JOBProfExe = .;
      IMP_JOBSales = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_REASON ;
drop IMP_REASONDebtCon ;
if missing( IMP_REASON ) then do;
   IMP_REASONDebtCon = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   %DMNORMCP( IMP_REASON , _dm7 )
   if _dm7 = 'DEBTCON'  then do;
      IMP_REASONDebtCon = 1;
   end;
   else if _dm7 = 'HOMEIMP'  then do;
      IMP_REASONDebtCon = -1;
   end;
   else do;
      IMP_REASONDebtCon = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   IMP_CLAGE , 
   IMP_CLNO , 
   IMP_DEBTINC , 
   IMP_DELINQ , 
   IMP_DEROG , 
   IMP_MORTDUE , 
   IMP_NINQ , 
   IMP_VALUE , 
   IMP_YOJ , 
   LOAN   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_IMP_CLAGE  =     -2.1324986323703 +     0.01177180625915 * IMP_CLAGE ;
   S_IMP_CLNO  =    -2.11100475843317 +     0.09921497033636 * IMP_CLNO ;
   S_IMP_DEBTINC  =    -4.21130359350115 +     0.12464292126092 * IMP_DEBTINC
         ;
   S_IMP_DELINQ  =    -0.40381023676556 +     0.87362166360406 * IMP_DELINQ ;
   S_IMP_DEROG  =    -0.31573464531037 +     1.31032371760165 * IMP_DEROG ;
   S_IMP_MORTDUE  =    -1.76062130304699 +       0.000023929645 * IMP_MORTDUE
         ;
   S_IMP_NINQ  =     -0.7098195299189 +     0.61350782376294 * IMP_NINQ ;
   S_IMP_VALUE  =    -1.78391262611731 +     0.00001740731711 * IMP_VALUE ;
   S_IMP_YOJ  =    -1.21374892345752 +     0.13686286372334 * IMP_YOJ ;
   S_LOAN  =    -1.61848713271866 +     0.00008662382017 * LOAN ;
END;
ELSE DO;
   IF MISSING( IMP_CLAGE ) THEN S_IMP_CLAGE  = . ;
   ELSE S_IMP_CLAGE  =     -2.1324986323703 +     0.01177180625915 * IMP_CLAGE
         ;
   IF MISSING( IMP_CLNO ) THEN S_IMP_CLNO  = . ;
   ELSE S_IMP_CLNO  =    -2.11100475843317 +     0.09921497033636 * IMP_CLNO ;
   IF MISSING( IMP_DEBTINC ) THEN S_IMP_DEBTINC  = . ;
   ELSE S_IMP_DEBTINC  =    -4.21130359350115 +     0.12464292126092 * 
        IMP_DEBTINC ;
   IF MISSING( IMP_DELINQ ) THEN S_IMP_DELINQ  = . ;
   ELSE S_IMP_DELINQ  =    -0.40381023676556 +     0.87362166360406 * 
        IMP_DELINQ ;
   IF MISSING( IMP_DEROG ) THEN S_IMP_DEROG  = . ;
   ELSE S_IMP_DEROG  =    -0.31573464531037 +     1.31032371760165 * IMP_DEROG
         ;
   IF MISSING( IMP_MORTDUE ) THEN S_IMP_MORTDUE  = . ;
   ELSE S_IMP_MORTDUE  =    -1.76062130304699 +       0.000023929645 * 
        IMP_MORTDUE ;
   IF MISSING( IMP_NINQ ) THEN S_IMP_NINQ  = . ;
   ELSE S_IMP_NINQ  =     -0.7098195299189 +     0.61350782376294 * IMP_NINQ ;
   IF MISSING( IMP_VALUE ) THEN S_IMP_VALUE  = . ;
   ELSE S_IMP_VALUE  =    -1.78391262611731 +     0.00001740731711 * IMP_VALUE
         ;
   IF MISSING( IMP_YOJ ) THEN S_IMP_YOJ  = . ;
   ELSE S_IMP_YOJ  =    -1.21374892345752 +     0.13686286372334 * IMP_YOJ ;
   IF MISSING( LOAN ) THEN S_LOAN  = . ;
   ELSE S_LOAN  =    -1.61848713271866 +     0.00008662382017 * LOAN ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.21972525652375 * S_IMP_CLAGE  +     0.01330040415903 * 
        S_IMP_CLNO  +     0.16551178865378 * S_IMP_DEBTINC
          +     0.15242649681575 * S_IMP_DELINQ  +     0.11484860086277 * 
        S_IMP_DEROG  +    -0.17323002680469 * S_IMP_MORTDUE
          +     0.03266885535341 * S_IMP_NINQ  +     0.11182927465915 * 
        S_IMP_VALUE  +       0.056779460262 * S_IMP_YOJ
          +    -0.19006398730418 * S_LOAN ;
   H12  =     0.33701693274519 * S_IMP_CLAGE  +    -0.73710903929568 * 
        S_IMP_CLNO  +     -0.7790860743945 * S_IMP_DEBTINC
          +     1.19533709328823 * S_IMP_DELINQ  +     0.10909868350879 * 
        S_IMP_DEROG  +     0.86008068403726 * S_IMP_MORTDUE
          +     0.42327995806753 * S_IMP_NINQ  +     0.56031253733719 * 
        S_IMP_VALUE  +    -0.02088885098391 * S_IMP_YOJ
          +     0.61898448323789 * S_LOAN ;
   H13  =     0.06661392595187 * S_IMP_CLAGE  +     0.16004565939967 * 
        S_IMP_CLNO  +    -0.42509046876961 * S_IMP_DEBTINC
          +    -0.08121529085358 * S_IMP_DELINQ  +    -0.83008718828754 * 
        S_IMP_DEROG  +     0.49079961836317 * S_IMP_MORTDUE
          +    -0.97437376619078 * S_IMP_NINQ  +     0.29018917672148 * 
        S_IMP_VALUE  +     0.64714151985381 * S_IMP_YOJ
          +     0.10398642906421 * S_LOAN ;
   H11  = H11  +    -0.04805203864087 * IMP_JOBMgr  +    -0.24267700615391 * 
        IMP_JOBOffice  +    -0.09850499493862 * IMP_JOBOther
          +    -0.04245487882776 * IMP_JOBProfExe  +     0.30434386920662 * 
        IMP_JOBSales  +    -0.14740484444989 * IMP_REASONDebtCon ;
   H12  = H12  +     0.23731942458976 * IMP_JOBMgr  +     0.54781013007113 * 
        IMP_JOBOffice  +     -0.0971782122145 * IMP_JOBOther
          +    -0.36965077948409 * IMP_JOBProfExe  +     0.01073327088982 * 
        IMP_JOBSales  +    -0.28624794782265 * IMP_REASONDebtCon ;
   H13  = H13  +    -0.04197522189056 * IMP_JOBMgr  +     0.01523464577788 * 
        IMP_JOBOffice  +     -0.1737413254298 * IMP_JOBOther
          +     0.20525632825676 * IMP_JOBProfExe  +    -0.63529543801715 * 
        IMP_JOBSales  +    -1.09325168842598 * IMP_REASONDebtCon ;
   H11  =    -0.15668820809389 + H11 ;
   H12  =    -2.94086259104725 + H12 ;
   H13  =    -1.32093686502941 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node BAD ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_BAD1  =     3.35089413479668 * H11  +     2.48537539617406 * H12
          +    -1.70286141436651 * H13 ;
   P_BAD1  =     0.16050682366113 + P_BAD1 ;
   P_BAD0  = 0; 
   _MAX_ = MAX (P_BAD1 , P_BAD0 );
   _SUM_ = 0.; 
   P_BAD1  = EXP(P_BAD1  - _MAX_);
   _SUM_ = _SUM_ + P_BAD1 ;
   P_BAD0  = EXP(P_BAD0  - _MAX_);
   _SUM_ = _SUM_ + P_BAD0 ;
   P_BAD1  = P_BAD1  / _SUM_;
   P_BAD0  = P_BAD0  / _SUM_;
END;
ELSE DO;
   P_BAD1  = .;
   P_BAD0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_BAD1  =     0.19939577039274;
   P_BAD0  =     0.80060422960725;
END;
*** *************************;
*** Writing the I_BAD  AND U_BAD ;
*** *************************;
_MAXP_ = P_BAD1 ;
I_BAD  = "1           " ;
U_BAD  =                    1;
IF( _MAXP_ LT P_BAD0  ) THEN DO; 
   _MAXP_ = P_BAD0 ;
   I_BAD  = "0           " ;
   U_BAD  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
