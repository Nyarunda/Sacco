report 50354 "Salary Posting Recon"
{
    ApplicationArea = All;
    Caption = 'Salary Posted Recon';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;

    RDLCLayout = 'Layouts/SalaryPostingRecon.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Member No.", "Employer Code", "Loan Product Type", Source;
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(OutstandingInterest; "Outstanding Interest")
            {
            }
            column(OutstandingPrincipal; "Outstanding Principal")
            {
            }
            column(PrincipalPaid; PrincipalPaid)
            { }
            column(InterestPaid; InterestPaid)
            { }
            column(Disbursement_Date; "Disbursement Date") { }
            column(DocumentNo; DocumentNo) { }
            column(Loan_Principle_Repayment; "Loan Principle Repayment")
            { }
            column(Loan_Interest_Repayment; "Loan Interest Repayment") { }

            trigger OnPreDataItem()
            begin
                if DocumentNo = '' then
                    Error('The Document No must have a value!');
            end;

            trigger OnAfterGetRecord()
            var
                DetCust: Record "Credit Ledger Entry";
            begin
                PrincipalPaid := 0;
                InterestPaid := 0;
                DetCust.Reset();
                DetCust.SetRange("Document No.", DocumentNo);
                DetCust.SetRange("Loan No.", Loans."Loan No.");
                DetCust.SetRange(Reversed, false);
                if DetCust.FindSet() then
                    repeat
                        if DetCust."Transaction Type" = DetCust."Transaction Type"::"Interest Paid" then
                            InterestPaid += DetCust.Amount * -1;
                        if DetCust."Transaction Type" = DetCust."Transaction Type"::"Principal Repayment" then
                            PrincipalPaid += DetCust.Amount * -1;
                    until DetCust.Next() = 0;
            end;
        }


    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = All;
                        TableRelation = "Salary Header";
                    }
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

    var
        DocumentNo: Code[20];
        PrincipalPaid: Decimal;
        InterestPaid: Decimal;
}
