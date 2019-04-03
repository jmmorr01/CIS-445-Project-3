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

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label H14 = 'Hidden: H1=4' ;

      label H15 = 'Hidden: H1=5' ;

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
   H11  =     -0.3017685934797 * S_IMP_CLAGE  +     0.67772949919122 *
        S_IMP_CLNO  +     1.76051663874502 * S_IMP_DEBTINC
          +    -0.65992402913565 * S_IMP_DELINQ  +    -0.15181813253071 *
        S_IMP_DEROG  +    -1.79029417231507 * S_IMP_MORTDUE
          +     0.24427099035887 * S_IMP_NINQ  +    -0.30784019328387 *
        S_IMP_VALUE  +     0.30919279018697 * S_IMP_YOJ
          +    -1.36621980628412 * S_LOAN ;
   H12  =     0.53032845652514 * S_IMP_CLAGE  +     -0.6366888643195 *
        S_IMP_CLNO  +    -2.11121456050444 * S_IMP_DEBTINC
          +    -0.33363860643462 * S_IMP_DELINQ  +    -0.49654770617387 *
        S_IMP_DEROG  +     0.54802157324604 * S_IMP_MORTDUE
          +     0.19264598572389 * S_IMP_NINQ  +    -0.70679349346154 *
        S_IMP_VALUE  +     0.04196782023788 * S_IMP_YOJ
          +    -0.13099188649286 * S_LOAN ;
   H13  =     0.00282582710473 * S_IMP_CLAGE  +    -0.21028500798803 *
        S_IMP_CLNO  +    -0.27051241464249 * S_IMP_DEBTINC
          +     0.24366734922767 * S_IMP_DELINQ  +     0.21891207401132 *
        S_IMP_DEROG  +     0.03701087979685 * S_IMP_MORTDUE
          +     0.21915275016511 * S_IMP_NINQ  +    -0.04369416010243 *
        S_IMP_VALUE  +    -0.17301384533761 * S_IMP_YOJ
          +     0.01947031689577 * S_LOAN ;
   H14  =     0.04010002145966 * S_IMP_CLAGE  +     0.08574567871774 *
        S_IMP_CLNO  +    -6.36519240230978 * S_IMP_DEBTINC
          +      -0.425151531904 * S_IMP_DELINQ  +     0.11691737767998 *
        S_IMP_DEROG  +    -0.16947255553468 * S_IMP_MORTDUE
          +    -0.02109707338782 * S_IMP_NINQ  +    -0.12397227771815 *
        S_IMP_VALUE  +     0.43675659396117 * S_IMP_YOJ
          +     0.18758746301175 * S_LOAN ;
   H15  =    -0.17934176462643 * S_IMP_CLAGE  +    -0.01062194946191 *
        S_IMP_CLNO  +    -1.75865848996631 * S_IMP_DEBTINC
          +     0.09613525018482 * S_IMP_DELINQ  +    -0.15479861612447 *
        S_IMP_DEROG  +     0.10444549762751 * S_IMP_MORTDUE
          +    -0.34687139614226 * S_IMP_NINQ  +     0.24992785705303 *
        S_IMP_VALUE  +     0.41396843324218 * S_IMP_YOJ
          +     0.09779538177636 * S_LOAN ;
   H11  = H11  +    -1.67330879776938 * IMP_JOBMgr  +     0.16757057064923 *
        IMP_JOBOffice  +     0.13267750511725 * IMP_JOBOther
          +     0.74047662930496 * IMP_JOBProfExe  +    -1.31104464424448 *
        IMP_JOBSales  +     0.79923737744783 * IMP_REASONDebtCon ;
   H12  = H12  +     0.13613566163595 * IMP_JOBMgr  +     1.59365591845688 *
        IMP_JOBOffice  +     0.67801461800597 * IMP_JOBOther
          +     0.19181681974747 * IMP_JOBProfExe  +    -2.25621146050576 *
        IMP_JOBSales  +    -0.29828277287433 * IMP_REASONDebtCon ;
   H13  = H13  +     0.16332920963777 * IMP_JOBMgr  +    -0.14886049408019 *
        IMP_JOBOffice  +     0.06719478570477 * IMP_JOBOther
          +    -0.11353875863583 * IMP_JOBProfExe  +    -0.19181249110526 *
        IMP_JOBSales  +     0.11663097049024 * IMP_REASONDebtCon ;
   H14  = H14  +     1.05690784634804 * IMP_JOBMgr  +    -0.27851507675832 *
        IMP_JOBOffice  +      0.3102236813451 * IMP_JOBOther
          +    -0.25632191644424 * IMP_JOBProfExe  +    -0.86625235533524 *
        IMP_JOBSales  +     0.08527855605787 * IMP_REASONDebtCon ;
   H15  = H15  +     0.62302420740797 * IMP_JOBMgr  +       0.482421180363 *
        IMP_JOBOffice  +     0.17027727699736 * IMP_JOBOther
          +     0.39664058551545 * IMP_JOBProfExe  +    -0.75461795393778 *
        IMP_JOBSales  +    -0.67612610938861 * IMP_REASONDebtCon ;
   H11  =    -2.43628954762314 + H11 ;
   H12  =     3.19760305723593 + H12 ;
   H13  =    -0.01403734775582 + H13 ;
   H14  =    -2.31915399939109 + H14 ;
   H15  =     0.76956367031114 + H15 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
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
   P_BAD1  =     1.68183325394287 * H11  +    -4.47637763853637 * H12
          +     4.95877587880174 * H13  +    -2.45252133618952 * H14
          +     2.72907958971005 * H15 ;
   P_BAD1  =     0.60571744508804 + P_BAD1 ;
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
drop
H11
H12
H13
H14
H15
;
drop S_:;
