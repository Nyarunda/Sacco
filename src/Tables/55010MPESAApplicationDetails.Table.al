Table 55010 "MPESA Application Details"
{

    fields
    {
        field(1; "Application No"; Code[30])
        {
            NotBlank = true;
            TableRelation = "MPESA Applications".No;
        }
        field(2; "Account Type"; Option)
        {
            Caption = 'Account Type';
            NotBlank = true;
            OptionCaption = 'Debtor,Member';
            OptionMembers = Customer,Member;
        }
        field(3; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            NotBlank = true;
            TableRelation = if ("Account Type" = const(Member)) "SACCO Account"."No." where("Loan Disbursement Account" = const(true));

            trigger OnValidate()
            begin

                case "Account Type" of
                    "account type"::Customer:
                        begin
                            Cust.Get("Account No.");
                            Description := Cust.Name;
                        end;
                    "account type"::Member:
                        begin
                            Vend.Get("Account No.");
                            Description := Vend.Name;
                        end;
                end;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Application No", "Account Type", "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record "SACCO Account";
        Vend: Record "SACCO Account";
}

