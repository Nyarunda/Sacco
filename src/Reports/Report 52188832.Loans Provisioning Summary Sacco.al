Report 50534 "Loans Provisioning Summary_S"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Provisioning Summary Sacco.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Principal", "Loans Category-SACCO";
            RequestFilterFields = "Loan Product Type";
            DataItemTableView = WHERE(Posted = CONST(true),
                                      "Outstanding Principal" = FILTER(> 0));
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PROVLOSSBAL; PROVLOSSBAL)
            {
            }
            column(V100; 100)
            {
            }
            column(LOSSBAL; LOSSBAL)
            {
            }
            column(LOSSCOUNT; LOSSCOUNT)
            {
            }
            column(DOUBTBAL; DOUBTBAL)
            {
            }
            column(DOUBTCOUNT; DOUBTCOUNT)
            {
            }
            column(V50; 50)
            {
            }
            column(PROVDOUBTBAL; PROVDOUBTBAL)
            {
            }
            column(SUBBAL; SUBBAL)
            {
            }
            column(SUBCOUNT; SUBCOUNT)
            {
            }
            column(V25; 25)
            {
            }
            column(PROVSUBBAL; PROVSUBBAL)
            {
            }
            column(WATCHBAL; WATCHBAL)
            {
            }
            column(WATCHCOUNT; WATCHCOUNT)
            {
            }
            column(V5; 5)
            {
            }
            column(PROVWATCHBAL; PROVWATCHBAL)
            {
            }
            column(PERFOMBAL; PERFOMBAL)
            {
            }
            column(PERFOMCOUNT; PERFOMCOUNT)
            {
            }
            column(V1; 1)
            {
            }
            column(PROVPERFOMBAL; PROVPERFOMBAL)
            {
            }
            column(RESCHEDULE; RESCHEDULE)
            {
            }
            column(V100_Control1102756049; 100)
            {
            }
            column(RESCHEDULE_Control1102756050; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756053; RESCHEDULE)
            {
            }
            column(V50_Control1102756054; 50)
            {
            }
            column(RESCHEDULE_Control1102756055; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756056; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756060; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756061; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756062; RESCHEDULE)
            {
            }
            column(V25_Control1102756063; 25)
            {
            }
            column(RESCHEDULE_Control1102756066; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756067; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756068; RESCHEDULE)
            {
            }
            column(V5_Control1102756069; 5)
            {
            }
            column(RESCHEDULE_Control1102756072; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756073; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756074; RESCHEDULE)
            {
            }
            column(V0_Control1102756075; 1)
            {
            }
            column(RESCHEDULE_Control1102756086; RESCHEDULE)
            {
            }
            column(Tcount; Tcount)
            {
            }
            column(Portfolio; Portfolio)
            {
            }
            column(Tprovision; Tprovision)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaption; RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl)
            {
            }
            column(FORM_4Caption; FORM_4CaptionLbl)
            {
            }
            column(SASRA_2_004Caption; SASRA_2_004CaptionLbl)
            {
            }
            column(R__46_Caption; R__46_CaptionLbl)
            {
            }
            column(No__of_A_C_sCaption; No__of_A_C_sCaptionLbl)
            {
            }
            column(Outstanding_Loan_Portfolio__Kshs__Caption; Outstanding_Loan_Portfolio__Kshs__CaptionLbl)
            {
            }
            column(Required_Provision____Caption; Required_Provision____CaptionLbl)
            {
            }
            column(Required_Provision_Amount__Kshs__Caption; Required_Provision_Amount__Kshs__CaptionLbl)
            {
            }
            column(ClassificationCaption; ClassificationCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(ACaption; ACaptionLbl)
            {
            }
            column(BCaption; BCaptionLbl)
            {
            }
            column(CCaption; CCaptionLbl)
            {
            }
            column(DCaption; DCaptionLbl)
            {
            }
            column(PORTFOLIO_AGEING_REPORTCaption; PORTFOLIO_AGEING_REPORTCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(PerfomingCaption; PerfomingCaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(LossCaption_Control1102756051; LossCaption_Control1102756051Lbl)
            {
            }
            column(DoubtfulCaption_Control1102756052; DoubtfulCaption_Control1102756052Lbl)
            {
            }
            column(V4Caption_Control1102756057; V4Caption_Control1102756057Lbl)
            {
            }
            column(V5Caption_Control1102756058; V5Caption_Control1102756058Lbl)
            {
            }
            column(SubstandardCaption_Control1102756059; SubstandardCaption_Control1102756059Lbl)
            {
            }
            column(V3Caption_Control1102756064; V3Caption_Control1102756064Lbl)
            {
            }
            column(WatchCaption_Control1102756065; WatchCaption_Control1102756065Lbl)
            {
            }
            column(V2Caption_Control1102756070; V2Caption_Control1102756070Lbl)
            {
            }
            column(PerfomingCaption_Control1102756071; PerfomingCaption_Control1102756071Lbl)
            {
            }
            column(V1Caption_Control1102756076; V1Caption_Control1102756076Lbl)
            {
            }
            column(Rescheduled_Renegotiated_LoansCaption; Rescheduled_Renegotiated_LoansCaptionLbl)
            {
            }
            column(Sub_TotalCaption; Sub_TotalCaptionLbl)
            {
            }
            column(AUTHORIZATIONCaption; AUTHORIZATIONCaptionLbl)
            {
            }
            column(We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_Caption; We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_CaptionLbl)
            {
            }
            column(Sign__________________________________________________Date_____________________________Caption; Sign__________________________________________________Date_____________________________CaptionLbl)
            {
            }
            column(Name_of_Authorizing_OfficerCaption; Name_of_Authorizing_OfficerCaptionLbl)
            {
            }
            column(Sign__________________________________________________Date_____________________________Caption_Control1102756084; Sign__________________________________________________Date_____________________________Caption_Control1102756084Lbl)
            {
            }
            column(Name_of_Counter_Signing_OfficerCaption; Name_of_Counter_Signing_OfficerCaptionLbl)
            {
            }
            column(Loans_Loan__No_; Loans."Loan No.")
            {
            }
            column(RESPERFOMBAL; RESPERFOMBAL)
            {
            }
            column(RESWATCHBAL; RESWATCHBAL)
            {
            }
            column(RESSUBBAL; RESSUBBAL)
            {
            }
            column(RESDOUBTBAL; RESDOUBTBAL)
            {
            }
            column(RESLOSSBAL; RESLOSSBAL)
            {
            }
            column(RESPERFOMCOUNT; RESPERFOMCOUNT)
            {
            }
            column(RESWATCHCOUNT; RESWATCHCOUNT)
            {
            }
            column(RESSUBCOUNT; RESSUBCOUNT)
            {
            }
            column(RESDOUBTCOUNT; RESDOUBTCOUNT)
            {
            }
            column(RESLOSSCOUNT; RESLOSSCOUNT)
            {
            }
            column(RESPROVPERFOMBAL; RESPROVPERFOMBAL)
            {
            }
            column(RESPROVWATCHBAL; RESPROVWATCHBAL)
            {
            }
            column(RESPROVSUBBAL; RESPROVSUBBAL)
            {
            }
            column(RESPROVDOUBTBAL; RESPROVDOUBTBAL)
            {
            }
            column(RESPROVLOSSBAL; RESPROVLOSSBAL)
            {
            }
            column(RESTcount; RESTcount)
            {
            }
            column(RESPortfolio; RESPortfolio)
            {
            }
            column(RESTprovision; RESTprovision)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Loans."Disbursement Date" > AsAt THEN
                    CurrReport.SKIP;

                Loans.CALCFIELDS("Outstanding Principal");
                IF Loans."Outstanding Principal" = 0 THEN
                    CurrReport.SKIP;
                IF Loans."Loan Rescheduled" = false THEN BEGIN
                    Loans.CALCFIELDS("Loans Category-SACCO", "Outstanding Principal");
                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Perfoming THEN BEGIN
                        PERFOMBAL := PERFOMBAL + Loans."Outstanding Principal";
                        PERFOMCOUNT := PERFOMCOUNT + 1;
                        PROVPERFOMBAL := PERFOMBAL * 0.01;
                    END;

                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Watch THEN BEGIN
                        WATCHBAL := WATCHBAL + Loans."Outstanding Principal";
                        WATCHCOUNT := WATCHCOUNT + 1;
                        PROVWATCHBAL := WATCHBAL * 0.05;
                    END;

                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Substandard THEN BEGIN
                        SUBBAL := SUBBAL + Loans."Outstanding Principal";
                        SUBCOUNT := SUBCOUNT + 1;
                        PROVSUBBAL := SUBBAL * 0.25;
                    END;

                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Doubtful THEN BEGIN
                        DOUBTBAL := DOUBTBAL + Loans."Outstanding Principal";
                        DOUBTCOUNT := DOUBTCOUNT + 1;
                        PROVDOUBTBAL := DOUBTBAL * 0.5;
                    END;

                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Loss THEN BEGIN
                        LOSSBAL := LOSSBAL + Loans."Outstanding Principal";
                        LOSSCOUNT := LOSSCOUNT + 1;
                        PROVLOSSBAL := LOSSBAL * 1.0;
                    END;

                    Tcount := PERFOMCOUNT + WATCHCOUNT + SUBCOUNT + DOUBTCOUNT + LOSSCOUNT;
                    Portfolio := PERFOMBAL + WATCHBAL + SUBBAL + DOUBTBAL + LOSSBAL;
                    Tprovision := PROVPERFOMBAL + PROVWATCHBAL + PROVSUBBAL + PROVDOUBTBAL + PROVLOSSBAL;
                END ELSE IF Loans."Loan Rescheduled" THEN BEGIN
                    Loans.CALCFIELDS("Loans Category-SACCO", "Outstanding Principal");
                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Perfoming THEN BEGIN
                        RESPERFOMBAL := RESPERFOMBAL + Loans."Outstanding Principal";
                        RESPERFOMCOUNT := RESPERFOMCOUNT + 1;
                        RESPROVPERFOMBAL := RESPERFOMBAL * 0.01;
                    END;

                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Watch THEN BEGIN
                        RESWATCHBAL := RESWATCHBAL + Loans."Outstanding Principal";
                        RESWATCHCOUNT := RESWATCHCOUNT + 1;
                        RESPROVWATCHBAL := RESWATCHBAL * 0.05;
                    END;

                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Substandard THEN BEGIN
                        RESSUBBAL := RESSUBBAL + Loans."Outstanding Principal";
                        RESSUBCOUNT := RESSUBCOUNT + 1;
                        RESPROVSUBBAL := RESSUBBAL * 0.25;
                    END;

                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Doubtful THEN BEGIN
                        RESDOUBTBAL := RESDOUBTBAL + Loans."Outstanding Principal";
                        RESDOUBTCOUNT := RESDOUBTCOUNT + 1;
                        RESPROVDOUBTBAL := RESDOUBTBAL * 0.5;
                    END;

                    IF Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Loss THEN BEGIN
                        RESLOSSBAL := RESLOSSBAL + Loans."Outstanding Principal";
                        RESLOSSCOUNT := RESLOSSCOUNT + 1;
                        RESPROVLOSSBAL := RESLOSSBAL * 1.0;
                    END;

                    RESTcount := RESPERFOMCOUNT + RESWATCHCOUNT + RESSUBCOUNT + RESDOUBTCOUNT + RESLOSSCOUNT;
                    RESPortfolio := RESPERFOMBAL + RESWATCHBAL + RESSUBBAL + RESDOUBTBAL + RESLOSSBAL;
                    RESTprovision := RESPROVPERFOMBAL + RESPROVWATCHBAL + RESPROVSUBBAL + RESPROVDOUBTBAL + RESPROVLOSSBAL;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF AsAt = 0D THEN AsAt := TODAY;
                Loans.SETFILTER("Date Filter", '..%1', AsAt);

                PERFOMBAL := 0;
                PERFOMCOUNT := 0;
                PROVPERFOMBAL := 0;
                WATCHBAL := 0;
                WATCHCOUNT := 0;
                PROVWATCHBAL := 0;
                SUBBAL := 0;
                SUBCOUNT := 0;
                PROVSUBBAL := 0;
                DOUBTBAL := 0;
                DOUBTCOUNT := 0;
                PROVDOUBTBAL := 0;
                LOSSBAL := 0;
                LOSSCOUNT := 0;
                PROVLOSSBAL := 0;
                Tcount := 0;
                Portfolio := 0;
                Tprovision := 0;

                RESPERFOMBAL := 0;
                RESPERFOMCOUNT := 0;
                RESPROVPERFOMBAL := 0;
                RESWATCHBAL := 0;
                RESWATCHCOUNT := 0;
                RESPROVWATCHBAL := 0;
                RESSUBBAL := 0;
                RESSUBCOUNT := 0;
                RESPROVSUBBAL := 0;
                RESDOUBTBAL := 0;
                RESDOUBTCOUNT := 0;
                RESPROVDOUBTBAL := 0;
                RESLOSSBAL := 0;
                RESLOSSCOUNT := 0;
                RESPROVLOSSBAL := 0;
                RESTcount := 0;
                RESPortfolio := 0;
                RESTprovision := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date Filter")
                {
                    field("As At"; AsAt)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE(StatusPermission."User ID", USERID);
        //StatusPermission.SETRANGE(StatusPermission,TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            //ERROR('You Do Not have Permission to perform this action');
        END;
    end;

    var
        IntAmount: Decimal;
        RInst: Integer;
        "Net Repayment": Decimal;
        InCount: Integer;
        LoansT: Record Loans;
        PERFOMBAL: Decimal;
        WATCHBAL: Decimal;
        SUBBAL: Decimal;
        DOUBTBAL: Decimal;
        LOSSBAL: Decimal;
        PERFOMCOUNT: Integer;
        WATCHCOUNT: Integer;
        SUBCOUNT: Integer;
        DOUBTCOUNT: Integer;
        LOSSCOUNT: Integer;
        PROVPERFOMBAL: Decimal;
        PROVWATCHBAL: Decimal;
        PROVSUBBAL: Decimal;
        PROVDOUBTBAL: Decimal;
        PROVLOSSBAL: Decimal;
        Tcount: Integer;
        Portfolio: Decimal;
        Tprovision: Decimal;
        RESCHEDULE: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: Label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: Label 'FORM 4';
        SASRA_2_004CaptionLbl: Label 'SASRA 2/004';
        R__46_CaptionLbl: Label 'R.(46)';
        No__of_A_C_sCaptionLbl: Label 'No. of A/C''s';
        Outstanding_Loan_Portfolio__Kshs__CaptionLbl: Label 'Outstanding Loan Portfolio (Kshs.)';
        Required_Provision____CaptionLbl: Label 'Required Provision (%)';
        Required_Provision_Amount__Kshs__CaptionLbl: Label 'Required Provision Amount (Kshs.)';
        ClassificationCaptionLbl: Label 'Classification';
        No_CaptionLbl: Label 'No.';
        ACaptionLbl: Label 'A';
        BCaptionLbl: Label 'B';
        CCaptionLbl: Label 'C';
        DCaptionLbl: Label 'D';
        PORTFOLIO_AGEING_REPORTCaptionLbl: Label 'PORTFOLIO AGEING REPORT';
        LossCaptionLbl: Label 'Loss';
        DoubtfulCaptionLbl: Label 'Doubtful';
        SubstandardCaptionLbl: Label 'Substandard';
        WatchCaptionLbl: Label 'Watch';
        PerfomingCaptionLbl: Label 'Perfoming';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V4CaptionLbl: Label '4';
        V5CaptionLbl: Label '5';
        LossCaption_Control1102756051Lbl: Label 'Loss';
        DoubtfulCaption_Control1102756052Lbl: Label 'Doubtful';
        V4Caption_Control1102756057Lbl: Label '4';
        V5Caption_Control1102756058Lbl: Label '5';
        SubstandardCaption_Control1102756059Lbl: Label 'Substandard';
        V3Caption_Control1102756064Lbl: Label '3';
        WatchCaption_Control1102756065Lbl: Label 'Watch';
        V2Caption_Control1102756070Lbl: Label '2';
        PerfomingCaption_Control1102756071Lbl: Label 'Perfoming';
        V1Caption_Control1102756076Lbl: Label '1';
        Rescheduled_Renegotiated_LoansCaptionLbl: Label 'Rescheduled/Renegotiated Loans';
        Sub_TotalCaptionLbl: Label 'Sub-Total';
        AUTHORIZATIONCaptionLbl: Label 'AUTHORIZATION';
        We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_CaptionLbl: Label 'We declare that this return, to the best of our knowledge and belief is correct.';
        Sign__________________________________________________Date_____________________________CaptionLbl: Label '................................................Sign..................................................Date.............................';
        Name_of_Authorizing_OfficerCaptionLbl: Label 'Name of Authorizing Officer';
        Sign__________________________________________________Date_____________________________Caption_Control1102756084Lbl: Label '................................................Sign..................................................Date.............................';
        Name_of_Counter_Signing_OfficerCaptionLbl: Label 'Name of Counter Signing Officer';
        datefilter: Date;
        maxdate: Text;
        AsAt: Date;
        StatusPermission: Record "User Setup";
        RESPERFOMBAL: Decimal;
        RESWATCHBAL: Decimal;
        RESSUBBAL: Decimal;
        RESDOUBTBAL: Decimal;
        RESLOSSBAL: Decimal;
        RESPERFOMCOUNT: Integer;
        RESWATCHCOUNT: Integer;
        RESSUBCOUNT: Integer;
        RESDOUBTCOUNT: Integer;
        RESLOSSCOUNT: Integer;
        RESPROVPERFOMBAL: Decimal;
        RESPROVWATCHBAL: Decimal;
        RESPROVSUBBAL: Decimal;
        RESPROVDOUBTBAL: Decimal;
        RESPROVLOSSBAL: Decimal;
        RESTcount: Integer;
        RESPortfolio: Decimal;
        RESTprovision: Decimal;
}
