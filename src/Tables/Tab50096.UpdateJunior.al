table 51096 "Update Junior"
{
    Caption = 'Update Junior';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(3; Updated; Boolean)
        {
            Caption = 'Updated';
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
        Fosa: Record "Savings Accounts";
    begin
        if Fosa.get("No.") then begin
            Fosa."Member No." := "Member No.";
            Fosa.Modify();
            Updated := true;
        end;
    end;


}
