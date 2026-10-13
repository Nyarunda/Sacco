table 50460 "Registration Commissions Setup"
{
    Caption = 'Registration Commissions Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; code[20])
        {
            Editable = false;
        }

        field(3; "Minimum No. Members"; Integer)
        {

        }
        field(4; "Minimum Reg. Fee"; Decimal)
        {

        }
        field(5; "Minimum Deposits"; Decimal)
        {

        }
        field(6; "Commission Amount"; Decimal)
        {

        }


    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
