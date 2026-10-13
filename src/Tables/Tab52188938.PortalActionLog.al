table 50027 "Portal Action Log"
{
    Caption = 'Portal Action Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(3; "User ID"; Text[100])
        {
            Caption = 'User ID';
        }
        field(4; "Action"; Code[50])
        {
            Caption = 'Action';
        }
        field(5; "Action Description"; Text[250])
        {
            Caption = 'Action Description';
        }
        field(6; "Request Date Time"; DateTime)
        {
            Caption = 'Request Date Time';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(MemberAction; "Member No.", "Request Date Time")
        {
        }
    }
}
