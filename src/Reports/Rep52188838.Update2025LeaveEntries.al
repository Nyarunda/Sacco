namespace UnitedWomen_Production.UnitedWomen_Production;

report 50540 "Update 2025 Leave Entries"
{
    Caption = 'Update 2025 Leave Entries';
    ProcessingOnly = true;
    dataset
    {
        dataitem(HRLeaveLedgerEntries; "HR Leave Ledger Entries.")
        {
            trigger OnPreDataItem()
            begin
                HRLeaveLedgerEntries.SetFilter("Posting Date", '%1..', DMY2Date(01, 01, 2026));
                HRLeaveLedgerEntries.SetRange("Leave Calendar Code", '2025L');
            end;

            trigger OnAfterGetRecord()
            begin
                HRLeaveLedgerEntries."Posting Date" := DMY2Date(31, 12, 2025);
                HRLeaveLedgerEntries.Modify();
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
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;

    trigger OnPostReport()
    begin
        //Code to execute after the report is processed
        Message('2025 Leave Entries Updated Successfully');
    end;
}
