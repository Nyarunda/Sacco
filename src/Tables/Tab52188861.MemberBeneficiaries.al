table 50563 "Member Beneficiaries"
{
    Caption = 'Member Beneficiaries';
    DataClassification = CustomerContent;
    LookupPageID = "Member Beneficiaries";
    DrillDownPageID = "Member Beneficiaries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members."No.";
        }
        field(3; "Beneficiary ID"; Code[20])
        {
            Caption = 'Beneficiary ID';
        }
        field(4; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(5; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Member,Bank,Other;
            OptionCaption = 'Member,Bank,Other';
        }
        field(6; "Bank"; Text[50])
        {
            Caption = 'Bank';
        }
        field(7; "Account Number"; Text[50])
        {
            Caption = 'Account Number';
        }
        field(8; "Date Added"; DateTime)
        {
            Caption = 'Date Added';
        }
        field(9; "Added By"; Code[50])
        {
            Caption = 'Added By';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Member No.", "Beneficiary ID")
        {
        }
    }

    trigger OnInsert()
    begin
        "Date Added" := CurrentDateTime;
        "Added By" := UserId;

        // Generate Beneficiary ID if not provided
        if "Beneficiary ID" = '' then begin
            "Beneficiary ID" := 'BEN-' + Format(Today, 0, '<Year,2><Month,2><Day,2>') + '-' + Format("Entry No.", 0, '<Integer,4><Filler Character,0>');
        end;
    end;
}
