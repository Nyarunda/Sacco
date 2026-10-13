
Table 50163 "Loan Interest Buffer"
{

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(3; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Savings,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        }
        field(4; "Interest Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Interest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loan No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Loans;
        }
        field(16; "Loan Product type"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Product Setup";
        }
        field(17; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Bal. Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Bal. Account Type" = const(Credit)) Customer;
        }
        field(23; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; Blocked; Enum "Customer Blocked")
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CustLedgerEntry: Record "Credit Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                IdentityManagement: Codeunit "Identity Management";
            begin
            end;
        }
        field(40; Reversed; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Credit Ledger Entry".Reversed where("Loan No." = field("Loan No."), Description = field(Description), "Posting Date" = field("Posting Date")));
        }
        field(41; "Annual Interest %"; Decimal)
        {
            Caption = 'Annual Interest';
            DataClassification = ToBeClassified;
        }
        field(42; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Active,Dormant,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            OptionMembers = " ",Active,Dormant,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        }
        field(43; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Employer Code"; Code[20])
        {
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(45; Name; Text[200])
        {
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(46; "Is Mobile"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Staff No."; Code[50])
        {
            CalcFormula = lookup(Members."Payroll/Staff No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(48; "Loan Product type Name"; Code[50])
        {
            CalcFormula = lookup(Loans."Loan Product Type Name" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(49; "Member No."; Code[50])
        {
            TableRelation = Members;
        }

        field(2067; "Dimension Set ID"; Integer)
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
                    Rec, "Dimension Set ID", "Loan No.", "Global Dimension 1 Code", "Global Dimension 1 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;
        }
        field(2068; Source; Option)
        {
            OptionMembers = Interest,Insurance;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Interest Date", source)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup."Bill Interest" then
            Error('You do not have any permissions for Interest Billing. Contact the administrator!');
    end;
}

