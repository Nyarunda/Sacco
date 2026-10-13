table 50432 "STO Recovery Priority"
{
    Caption = 'STO Recovery Priority';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Destination Acc. Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,External,Fixed Asset,IC Partner,Employee,Internal,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,External,"Fixed Asset","IC Partner",Employee,Internal,Credit;
            ValuesAllowed = "G/L Account", External, Internal, Credit;
        }
        field(3; "Recovery Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
