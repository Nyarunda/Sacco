Table 50061 "Bulk SMS Lines"
{

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bulk SMS Header".No;
        }
        field(2; "Phone No."; Code[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin

                "Account to Charge" := '';

                Members.Reset;
                Members.SetRange("Mobile Phone No.", "Phone No.");
                if Members.FindFirst then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::" ");
                    SavingsAccounts.SetRange("Member No.", Members."No.");
                    if SavingsAccounts.FindFirst then
                        "Account to Charge" := SavingsAccounts."No.";
                end;
            end;
        }
        field(3; "Sms Message"; Text[2000])
        {
        }
        field(4; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Account to Charge"; Code[20])
        {
            TableRelation = "Member Accounts";
        }
        field(6; "Loan No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No, "Phone No.", "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SavingsAccounts: Record "Savings Accounts";
        Members: Record Members;
}

