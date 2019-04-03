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
      label G_GRP_IMP_DEBTINC0 = 'Dummy: G_GRP_IMP_DEBTINC=0' ;

      label G_GRP_IMP_DEBTINC1 = 'Dummy: G_GRP_IMP_DEBTINC=1' ;

      label GRP_IMP_CLAGE2 = 'Dummy: GRP_IMP_CLAGE=2' ;

      label GRP_IMP_CLAGE3 = 'Dummy: GRP_IMP_CLAGE=3' ;

      label GRP_IMP_CLAGE4 = 'Dummy: GRP_IMP_CLAGE=4' ;

      label GRP_IMP_NINQ1 = 'Dummy: GRP_IMP_NINQ=1' ;

      label GRP_IMP_NINQ2 = 'Dummy: GRP_IMP_NINQ=2' ;

      label GRP_IMP_NINQ3 = 'Dummy: GRP_IMP_NINQ=3' ;

      label GRP_INDELINQ3 = 'Dummy: GRP_INDELINQ=3' ;

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

*** Generate dummy variables for G_GRP_IMP_DEBTINC ;
drop G_GRP_IMP_DEBTINC0 G_GRP_IMP_DEBTINC1 ;
if missing( G_GRP_IMP_DEBTINC ) then do;
   G_GRP_IMP_DEBTINC0 = .;
   G_GRP_IMP_DEBTINC1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( G_GRP_IMP_DEBTINC , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      G_GRP_IMP_DEBTINC0 = -1;
      G_GRP_IMP_DEBTINC1 = -1;
   end;
   else if _dm12 = '1'  then do;
      G_GRP_IMP_DEBTINC0 = 0;
      G_GRP_IMP_DEBTINC1 = 1;
   end;
   else if _dm12 = '0'  then do;
      G_GRP_IMP_DEBTINC0 = 1;
      G_GRP_IMP_DEBTINC1 = 0;
   end;
   else do;
      G_GRP_IMP_DEBTINC0 = .;
      G_GRP_IMP_DEBTINC1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_IMP_CLAGE ;
drop GRP_IMP_CLAGE2 GRP_IMP_CLAGE3 GRP_IMP_CLAGE4 ;
if missing( GRP_IMP_CLAGE ) then do;
   GRP_IMP_CLAGE2 = .;
   GRP_IMP_CLAGE3 = .;
   GRP_IMP_CLAGE4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_IMP_CLAGE , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '3'  then do;
      GRP_IMP_CLAGE2 = 0.63245553203367;
      GRP_IMP_CLAGE3 = -0.63245553203367;
      GRP_IMP_CLAGE4 = -0.63245553203367;
   end;
   else if _dm12 = '5'  then do;
      GRP_IMP_CLAGE2 = 0.63245553203367;
      GRP_IMP_CLAGE3 = 0.63245553203367;
      GRP_IMP_CLAGE4 = 0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_IMP_CLAGE2 = -0.63245553203367;
      GRP_IMP_CLAGE3 = -0.63245553203367;
      GRP_IMP_CLAGE4 = -0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_IMP_CLAGE2 = 0.63245553203367;
      GRP_IMP_CLAGE3 = 0.63245553203367;
      GRP_IMP_CLAGE4 = -0.63245553203367;
   end;
   else do;
      GRP_IMP_CLAGE2 = .;
      GRP_IMP_CLAGE3 = .;
      GRP_IMP_CLAGE4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_IMP_NINQ ;
drop GRP_IMP_NINQ1 GRP_IMP_NINQ2 GRP_IMP_NINQ3 ;
if missing( GRP_IMP_NINQ ) then do;
   GRP_IMP_NINQ1 = .;
   GRP_IMP_NINQ2 = .;
   GRP_IMP_NINQ3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_IMP_NINQ , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      GRP_IMP_NINQ1 = -0.63245553203367;
      GRP_IMP_NINQ2 = -0.63245553203367;
      GRP_IMP_NINQ3 = -0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_IMP_NINQ1 = 0.63245553203367;
      GRP_IMP_NINQ2 = -0.63245553203367;
      GRP_IMP_NINQ3 = -0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_IMP_NINQ1 = 0.63245553203367;
      GRP_IMP_NINQ2 = 0.63245553203367;
      GRP_IMP_NINQ3 = 0.63245553203367;
   end;
   else if _dm12 = '3'  then do;
      GRP_IMP_NINQ1 = 0.63245553203367;
      GRP_IMP_NINQ2 = 0.63245553203367;
      GRP_IMP_NINQ3 = -0.63245553203367;
   end;
   else do;
      GRP_IMP_NINQ1 = .;
      GRP_IMP_NINQ2 = .;
      GRP_IMP_NINQ3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_INDELINQ ;
drop GRP_INDELINQ3 ;
if missing( GRP_INDELINQ ) then do;
   GRP_INDELINQ3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_INDELINQ , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '3'  then do;
      GRP_INDELINQ3 = -1;
   end;
   else if _dm12 = '4'  then do;
      GRP_INDELINQ3 = 1;
   end;
   else do;
      GRP_INDELINQ3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node ord ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.63350027528629 * G_GRP_IMP_DEBTINC0  +    -0.50507654118674 *
        G_GRP_IMP_DEBTINC1 ;
   H12  =     -0.0719710087899 * G_GRP_IMP_DEBTINC0  +    -0.17157822907543 *
        G_GRP_IMP_DEBTINC1 ;
   H13  =    -0.27197262042419 * G_GRP_IMP_DEBTINC0  +    -0.15460987741074 *
        G_GRP_IMP_DEBTINC1 ;
   H14  =    -0.53685316522324 * G_GRP_IMP_DEBTINC0  +     0.40092805253601 *
        G_GRP_IMP_DEBTINC1 ;
   H15  =     1.05821426686083 * G_GRP_IMP_DEBTINC0  +    -0.27257208635493 *
        G_GRP_IMP_DEBTINC1 ;
   H11  = H11  +     1.22578707350225 * GRP_IMP_CLAGE2
          +  1.0000000827403E-10 * GRP_IMP_CLAGE3  +  1.0000000133514E-10 *
        GRP_IMP_CLAGE4  +     0.59501072667634 * GRP_IMP_NINQ1
          +  9.9999994396249E-11 * GRP_IMP_NINQ2  +     1.52286118790381 *
        GRP_IMP_NINQ3  +  1.0000000827403E-10 * GRP_INDELINQ3 ;
   H12  = H12  +                1E-10 * GRP_IMP_CLAGE2
          +     0.84850082164068 * GRP_IMP_CLAGE3  +     0.51459127964493 *
        GRP_IMP_CLAGE4  +     0.29007181943664 * GRP_IMP_NINQ1
          +     0.58471095303443 * GRP_IMP_NINQ2  +     0.40965666460584 *
        GRP_IMP_NINQ3  +                1E-10 * GRP_INDELINQ3 ;
   H13  = H13  +     0.95869402187507 * GRP_IMP_CLAGE2
          +     0.80116832119809 * GRP_IMP_CLAGE3  +     0.63762800523573 *
        GRP_IMP_CLAGE4  +     0.68770440362066 * GRP_IMP_NINQ1
          +     0.80490858515248 * GRP_IMP_NINQ2  +  1.0000000133514E-10 *
        GRP_IMP_NINQ3  +     0.31419008317281 * GRP_INDELINQ3 ;
   H14  = H14  +     0.04593887318837 * GRP_IMP_CLAGE2
          +     0.14899322243251 * GRP_IMP_CLAGE3  +                1E-10 *
        GRP_IMP_CLAGE4  +     0.11044493377131 * GRP_IMP_NINQ1
          +     0.21505260829155 * GRP_IMP_NINQ2  +     0.42030101265196 *
        GRP_IMP_NINQ3  +     0.16857952722716 * GRP_INDELINQ3 ;
   H15  = H15  +  1.0000000827403E-10 * GRP_IMP_CLAGE2
          +     1.03149586299847 * GRP_IMP_CLAGE3  +     0.73005942364469 *
        GRP_IMP_CLAGE4  +  1.0000000827403E-10 * GRP_IMP_NINQ1
          +     1.16577576912136 * GRP_IMP_NINQ2  +     0.34013692900383 *
        GRP_IMP_NINQ3  +     0.42692302316857 * GRP_INDELINQ3 ;
   H11  =    -1.42228897462966 + H11 ;
   H12  =    -0.75788240766799 + H12 ;
   H13  =     1.97804881573188 + H13 ;
   H14  =     0.09480909579747 + H14 ;
   H15  =    -1.48090682130621 + H15 ;
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
   P_BAD1  =    -0.65045588717447 * H11  +    -3.01325219538561 * H12
          +    -0.92628078956314 * H13  +      4.1244825171781 * H14
          +     2.49327582479654 * H15 ;
   P_BAD1  =    -1.07700005621969 + P_BAD1 ;
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
