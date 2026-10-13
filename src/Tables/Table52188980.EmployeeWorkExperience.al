table 50682 "Employee Work Experience"
{
    Caption = 'Employee Work Experience';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Organization Name"; Text[100])
        {
        }
        field(4; "Position Held"; Text[100])
        {
        }
        field(5; "Start Date"; Date)
        {
        }
        field(6; "End Date"; Date)
        {
        }
        field(7; "Period Description"; Text[50])
        {
        }
    }

    keys
    {
        key(PK; "Employee No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
