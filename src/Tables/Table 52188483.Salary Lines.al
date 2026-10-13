
Table 50146 "Salary Lines"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts"."No." where("Product Category" = filter("Ordinary Savings" | Business));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Acc.Reset;
                Acc.SetRange(Acc."No.", "Account No.");
                if Acc.Find('-') then begin

                    "Member No." := Acc."Member No.";
                    Status := Acc.Status;
                    Blocked := Acc.Blocked;
                    Name := Acc.Name;
                end;

                if "Account No." = '' then begin
                    "Member No." := '';
                    Name := '';
                    Amount := 0;
                end;
            end;
        }
        field(4; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Account Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(8; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Multiple Salary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "ID No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(15; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Blocked Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Salary Header No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                /*
               IF "Employer Code"<> SalProcessingHeader."Employer Code" THEN  BEGIN
               "Employer/ Staff Mismatch":=TRUE;
               MODIFY;
               END;
               */

            end;
        }
        field(19; "Employer/ Staff Mismatch"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Status; Enum "Account Status Enum")
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //IF (Status<>Status::New) OR (Status<>Status::Closed) THEN
                //Blocked:=Blocked::All;
            end;
        }
        field(22; Blocked; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
        }
        field(23; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Posted By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Posting Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,Blocked);
            end;
        }
        field(28; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Last Date Modified");
            end;
        }
        field(29; "Old Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Loan Recovered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Product Type"; Code[20])
        {
            CalcFormula = lookup(Vendor."Product Type" where("No." = field("Account No.")));
            FieldClass = FlowField;
        }
        field(33; "Batch No."; Code[20])
        {

        }


        field(34; "Income Type"; Enum "Repay Mode Enum")
        {
            CalcFormula = lookup("Salary Header"."Income Type" where("No" = field("Salary Header No.")));
            FieldClass = FlowField;
        }
        field(35; "Journal Posted"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Savings Ledger Entry" where("Account No." = field("Account No."), "Document No."
            = field("Salary Header No.")));
            Editable = false;
        }



        field(60; Period; Option)
        {
            CalcFormula = lookup("Salary Header".period where("No" = field("Salary Header No.")));
            FieldClass = FlowField;
            OptionMembers = " ","Mid Month","End Month","After Month",Allowance;
        }

        field(61; "P2F"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Reference No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Salary Header No.", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Acc: Record "Savings Accounts";
}

