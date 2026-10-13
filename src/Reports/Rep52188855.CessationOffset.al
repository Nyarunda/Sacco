namespace UnitedWomen.UnitedWomen;

report 50557 "Cessation Offset"
{
    ApplicationArea = All;
    Caption = 'Cessation Offset';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './src/Layouts/Cessation Offset.docx';
    dataset
    {
        dataitem(DefaulterLoanRecovery; "Defaulter Loan Recovery")
        {
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Name; Name)
            {
            }
            column(MemberSavings; "Member Savings")
            {
            }
            column(NetRefund; "Net Refund")
            {
            }
            column(ShareCapital; "Share Capital")
            {
            }
            column(Outstanding_Insurance; "Outstanding Insurance")
            {

            }
            column(OutstandingInterest; "Outstanding Interest")
            {
            }
            column(OutstandingPenalty; "Outstanding Penalty")
            {
            }
            column(OutstandingPrincipal; "Outstanding Principal")
            {
            }
            column(CEO_Name; CEONameLbl) { }
            column(CEO_Title; CEOTitleLbl) { }
            column(DocumentDate; Format(Today, 0, '<Day,2> <Month Text> <Year4>')) { }
            column(Total_Deduction_Loans;"Total Deduction Loans"){}
            column(firstName; MemberActivity.GetMemberFirstName(DefaulterLoanRecovery.Name)){}

           
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
    var
        CEONameLbl: Label 'Nancy N. Mutugu';
        CEOTitleLbl: Label 'Chief Executive Officer';
        DocumentDate: Date;
        MemberActivity : Codeunit "Member Activities";

}
