/// <summary>
/// Report Member Statement - Summary (ID 50393).
/// </summary>
report 50393 "Member Statement - Summary"
{
    ApplicationArea = All;
    Caption = 'Member Statement - Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Statement - Summary.rdlc';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(LoanProvBal; LoanProvBal)
            {
            }
            column(M_no; Members."No.")
            {
            }
            column(MAddress; Members.Address)
            {
            }
            column(Account; Members."Employer Code")
            {
            }
            column(DOB; Members."Date of Birth")
            {
            }
            column(MName; Members.Name)
            {
            }
            column(M_Email; Members."E-Mail")
            {
            }
            column(MID; Members."ID No.")
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(UserName; UserName)
            {
            }
            column(MPhone; Members."Mobile Phone No.")
            {
            }
            column(DepLoanRatio; DepLoanRatio)
            {
            }
            column(DepGuarRatio; DepGuarRatio)
            {
            }
            column(MonthlyRep; MonthlyRep)
            {
            }
            column(TArrears; TArrears)
            {
            }
            column(Black; Black)
            {
            }
            column(Status_Members; Members."Member Status")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(Web; Web)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(PeriodFilter; PeriodFilter)
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(WorkingDate_Member; FORMAT(TODAY, 0, 4))
            {
            }
            column(sHARES_Member; sHARES)
            {
            }
            column(Bbf_Member; Bbf)
            {
            }
            column(InstantLoan_Member; InstantLoan)
            {
            }
            column(FosaLoan_Member; FosaLoan)
            {
            }
            column(BosaLoan_Member; BosaLoan)
            {
            }
            column(Jiajiri; Jiajiri)
            {
            }
            column(TOutInt; TOutInt)
            {
            }
            column(MCash; MCash)
            {
            }
            column(MobileLoans; MobileLoans)
            {
            }
            column(SecAmt; SecAmt)
            {
            }
            column(MembrEligibility; MembrEligibility)
            {
            }
            dataitem("Member Statements"; "Statement Buffer New")
            {
                DataItemLink = "Member No" = FIELD("No.");
                DataItemTableView = SORTING("Member No", Date);
                column(MonthlyShares; MonthlyShares)
                {
                }
                column(MonthlyBBF; MonthlyBBF)
                {
                }
                column(Date_MemberStatements; DatePeriod)
                {
                }
                column(OpeningBalance_MemberStatements; "Member Statements".OpeningBalLoans)
                {
                }
                column(NewLoans_MemberStatements; "Member Statements"."New Loans")
                {
                }
                column(Repayment_MemberStatements; "Member Statements"."Loan Repayments")
                {
                }
                column(InterestPaid_MemberStatements; "Member Statements"."Interest Paid")
                {
                }
                column(InterestDue_MemberStatements; "Member Statements"."Interest Dues")
                {
                }
                column(OustandingInterest_MemberStatements; "Member Statements"."Oustanding Interest")
                {
                }
                column(OustandingLoan_MemberStatements; "Member Statements"."Oustanding Loan")
                {
                }
                column(DepositOpeningBalance_MemberStatements; "Member Statements".DepOpeingBal)
                {
                }
                column(DepositContribution_MemberStatements; "Member Statements"."DepContrib.")
                {
                }
                column(ClosingDeposits_MemberStatements; "Member Statements".DepClosingBal)
                {
                }
                column(MonthContribution_MemberStatements; "Member Statements".MonthlyShares)
                {
                }
                column(Share_Capital_MemberStatements; "Share Capital")
                {
                }
                column(TotalLoans; TotalLoans)
                {
                }
                column(TotRcpt; "Member Statements"."Total Contribution")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DatePeriod := (FORMAT("Member Statements".Date, 0, '<Month Text,3>  <Year4> '));
                    sHARES := 0;
                    Bbf := 0;

                    SAccount.RESET;
                    SAccount.SETRANGE("Member No.", "Member No");
                    SAccount.SetFilter("Product Category", '%1|%2|%3',
                        SAccount."Product Category"::"Share Capital",
                        SAccount."Product Category"::"Benevolent Fund",
                        SAccount."Product Category"::Jiajiri);
                    SAccount.SetLoadFields("No.", "Product Category", "Balance (LCY)");
                    SAccount.SetAutoCalcFields("Balance (LCY)");
                    IF SAccount.FIND('-') THEN BEGIN
                        repeat
                            if SAccount."Product Category" = SAccount."Product Category"::"Share Capital" then
                                sHARES := SAccount."Balance (LCY)";
                            if SAccount."Product Category" = SAccount."Product Category"::"Benevolent Fund" then
                                Bbf := SAccount."Balance (LCY)";
                            MName := SAccount.Name;
                            if SAccount."Product Category" = SAccount."Product Category"::Jiajiri then
                                Jiajiri := SAccount."Balance (LCY)";
                        until SAccount.Next() = 0;
                    END;


                    MonthlyBBF := 0;
                    MonthlyShares := 0;

                    SAccount.RESET;
                    SAccount.SETRANGE("Member No.", "Member No");
                    SAccount.SETFILTER("Date Filter", '%1..%2', CALCDATE('-CM', "Member Statements".Date), CALCDATE('CM', "Member Statements".Date));
                    SAccount.SetFilter("Product Category", '%1|%2',
                        SAccount."Product Category"::"Share Capital", SAccount."Product Category"::"Benevolent Fund");
                    SAccount.SetLoadFields("No.", "Product Category", "Balance (LCY)");
                    SAccount.SetAutoCalcFields("Balance (LCY)");
                    IF SAccount.FIND('-') THEN
                        repeat
                            if SAccount."Product Category" = SAccount."Product Category"::"Benevolent Fund" then
                                MonthlyBBF := SAccount."Balance (LCY)";
                            if SAccount."Product Category" = SAccount."Product Category"::"Share Capital" then
                                MonthlyShares := SAccount."Balance (LCY)";
                        until SAccount.Next() = 0;

                    InstantLoan := 0;
                    LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", "Member No");
                    LoanApps.SETFILTER(LoanApps."Loan Product Type", 'L24');
                    LoanApps.SetAutoCalcFields("Outstanding Principal", "Total Outstanding Balance");
                    LoanApps.SetLoadFields("Outstanding Principal", "Loan Product Type", "Total Outstanding Balance");
                    IF LoanApps.FIND('-') THEN BEGIN
                        REPEAT
                            IF LoanApps."Total Outstanding Balance" <> 0 THEN
                                InstantLoan := LoanApps."Total Outstanding Balance" + InstantLoan;
                        UNTIL LoanApps.NEXT = 0;
                    END;

                    FosaLoan := 0;
                    LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", "Member No");
                    LoanApps.SETFILTER(LoanApps."Loan Product Type", '<>L24&<>L30');
                    LoanApps.SetRange("Mobile Loan", false);
                    LoanApps.SetRange(Source, LoanApps.Source::FOSA);
                    LoanApps.SetAutoCalcFields("Outstanding Principal", "Total Outstanding Balance");
                    LoanApps.SetLoadFields("Outstanding Principal", "Total Outstanding Balance", "Loan Product Type");
                    IF LoanApps.FindSet() THEN BEGIN
                        REPEAT
                            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                IF NOT LoanType."Appraise Deposits" THEN
                                    IF LoanApps."Total Outstanding Balance" > 0 THEN BEGIN
                                        FosaLoan := LoanApps."Total Outstanding Balance" + FosaLoan;
                                    END;
                            END;
                        UNTIL LoanApps.NEXT = 0;
                    END;

                    BosaLoan := 0;
                    LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", "Member No");
                    LoanApps.SetRange(Source, LoanApps.Source::BOSA);
                    LoanApps.SetAutoCalcFields("Outstanding Principal", "Total Outstanding Balance");
                    LoanApps.SetLoadFields("Outstanding Principal", "Total Outstanding Balance", "Loan Product Type");
                    IF LoanApps.FIND('-') THEN BEGIN
                        REPEAT
                            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                IF NOT LoanType."Appraise Deposits" THEN
                                    IF LoanApps."Total Outstanding Balance" > 0 THEN BEGIN
                                        BosaLoan := LoanApps."Total Outstanding Balance" + BosaLoan;
                                    END;
                            END;
                        UNTIL LoanApps.NEXT = 0;
                    END;

                    MCash := 0;
                    /*LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", "Member No");
                    LoanApps.SetRange(LoanApps."Loan Product Type", 'L30');
                    LoanApps.SetAutoCalcFields("Outstanding Principal", "Total Outstanding Balance");
                    LoanApps.SetLoadFields("Loan No.", "Total Outstanding Balance", "Outstanding Principal");
                    IF LoanApps.FIND('-') THEN BEGIN
                        REPEAT
                            IF LoanApps."Total Outstanding Balance" > 0 THEN BEGIN
                                MCash += LoanApps."Total Outstanding Balance";
                            END;
                        UNTIL LoanApps.NEXT = 0;
                    END;*/

                    LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", "Member No");
                    LoanApps.SetRange("Mobile Loan", true);
                    LoanApps.SetAutoCalcFields("Outstanding Principal", "Total Outstanding Balance");
                    LoanApps.SetLoadFields("Loan No.", "Total Outstanding Balance", "Outstanding Principal");
                    IF LoanApps.FIND('-') THEN BEGIN
                        REPEAT
                            IF LoanApps."Total Outstanding Balance" > 0 THEN BEGIN
                                MobileLoans += LoanApps."Total Outstanding Balance";
                            END;
                        UNTIL LoanApps.NEXT = 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin

                    //MESSAGE('TOutInt %1',TOutInt);
                end;
            }

            dataitem(Vendor; "Savings Accounts")
            {
                DataItemLink = "Member No." = FIELD("No.");
                DataItemTableView = where("Product Category" = filter("Junior Savings" | "Holiday Savings" | Investment | Jiajiri | "Ordinary Savings" | "Fixed Deposit" | "Unallocated Fund" | "Dividend Account" | "MFI Deposit"));
                column(AccountType_Vendor; "Product Name")
                {
                }
                column(FosaBal; FosaBal)
                {
                }
                column(Child; Child)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Child := '';
                    FosaBal := 0;
                    IF Vendor."Product Category" = Vendor."Product Category"::"Junior Savings" THEN
                        Child := Name;

                    FosaBal := PeriodicActivities.GetAccountBalance(Vendor."No.");

                end;
            }

            dataitem(Security; "Loan Security")
            {
                DataItemLink = "Member No" = FIELD("No.");
                DataItemTableView = WHERE("Guarantor Type" = CONST(Collateral),
                                         "Outstanding Principal" = FILTER(> 0));
                column(OutstandingBalance_LoanGuarantorsandSecurity; "Outstanding Principal")
                {
                }
                column(SecLoan; SecLoan)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SecLoan := '';

                end;

                trigger OnPreDataItem()
                begin
                    SecAmt := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                DepAmt: Decimal;
                LoanRepay: Decimal;
                SeccoStup: Record "Sacco Setup";
                GoLiveDepositBal: Decimal;
                GoLiveShareBal: Decimal;
                SaccoActivities: Codeunit "Sacco Activities";
            begin
                SeccoStup.Get();

                IF Members."Mobile Phone No." = '' THEN
                    Members."Mobile Phone No." := Members."Phone No.";

                SecAmt := 0;

                SecuritiesRegister.RESET;
                SecuritiesRegister.SetRange("Account No.", Members."No.");
                SecuritiesRegister.SetRange(Status, SecuritiesRegister.Status::Approved);
                SecuritiesRegister.SetRange("Inward/Outward", SecuritiesRegister."Inward/Outward"::"In-Store");
                IF SecuritiesRegister.FindSet() THEN BEGIN
                    REPEAT
                        SecAmt += SecuritiesRegister."Collateral Limit";
                    UNTIL SecuritiesRegister.NEXT = 0;
                END;

                //MESSAGE('%1',SecAmt);


                LoanProvBal := 0;
                /*LoanApps.RESET;
                LoanApps.SETRANGE("Member No.", Members."No.");
                LoanApps.SETFILTER("Outstanding Principal", '>0');
                IF LoanApps.FINDFIRST THEN BEGIN
                    REPEAT
                    //LoanApps.CALCFIELDS("Loan Provisioning Balance");
                    //LoanProvBal := LoanApps."Loan Provisioning Balance";
                    UNTIL LoanApps.NEXT = 0;
                END;*/


                Black := 'No';
                IF Members."Mobile Blacklisted" THEN
                    Black := 'Yes';

                IF StartDate = 0D THEN BEGIN
                    StartDate := CALCDATE('-11M -CM', TODAY);
                    EndDate := CALCDATE('CM', StartDate);
                END;

                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No", Members."No.");
                IF DivProg.FIND('-') THEN
                    DivProg.DELETEALL;

                CDiv := 0;
                GenSetUp.GET();


                FOR i := 1 TO Months DO BEGIN

                    FromDate := CALCDATE('-CM', StartDate);
                    ToDate := CALCDATE('CM', StartDate);

                    EVALUATE(FromDateS, FORMAT(FromDate));
                    EVALUATE(ToDateS, FORMAT(ToDate));
                    DateFilter := FromDateS + '..' + ToDateS;

                    ShCap := 0;
                    GoLiveDepositBal := 0;
                    GoLiveShareBal := 0;

                    SAccount.RESET;
                    SAccount.SETRANGE("Member No.", Members."No.");
                    SAccount.SETFILTER("Date Filter", DateFilter);
                    SAccount.SetFilter("Product Category", '%1|%2', SAccount."Product Category"::"Share Capital", SAccount."Product Category"::"Benevolent Fund");
                    SAccount.SetAutoCalcFields("Balance (LCY)");
                    SAccount.SetLoadFIelds("No.", "Balance (LCY)", "Product Category");
                    IF SAccount.FindSet() THEN BEGIN
                        repeat

                            if SAccount."Product Category" = SAccount."Product Category"::"Benevolent Fund" then
                                Benevolent := SAccount."Balance (LCY)";
                            if SAccount."Product Category" = SAccount."Product Category"::"Share Capital" then
                                ShCap := SAccount."Balance (LCY)";

                        until SAccount.next() = 0;
                    end;

                    TOutInt := 0;
                    LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", Members."No.");
                    //LoanApps.SETFILTER("Date Filter",'..%1',CALCDATE('-CM-1D',TODAY));
                    LoanApps.SETRANGE(Posted, TRUE);
                    LoanApps.SetAutoCalcFields("Outstanding Interest");
                    LoanApps.SetLoadFields("Loan No.", "Outstanding Interest");
                    IF LoanApps.FIND('-') THEN BEGIN
                        REPEAT
                            LoanApps.CALCFIELDS(LoanApps."Outstanding Interest");
                            TOutInt += LoanApps."Outstanding Interest";
                        UNTIL LoanApps.NEXT = 0;
                    END;

                    LoanApps.Reset();

                    DepAmt := 0;

                    SAccount.reset();
                    SAccount.SetRange("Member No.", Members."No.");
                    SAccount.SetFilter("Date Filter", DateFilter);
                    // SAccount.SetFilter("Credit Amount (LCY)", '>0');
                    SAccount.setrange("Product Category", SAccount."Product Category"::"Deposit Contribution");
                    SAccount.SetAutoCalcFields("Credit Amount (LCY)");
                    SAccount.SetLoadFields("No.", "Credit Amount (LCY)", "Balance (LCY)");
                    if SAccount.FindFirst() Then begin
                        DepAmt := SAccount."Balance (LCY)";//"Credit Amount (LCY)";
                    end;

                    DivProg.INIT;
                    DivProg."Member No" := Members."No.";
                    DivProg.Date := ToDate;
                    DivProg."DepContrib." := DepAmt;
                    DivProg."Share Capital" := ShCap;

                    LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", Members."No.");
                    LoanApps.SetRange(LoanApps.Posted, True);
                    LoanApps.SetFilter("Outstanding Principal", '>0');
                    LoanApps.SETFILTER(LoanApps."Disbursement Date", DateFilter);
                    LoanApps.SetAutoCalcFields("Outstanding Principal");
                    LoanApps.SetLoadFields("Outstanding Principal", "Approved Amount", "Amount To Disburse", "Type of Disbursement");
                    IF LoanApps.FIND('-') THEN BEGIN
                        repeat
                            //**IF (LoanApps."Loan Product Type"<>'INST') AND (LoanApps."Loan Product Type"<>'FLP') THEN
                            IF LoanApps."Type of Disbursement" = LoanApps."Type of Disbursement"::"Partial Disbursement" THEN
                                DivProg."New Loans" += LoanApps."Amount To Disburse"
                            ELSE
                                DivProg."New Loans" += LoanApps."Approved Amount";
                        UNTIL LoanApps.NEXT = 0;
                    END;

                    /*Partial.RESET;
                    Partial.SETRANGE(Partial."Member No.", Cust."No.");
                    Partial.SETFILTER(Partial.Posted, 'YES');
                    Partial.SETFILTER(Partial."Issued Date", DateFilter);
                    IF Partial.FIND('-') THEN BEGIN
                        REPEAT
                            DivProg."New Loans" += Partial."Amount to Disburse"
                        UNTIL Partial.NEXT = 0;
                    END; */

                    //Montly repayment on loan Principle less INST & FLP Loan
                    LoanRepay := 0;
                    LoanApps.RESET;
                    LoanApps.SetRange(LoanApps."Member No.", Members."No.");
                    LoanApps.SetRange(LoanApps.Posted, true);
                    //LoanApps.SetFilter("Disbursement Date", DateFilter);
                    LoanApps.SetFilter(LoanApps."Date Filter", DateFilter);
                    LoanApps.SetAutoCalcFields("Outstanding Appraisal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Principal", "Interest Paid", "Principal Paid", "Interest Due");
                    LoanApps.SetLoadFields("Loan No.", "Interest Due", "Interest Paid", Repayment, "Principal Paid", "Outstanding Interest", "Outstanding Appraisal", "Outstanding Interest", "Outstanding Principal");
                    //LoanApps.SetFilter("Total Outstanding Balance",'>0');
                    IF LoanApps.FindSet() THEN BEGIN
                        REPEAT

                            Penalty1 := GetBalance(LoanApps."Loan No.", TransType::Penalty, DateFilter);
                            //Penalty2 := GetIrregularPenalty(LoanApps."Loan No.", DateFilter);
                            //**IF (LoanApps."Loan Product Type"<>'INST') AND (LoanApps."Loan Product Type"<>'FLP') THEN
                            DivProg."Loan Repayments" += LoanApps."Principal Paid";
                            DivProg."Interest Paid" += LoanApps."Interest Paid";
                            DivProg."Interest Dues" += LoanApps."Interest Due";//+Penalty1+Penalty2;
                            DivProg."Oustanding Interest" += LoanApps."Outstanding Interest";

                        UNTIL LoanApps.NEXT = 0;
                    END;


                    //Opening Balance Deposits

                    //PN
                    DateFilter := '..' + FORMAT(CALCDATE('-1D', FromDate));

                    SAccount.RESET;
                    SAccount.SetRange(SAccount."Member No.", Members."No.");
                    SAccount.SetFilter(SAccount."Date Filter", DateFilter);
                    SAccount.SetRange(SAccount."Product Category", SAccount."Product Category"::"Deposit Contribution");
                    IF SAccount.FIND('-') THEN BEGIN
                        SAccount.CALCFIELDS("Balance (LCY)");
                        DivProg.DepOpeingBal := SAccount."Balance (LCY)";
                    END;
                    SeccoStup.TestField("Go Live Date");
                    if Date2DMY(FromDate, 2) = Date2DMY(SeccoStup."Go Live Date", 2) then begin
                        GoLiveDepositBal := 0;
                        GoLiveShareBal := 0;

                        SAccount.RESET;
                        SAccount.SetRange(SAccount."Member No.", Members."No.");
                        SAccount.SetRange(SAccount."Date Filter", SeccoStup."Go Live Date");
                        SAccount.SetRange(SAccount."Product Category", SAccount."Product Category"::"Deposit Contribution");
                        SAccount.SetAutoCalcFields("Balance (LCY)");
                        IF SAccount.FIND('-') THEN BEGIN
                            GoLiveDepositBal := SAccount."Balance (LCY)";
                            DivProg.DepOpeingBal += GoLiveDepositBal;
                            DivProg."DepContrib." -= GoLiveDepositBal;
                        END;

                        SAccount.RESET;
                        SAccount.SetRange(SAccount."Member No.", Members."No.");
                        SAccount.SetRange(SAccount."Date Filter", SeccoStup."Go Live Date");
                        SAccount.SetRange(SAccount."Product Category", SAccount."Product Category"::"Share Capital");
                        SAccount.SetAutoCalcFields("Balance (LCY)");
                        IF SAccount.FIND('-') THEN BEGIN
                            GoLiveShareBal := SAccount."Balance (LCY)";
                            DivProg."Share Capital" -= GoLiveShareBal;
                        END;
                    end;


                    //Loan Balance less INST & FLP Loan
                    PenaltyOnly := 0;
                    LoanApps.RESET;
                    LoanApps.SetRange(LoanApps."Member No.", Members."No.");
                    //LoanApps.SetRange("Disbursement Date", 0D, EndDate);
                    LoanApps.SetRange(LoanApps.Posted, TRUE);
                    LoanApps.SetFilter(LoanApps."Date Filter", DateFilter);
                    LoanApps.SetAutoCalcFields("Outstanding Principal", "Outstanding Interest", "Penalty Due", "Penalty Paid");
                    IF LoanApps.FindSet() THEN BEGIN
                        REPEAT

                            Penalty1 := LoanApps."Penalty Due"; //GetBalance(LoanApps."Loan No.", TransType::Penalty, DateFilter);
                            PenaltyOnly += Penalty1;

                            DivProg.OpeningBalLoans := DivProg.OpeningBalLoans + LoanApps."Outstanding Principal" + LoanApps."Outstanding Interest";

                        UNTIL LoanApps.NEXT = 0;
                    END;

                    DivProg."Oustanding Loan" := DivProg.OpeningBalLoans + DivProg."New Loans" - DivProg."Loan Repayments" + DivProg."Interest Dues" - DivProg."Interest Paid";
                    DivProg.DepClosingBal := DivProg.DepOpeingBal + DivProg."DepContrib.";
                    DivProg."Month Contrib." := DivProg."Loan Repayments" + DivProg."Interest Paid" + DivProg."DepContrib.";
                    //DivProg."Total Contribution":=DivProg."Month Contribution"+Benevolent+ShCap; PREVIOUS CALCULATIONS
                    //MESSAGE ('Deposit:' +FORMAT(DivProg."Deposit Contribution")+' Ben:'+ FORMAT(Benevolent) +' ShareCap:' + FORMAT(ShCap) + ' Loan payment:' + FORMAT(DivProg.Repayment)+ ' IntPaid:' + FORMAT(DivProg."Interest Paid"));
                    DivProg."Total Contribution" := DivProg."DepContrib." + Benevolent + ShCap + DivProg."Loan Repayments" + DivProg."Interest Paid" - GoLiveDepositBal;

                    if Date2DMY(FromDate, 2) = Date2DMY(SeccoStup."Go Live Date", 2) then
                        if DivProg."Total Contribution" < 0 then
                            DivProg."Total Contribution" := 0;

                    DivProg.INSERT;


                    StartDate := CALCDATE('1M', StartDate);

                END;



                DepLoanRatio := 0;
                DepGuarRatio := 0;

                SAccount.RESET;
                SAccount.SETRANGE("Member No.", Members."No.");
                SAccount.SetRange("Product Category", SAccount."Product Category"::"Deposit Contribution");
                IF SAccount.FIND('-') THEN BEGIN

                    SAccount.CALCFIELDS("Balance (LCY)");
                    LoanType.get(SAccount."Product Type");


                    MonthlyRep := 0;
                    LBal := 0;
                    TArrears := 0;

                    LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", Members."No.");
                    //LoanApps.SETFILTER(LoanApps."Loan Product Type",'<>INST&<>MCASH');
                    LoanApps.SETFILTER("Outstanding Principal", '>0');
                    LoanApps.SetAutoCalcFields("Outstanding Principal", "Outstanding Interest", "Principal Arrears", "Total Arrears");
                    IF LoanApps.FIND('-') THEN BEGIN

                        LBal := 0;
                        InterestArrears := 0;
                        REPEAT

                            LBal += LoanApps."Outstanding Principal";

                            IF LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::Amortised THEN
                                MonthlyRep += LoanApps.Repayment
                            ELSE
                                MonthlyRep += LoanApps."Loan Principle Repayment" + ROUND(LoanApps."Outstanding Principal" * LoanApps."Annual Interest %" / 1200);

                            //IF SASRACategorization.GET(LoanApps."Loan No.") THEN BEGIN
                            //  IF SASRACategorization."Principal Arrears" > LoanApps."Outstanding Principal" THEN
                            //    SASRACategorization."Principal Arrears" := LoanApps."Outstanding Principal";
                            /*MemberLedgerEntries.RESET;
                            MemberLedgerEntries.SETRANGE("Account No.", Members."No.");
                            MemberLedgerEntries.SETFILTER("Transaction Type", '%1|%2', MemberLedgerEntries."Transaction Type"::"Interest Due", MemberLedgerEntries."Transaction Type"::"Interest Paid");
                            MemberLedgerEntries.SETFILTER("Posting Date", '..%1', CALCDATE('-CM-1D', TODAY));*/

                            //InterestArrears := SaccoActivities.GetInterestArrears(LoanApps."Loan No.", CALCDATE('-CM-1D', TODAY));
                            TArrears += LoanApps."Total Arrears"; //SASRACategorization."Principal Arrears";
                                                                  //END;
                        UNTIL LoanApps.NEXT = 0;
                    END;

                    MonthlyRep += (LoanType."Mandatory Contribution");

                    DepLoanRatio := LBal;

                    IF SAccount."Balance (LCY)" > 0 THEN
                        DepLoanRatio := ROUND(LBal / (SAccount."Balance (LCY)"));

                    DepGuarRatio := 0;
                    GuaranteeValue := 0;

                    LoanGuarantorsandSecurity.RESET;
                    LoanGuarantorsandSecurity.SETRANGE("Account No.", SAccount."No.");
                    IF LoanGuarantorsandSecurity.FIND('-') THEN BEGIN
                        REPEAT
                            if LoanApps.GET(LoanGuarantorsandSecurity."Loan No.") then;
                            LoanApps.CALCFIELDS("Outstanding Principal", "Total Guaranteed");
                            //IF LoanApps."Member No."<>Members."No." THEN
                            IF LoanApps."Outstanding Principal" > 0 THEN BEGIN
                                IF LoanApps."Total Guaranteed" > 0 THEN
                                    GuaranteeValue += ((LoanGuarantorsandSecurity."Amount Guaranteed" / LoanApps."Total Guaranteed") * LoanApps."Outstanding Principal");

                            END;
                        UNTIL LoanGuarantorsandSecurity.NEXT = 0;
                    END;

                    DepGuarRatio := GuaranteeValue;
                    IF SAccount."Balance (LCY)" > 0 THEN
                        DepGuarRatio := ROUND(GuaranteeValue / (SAccount."Balance (LCY)"));


                END;

                //ELIGIBILITY
                MembrEligibility := 0;
                Eligibility := 0;

                SAccount.RESET;
                SAccount.SETRANGE("Member No.", Members."No.");
                SAccount.SetRange("Product Category", SAccount."Product Category"::"Deposit Contribution");
                SAccount.SetAutoCalcFields("Balance (LCY)");
                SAccount.SetLoadFields("No.", "Balance (LCY)");
                IF SAccount.FIND('-') THEN BEGIN

                    LoanBalance := 0;
                    LoanApps.RESET;
                    LoanApps.SETRANGE(LoanApps."Member No.", Members."No.");
                    LoanApps.SETFILTER(LoanApps."Outstanding Principal", '>0');
                    IF LoanApps.FIND('-') THEN BEGIN
                        REPEAT
                            LoanApps.CALCFIELDS(LoanApps."Outstanding Principal");
                            IF LoanType.GET(LoanApps."Loan Product Type") THEN
                                IF LoanType."Appraise Deposits" THEN
                                    LoanBalance += LoanApps."Outstanding Principal";
                        UNTIL LoanApps.NEXT = 0;
                    END;

                    SharesMultiplier := 4;
                    MembrEligibility := (SAccount."Balance (LCY)" * SharesMultiplier) - LoanBalance;

                    IF MembrEligibility <= 0 THEN BEGIN
                        Eligibility := 0;
                    END;

                    IF MembrEligibility > 0 THEN BEGIN
                        Eligibility := MembrEligibility;
                    END;
                END;

                IF "Charge Fee" THEN BEGIN
                    SaccoActivities.ChargeStatementFee(Members."No.");
                END;
            end;

            trigger OnPreDataItem()
            begin


                IF Months = 0 THEN
                    Months := 12;


                //UserName := Sacco.GetUserName;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date:"; StartDate)
                {
                    ApplicationArea = All;
                }
                field(Months; Months)
                {
                    ApplicationArea = All;
                }
                field("Charge Fee"; "Charge Fee")
                {
                    ApplicationArea = All;
                    Caption = 'Charge Fee';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        MNo = 'MNo.:';
        Name = 'Name :';
        DateFilter = 'Date Filter :';
        Period = 'Period';
        LoanOpeningBalance = 'Loan Opening Balance';
        NewLoan = 'New Loan';
        LoanRepayment = 'Loan Repayment';
        InterestPaid = 'Interest Paid';
        InterestDue = 'InterestDue';
        OutstandingInterest = 'Outstanding Interest';
        LoanClosingBalance = 'Loan Closing Balance';
        DepositOpeningBalance = 'Deposit Opening Balance';
        DepositContribution = 'Deposit Contribution';
        DepositClosingBalance = 'Deposit Closing  Balance';
        TotalReceipts = 'Total Receipts';
        ShareCapital = 'Share Capital :';
        INSTLoan = 'INST Loan :';
        FOSALoan = 'FOSA Loan :';
        BenevolentFund = 'Benevolent Fund :';
        PrintedBy = 'Printed By :';
        PrintDate = 'Print Date :';
        VerifiedBy = 'Verified By :';
        WorkingDate = 'Working date :';
        JiajiriSh = 'Jiajiri Share Capital :';
        MStatus = 'Member Status :';
        BlackListed = 'MCASH Black-Listed :';
    }

    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' - ' + CompanyInformation."Post Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";//+' ; '+CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";
#pragma warning disable AL0432
        Web := 'Member Portal: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432

        //

    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Member Statement" then
            Error('You do not have any permissions to access this report. Contact the administrator!');
    end;

    var
        Usersetup: Record "User Setup";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        PeriodFilter: Text;
        LoanAcc: Record Loans;
        Amounts: array[5] of Decimal;
        LongTLoans: Decimal;
        TotalLoans: Decimal;
        LoanApps: Record Loans;
        StartDate: Date;
        EndDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivProg: Record "Statement Buffer New";
        CDiv: Decimal;
        GenSetUp: Record "Sacco Setup";
        Cust: Record Members;
        CustR: Record Members;
        sHARES: Decimal;
        Bbf: Decimal;
        MName: Text;
        InstantLoan: Decimal;
        FosaLoan: Decimal;
        BosaLoan: Decimal;
        LoanType: Record "Product Setup";
        StartDateFilt: Text;
        Partial: Record "Partial Disbursement Schedule";
        Months: Integer;
        Msacco: Codeunit "Sky MBanking";
        FosaBal: Decimal;
        Jiajiri: Decimal;
        Black: Text;
        Web: Text;
        Child: Text;
        Benevolent: Decimal;
        TotRcpt: Decimal;
        MCash: Decimal;
        MobileLoans: Decimal;
        DepLoanRatio: Decimal;
        DepGuarRatio: Decimal;
        MonthlyRep: Decimal;
        TArrears: Decimal;
        LBal: Decimal;
        GuaranteeValue: Decimal;
        LoanGuarantorsandSecurity: Record "Loan Security";
        SASRACategorization: Record "SACCO Categorization";
        //AccTypes: Record "39004271";
        AccName: Text;
        Sacco: Codeunit "Sacco Activities";
        UserName: Text;
        SecLoan: Text;
        TOutInt: Decimal;
        SecuritiesRegister: Record "Loan Collateral Register";
        SecAmt: Decimal;
        MonthlyBBF: Decimal;
        MonthlyShares: Decimal;
        ShCap: Decimal;
        Penalty1: Decimal;
        Penalty2: Decimal;
        TransType: Option Principal,Interest,Penalty;
        DatePeriod: Text;
        PenaltyOnly: Decimal;
        LoanBalance: Decimal;
        LoansR: Record Loans;
        MembrEligibility: Decimal;
        Eligibility: Decimal;
        i: Integer;
        SharesMultiplier: Decimal;
        LoanProvBal: Decimal;
        MemberLedgerEntries: Record "Credit Ledger Entry";
        DepositContributions: Decimal;
        InterestArrears: Decimal;
        "Charge Fee": Boolean;
        PeriodicActivities: Codeunit "Member Activities";
        SAccount: Record "Savings Accounts";
    // SaccoOperations: Codeunit "Sacco Activities";

    procedure GetBalance(LoanNo: Code[20]; TransType: Option Principal,Interest,Penalty; DFilter: Text): Decimal
    var
        CLedger: Record "Credit Ledger Entry";
    begin
        IF LoanNo = '' THEN
            EXIT(0);


        CLedger.RESET;
        CLedger.SETRANGE("Loan No.", LoanNo);
        IF TransType = TransType::Principal THEN
            CLedger.SETFILTER("Transaction Type", '%1|%2', CLedger."Transaction Type"::"Loan Disbursement", CLedger."Transaction Type"::"Principal Repayment");
        IF TransType = TransType::Interest THEN
            CLedger.SETFILTER("Transaction Type", '%1|%2', CLedger."Transaction Type"::"Interest Due", CLedger."Transaction Type"::"Interest Paid");
        IF TransType = TransType::Penalty THEN
            CLedger.SETFILTER("Transaction Type", '%1', CLedger."Transaction Type"::"Penalty Paid");
        CLedger.SETFILTER("Posting Date", DFilter);
        IF CLedger.FINDFIRST THEN BEGIN
            CLedger.CALCSUMS("Amount (LCY)");
            EXIT(CLedger."Amount (LCY)");
        END;
    end;

    /// <summary>
    /// GetIrregularPenalty.
    /// </summary>
    /// <param name="LoanNo">Code[20].</param>
    /// <param name="DFilter">Text.</param>
    /// <returns>Return value of type Decimal.</returns>
    procedure GetIrregularPenalty(LoanNo: Code[20]; DFilter: Text): Decimal
    var
        CLedger: Record "Credit Ledger Entry";
        LRec: Record Loans;
        LoanProductTypes: Record "Product Setup";
        Penalty: Decimal;
        i: Integer;
        FirstDate: Date;
    begin
        IF LoanNo = '' THEN
            EXIT(0);

        LRec.GET(LoanNo);
        LoanProductTypes.GET(LRec."Loan Product Type");

        IF LoanProductTypes."Product ID" <> 'INST' THEN
            IF LoanProductTypes."Product ID" <> 'INST2' THEN
                IF LoanProductTypes."Product ID" <> 'MCASH' THEN
                    EXIT(0);


        Penalty := 0;

        CLedger.RESET;
        CLedger.SETRANGE("Loan No.", LoanNo);
        CLedger.SETRANGE(Reversed, FALSE);
        CLedger.SETFILTER("Transaction Type", '%1', CLedger."Transaction Type"::"Loan Disbursement");
        IF CLedger.FINDFIRST THEN BEGIN
            IF CLedger.COUNT > 1 THEN BEGIN

                FirstDate := CLedger."Posting Date";

                CLedger.RESET;
                CLedger.SETRANGE("Loan No.", LoanNo);
                CLedger.SETRANGE(Reversed, FALSE);
                CLedger.SETFILTER("Transaction Type", '%1', CLedger."Transaction Type"::"Loan Disbursement");
                CLedger.SETFILTER("Posting Date", DFilter);
                IF CLedger.FINDFIRST THEN BEGIN
                    REPEAT
                        IF CLedger."Posting Date" > FirstDate THEN
                            Penalty += CLedger."Amount (LCY)";
                    UNTIL CLedger.NEXT = 0;
                END;
            END;
        END;

        EXIT(Penalty);
    end;
}
