tableextension 50075 AccountingPeriod extends "Accounting Period"
{
    fields
    {
        field(90000; "Close Posting Period"; Boolean)
        {
            Caption = 'Close Posting Period';
            DataClassification = ToBeClassified;
        }
        field(50013; "Posting Period Closed By"; Code[50])
        {
            Caption = 'Posting Period Closed By';
            DataClassification = ToBeClassified;
        }
        field(50017; "Posting Period Date Closed"; Date)
        {
            Caption = 'Posting Period Date Closed';
            DataClassification = ToBeClassified;
        }
        field(50018; "Posting Period Opened By"; Code[50])
        {
            Caption = 'Posting Period Opened By';
            DataClassification = ToBeClassified;
        }
    }
}
