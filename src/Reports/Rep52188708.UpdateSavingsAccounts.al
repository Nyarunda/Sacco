report 50372 "Update Savings Accounts"
{
    ApplicationArea = All;
    Caption = 'Update Savings Accounts';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Vendor; "Savings Accounts")
        {
            DataItemTableView = where("Creditor Type" = const(Fosa), "Product Type" = const('0102'), "Salary Processing" = const(false));
            column(SalaryProcessing; "Salary Processing")
            {
            }
            column(No; "No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Name; Name)
            {
            }

            trigger OnAfterGetRecord()
            var
                SavAcc: Record "Savings Accounts";
            begin
                SavAcc.Reset();
                SavAcc.SetRange("No.", Vendor."No.");
                if SavAcc.FindFirst() then begin
                    SavAcc."Salary Processing" := true;
                    SavAcc.Modify();
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
