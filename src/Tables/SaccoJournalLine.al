Table 50356 "Sacco Journal Line"
{

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

        }
        field(13; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                ValidateAmount();
            end;
        }
        field(14; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';

            trigger OnValidate()
            begin
                if ("Credit Amount" = 0) or ("Debit Amount" <> 0) then begin
                    Amount := "Debit Amount";
                    Validate(Amount);
                end;
            end;
        }
        field(15; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';

            trigger OnValidate()
            begin
                if ("Debit Amount" = 0) or ("Credit Amount" <> 0) then begin
                    Amount := -"Credit Amount";
                    Validate(Amount);
                end;
            end;
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin

                if "Currency Code" = '' then begin
                    Amount := "Amount (LCY)";
                    Validate(Amount);
                end;
            end;
        }
        field(17; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            Editable = false;
        }
        field(50002; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            DataClassification = ToBeClassified;
        }
        field(50003; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(50004; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(50005; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;

            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee
            else
            if ("Account Type" = const(Savings)) "Savings Accounts"// where("Member No." = field("Member No."))
            else
            if ("Account Type" = const(Credit)) "Credit Accounts" where("No." = field("Account No."));

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
                Cust: Record Members;
                Customer: Record Customer;
                Vend: Record "Savings Accounts";
                FA: Record "Fixed Asset";
                BankAcc: Record "Bank Account";
                SA: Record "Savings Accounts";
                CR: Record "Credit Accounts";
            begin
                "Account Name" := '';
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            GLAcc.Get("Account No.");
                            "Account Name" := GLAcc.Name;
                        end;
                    "Account Type"::Customer:
                        begin
                            Customer.Get("Account No.");
                            "Account Name" := Cust.Name;
                        end;
                    "Account Type"::Vendor:
                        begin
                            Vend.Get("Account No.");
                            "Account Name" := Vend.Name;
                        end;
                    "Account Type"::Savings:
                        begin
                            SA.Get("Account No.");
                            "Account Name" := SA.Name;
                        end;
                    "Account Type"::Credit:
                        begin
                            CR.Get("Account No.");
                            "Account Name" := CR.Name;
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            BankAcc.Get("Account No.");
                            "Account Name" := BankAcc.Name;
                        end;
                end;
            end;

        }
        field(50006; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50007; "Member No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(50008; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }
        field(50011; "Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(50012; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No." where("Member No." = field("Member No."), "Total Outstanding Balance" = filter(<> 0));

            trigger OnValidate()
            var
                Loans: Record Loans;
            begin
                Loans.Get("Loan No");
                "Account No." := Loans."Loan Account";
                "Account Name" := Loans."Loan Product Type Name";
            end;
        }
        field(50013; "Product Type Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50015; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50016; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Product Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(50019; "Bal. Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(50020; Blocked; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(50021; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Loan Product"; Code[20])
        {
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(50023; Transaction; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Gross,Tax,Processing Fee,Duty on Processing Fee,Loan,SMS,Capitalized';
            OptionMembers = " ",Gross,Tax,"Processing Fee","Duty on Processing Fee",Loan,SMS,Capitalized;
        }

        field(50024; "Creation Date"; Date)
        {
            CalcFormula = lookup("Sacco Journal Header".Date where("Document No." = field("Batch No.")));
            FieldClass = FlowField;

        }
        field(51200; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = true;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                OldDimSetID: Integer;
                IsHandled: Boolean;
                DimMgt: Codeunit DimensionManagement;
            begin

                OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet(
                    Rec, "Dimension Set ID", "Document No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }

        field(51201; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Batch No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if "Line No." = 0 then
            "Line No." := GetNewLineNo
    end;


    trigger OnModify()
    var
        JVHeader: Record "Sacco Journal Header";
    begin
        JVHeader.Get("Batch No.");
        JVHeader.TestField("Captured By", UserId);
    end;

    procedure SetUpNewLine(LastGenJnlLine: Record "Sacco Journal Line")
    var
        GenJnlLine: Record "Sacco Journal Line";
        GenJnlHeader: Record "Sacco Journal Header";


    begin
        GenJnlHeader.Get("Batch No.");

        GenJnlLine.SETRANGE("Batch No.", "Batch No.");
        IF GenJnlLine.FINDFIRST THEN BEGIN
            "Posting Date" := LastGenJnlLine."Posting Date";
            "Document No." := LastGenJnlLine."Document No.";
            //if GenJnlHeader."Posting Type" = GenJnlHeader."Posting Type"::"User Header Document No." then
            //  "Document No." := GenJnlHeader."Document No.";

        END ELSE BEGIN
            "Posting Date" := WORKDATE;
            if GenJnlHeader."Posting Type" = GenJnlHeader."Posting Type"::"User Header Document No." then
                "Document No." := GenJnlHeader."Document No.";
        END;


    end;

    procedure GetNewLineNo(): Integer
    var
        GenJnlLine: Record "Sacco Journal Line";
        GenJnlHeader: Record "Sacco Journal Header";

    begin

        GenJnlLine.SETRANGE("Batch No.", "Batch No.");
        IF GenJnlLine.FINDLAST THEN
            EXIT(GenJnlLine."Line No." + 10000);
        EXIT(10000);

    end;


    procedure UpdateLineBalance()
    begin
        "Debit Amount" := 0;
        "Credit Amount" := 0;

        if Amount > 0 then
            "Debit Amount" := Amount
        else
            "Credit Amount" := -Amount;

        if "Currency Code" = '' then
            "Amount (LCY)" := Amount;


        case true of
            ("Account No." <> '') and ("Bal. Account No." <> ''):
                "Balance (LCY)" := 0;
            "Bal. Account No." <> '':
                "Balance (LCY)" := -"Amount (LCY)";
            else
                "Balance (LCY)" := "Amount (LCY)";
        end;


    end;

    local procedure ValidateAmount()
    var
        IsHandled: Boolean;
    begin
        "Amount (LCY)" := Amount;
        UpdateLineBalance;

    end;

}
