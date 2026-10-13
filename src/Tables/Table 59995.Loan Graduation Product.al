table 59995 "Loan Graduation Product"
{
    Caption = 'Loan Graduation Product';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Model Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Loan Graduation Model"."Code";
        }
        field(2; "Loan Product Type"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Product Setup"."Product ID";
        }
        field(3; "Product Role"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Scored,Excluded;
            OptionCaption = 'Scored,Excluded';
        }
    }

    keys
    {
        key(PK; "Model Code", "Loan Product Type")
        {
            Clustered = true;
        }
    }
}
