
Table 50148 "Charges."
{
    // // This table is used for Azure Machine Learning related features to control that amount of time used by all
    // // these features in total does not exceed the limit defined by Azure ML.The table is singleton and used only in SaaS.

    DrillDownPageID = Charges;
    LookupPageID = Charges;

    fields
    {
        field(1; "Charge Code"; Code[10])
        {
        }
        field(50001; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
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
            OptionMembers = General,"Top up","External Loan","Deposit Financing","Share Capital","Share Financing","Deposit Financing on Maximum","External Payment to Vendor",Rescheduling,Insurance,Non_Individual,"Loan Processing Fee";
        }
        field(50007; "Charging Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"On Approved Amount","On Net Amount";
        }
        field(50008; "Charge Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Charges G_L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Charge Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                                       Blocked = const(false))
            else
            if ("Charge Account Type" = const(Vendor)) Vendor
            else
            if ("Charge Account Type" = const("Bank Account")) "Bank Account";
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
        field(50018; "Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Deduct From Net Payable","Add to Loan Amount";

        }
    }

    keys
    {
        key(Key1; "Charge Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PermissionManager: Codeunit "Permission Manager";
        ProcessingTimeLessThanZeroErr: label 'The provided Azure ML processing time is less or equal to zero.';
}

