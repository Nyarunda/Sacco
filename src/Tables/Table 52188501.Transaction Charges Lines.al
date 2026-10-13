
Table 50164 "Transaction Charges Lines"
{

    fields
    {
        field(1; "Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Charge Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Flat Amount,% of Amount,Staggered';
            OptionMembers = "Flat Amount","% of Amount",Staggered;
        }
        field(5; "Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Percentage of Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Charge Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Charge Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                                 Blocked = const(false))
            else
            if ("Charge Account Type" = const(Customer)) Customer
            else
            if ("Charge Account Type" = const(Vendor)) Vendor
            else
            if ("Charge Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Charge Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Charge Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Charge Account Type" = const(Employee)) Employee
            else
            if ("Charge Account Type" = const(Savings)) Vendor
            else
            if ("Charge Account Type" = const(Credit)) Customer;
        }
        field(8; "Minimum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Maximum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Staggered Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staggered Header.";
        }
        field(11; "Transaction Charge Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,"Stamp Duty","Withdrawal Frequency","Withdrawn Amount","Failed STO Charge";
        }
        field(12; "Charge Excise Duty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Sharing Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Sharing Account Type';
            DataClassification = ToBeClassified;
        }
        field(17; "Sharing Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Sharing Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                                  Blocked = const(false))
            else
            if ("Sharing Account Type" = const(Customer)) Customer
            else
            if ("Sharing Account Type" = const(Vendor)) Vendor
            else
            if ("Sharing Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Sharing Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Sharing Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Sharing Account Type" = const(Employee)) Employee
            else
            if ("Sharing Account Type" = const(Savings)) Vendor
            else
            if ("Sharing Account Type" = const(Credit)) Customer;
        }
        field(18; "Sharing Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Sharing Use Percentage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Sharing Excise Duty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Charge Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Is Sms Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Sharing Excise Duty %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Excise Duty %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Transaction Type", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

