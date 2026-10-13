namespace UnitedWomen_Production.UnitedWomen_Production;

report 50072 "Generate Defaulter Notice-3"
{
    ApplicationArea = All;
    Caption = 'Generate Defaulter Notice-3';
    UsageCategory = History;
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
                    CNotifications.GenerateDefaulterNotices("Loan No.", Notice::"Notice 3");

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
}
