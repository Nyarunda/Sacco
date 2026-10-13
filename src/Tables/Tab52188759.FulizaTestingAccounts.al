table 50441 "Fuuza Testing Accounts"
{
    Caption = 'Fuuza Testing Accounts';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
        }
        field(2; Product; Option)
        {
            Caption = 'Product';
            OptionMembers = " ",Fuuza;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Allowed,"Not Allowed";
        }
    }
    keys
    {
        key(PK; "Phone No.", Product)
        {
            Clustered = true;
        }
    }
}
