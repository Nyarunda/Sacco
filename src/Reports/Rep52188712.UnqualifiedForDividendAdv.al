report 50375 "Unqualified For Dividend Adv"
{
    ApplicationArea = All;
    Caption = 'Unqualified For Dividend Adv';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Unqualified For Adv.rdlc';

    dataset
    {
        dataitem(UnqualifiedForDividendAdv; "Unqualified For Dividend Adv")
        {
            column(EntryNo; "Entry No")
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(Reason; Reason)
            {
            }
            column(DateApplied; "Date Applied")
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_picture; Company.Picture)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
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
}
