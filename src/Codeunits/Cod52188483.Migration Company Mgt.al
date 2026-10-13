namespace UnitedWomen.UnitedWomen;

using System.Environment;

codeunit 50146 "Migration Company Copy Mgt."
{
    //Caption = 'Migration Company Copy Mgt.';

    procedure CopyAllMigrationDataToCompany(TargetCompany: Text)
    var
        MemberCopied: Integer;
        MemberUpdated: Integer;
        VendorCopied: Integer;
        VendorUpdated: Integer;
        BankCopied: Integer;
        BankUpdated: Integer;
    begin
        if TargetCompany = '' then
            Error('Target company must not be blank.');

        if TargetCompany = CompanyName then
            Error('Target company cannot be the current company.');

        CopyMemberLedgerMigrationToCompany(TargetCompany, MemberCopied, MemberUpdated);
        CopyVendorLedgerMigrationToCompany(TargetCompany, VendorCopied, VendorUpdated);
        CopyBankLedgerMigrationToCompany(TargetCompany, BankCopied, BankUpdated);

        Message(
            'Migration data copy completed.\' +
            'Target Company: %1\' +
            '\' +
            'Member Ledger Migration: Inserted %2, Updated %3\' +
            'Vendor Ledger Migration: Inserted %4, Updated %5\' +
            'Bank Ledger Migration: Inserted %6, Updated %7',
            TargetCompany,
            MemberCopied,
            MemberUpdated,
            VendorCopied,
            VendorUpdated,
            BankCopied,
            BankUpdated);
    end;

    procedure CopyMemberLedgerMigrationToCompany(TargetCompany: Text; var InsertedCount: Integer; var UpdatedCount: Integer)
    var
        SourceMigration: Record "Member Ledger Entry Migration";
        TargetMigration: Record "Member Ledger Entry Migration";
        ProgressWindow: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
    begin
        Clear(InsertedCount);
        Clear(UpdatedCount);

        ValidateTargetCompany(TargetCompany);

        TargetMigration.ChangeCompany(TargetCompany);

        SourceMigration.Reset();
        TotalRecords := SourceMigration.Count();

        if TotalRecords = 0 then
            exit;

        ProgressWindow.Open(
            'Copying Member Ledger Migration...\' +
            'Record #1######## of #2########\' +
            'Entry No. #3########');

        if SourceMigration.FindSet(false) then
            repeat
                CurrentRecordNo += 1;

                ProgressWindow.Update(1, CurrentRecordNo);
                ProgressWindow.Update(2, TotalRecords);
                ProgressWindow.Update(3, SourceMigration."Entry No.");

                TargetMigration.Reset();
                TargetMigration.ChangeCompany(TargetCompany);

                if TargetMigration.Get(SourceMigration."Entry No.", SourceMigration."No Count") then begin
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Modify(false);
                    UpdatedCount += 1;
                end else begin
                    TargetMigration.Init();
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Insert(false);
                    InsertedCount += 1;
                end;
            until SourceMigration.Next() = 0;

        ProgressWindow.Close();
    end;

    procedure CopyVendorLedgerMigrationToCompany(TargetCompany: Text; var InsertedCount: Integer; var UpdatedCount: Integer)
    var
        SourceMigration: Record "Vendor Ledger Entry Migration";
        TargetMigration: Record "Vendor Ledger Entry Migration";
        ProgressWindow: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
    begin
        Clear(InsertedCount);
        Clear(UpdatedCount);

        ValidateTargetCompany(TargetCompany);

        TargetMigration.ChangeCompany(TargetCompany);

        SourceMigration.Reset();
        TotalRecords := SourceMigration.Count();

        if TotalRecords = 0 then
            exit;

        ProgressWindow.Open(
            'Copying Vendor Ledger Migration...\' +
            'Record #1######## of #2########\' +
            'Entry No. #3########');

        if SourceMigration.FindSet(false) then
            repeat
                CurrentRecordNo += 1;

                ProgressWindow.Update(1, CurrentRecordNo);
                ProgressWindow.Update(2, TotalRecords);
                ProgressWindow.Update(3, SourceMigration."Entry No.");

                TargetMigration.Reset();
                TargetMigration.ChangeCompany(TargetCompany);

                if TargetMigration.Get(SourceMigration."Entry No.") then begin
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Modify(false);
                    UpdatedCount += 1;
                end else begin
                    TargetMigration.Init();
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Insert(false);
                    InsertedCount += 1;
                end;
            until SourceMigration.Next() = 0;

        ProgressWindow.Close();
    end;

    procedure CopyBankLedgerMigrationToCompany(TargetCompany: Text; var InsertedCount: Integer; var UpdatedCount: Integer)
    var
        SourceMigration: Record "Bank Account Ledger Migration";
        TargetMigration: Record "Bank Account Ledger Migration";
        ProgressWindow: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
    begin
        Clear(InsertedCount);
        Clear(UpdatedCount);

        ValidateTargetCompany(TargetCompany);

        TargetMigration.ChangeCompany(TargetCompany);

        SourceMigration.Reset();
        TotalRecords := SourceMigration.Count();

        if TotalRecords = 0 then
            exit;

        ProgressWindow.Open(
            'Copying Bank Ledger Migration...\' +
            'Record #1######## of #2########\' +
            'Entry No. #3########');

        if SourceMigration.FindSet(false) then
            repeat
                CurrentRecordNo += 1;

                ProgressWindow.Update(1, CurrentRecordNo);
                ProgressWindow.Update(2, TotalRecords);
                ProgressWindow.Update(3, SourceMigration."Entry No.");

                TargetMigration.Reset();
                TargetMigration.ChangeCompany(TargetCompany);

                if TargetMigration.Get(SourceMigration."Entry No.") then begin
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Modify(false);
                    UpdatedCount += 1;
                end else begin
                    TargetMigration.Init();
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Insert(false);
                    InsertedCount += 1;
                end;
            until SourceMigration.Next() = 0;

        ProgressWindow.Close();
    end;

    procedure CopyUnpostedMemberLedgerMigrationToCompany(TargetCompany: Text; var InsertedCount: Integer; var UpdatedCount: Integer)
    var
        SourceMigration: Record "Member Ledger Entry Migration";
        TargetMigration: Record "Member Ledger Entry Migration";
        ProgressWindow: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
    begin
        Clear(InsertedCount);
        Clear(UpdatedCount);

        ValidateTargetCompany(TargetCompany);

        TargetMigration.ChangeCompany(TargetCompany);

        SourceMigration.Reset();
        SourceMigration.SetRange(Posted, false);

        TotalRecords := SourceMigration.Count();

        if TotalRecords = 0 then
            exit;

        ProgressWindow.Open(
            'Copying Unposted Member Ledger Migration...\' +
            'Record #1######## of #2########\' +
            'Entry No. #3########');

        if SourceMigration.FindSet(false) then
            repeat
                CurrentRecordNo += 1;

                ProgressWindow.Update(1, CurrentRecordNo);
                ProgressWindow.Update(2, TotalRecords);
                ProgressWindow.Update(3, SourceMigration."Entry No.");

                TargetMigration.Reset();
                TargetMigration.ChangeCompany(TargetCompany);

                if TargetMigration.Get(SourceMigration."Entry No.", SourceMigration."No Count") then begin
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Modify(false);
                    UpdatedCount += 1;
                end else begin
                    TargetMigration.Init();
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Insert(false);
                    InsertedCount += 1;
                end;
            until SourceMigration.Next() = 0;

        ProgressWindow.Close();
    end;

    procedure CopyUnpostedVendorLedgerMigrationToCompany(TargetCompany: Text; var InsertedCount: Integer; var UpdatedCount: Integer)
    var
        SourceMigration: Record "Vendor Ledger Entry Migration";
        TargetMigration: Record "Vendor Ledger Entry Migration";
        ProgressWindow: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
    begin
        Clear(InsertedCount);
        Clear(UpdatedCount);

        ValidateTargetCompany(TargetCompany);

        TargetMigration.ChangeCompany(TargetCompany);

        SourceMigration.Reset();
        SourceMigration.SetRange(Posted, false);

        TotalRecords := SourceMigration.Count();

        if TotalRecords = 0 then
            exit;

        ProgressWindow.Open(
            'Copying Unposted Vendor Ledger Migration...\' +
            'Record #1######## of #2########\' +
            'Entry No. #3########');

        if SourceMigration.FindSet(false) then
            repeat
                CurrentRecordNo += 1;

                ProgressWindow.Update(1, CurrentRecordNo);
                ProgressWindow.Update(2, TotalRecords);
                ProgressWindow.Update(3, SourceMigration."Entry No.");

                TargetMigration.Reset();
                TargetMigration.ChangeCompany(TargetCompany);

                if TargetMigration.Get(SourceMigration."Entry No.") then begin
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Modify(false);
                    UpdatedCount += 1;
                end else begin
                    TargetMigration.Init();
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Insert(false);
                    InsertedCount += 1;
                end;
            until SourceMigration.Next() = 0;

        ProgressWindow.Close();
    end;

    procedure CopyUnpostedBankLedgerMigrationToCompany(TargetCompany: Text; var InsertedCount: Integer; var UpdatedCount: Integer)
    var
        SourceMigration: Record "Bank Account Ledger Migration";
        TargetMigration: Record "Bank Account Ledger Migration";
        ProgressWindow: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
    begin
        Clear(InsertedCount);
        Clear(UpdatedCount);

        ValidateTargetCompany(TargetCompany);

        TargetMigration.ChangeCompany(TargetCompany);

        SourceMigration.Reset();
        SourceMigration.SetRange(Posted, false);

        TotalRecords := SourceMigration.Count();

        if TotalRecords = 0 then
            exit;

        ProgressWindow.Open(
            'Copying Unposted Bank Ledger Migration...\' +
            'Record #1######## of #2########\' +
            'Entry No. #3########');

        if SourceMigration.FindSet(false) then
            repeat
                CurrentRecordNo += 1;

                ProgressWindow.Update(1, CurrentRecordNo);
                ProgressWindow.Update(2, TotalRecords);
                ProgressWindow.Update(3, SourceMigration."Entry No.");

                TargetMigration.Reset();
                TargetMigration.ChangeCompany(TargetCompany);

                if TargetMigration.Get(SourceMigration."Entry No.") then begin
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Modify(false);
                    UpdatedCount += 1;
                end else begin
                    TargetMigration.Init();
                    TargetMigration.TransferFields(SourceMigration, true);
                    TargetMigration.Insert(false);
                    InsertedCount += 1;
                end;
            until SourceMigration.Next() = 0;

        ProgressWindow.Close();
    end;

    local procedure ValidateTargetCompany(TargetCompany: Text)
    var
        CompanyRec: Record Company;
    begin
        if TargetCompany = '' then
            Error('Target company must not be blank.');

        if TargetCompany = CompanyName then
            Error('Target company cannot be the current company.');

        CompanyRec.Reset();
        CompanyRec.SetRange(Name, TargetCompany);

        if CompanyRec.IsEmpty() then
            Error('Company %1 does not exist.', TargetCompany);
    end;
}