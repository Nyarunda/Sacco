Table 51129 "HR Employee Bank Accounts"
{
    DrillDownPageID = "HR Bank Accounts List";
    LookupPageID = "HR Bank Accounts List";

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Employee Code"; Code[20])
        {
            Editable = false;
        }

        // ── Source (Disbursement) ────────────────────────────────────────────
        field(3; "Mode of Disbursement"; Option)
        {
            OptionMembers = " ","Cheque","Mobile Money",EFT,RTGS;
            OptionCaption = ' ,Cheque,Mobile Money,EFT,RTGS';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Disbursement Account No." := '';
                "Cheque No." := '';
                "Disbursement Bank Name" := '';
            end;
        }
        field(4; "Disbursement Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Mode of Disbursement" = filter(Cheque | EFT | RTGS | "Mobile Money"))
                                "Bank Account"."No.";

            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
            begin
                "Disbursement Bank Name" := '';
                if "Disbursement Account No." = '' then
                    exit;

                if "Mode of Disbursement" = "Mode of Disbursement"::" " then
                    Error('Please select Mode of Disbursement before selecting the Disbursement Account.');

                if BankAccount.Get("Disbursement Account No.") then
                    "Disbursement Bank Name" := BankAccount.Name;
            end;
        }
        field(5; "Disbursement Bank Name"; Text[100])
        { Editable = false; }
        field(6; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque No./Document No.';


        }

        // ── Recipient (Destination) ──────────────────────────────────────────
        field(7; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Codes";
            trigger OnValidate()
            var
                PRBankAccount: Record "Bank Codes";
            begin
                "Bank Name" := '';
                "Branch Code" := '';
                "Branch Name" := '';
                if PRBankAccount.Get("Bank Code") then
                    "Bank Name" := PRBankAccount."Bank Name";
            end;
        }
        field(8; "Bank Name"; Text[100]) { Editable = false; }
        field(9; "Branch Code"; Code[20])
        {
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Bank Code"));
            trigger OnValidate()
            var
                PRBankBranch: Record "Bank Branches";
            begin
                "Branch Name" := '';
                if PRBankBranch.Get("Bank Code", "Branch Code") then
                    "Branch Name" := PRBankBranch."Branch Name";
            end;
        }
        field(10; "Branch Name"; Text[100]) { Editable = false; }
        field(11; "A/C Number"; Code[20]) { }

        field(12; "Amount to Transfer"; Decimal)
        {
            trigger OnValidate()
            var
                OtherLines: Record "HR Employee Bank Accounts";
                MemberAppraisal: Record "Member Salary Appraisal";
                partialLines: Record "Partial Loans Disb. Lines";
                Loans: Record Loans;
                NetDisbursement: Decimal;
                OtherLinesTotal: Decimal;
                Text001: Label 'Amount cannot be negative.';
                Text002: Label 'Total recipient amounts (%1) cannot exceed the Net Loan Take Home (%2).';
            begin
                if "Amount to Transfer" < 0 then
                    Error(Text001);

                if not MemberAppraisal.Get("Loan No.") then begin

                    PartialLines.Reset();
                    PartialLines.SetRange("Header No.", "Loan No.");
                    if PartialLines.FindFirst() then
                        partialLines.CalcSums("Amount to Disbuse")
                    else begin
                        if Loans.Get("Loan No.") then;

                        if memberAppraisal.Get(Loans."Salary Appraisal No.") then
                            NetDisbursement := memberAppraisal."Net Loan Take Home"
                        else
                            Error('No Member Salary Appraisal or Partial Disbursement Lines found for this Loan.');
                    end;

                    NetDisbursement := partialLines."Amount to Disbuse";
                end;

                if NetDisbursement = 0 then
                    NetDisbursement := MemberAppraisal."Net Loan Take Home";

                OtherLines.Reset();
                OtherLines.SetRange("Loan No.", "Loan No.");
                OtherLines.SetFilter("Line No.", '<>%1', "Line No.");
                if OtherLines.FindFirst() then begin
                    OtherLines.CalcSums("Amount to Transfer");
                    OtherLinesTotal := OtherLines."Amount to Transfer";
                end;

                if OtherLinesTotal + "Amount to Transfer" > NetDisbursement then
                    Error(Text002, OtherLinesTotal + "Amount to Transfer", NetDisbursement);
            end;
        }

        field(13; "Total Allocated"; Decimal)
        {
            CalcFormula = sum("HR Employee Bank Accounts"."Amount to Transfer"
                              where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(15; SwiftCode; Code[20]) { }

        field(50000; "Old A/C Number"; Code[20]) { }
        field(50001; "Loan No."; Code[20]) { }
        field(50002; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(Key1; "Line No.", "Loan No.") { Clustered = true; }
    }

    procedure ValidateTotalAllocation()
    var
        MemberAppraisal: Record "Member Salary Appraisal";
        NetDisbursement: Decimal;
        Text001: Label 'Total allocated to recipients (%1) exceeds the Net Loan Take Home (%2).';
        Text002: Label 'Mode of Disbursement is missing on line %1.';
        Text003: Label 'Disbursement Account is missing on line %1.';
        Text004: Label 'Cheque No. is required for Cheque disbursement on line %1.';
        Lines: Record "HR Employee Bank Accounts";
    begin
        Lines.Reset();
        Lines.SetRange("Loan No.", Rec."Loan No.");

        if Lines.IsEmpty() then
            exit; // No lines is acceptable — funds stay at default

        // Validate each line
        if Lines.FindSet() then
            repeat
                if Lines."Mode of Disbursement" = Lines."Mode of Disbursement"::" " then
                    Error(Text002, Lines."Line No.");
                if Lines."Disbursement Account No." = '' then
                    Error(Text003, Lines."Line No.");
                if (Lines."Mode of Disbursement" = Lines."Mode of Disbursement"::Cheque) and
                   (Lines."Cheque No." = '') then
                    Error(Text004, Lines."Line No.");
            until Lines.Next() = 0;

        Lines.CalcSums("Amount to Transfer");
        if MemberAppraisal.Get(Rec."Loan No.") then
            NetDisbursement := MemberAppraisal."Net Loan Take Home";

        if Lines."Amount to Transfer" > NetDisbursement then
            Error(Text001, Lines."Amount to Transfer", NetDisbursement);
    end;
}