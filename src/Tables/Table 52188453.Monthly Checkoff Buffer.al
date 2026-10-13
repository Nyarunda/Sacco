
Table 50116 "Monthly Checkoff Buffer"
{

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Payroll; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,sInterest,sLoan,sShare,wCont,sJoining';
            OptionMembers = " ",sInterest,sLoan,sShare,wCont,sJoining;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Interest; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Search Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Checkoff No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(12; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Savings Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Credit Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Upload Response"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Upload No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Member Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "User Id"; Code[40])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Savings Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Loan Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(25; "Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Total Loans"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Total Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Reporting Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Savings Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }


    }

    keys
    {
        key(Key1; "Checkoff No", Payroll, "Search Code", No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

