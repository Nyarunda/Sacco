table 50435 "Loans Defaulter Notices"
{
    Caption = 'Loans Defaulter Notices';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Editable = false;
            Caption = 'Entry No';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Member No"; Code[20])
        {
            Editable = false;
            Caption = 'Member No';
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(4; "Loan No"; Code[20])
        {
            Editable = false;
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No"));
        }
        field(5; "Loan Product"; Code[20])
        {
            Editable = false;
            Caption = 'Loan Product';
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No")));
        }
        field(6; "Loan Product Name"; Text[100])
        {
            Editable = false;
            Caption = 'Loan Product Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Product Type Name" where("Loan No." = field("Loan No"), "Loan Product Type" = field("Loan Product")));
        }
        field(7; Sent; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(8; "Date Sent"; Date)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(9; Notice; Option)
        {
            Editable = false;
            OptionMembers = " ","1-Notice","2-Notice","Final-Notice";
        }
        field(10; Days; Integer)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(11; "Security Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Guarantor,Motor Vehicle,Title Deed,NSE Shares,Money Market Fund,Insurance,Own Deposit';
            OptionMembers = " ",Guarantor,"Motor Vehicle","Title Deed","NSE Shares","Money Market Fund",Insurance,"Own Deposit";

        }
        field(12; "CRB Listed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Board Referral"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Approved to Send"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Notice Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No", "Member No", "Loan No")
        {
            Clustered = true;
        }
    }
}
