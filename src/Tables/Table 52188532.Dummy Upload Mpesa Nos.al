
Table 50195 "Dummy Upload Mpesa Nos"
{

    fields
    {
        field(1; "Old No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Phone; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Name; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Old No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        Members.RESET;
        Members.SETRANGE("Old Member No.","Old No.");
        Members.SETRANGE(Name,Name);
        IF Members.FINDFIRST THEN BEGIN
            MemberAccounts.RESET;
            MemberAccounts.SETRANGE("Member No.",Members."No.");
            MemberAccounts.SETRANGE("Product Category",MemberAccounts."Product Category"::"Ordinary Savings");
            MemberAccounts.SETFILTER("Transactional Mobile No",'%1','');
            IF MemberAccounts.FINDFIRST THEN BEGIN
                MemberAccounts."Transactional Mobile No" := '+'+Phone;
                MemberAccounts.MODIFY;
                Updated := TRUE;
            END;
        END;
        */


        "Old No." := '+' + "Old No.";

    end;

    var
        Members: Record Members;
        MemberAccounts: Record "Savings Accounts";
}

