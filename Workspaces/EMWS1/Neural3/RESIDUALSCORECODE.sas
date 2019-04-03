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
      F_BAD  $ 12
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

      label I_BAD = 'Into: BAD' ;

      label F_BAD = 'From: BAD' ;

      label U_BAD = 'Unnormalized Into: BAD' ;

      label P_BAD1 = 'Predicted: BAD=1' ;

      label R_BAD1 = 'Residual: BAD=1' ;

      label P_BAD0 = 'Predicted: BAD=0' ;

      label R_BAD0 = 'Residual: BAD=0' ;

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
   H11  =     0.17500848713191 * S_IMP_CLAGE  +     0.05703585768321 * 
        S_IMP_CLNO  +     -0.1531530546784 * S_IMP_DEBTINC
          +    -0.28819458763472 * S_IMP_DELINQ  +    -0.12122230090792 * 
        S_IMP_DEROG  +     0.08205900697099 * S_IMP_MORTDUE
          +    -0.10843398027063 * S_IMP_NINQ  +     -0.0895808863823 * 
        S_IMP_VALUE  +     0.03323102380685 * S_IMP_YOJ
          +     0.08624956480573 * S_LOAN ;
   H11  = H11  +     0.00231325880648 * IMP_JOBMgr  +     0.20918257845978 * 
        IMP_JOBOffice  +      0.0545744267428 * IMP_JOBOther
          +     0.06228462131443 * IMP_JOBProfExe  +     -0.3127202760095 * 
        IMP_JOBSales  +      0.0228463933456 * IMP_REASONDebtCon ;
   H11  =      0.2176968379012 + H11 ;
   H11  = TANH(H11 );
END;
ELSE DO;
   H11  = .;
END;
*** *************************;
*** Writing the Node BAD ;
*** *************************;

*** Generate dummy variables for BAD ;
drop BAD1 BAD0 ;
label F_BAD = 'From: BAD' ;
length F_BAD $ 12;
F_BAD = put( BAD , BEST12. );
%DMNORMIP( F_BAD )
if missing( BAD ) then do;
   BAD1 = .;
   BAD0 = .;
end;
else do;
   if F_BAD = '0'  then do;
      BAD1 = 0;
      BAD0 = 1;
   end;
   else if F_BAD = '1'  then do;
      BAD1 = 1;
      BAD0 = 0;
   end;
   else do;
      BAD1 = .;
      BAD0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_BAD1  =    -3.64046258854667 * H11 ;
   P_BAD1  =    -0.75814361832851 + P_BAD1 ;
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
*** *****************************;
*** Writing the Residuals  of the Node BAD ;
*** ******************************;
IF MISSING( BAD1 ) THEN R_BAD1  = . ;
ELSE R_BAD1  = BAD1  - P_BAD1 ;
IF MISSING( BAD0 ) THEN R_BAD0  = . ;
ELSE R_BAD0  = BAD0  - P_BAD0 ;
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
