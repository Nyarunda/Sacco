table 59996 "Loan Graduation Band"
{
    Caption = 'Loan Graduation Band';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Model Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Loan Graduation Model"."Code";
        }
        field(2; "Min Score"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Max Score"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Tier"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Tier D","Tier C","Tier B","Tier A";
            OptionCaption = 'Tier D,Tier C,Tier B,Tier A';
        }
        field(5; "Risk Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Very High Risk","High Risk","Moderate Risk","Low Risk","Very Low Risk";
            OptionCaption = 'Very High Risk,High Risk,Moderate Risk,Low Risk,Very Low Risk';
        }
        field(6; "Eligible Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; Qualified; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Model Code", "Min Score", "Max Score")
        {
            Clustered = true;
        }
    }
}
