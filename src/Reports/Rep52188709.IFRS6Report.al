report 50373 "IFRS6 Report"
{
    ApplicationArea = All;
    Caption = 'IFRS6 Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/IFRS6 Report.RDLC';
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(posted = const(true));
            CalcFields = "Outstanding Interest";
            RequestFilterFields = "Loan No.", "Loan Product Type", "Date Filter";

            column(LastPaymentAmount; LastPaymentAmount)
            {
            }
            column(LastPaymentDate; LastPaymentDate)
            {
            }
            column(DefInst; DefInst)
            {
            }
            column(CommittedAmt; CommittedAmt)
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(Repayment_Frequency; "Repayment Frequency") { }
            column(MemberNo; "Member No.")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(LoansCategorySASRA; "Loans Category-SASRA")
            {
            }
            column(RepaymentFrequency; "Repayment Frequency")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(DisbursementDate; "Disbursement Date")
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(Principal_Repayment; "Principal Repayment")
            { }
            column(Outstanding_Interest; "Outstanding Interest")
            { }
            column(Total_Outstanding_Balance; "Total Outstanding Balance")
            { }

            column(ApprovedAmount; "Approved Amount")
            {
            }

            column(OutstandingPrincipal; "Outstanding Principal")
            {
            }
            column(PrincipalArrears; "Principal Arrears")
            {
            }
            column(TotalArrears; "Total Arrears")
            {
            }
            column(LastPayDate; "Last Pay Date")
            {
            }
            column(AnnualInterest; "Annual Interest %")
            {
            }
            column(CompletionDate; "Completion Date")
            {
            }
            column(DaysInArrear; DaysInArrear)
            {
            }
            column(Deposits; MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts("Member No.")))
            {
            }
            column(Installments; Installments)
            {
            }
            column(Annual_Interest__; "Annual Interest %")
            { }

            column(MemberStatus; MemberStatus) { }

            column(Guarantor_Type; GuarantorType)
            { }
            column(Amount_Guaranteed; AmountGuaranteed)
            { }
            column(Collateral_Value; CollateralValue)
            { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                AsAt := GetRangeMax("Date Filter");
            end;

            trigger OnAfterGetRecord()
            var
                Members: Record Members;
                DepAcc: Record "Savings Accounts";
                GuarDep: Decimal;
                GuarCommitted: Decimal;

                GracePeriod: DateFormula;
                ExpectedAmt: Decimal;
                AmtPaid: Decimal;
                DefAmount: Decimal;
                ArrearsDate: Date;
                MDef: Integer;
                SActivities: Codeunit "Sacco Activities";
                CLedger: Record "Credit Ledger Entry";
            begin
                GuarantorType := '';
                AmountGuaranteed := 0;
                CollateralValue := 0;
                CommittedAmt := 0;
                DefInst := 0;
                DaysInArrear := 0;

                LastPaymentAmount := 0;
                LastPaymentDate := 0D;

                CLedger.Reset();
                CLedger.SetCurrentKey("Posting Date");
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Transaction Type", CLedger."Transaction Type"::"Principal Repayment");
                CLedger.SetFilter("Posting Date", '..%1', AsAt);
                if CLedger.FindLast() then begin
                    LastPaymentAmount := CLedger."Amount (LCY)" * -1;
                    LastPaymentDate := CLedger."Posting Date";
                end;

                // Get Member Status
                MemberStatus := '';
                Members.Reset();
                Members.SetRange("No.", "Member No.");
                if Members.FindFirst() then MemberStatus := Format(Members."Member Status");

                LSecurity.Reset();
                LSecurity.SetRange("Loan No.", Loans."Loan No.");
                if LSecurity.FindFirst() then
                    repeat
                        GuarantorType := Format(LSecurity."Guarantor Type");
                        AmountGuaranteed += LSecurity."Amount Guaranteed";
                        if LSecurity."Guarantor Type" = LSecurity."Guarantor Type"::Collateral then
                            CollateralValue += LSecurity."Amount Guaranteed";
                    until LSecurity.Next() = 0;




                LSecurity.Reset();
                LSecurity.SetRange("Loan No.", Loans."Loan No.");
                if LSecurity.FindFirst() then
                    repeat
                        GuarCommitted := LSecurity."Current Committed";
                        if LSecurity."Guarantor Type" <> LSecurity."Guarantor Type"::Collateral then begin
                            DepAcc.Reset();
                            DepAcc.SetRange("No.", LSecurity."Account No.");
                            if DepAcc.FindFirst() then begin
                                DepAcc.CalcFields("Balance (LCY)");
                                GuarDep := DepAcc."Balance (LCY)";

                                if GuarCommitted > GuarDep then begin
                                    GuarCommitted := GuarDep;
                                end;

                            end;
                        end;

                        CommittedAmt += GuarCommitted;

                    until LSecurity.Next() = 0;



                SActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);
                DefInst := 0;
                if Loans."Loan Principle Repayment" > 0 then
                    DefInst := round(DefAmount / Loans."Loan Principle Repayment", 1, '<');

            end;




        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        MemberActivities: codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        MemberStatus: text;
        GuarantorType: Text[100];
        AmountGuaranteed: Decimal;
        CollateralValue: Decimal;
        LSecurity: Record "Loan Security";
        Company: Record "Company Information";
        AsAt: Date;
        CommittedAmt: Decimal;
        DefInst: Decimal;
        DaysInArrear: Integer;
        LastPaymentDate: Date;
        LastPaymentAmount: Decimal;
}
