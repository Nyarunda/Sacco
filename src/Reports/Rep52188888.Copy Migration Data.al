namespace UnitedWomen.UnitedWomen;

using System.Environment;

report 50590 "Copy Migration Data"
{
    Caption = 'Copy Migration Data';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(TargetCompany; TargetCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Target Company';
                        TableRelation = Company.Name;
                        ToolTip = 'Select the company where the migration records should be copied.';
                    }

                    field(CopyOnlyUnposted; CopyOnlyUnposted)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Only Unposted Records';
                        ToolTip = 'Turn on to copy only records where Posted is false. Turn off to copy all migration records.';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        MigrationCopyMgt: Codeunit "Migration Company Copy Mgt.";
        MemberInserted: Integer;
        MemberUpdated: Integer;
        VendorInserted: Integer;
        VendorUpdated: Integer;
        BankInserted: Integer;
        BankUpdated: Integer;
    begin
        if TargetCompany = '' then
            Error('Please select the Target Company.');

        if TargetCompany = CompanyName then
            Error('Target company cannot be the current company.');

        if not Confirm(
            'Copy migration data from company %1 to company %2?',
            false,
            CompanyName,
            TargetCompany)
        then
            exit;

        if CopyOnlyUnposted then begin
            MigrationCopyMgt.CopyUnpostedMemberLedgerMigrationToCompany(
                TargetCompany,
                MemberInserted,
                MemberUpdated);

            MigrationCopyMgt.CopyUnpostedVendorLedgerMigrationToCompany(
                TargetCompany,
                VendorInserted,
                VendorUpdated);

            MigrationCopyMgt.CopyUnpostedBankLedgerMigrationToCompany(
                TargetCompany,
                BankInserted,
                BankUpdated);

            Message(
                'Unposted migration data copied successfully.\' +
                'Source Company: %1\' +
                'Target Company: %2\' +
                '\' +
                'Member Ledger Migration: Inserted %3, Updated %4\' +
                'Vendor Ledger Migration: Inserted %5, Updated %6\' +
                'Bank Ledger Migration: Inserted %7, Updated %8',
                CompanyName,
                TargetCompany,
                MemberInserted,
                MemberUpdated,
                VendorInserted,
                VendorUpdated,
                BankInserted,
                BankUpdated);
        end else
            MigrationCopyMgt.CopyAllMigrationDataToCompany(TargetCompany);
    end;

    var
        TargetCompany: Text[100];
        CopyOnlyUnposted: Boolean;
}