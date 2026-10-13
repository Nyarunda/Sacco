table 50585 "Top Up Products"
{
    Caption = 'Loan to Top Up';
    DataClassification = ToBeClassified;

    DrillDownPageId = "Top Up Products";
    LookupPageId = "Top Up Products";

    fields
    {
        field(1; "Product ID"; Code[20])
        {
            Caption = 'Product ID';
            TableRelation = "Product Setup";
        }
        field(2; "Top Up Product"; Code[20])
        {
            Caption = 'Top Up Product';
            TableRelation = "Product Setup";
        }
        field(3; "Commission %"; Decimal)
        {
            Caption = 'Commission %';
        }
        field(4; "Commission GL"; Code[20])
        {
            Caption = 'Commission GL';
            TableRelation = "G/L Account";
        }
        field(5; "Excise Duty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Minimum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Maximum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Use Payment Threshold"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Use Payment Threshold';
        }
        field(50101; "Payment Threshold %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Threshold %';
            MinValue = 0;
            MaxValue = 100;
            InitValue = 50;

            trigger OnValidate()
            begin
                if "Payment Threshold %" = 0 then
                    "Payment Threshold %" := 50;
            end;
        }
        field(50102; "Commission % Above Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission % (Above Threshold)';
            MinValue = 0;
            MaxValue = 100;

            trigger OnValidate()
            begin
            end;
        }
        field(50103; "Commission % Below Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission % (Below Threshold)';
            MinValue = 0;
            MaxValue = 100;

            trigger OnValidate()
            begin
                if "Use Payment Threshold" then
                    TestField("Commission % Above Threshold");
            end;
        }
    }
    keys
    {
        key(PK; "Product ID", "Top Up Product")
        {
            Clustered = true;
        }
    }
}
