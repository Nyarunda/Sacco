
Table 50160 "Defaulter Recovery Lines"
{

    fields
    {
        field(1; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Guarantor Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Guarantor Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Withdrawable Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Non-Withdrable Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Loan Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Amount to Recover"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF "Amount to Recover" <> "Loan Allocation" THEN
                // ERROR('This Amount MUST be equal to the Loan Allocation');
            end;
        }
        field(9; "Amount Recovered"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Guarantor Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Committed Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Committed Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Loan Balance After Offset"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; Installement; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50024; "Loan Type Name"; Text[50])
        {
            CalcFormula = lookup(Loans."Loan Product Type Name" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(50100; "Recovery Method"; Enum "Guarantor Recovery Method")
        {
            Caption = 'Recovery Method';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                case "Recovery Method" of
                    "Recovery Method"::Savings:
                        begin
                            "Amount from Savings" := "Amount to Recover";
                            "Amount as Loan" := 0;
                        end;

                    "Recovery Method"::Loan:
                        begin
                            "Amount as Loan" := "Amount to Recover";
                            "Amount from Savings" := 0;
                        end;

                    "Recovery Method"::Split:
                        begin
                            // Clear both so the officer fills them in deliberately.
                            // ValidateSplitAmounts() is called when each amount field changes.
                            "Amount from Savings" := 0;
                            "Amount as Loan" := 0;
                        end;

                    "Recovery Method"::Default:
                        begin
                            "Amount from Savings" := 0;
                            "Amount as Loan" := 0;
                        end;
                end;
            end;
        }

        field(50101; "Amount from Savings"; Decimal)
        {
            Caption = 'Amount from Savings';
            DataClassification = CustomerContent;
            MinValue = 0;
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                if "Recovery Method" <> "Recovery Method"::Split then
                    Error('Amount from Savings can only be edited when Recovery Method is Split.');

                ValidateSplitAmounts();
            end;
        }

        field(50102; "Amount as Loan"; Decimal)
        {
            Caption = 'Amount as Loan';
            DataClassification = CustomerContent;
            MinValue = 0;
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                if "Recovery Method" <> "Recovery Method"::Split then
                    Error('Amount as Loan can only be edited when Recovery Method is Split.');

                ValidateSplitAmounts();
            end;
        }
        field(50103; Reversed; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Credit Ledger Entry" where("Document No." = field("Header No."),
                                                            "Loan No." = field("Loan No."),
                                                            Reversed = const(true)));
        }
        field(50104; "Outstanding Penalty"; Decimal)
        {
            Caption = 'Outstanding Penalty';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Header No.", "Loan No.", "Guarantor Savings Account", "Guarantor Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    var
        myInt: Integer;
    begin
        Error('Not Allowed Error!');
    end;

    local procedure ValidateSplitAmounts()
    var
        Total: Decimal;
    begin
        Total := "Amount from Savings" + "Amount as Loan";

        // Allow partial entry while the officer is still filling in both fields.
        // Only block if the total EXCEEDS the required amount, or if the record
        // is being saved (checked in OnInsert/OnModify via CheckSplitComplete).
        if Total > "Amount to Recover" then
            Error(
                'The split amounts (%1 + %2 = %3) exceed the amount to recover (%4).\' +
                'Please reduce one of the values.',
                "Amount from Savings",
                "Amount as Loan",
                Total,
                "Amount to Recover");
    end;

    procedure CheckSplitComplete()
    begin
        if "Recovery Method" <> "Recovery Method"::Split then
            exit;

        if ("Amount from Savings" + "Amount as Loan") <> "Amount to Recover" then
            Error(
                'Guarantor %1 (%2): Split amounts (%3 + %4 = %5) must equal the amount to recover (%6).',
                "Guarantor Name",
                "Guarantor Member No.",
                "Amount from Savings",
                "Amount as Loan",
                "Amount from Savings" + "Amount as Loan",
                "Amount to Recover");
    end;

    procedure GetSavingsAmount(): Decimal
    begin
        case "Recovery Method" of
            "Recovery Method"::Savings,
            "Recovery Method"::Default:
                exit("Amount to Recover");

            "Recovery Method"::Split:
                exit("Amount from Savings");

            "Recovery Method"::Loan:
                exit(0);
        end;
    end;

    procedure GetLoanAmount(): Decimal
    begin
        case "Recovery Method" of
            "Recovery Method"::Loan:
                exit("Amount to Recover");

            "Recovery Method"::Split:
                exit(Rec."Amount as Loan");

            "Recovery Method"::Savings,
            "Recovery Method"::Default:
                exit(0);
        end;
    end;
}
