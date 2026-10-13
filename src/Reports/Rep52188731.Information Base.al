/// <summary>
/// Report Info Base (ID 50394).
/// </summary>
report 50394 "Info Base"
{
    ApplicationArea = All;
    Caption = 'Info Base';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Information Base.rdlc';
    dataset
    {
        dataitem(InformationBase; "Information Base.")
        {
            column(AccountNo; "Account No.")
            {
            }
            column(CapturedBy; "Captured By")
            {
            }
            column(Date; "Date")
            {
            }
            column(Info; Info)
            {
            }
            column(MemberNo; "Member No.")
            {
            }
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
                    field(MemberNo; InformationBase."Member No.")
                    {
                        ApplicationArea = All;

                    }
                    field(Date; InformationBase.Date)
                    {
                        ApplicationArea = All;

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
}
