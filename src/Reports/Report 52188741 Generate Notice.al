report 50415 "Generate Defaulter Notices"
{
    ApplicationArea = All;
    Caption = 'Generate Defaulter Notices';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = rdlc;
    RDLCLayout = './src/Layouts/GenerateDefaulterNotices.rdlc';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Principal" = filter(> 0));
            RequestFilterFields = "Loan No.", "Member No.", "Loans Category-SASRA", "Loan Product Type", "Disbursement Date";
            trigger OnAfterGetRecord()
            var
                CNotifications: Codeunit "Custom Notifications";
                Members: Record members;
                Notice: enum "Notice Type";
            begin
                Members.Reset();
                Members.SetRange("No.", Loans."Member No.");
                Members.SetFilter("Member Status", '%1|%2', Members."Member Status"::Active, Members."Member Status"::Dormant);
                if Members.FindFirst() then
                    CNotifications.GenerateDefaulterNoticesNew("Loan No.", Notice);
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



}
