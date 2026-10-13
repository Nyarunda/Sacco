Table 50357 "Mbanking Nos Send Pin"
{

    fields
    {
        field(1; "Account No."; Code[20])
        {
        }
        field(2; "ID No."; Code[200])
        {
        }
        field(3; "Mobile No."; Code[20])
        {
        }
        field(4; Status; Text[30])
        {
        }
        field(60; "Pin Sent"; Boolean)
        {
        }
        field(61; SMS; Text[250])
        {
        }
        field(62; "SMS Sent"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Mobile No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", '+' + "Mobile No.");
        if SavAcc.FindFirst then begin
            "Account No." := SavAcc."No.";
        end;
    end;

    var
        SavAcc: Record "Savings Accounts";
}

