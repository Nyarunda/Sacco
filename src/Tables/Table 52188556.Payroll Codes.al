
Table 50219 "Payroll Codes"
{

    fields
    {
        field(1; "Transaction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Unique Trans line code';
        }
        field(2; "Transaction Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Description';
        }
        field(3; "Balance Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'None,Increasing,Reducing';
            OptionMembers = "None",Increasing,Reducing;
        }
        field(4; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Earning,Deduction,"Basic Pay","Gross Pay","Net Pay",PAYE,Statutory;
        }
        field(5; Frequency; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }
        field(6; Taxable; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Is it taxable or not';

            trigger OnValidate()
            begin

                //TESTFIELD(Frequency,Frequency::Fixed);
            end;
        }
        field(7; "Calculation Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Is the transaction based on a formula';
            OptionMembers = "Varied Amount","Standard Amount",Formula;
        }
        field(8; Formula; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = '[Formula] If the above field is "Yes", give the formula';
        }
        field(9; "Special Transactions"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Represents all Special Transactions';
            OptionMembers = "None","Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Custom 1",Mortgage,"Salary Arrears","Staff Loan","Education Insurance","Staff Welfare","Salary Advance";
        }
        field(10; "Deduct Premium"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '[Insurance] Should the Premium be treated as a payroll deduction?';
        }
        field(11; "Employer Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Caters for Employer Deductions';
        }
        field(12; "Special Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",NHIF,NSSF,"House Allowance","Housing Levy";
        }
        field(13; "Include Employer Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Is the transaction to include the employer deduction? - Dennis';
        }
        field(14; "Is Formula for employer"; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = '[Is Formula for employer] If the above field is "Yes", give the Formula for employer Dennis';
        }
        field(15; "GL Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '"G/L Account".No.';
            TableRelation = "G/L Account"."No.";
        }
        field(16; "Employer GL Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'to post to GLemployee  account - Dennis';
            TableRelation = "G/L Account"."No.";
        }
        field(17; Subledger; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        }
        field(18; Suspended; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 1 Code");
                if DimensionValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimensionValue.Name;
                end;
            end;
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 2 Code");
                if DimensionValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimensionValue.Name;
                end;
            end;
        }
        field(21; "Global Dimension 1 Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Global Dimension 2 Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Standard Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Employer Calculation Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Is the transaction based on a formula';
            OptionMembers = "Varied Amount","Standard Amount",Formula;
        }
        field(26; "Employer Standard Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Deduct Mortgage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Fringe Benefit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Sort Order"; Integer)
        {
        }
        field(31; "Sacco Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Sub-Ledger Product Type"; Code[20])
        {
            TableRelation = "Product Setup";
        }
        field(33; "Ledger Types"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        }
        field(34; "Sub-Ledger Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Subledger = const(Vendor)) Vendor
            else
            if (Subledger = const(Customer)) Customer
            else
            if (Subledger = const(Savings)) "Savings Accounts";
        }
        field(35; "Loan Interest Method"; Option)
        {
            OptionMembers = " ","Flat Rate","Reducing Balance","User Defined Amount",Amortised;
        }
        field(36; "Post Loan Interest Due"; Boolean)
        {
        }
        field(37; "Employer Only"; Boolean)
        {
        }
        field(38; "Is Default"; Boolean)
        {
        }
        field(40; Status; Option)
        {
            OptionMembers = " ",Inactive;
        }
        field(41; "Irregular Income"; Boolean)
        {
        }
        field(42; "Group Order"; Integer)
        {
        }

    }

    keys
    {
        key(Key1; "Transaction Code")
        {
            Clustered = true;
        }
        key(Key2; "Sort Order")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Transaction Code", "Transaction Name", "Transaction Type")
        {
        }
    }

    var
        DimensionValue: Record "Dimension Value";
}

