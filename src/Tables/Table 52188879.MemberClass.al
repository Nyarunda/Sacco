table 50581 "Member Class"
{
    Caption = 'Member Class';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Member Class";
    LookupPageID = "Member Class";

    fields
    {
        field(1; "Member Class"; Code[10])
        {
            Caption = 'Member Class"';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

            begin
                if Description = '' then
                    Description := Format("Member Class");
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Minimum Registration Fee"; Decimal)
        {
            Caption = 'Minimum Registration Fee';
            DataClassification = ToBeClassified;
        }
        field(5; "Minimum Share Capital"; Decimal)
        {
            Caption = 'Minimum Share Capital';
            DataClassification = ToBeClassified;
        }
        field(6; "Minimum Share Deposits"; Decimal)
        {
            Caption = 'Minimum Share Deposits';
            DataClassification = ToBeClassified;
        }
        field(7; "Default Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Default Share Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Member Class")
        {
            Clustered = true;
        }
    }
}
