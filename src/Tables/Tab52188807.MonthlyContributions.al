table 50489 "Old Monthly Deposits"
{
    Caption = 'Monthly Contributions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Dec 2023"; Decimal)
        {
            Caption = 'Dec 2023';
        }
        field(4; Jan; Decimal)
        {
            Caption = 'Jan';
        }
        field(5; Feb; Decimal)
        {
            Caption = 'Feb';
        }
        field(6; March; Decimal)
        {
            Caption = 'March';
        }
        field(7; April; Decimal)
        {
            Caption = 'April';
        }
        field(8; May; Decimal)
        {
            Caption = 'May';
        }
        field(9; June; Decimal)
        {
            Caption = 'June';
        }
        field(10; July; Decimal)
        {
            Caption = 'July';
        }
        field(11; Aug; Decimal)
        {
            Caption = 'Aug';
        }
        field(12; Sept; Decimal)
        {
            Caption = 'Sept';
        }
        field(13; Oct; Decimal)
        {
            Caption = 'Oct';
        }
        field(14; Nov; Decimal)
        {
            Caption = 'Nov';
        }
        field(15; Dec; Decimal)
        {
            Caption = 'Dec';
        }
        field(16; "Product Code"; Code[10])
        {
            TableRelation = "Product Setup";
        }
        field(17; "Account No."; Code[20])
        {
            //TableRelation = "Product Setup";
        }
    }
    keys
    {
        key(PK; "Member No.", "Account No.")
        {
            Clustered = true;
        }
        key(key1; "Product Code")
        {

        }
        key(key2; "Account No.")
        {

        }
    }
}
