report 50357 "Modify Branch Managers"
{
    ApplicationArea = All;
    Caption = 'Modify Branch Managers';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Members)
        {
            DataItemTableView = where("Branch manager" = filter('089'));
            trigger onafterGetRecord()
            var
                userSetup: record "User Setup";
                HREmployees: Record Employee;
            begin
                UserSetup.Reset;
                UserSetup.SetRange("Global Dimension 2 Code", "Global Dimension 2 Code");
                UserSetup.SetRange("Branch Manager", true);
                if UserSetup.FindFirst then begin
                    "Branch Manager" := UserSetup."Staff No";
                    HREmployees.Get("Branch Manager");
                    "Branch Manager Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                    Modify();
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
}
