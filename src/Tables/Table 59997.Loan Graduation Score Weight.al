table 59997 "Loan Graduation Score Weight"
{
    Caption = 'Loan Graduation Score Weight';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Model Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Loan Graduation Model"."Code";
        }
        field(2; "Score Area"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Repayment,Savings,CRB,Ratio,Membership;
            OptionCaption = 'Repayment,Savings,CRB,Ratio,Membership';
        }
        field(3; Weight; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Maximum Raw Score"; Decimal)
        {
            DataClassification = CustomerContent;
            InitValue = 100;
        }
    }

    keys
    {
        key(PK; "Model Code", "Score Area")
        {
            Clustered = true;
        }
    }
}
