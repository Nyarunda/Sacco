
Table 50119 "Monthly Advice"
{
    DataCaptionFields = "No.";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.LookupUserID("User ID");
            end;
        }
        field(50001; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Period; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; Appraisal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Penalty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Interest; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Advice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Advice Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Changes,Everything';
            OptionMembers = Changes,Everything;
        }
        field(50015; "ID No."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Advice Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Payroll No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Advice Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Loan Adjustments/Stoppage","New Loans","Savings Adjustments","New Savings","Loan Balance Adjustments","Savings Balance Adjustments","Full Advice";
        }
        field(50020; "Product Search Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50022; Transfered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Product Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Employer Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; Principal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Principal Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Schedule Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Amount On"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Amount Off"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Loan Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50033; "Interest Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50096; "Cummulative Contribution"; Decimal)
        {
        }

        field(50097; "Current Balance"; Decimal)
        {
        }

        field(50098; "Change Balance"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50099; "Sort Order"; Code[200])
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
        }


        field(50100; "Start Date"; Date)
        {
            CalcFormula = lookup("Monthly Advice Header"."Start Date" WHERE(Posted = const(true), "No." = FiELD("Advice Header No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50101; "End Date"; Date)
        {
            CalcFormula = lookup("Monthly Advice Header"."End Date" WHERE(Posted = const(true), "No." = FiELD("Advice Header No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50102; "Posted"; Boolean)
        {
            CalcFormula = lookup("Monthly Advice Header".Posted WHERE("No." = FiELD("Advice Header No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50103; "Line No."; Integer)
        {
        }

        field(50104; "Property Code"; Code[20])
        {
        }
        field(50105; "Advice Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Wanandege Bosa Loans","Wanandege Fosa Loans","Wanandege Deposit Savings";
        }
        field(50106; Description; Text[50])
        {
        }

    }

    keys
    {
        key(Key1; "Advice Header No.", "No.", "Account No.", "Loan No.")
        {
            Clustered = true;
        }
        key(Key2; "Sort Order")
        {
        }
        key(Key3; "Payroll No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record loans;
        Text000: label 'The entry cannot be unapplied, because the %1 has been compressed.';
        Text001: label 'The transaction cannot be reversed, because the %1 has been compressed.';
}

