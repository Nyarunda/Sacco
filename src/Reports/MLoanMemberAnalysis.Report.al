Report 50297 "MLoan Member Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/MLoan Member Analysis.rdlc';

    dataset
    {
        dataitem(Vendor; "Savings Accounts")
        {
            DataItemTableView = sorting("No.") where("Creditor Type" = const(FOSA), "Product Category" = filter("ordinary savings"));
            RequestFilterFields = "Product Type", Status, "Salary Processing", "No.";
            column(ReportForNavId_3182; 3182)
            {
            }
            column(MAdvanceAmount; 0)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(UserId; UserId)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__Account_Type_; "Product Type")
            {
            }
            column(Vendor__Last_Transaction_Date_; "Last Transaction Date")
            {
            }
            column(DisabledATMCardNo_Vendor; '')
            {
            }
            column(Vendor_Status; Status)
            {
            }
            column(processing; Vendor."Salary Processing")
            {
            }
            column(Accounts_StatusCaption; Accounts_StatusCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Vendor__No__Caption; FieldCaption("No."))
            {
            }
            column(Vendor_NameCaption; FieldCaption(Name))
            {
            }
            column(Vendor__Account_Type_Caption; FieldCaption("Product Type"))
            {
            }
            column(Vendor__Last_Transaction_Date_Caption; FieldCaption("Last Transaction Date"))
            {
            }
            column(Vendor_StatusCaption; FieldCaption(Status))
            {
            }
            column(Reason; '')
            {
            }
            column(CheckOffDeposits; CheckOffDeposits)
            {
            }
            column(NonCheckOffDeposits; NonCheckOffDeposits)
            {
            }
            column(AvgCheckOffDeposits; AvgCheckOffDeposits)
            {
            }
            column(AvgNonCheckOffDeposits; AvgNonCheckOffDeposits)
            {
            }
            column(TotalSalary; TotalSalary)
            {
            }
            column(SalAvg; SalAvg)
            {
            }
            column(TotalNonSalary; TotalNonSalary)
            {
            }
            column(NonSalAvg; NonSalAvg)
            {
            }
            column(SalaryLoans; SalaryLoans)
            {
            }
            column(STO; STO)
            {
            }
            column(ChqAmt; ChqAmt)
            {
            }
            column(MpesaAmt; MpesaAmt)
            {
            }
            column(Ability; Ability)
            {
            }
            column(SmallestSal; SmallestSal)
            {
            }
            column(InconsistencyLevel; InconsistencyLevel)
            {
            }

            trigger OnAfterGetRecord()
            var
                DepositsMaxAbility: Decimal;
                Skip: Boolean;
            begin
                //if MembersToSkip(Vendor."No.") then CurrReport.Skip;
                Ability := 0;

                TotalSalary := 0;
                SalAvg := 0;
                TotalNonSalary := 0;
                NonSalAvg := 0;
                SalaryLoans := 0;
                STO := 0;
                ChqAmt := 0;
                MpesaAmt := 0;



                CheckOffDeposits := 0;
                NonCheckOffDeposits := 0;
                AvgCheckOffDeposits := 0;
                AvgNonCheckOffDeposits := 0;
                SmallestSal := 0;

                Cust.Get(Vendor."Member No.");

                if not Vendor.IsEmpty then begin

                    SkyMBanking.LeastSalary(Vendor."No.", 3, TotalSalary, SalAvg, SmallestSal);


                    SalaryLoans := (SkyMBanking.GetSalaryLoanRepayment(Vendor."No."));

                    if NonSalAvg > SalAvg then
                        NonSalAvg := SalAvg;


                    STO := SkyMBanking.GetStandingOrderAmount(Vendor."No.");

                    SkyMBanking.GetFosaNonSalaryRemittance(Vendor."No.", 3, TotalNonSalary, NonSalAvg, ChqAmt, MpesaAmt);

                    //Ability := (1 / 2 * (SalAvg - SalaryLoans - STO)) + (1 / 4 * NonSalAvg);
                    Ability := (SmallestSal - SalaryLoans - STO);

                    Ability := Ability * (60 / 100);



                end
                else begin


                    SkyMBanking.GetBosaDeposits(Vendor."No.", 3, CheckOffDeposits, NonCheckOffDeposits, AvgCheckOffDeposits, AvgNonCheckOffDeposits);
                    Ability := ROUND((AvgCheckOffDeposits) + (1 / 8 * AvgNonCheckOffDeposits));

                    if CheckOffDeposits <= 0 then
                        Ability := (1 * AvgNonCheckOffDeposits);




                end;


                //Ability := SkyMBanking.GetAbilityToRepay(Vendor."No.",ProductCode);

                RepAmt := 0;
                SkyMBanking.GetSameLoanBalance(Vendor."No.", ProductCode, RepAmt);
                Ability -= RepAmt;

                Deposits := MActivities.GetAccountBalance(Legacy.GetDepositAccounts(Cust."No."));


                DepositsMaxAbility := Deposits * (60 / 100);
                //MESSAGE('Depo '+FORMAT(Cust."Current Shares")+'  70% '+FORMAT(DepositsMaxAbility));
                if Ability > DepositsMaxAbility then
                    Ability := DepositsMaxAbility;


                //GetTopUpAbility(Vendor."No.",Ability,1);

                //InconsistencyLevel := SkyMBanking.DepositInconsistencyLevel(Vendor."BOSA Account No");
                if Ability < 0 then
                    Ability := 0;


            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        MActivities: Codeunit "Member Activities";
        AccountType: Record "Product Setup";
        ProductCode: Code[20];
        Deposits: Decimal;
        Accounts_StatusCaptionLbl: label 'Accounts Status';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        SkyMBanking: Codeunit "Sky MBanking";
        CheckOffDeposits: Decimal;
        NonCheckOffDeposits: Decimal;
        AvgCheckOffDeposits: Decimal;
        AvgNonCheckOffDeposits: Decimal;
        TotalSalary: Decimal;
        SalAvg: Decimal;
        TotalNonSalary: Decimal;
        NonSalAvg: Decimal;
        SalaryLoans: Decimal;
        STO: Decimal;
        ChqAmt: Decimal;
        MpesaAmt: Decimal;
        Ability: Decimal;
        SmallestSal: Decimal;
        InconsistencyLevel: Decimal;
        RepAmt: Decimal;
        Cust: Record Members;
        Legacy: Codeunit Legacy;


    procedure GetAbilityToRepay(Account: Record "Savings Accounts") Ability: Decimal
    var
        CheckOffDeposits: Decimal;
        NonCheckOffDeposits: Decimal;
        AvgCheckOffDeposits: Decimal;
        AvgNonCheckOffDeposits: Decimal;
        TotalSalary: Decimal;
        SalAvg: Decimal;
        TotalNonSalary: Decimal;
        NonSalAvg: Decimal;
        SalaryLoans: Decimal;
        STO: Decimal;
        ChqAmt: Decimal;
        MpesaAmt: Decimal;
    begin
    end;

    /*
    local procedure GetTopUpAbility(VendorNo: Code[30]; Ability: Decimal; Duration: Integer)
    var
        Vendor: Record "Savings Accounts";
        MemberNo: Code[30];
        TotalLoansBalance: Decimal;
        TotalChg: Decimal;
        SkyMobileSetup: Record "Sky Mobile Setup.";
        LeastTakeHome: Decimal;
        LoanProductTypes: Record "Loan Product Types";
        NetTakeHome: Decimal;
        Interest: Decimal;
        OutstandingLoansCount: Integer;
        QualifyingAmount: Decimal;
        Loans: Record Loans;
    begin
        if Vendor.Get(VendorNo) then begin
            OutstandingLoansCount := 0;
            MemberNo := Vendor."BOSA Account No";
            //MaxLoan:=LoanProduct."Maximum Loan Amount";
            TotalLoansBalance := 0;
            Loans.Reset;
            Loans.SetRange("BOSA No", MemberNo);
            Loans.SetRange("Loan Product Type", 'M-LOAN');
            Loans.SetFilter("Outstanding Balance", '>0');
            if Loans.FindFirst then begin
                OutstandingLoansCount := Loans.Count();
                //MESSAGE(FORMAT(OutstandingLoansCount));
                repeat
                    Loans.CalcFields("Outstanding Balance", "Oustanding Interest");
                    if Loans."Oustanding Interest" < 0 then
                        Loans."Oustanding Interest" := 0;

                    TotalLoansBalance += Loans."Outstanding Balance" + Loans."Oustanding Interest";
                until Loans.Next = 0;
            end;

            SkyMobileSetup.Reset;
            SkyMobileSetup.SetRange("Transaction Type", SkyMobileSetup."transaction type"::"Loan Disbursement");
            if SkyMobileSetup.FindFirst then begin
                TotalChg := SkyMobileSetup."Sacco Fee" + SkyMobileSetup."Vendor Commission" + SkyMobileSetup."SMS Charge";
            end
            else begin
                Error('Setup Missing for %1', SkyMobileSetup."transaction type"::"Loan Disbursement");
            end;
            LoanProductTypes.Get('M-LOAN');
            // MESSAGE(LoanProductTypes."Product Description");
            LeastTakeHome := LoanProductTypes."Mobile Loan Top up Limit"; //Least amount one should take home

            if Duration = 1 then
                Interest := LoanProductTypes."Interest rate";
            if Duration = 3 then
                Interest := LoanProductTypes."Interest rate 2";
            if Duration = 5 then
                Interest := LoanProductTypes."Interest rate 3";

            NetTakeHome := Ability - (TotalChg + (Ability * (Interest / 1200)) + TotalLoansBalance);


            if OutstandingLoansCount < 1 then begin
                Ability := Ability;
            end;
            if (OutstandingLoansCount >= 2) and (NetTakeHome >= LeastTakeHome) then begin
                Ability := NetTakeHome;
            end;
            if (OutstandingLoansCount >= 2) and (NetTakeHome < LeastTakeHome) then begin
                Ability := 0;
            end;
        end;
        //***
    end;
    */


    procedure MembersToSkip(VendorNumber: Code[30]) skip: Boolean
    var
        Continue: Boolean;
        Members: Record Members;
        Vendor: Record "Savings Accounts";
        DepAvg: Decimal;
        Loans: Record Loans;
        MembershipPeriod: Integer;
    begin
        skip := false;
        Continue := true;
        Vendor.Get(VendorNumber);
        Members.Get(Vendor."Member No.");

        /*
        if Continue then begin
            if Members."M-Loans Status" then begin
                Continue := false;
                skip := true;
            end;
        end;
        */


        if Continue then begin
            if Members."Member Status" <> Members."Member Status"::Active then begin
                Continue := false;
                skip := true;
            end;
        end;

        if Continue then begin
            if Vendor.Status <> Vendor.Status::Active then begin
                Continue := false;
                skip := true;
            end;
        end;


        /*
        if Continue then begin
            if SkyMBanking.MembershipPeriod(Members."No.") < 2 then begin
                Continue := false;
                skip := true;
            end;
        end;
        */



    end;
}

