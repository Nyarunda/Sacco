
Report 50124 "Collateral Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Collateral Register.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Loan Collateral Register"; "Loan Collateral Register")
        {
            RequestFilterFields = "Inward/Outward";
            column(ReportForNavId_1; 1)
            {
            }
            column(LoansCommitted; LoansCommitted)
            {
            }
            column(AmountCommitted; AmountCommitted)
            {
            }
            column(No; "Loan Collateral Register"."No.")
            {
            }
            column(Vehicle_Reg__No_; "Vehicle Reg. No.")
            { }
            column(AccountNo; "Loan Collateral Register"."Account No.")
            {
            }

            column(AccountName; "Loan Collateral Register"."Account Name")
            {
            }
            column(CollateralType; "Loan Collateral Register"."Collateral Type")
            {
            }
            column(Collateral; "Loan Collateral Register".Collateral)
            {
            }
            column(CollateralName; "Loan Collateral Register"."Collateral Name")
            {
            }
            column(CollateralDesc; "Collateral Description")
            {
            }
            column(CollateralMultiplier; "Loan Collateral Register"."Collateral Multiplier")
            {
            }
            column(CollateralValue; "Loan Collateral Register"."Collateral Value")
            {
            }
            column(CollateralLimit; "Loan Collateral Register"."Collateral Limit")
            {
            }
            column(Status; "Loan Collateral Register".Status)
            {
            }
            column(Inward_Outward; "Loan Collateral Register"."Inward/Outward")
            {
            }
            column(LastValuationDate; "Loan Collateral Register"."Last Valuation Date")
            {
            }
            column(ForcedSaleValue; "Loan Collateral Register"."Forced Sale Value")
            {
            }
            column(CollateralPerfected; "Loan Collateral Register"."Collateral Perfected")
            {
            }
            column(NextValuationDate; "Loan Collateral Register"."Next Valuation Date")
            {
            }
            column(Remarks; "Loan Collateral Register".Remarks)
            {
            }
            column(CollateralDetails; "Loan Collateral Register"."Collateral Details")
            {
            }
            column(RegisteredOwner; "Loan Collateral Register"."Registered Owner")
            {
            }
            column(ReOpenedBy; "Loan Collateral Register"."Re-Opened By")
            {
            }
            column(DateReOpened; "Loan Collateral Register"."Date Re-Opened")
            {
            }
            column(InsuranceExpiryDate; "Loan Collateral Register"."Insurance Expiry Date")
            {
            }
            column(ValuationType; "Loan Collateral Register"."Valuation Type")
            {
            }
            column(LegallyCleared; "Loan Collateral Register"."Legally Cleared")
            {
            }
            column(Branch; "Loan Collateral Register"."Global Dimension 2 Code")
            {
            }
            column(ChargedValue; "Loan Collateral Register"."Charged Value")
            {
            }
            column(CollectionStatus; "Loan Collateral Register"."Collection Status")
            {
            }
            column(CollectorIDNo; "Loan Collateral Register"."Collector ID No")
            {
            }
            column(CollectorName; "Loan Collateral Register"."Collector Name")
            {
            }
            column(CollectorPhoneNo; "Loan Collateral Register"."Collector Phone No.")
            {
            }
            column(DateCollected; "Loan Collateral Register"."Date Collected")
            {
            }
            column(Revalued; Revalued)
            {
            }
            column(CompanyInfo_Pic; CompanyInfo.Picture)
            {

            }
            dataitem(CollateralAll; "Collateral Allocation")
            {
                DataItemLink = "Collateral No." = field("No.");
               
                column(MemberNo; CollateralAll."Member No.")
                {
                }
                column(AmountAllocated; CollateralAll."Collateral Allocation")
                {
                }
                column(AllocatedMemberName; AllocatedMemberName)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Member: Record Members;

                begin
                    AllocatedMemberName := '';
                    if CollateralAll."Member No." <> '' then begin
                        if Member.Get(CollateralAll."Member No.") then
                            AllocatedMemberName := Member.Name;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Loans: Record Loans;
                LoanSecurity: Record "Loan Security";
                Revalution: Record "Collateral History";
            begin
                AmountCommitted := 0;
                LoansCommitted := '';
                Revalued := false;


                Revalution.Reset();
                Revalution.SetRange("Col. Reg. No", "Loan Collateral Register"."No.");
                if Revalution.FindFirst() then
                    Revalued := true;

                LoanSecurity.reset;
                LoanSecurity.SetRange("Collateral Reg. No.", "Loan Collateral Register"."No.");
                LoanSecurity.setrange("Guarantor Type", LoanSecurity."Guarantor Type"::Collateral);
                LoanSecurity.SetFilter("Outstanding Principal", '>0');
                if LoanSecurity.FindFirst() then begin
                    repeat
                        if Loans.get(LoanSecurity."Loan No.") then;
                        Loans.CalcFields("Total Outstanding Balance");
                        AmountCommitted += Loans."Total Outstanding Balance";
                        LoansCommitted += Loans."Loan No." + ', '
                    until LoanSecurity.Next() = 0;
                end;

                LoanSecurity.reset;
                LoanSecurity.SetRange("Collateral Reg. No.", "Loan Collateral Register"."No.");
                LoanSecurity.setrange("Guarantor Type", LoanSecurity."Guarantor Type"::Collateral);
                LoanSecurity.SetFilter("Outstanding Principal", '<=0');
                if LoanSecurity.FindFirst() then begin
                    repeat
                        if Loans.get(LoanSecurity."Loan No.") then;
                        if not Loans.Posted then
                            if Loans.Status <> Loans.Status::Rejected then begin

                                AmountCommitted += LoanSecurity."Amount Guaranteed";
                                LoansCommitted += Loans."Loan No." + ', '
                            end;
                    until LoanSecurity.Next() = 0;
                end;
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        LoansCommitted: Text;
        AmountCommitted: Decimal;
        LastRevaluationDate: Date;
        Revalued: Boolean;
        CompanyInfo: Record "Company Information";
        AllocatedMemberName: Text;
}

