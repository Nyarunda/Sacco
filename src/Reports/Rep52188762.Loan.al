namespace CentralDB.CentralDB;

report 50444 "Loans Guaranteed Notification"
{
    Caption = 'Loans Guaranteed Notification';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Member Status", "Employer Code";

            DataItemTableView = where("Member Status" = filter(Active | Dormant));
            trigger OnAfterGetRecord()
            var
                CustomNotifications: Codeunit "Custom Notifications";
                Notice: enum "Notice Type";
            begin
                //CustomNotifications.GenerateLoanGuarantorGuaranteed(Members."No.");
                CustomNotifications.GenerateDefaulterNotices("Member No.", Notice);
                //CurrReport.Skip();
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
