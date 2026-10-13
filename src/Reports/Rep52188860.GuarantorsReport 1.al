namespace UnitedWomenUnitedWomen.UnitedWomenUnitedWomen;
using Microsoft.Foundation.Company;

report 50566 "Guarantors Report"
{
    Caption = 'Guarantors Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Guarantors Report.rdlc';
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Member No.", "Date Filter";

            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(Member_Name;"Member Name")
            {                
            }
            column(Member_No_;"Member No.")
            {                
            }
            column(RepaymentStartDate; "Repayment Start Date")
            {
            }
            column(CompletionDate; "Completion Date")
            {
            }
            column(OutstandingPrincipal; "Outstanding Principal")
            {
            }
            column(CurrentShares; Currentshares)
            {
            }
            column(CompanyInfo_Picture; Company.Picture)
            {
            }
            dataitem(loansecurity; "Loan Security")
            {
                dataitemlink = "Loan No." = field("Loan No.");

                column(Self_Guarantee; "Self Guarantee")
                { }
                column(Amount_Guaranteed; DisplayAmountGuaranteed)
                {
                }
                column(current_committed; "Current Committed")
                {
                }
                column(LoanBalance_LoanGuarantors; "Guarantor Loan Balance")
                {
                }
                column(MemberNo_LoanGuarantors; DisplayMemberNo)
                {
                }
                column(Name_LoanGuarantors; DisplayName)
                {
                }
                column(OutstandingBalance_LoanGuarantors; "Outstanding Principal")
                {
                }
                column(MemberGuaranteed_LoanGuarantors; "Member Guaranteed")
                {
                }
                column(Guaranteed_By; "Guaranteed By")
                {
                }
                column(Outstanding_Principal; "Outstanding Principal")
                {
                }

                trigger OnAfterGetRecord()
                var
                    Coll: Record "Loan Collateral Register";
                begin
                    DisplayMemberNo := Loansecurity."Member No";
                    DisplayName := Loansecurity.Name;
                    DisplayAmountGuaranteed := Loansecurity."Amount Guaranteed";

                    if Loansecurity."Guarantor Type" = Loansecurity."Guarantor Type"::Collateral then begin
                        CurrReport.Skip();

                        if DisplayMemberNo = '' then
                            DisplayMemberNo := Loansecurity."Account No.";

                        DisplayAmountGuaranteed := Loansecurity."Application Amount Guaranteed";

                        if (Loansecurity."Collateral Reg. No." <> '') and Coll.Get(Loansecurity."Collateral Reg. No.") then
                            DisplayName := Coll."Account Name";
                    end;
                end;





            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                LoanG: Record "Loan Security";
                savAccRec: Record "Savings Accounts";
            begin
                Currentshares := 0;
                savAccRec.Reset();
                savAccRec.SetLoadFields("Balance (LCY)");
                savAccRec.SetRange("Member No.", Loans."Member No.");
                savAccRec.SetRange("Product Category", savAccRec."Product Category"::"Deposit Contribution");
                if Loans.GetFilter("Date Filter") <> '' then
                    savAccRec.SetFilter("Date Filter", Loans.GetFilter("Date Filter"));
                if savAccRec.FindFirst() then begin
                    savAccRec.CalcFields("Balance (LCY)");
                    Currentshares := savAccRec."Balance (LCY)";
                end;

                //if Loans.Get(LoanG."Loan No.") then
                //  Report.Run(Report::"Update Guarantor Commitment", false, false, LoanG);


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
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
        currentshares: Decimal;
        Company: Record "Company Information";
        DisplayAmountGuaranteed: Decimal;
        DisplayMemberNo: Code[20];
        DisplayName: Text[200];
}
