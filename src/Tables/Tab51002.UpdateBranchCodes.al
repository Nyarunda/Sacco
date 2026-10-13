table 51002 "Update Branch Codes"
{
    Caption = 'Update Branch Codes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Check No."; Code[20])
        {
            Caption = 'Check No.';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
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
        key(PK; "Check No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Members: Record Members;
        Accounts: Record "Savings Accounts";
    begin
        Members.Reset();
        Members.SetRange("Payroll/Staff No.", "Check No.");
        if Members.FindFirst() then begin
            Members.Validate("Global Dimension 2 Code", 'NAIROBI');
            Members.Modify();

            Accounts.Reset();
            Accounts.SetRange("Member No.", Members."No.");
            if Accounts.FindSet(true) then begin
                repeat

                    Accounts.Validate("Global Dimension 2 Code", 'NAIROBI');
                    Accounts.Modify();
                    Updated := true;
                until Accounts.Next() = 0;
            end
        end;
    end;
}
