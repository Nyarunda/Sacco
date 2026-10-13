table 51201 "Update Bank Details"
{
    Caption = 'Update Bank Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Bank No."; Code[200])
        {
            Caption = 'Bank No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Branch Code"; Code[200])
        {
            Caption = 'Branch Code';
            DataClassification = ToBeClassified;
        }
        field(4; SWIFT; Code[200])
        {
            Caption = 'SWIFT';
            DataClassification = ToBeClassified;
        }

        field(6; Updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Customer: Record "Bank Account";
    begin
        if Customer.get("No.") then begin
            Customer."Bank Account No." := "Bank No.";
            Customer."Bank Branch No." := "Branch Code";
            Customer."SWIFT Code" := SWIFT;
            Customer.Modify();
            Updated := true;
        end;
    end;
}
