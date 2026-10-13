report 50580 "Writeoff Listing Report"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Writeoff Report.rdlc';
    ApplicationArea = All;
    Caption = 'Writeoff Listing Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Writeoffs; "Write offs")
        {
            column(MemberName; "Member Name")
            {
            }
            column(OldMemberNo; "Old Member No")
            {
            }
            column(Date_Posted; "Date Posted")
            { }
            column(Member_No; "Member No")
            { }
            column(ShareCapital; "Share Capital")
            {
            }
            column(Depostis; Depostis)
            {
            }
            column(UnpaidDividend; "Unpaid Dividend")
            {
            }
            column(TotalWriteOffAmount; "Total Write Off Amount")
            {
            }
            column(Total_Share_Amount; "Total Share Amount")
            {

            }
            column(InterestBalance; "Interest Balance")
            {
            }
            column(LoanBalance; "Loan Balance")
            {
            }

            column(MemberStatus; MemberStatus)
            {

            }
            column(CompanyPicture; CompanyInfo.Picture) { }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Loan No." = field("Loan No");
                CalcFields = "Total Outstanding Balance";
                column(Approved_Amount; "Approved Amount")
                { }
                column(ID_No_; "ID No.")
                { }
                column(Disbursement_Date; "Disbursement Date")
                { }
                column(Installments; Installments)
                { }
                column(OutstandingPrincipal; "Outstanding Principal")
                {
                }
                column(RemainigInstallments; RemainigInstallments)
                {
                }
                column(OutstandingInterest; "Outstanding Interest")
                { }
                column(Total_Outstanding_Balance; "Total Outstanding Balance")
                { }
            }
            trigger OnAfterGetRecord()
            var
                Cust: Record Members;
                SActivities: codeunit "Sacco Activities";
            begin
                MemberStatus := '';
                if Cust.get(Writeoffs."Member No") then begin
                    MemberStatus := format(Cust."Member Status");
                    RemainigInstallments := SActivities.GetRemainingInstallments(Writeoffs."Loan No");
                end;
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

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        MemberStatus: Text;
        RemainigInstallments: Integer;
        CompanyInfo: Record "Company Information";
}
