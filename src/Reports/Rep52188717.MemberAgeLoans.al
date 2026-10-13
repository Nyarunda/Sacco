report 50439 "Member Age & Loans"
{
    ApplicationArea = All;
    Caption = 'Member Age & Loans';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Age & Loans.rdlc';
    dataset
    {
        dataitem(Loans; Loans)

        {
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", Source;
            DataItemTableView = where("Total Outstanding Balance" = filter(> 0));
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(DisbursementAccountNo; "Disbursement Account No")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(TotalOutstandingBalance; "Total Outstanding Balance")
            {
            }
            column(ID_No_; "ID No.")
            {
            }
            column(MemberAge; MemberAge)
            {

            }
            column(Installments; Installments)
            { }
            column(Disbursement_Date; "Disbursement Date")
            { }
            column(DOB; DOB)
            { }
            column(CurrentDeposits; CurrentDeposits)
            { }
            column(OutstandingRP; OutstandingRP)
            { }

            trigger OnAfterGetRecord()
            var
                LRS: Record "Loan Repayment Schedule";
            begin
                if Cust.Get(Loans."Member No.") then begin
                    DOB := Cust."Date of Birth";
                    if Cust."Date of Birth" <> 0D then
                        MemberAge := Date2DMY(Today, 3) - Date2DMY(Cust."Date of Birth", 3);
                    CurrentDeposits := MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts("Member No."));
                end;

                LRS.Reset();
                LRS.SetRange("Loan No.", Loans."Loan No.");
                LRS.SetFilter("Repayment Date", '>=%1', Today);
                if LRS.FindSet() then OutstandingRP := LRS.Count;


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
        Company: Record "Company Information";
        Cust: Record Members;
        MemberAge: Integer;
        DOB: Date;
        CurrentDeposits: Decimal;
        MemberActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        OutstandingRP: Integer;

}
