
Table 50330 "Monthly Advice Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeries.TestManual(NoSetup."Advice Nos");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));//, Type = const(Checkoff));

            trigger OnValidate()
            begin
                if Customer.Get("Employer Code") then begin
                    "Employer Name" := Customer.Name;
                    if Customer."Advice Method" = Customer."Advice Method"::" " then
                        Error('Advice Type Not Specified for this Employer');
                end else
                    "Employer Name" := '';
            end;
        }
        field(14; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Total Count"; Integer)
        {
            Editable = false;
            CalcFormula = count("Monthly Checkoff Lines" where("Checkoff Header" = field("No.")));
            FieldClass = FlowField;
        }
        field(16; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(18; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(21; "CHK Buffer Amount"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Buffer".Amount where("Checkoff No" = field("No.")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }

        field(25; "Advice Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Loan Adjustments/Stoppage","New Loans","Savings Adjustments","New Savings","Loan Balance Adjustments","Savings Balance Adjustments","Full Advice","External Members","Full External Members",Savings,Loans;
            OptionCaption = ' ,Loan Adjustments/Stoppage,New Loans,Savings Adjustments,New Savings,Loan Balance Adjustments,Savings Balance Adjustments,Full Advice,Recent External Members,Full External Members,Savings,Loans';
        }
        field(26; "Loan Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",FOSA,BOSA,MICRO;
        }


        field(27; "PRD Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));

            trigger OnValidate()
            begin

            end;
        }


        field(28; "Employer Email"; Text[200])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }

        field(29; "Variance Advice"; Boolean)
        {
        }
        field(30; "Debit Account Type"; Option)
        {
            OptionMembers = Customer,Savings;
        }
        field(31; "Debit Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the name of the paying bank account in the database';
            Editable = true;
            TableRelation =
            if ("Debit Account Type" = const(Savings)) Vendor."No."
            else
            if ("Debit Account Type" = const(Customer)) Customer."No.";

            trigger OnValidate()
            begin


            end;
        }
        field(33; "Credit Account Type"; Option)
        {
            OptionMembers = Customer,Savings,"G/L Account";
        }
        field(36; "Credit Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the name of the paying bank account in the database';
            Editable = true;
            TableRelation =
            if ("Credit Account Type" = const(Savings)) Vendor."No."
            else
            if ("Credit Account Type" = const(Customer)) Customer."No."
            else
            if ("Credit Account Type" = const("G/L Account")) "G/L Account"."No." where("Direct Posting" = const(true));

            trigger OnValidate()
            begin


            end;
        }
        field(37; "Debit Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
        fieldgroup(DropDown; "No.", "End Date", "Employer Code", "Employer Name")
        {
        }
    }


    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Advice Nos");
            "No." := NoSeries.GetNextNo(NoSetup."Advice Nos", WorkDate(), true);
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Customer: Record Customer;
        UserSetup: Record "User Setup";
}

