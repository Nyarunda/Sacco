
Table 50143 "Loan Product Charges."
{

    fields
    {
        field(1; "Product Code"; Code[10])
        {
            TableRelation = "Product Setup";
        }
        field(2; "Charge Code"; Code[10])
        {
            TableRelation = "Charges.";

            trigger OnValidate()
            begin

                Charges.Get("Charge Code");
                Description := Charges.Description;
                "Charge Amount" := Charges."Charge Amount";
                Percentage := Charges.Percentage;
                "Charge Type" := Charges."Charge Type";
                "Charging Option" := Charges."Charging Option";
                "Account No." := Charges."Charges G_L Account";
                Charges.Minimum := Charges.Minimum;
                Charges.Maximum := Charges.Maximum;
                "Effect Excise Duty" := Charges."Effect Excise Duty";
                Prorate := Charges.Prorate;
                "Charge Method" := Charges."Charge Method";
                "Posting Type" := Charges."Posting Type";
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Payment Term Translation","Product Charges";
        }
        field(50003; "Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Charge Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = General,"Top up","External Clearance","Deposit Financing","Share Capital","Share Financing","Deposit Financing on Maximum","Custom",Rescheduling,Insurance,Non_Individual,"Loan Processing Fee";
        }
        field(50007; "Charging Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"On Approved Amount","On Net Amount","Amount to Disburse Less Topup","Approved Amount Less Topup";

        }
        field(50009; "Account No."; Code[20])
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
            if ("Account Type" = const(Employee)) Employee;
        }
        field(50010; Minimum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Maximum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Effect Excise Duty"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(50014; Prorate; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No Proration";
        }
        field(50015; "Charge Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Flat Amount,% of Amount,Staggered';
            OptionMembers = "Flat Amount","% of Amount",Staggered;
        }
        field(50016; "Staggered Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(50018; "Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Deduct From Net Payable","Add to Loan Amount";

        }
        field(15; "Is Sms Alert"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Excise Duty %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Charge Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record "Charges.";
}

