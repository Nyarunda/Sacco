report 50348 "Employer Change"
{
    Caption = 'Employer Change';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/EmployerChange.rdlc';
    UsageCategory = ReportsandAnalysis;
    dataset
    {
        dataitem(MemberChanges; "Member Changes")
        {
            RequestFilterFields = "Employer Code";
            DataItemTableView = where(Posted = filter(true));
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Names; Name)
            {
            }
            column(Reason_For_Change; "Reason For Change")
            {
            }
            column(Account_No_; "Account No.")
            {
            }
            column(Monthly_Contribution; "Monthly Contribution")
            {
            }
            column(New_Monthly_Contribution; "New Monthly Contribution")
            {
            }
            trigger OnAfterGetRecord()
            begin
                EmployerList.Reset;
                EmployerList.Setrange("No.", MemberChanges."Employer Code");
                If EmployerList.FindFirst then
                    EmployerName := EmployerList.Name;
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
    var
        EmployerName: Text;
        EmployerList: Record Customer;
}
