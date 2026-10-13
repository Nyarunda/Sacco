
Table 50282 "MBanking Lines"
{

    fields
    {
        field(1; "Application No"; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "MBanking Applications";
        }
        field(2; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            NotBlank = true;
            OptionMembers = " ",Creditor;
        }
        field(3; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Vendor where("Product Category" = const("Ordinary Savings"));

            trigger OnValidate()
            begin

                MpesaApplications.Reset;
                MpesaApplications.SetRange(MpesaApplications.No, "Application No");
                if MpesaApplications.Find('-') then begin

                    if MpesaApplications."Account No" <> "Account No." then begin

                        Error('Account Not For Selected Member');

                    end;

                end;

                case "Account Type" of
                    "account type"::" ":
                        begin
                            Cust.Get("Account No.");
                            Description := Cust.Name;
                        end;
                    "account type"::Creditor:
                        begin
                            Cust.Get("Account No.");
                            Description := Cust.Name;
                        end;
                end;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record "Savings Accounts";
        MpesaApplications: Record "MBanking Applications";
}

