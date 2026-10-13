Table 50440 "Fuuza Interest Buffer"
{
    DrillDownPageID = "Fuuza Interest";
    LookupPageID = "Fuuza Interest";

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
        }
        field(2; "Account Type"; enum "Gen. Journal Account Type")
        {

        }
        field(3; "Account No"; Code[20])
        {
            Editable = false;
            TableRelation = Vendor;
        }
        field(4; "Interest Date"; Date)
        {
        }
        field(5; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
            Editable = false;
        }
        field(6; "Interest Amount"; Decimal)
        {
        }
        field(7; "User ID"; Code[20])
        {
        }
        field(8; Description; Text[80])
        {
        }
        field(9; "Product Setup Code"; Code[50])
        {
            Editable = false;
            TableRelation = "Product Setup";
        }
        field(10; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;
        }
        field(11; "Payable Account"; Code[20])
        {
            Caption = 'Payable Account';
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
            if ("Bal. Account Type" = const("IC Partner")) "IC Partner";
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(14; Blocked; Enum "Vendor Blocked")
        {
            Caption = 'Blocked';
            Editable = false;
        }
        field(15; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Apportioned,Suspended,Awaiting Verdict,New';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Apportioned,Suspended,"Awaiting Verdict",New;
        }
        field(16; "Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(17; Posted; Boolean)
        {
        }
        field(18; "Expense Account"; Code[20])
        {
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
            if ("Bal. Account Type" = const("IC Partner")) "IC Partner";
        }
        field(19; Name; Text[80])
        {
            Caption = 'Name';
        }
        field(20; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(21; "Auto Interest"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Interest Date", "Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
          IF No = '' THEN BEGIN
          NoSetup.GET(0);
          NoSetup.TESTFIELD(NoSetup."Interest Buffer No");
          NoSeriesMgt.InitSeries(NoSetup."Interest Buffer No",xRec."No. Series",0D,No,"No. Series");
          END;
        */

    end;

    var
        NoSetup: Record "Purchases & Payables Setup";
}

