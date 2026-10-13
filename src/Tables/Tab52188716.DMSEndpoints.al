table 50379 "DMS Endpoints"
{
    Caption = 'DMS Endpoints';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Link Type"; Option)
        {
            Caption = 'Link';
            OptionMembers = MemberApp,Loans,PV,Transfers,JV;
        }
        field(2; Path; Text[500])
        {
            Caption = 'Path';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Link Type")
        {
            Clustered = true;
        }
    }
}
