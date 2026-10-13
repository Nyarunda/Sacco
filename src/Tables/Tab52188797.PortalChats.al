table 50479 "Portal Chats"
{
    Caption = 'Portal Chats';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GUID"; Guid)
        {
            Caption = 'GUID';
            Editable = false;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(3; "DateTime"; DateTime)
        {
            Caption = 'DateTime';
            Editable = false;
        }
        field(4; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(5; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
        }
        field(6; From; Option)
        {
            OptionMembers = " ",Member,Sacco;

        }
        field(7; ChatMessage; Text[2048])
        {
            Caption = 'ChatMessage';
            trigger OnValidate()

            var
                myInt: Integer;
                Chat: Record "Portal Chats";
            begin
                Chat.Reset();
                Chat.SetRange("Member No.", "Member No.");
                if Chat.FindLast() then
                    "Session ID" := Chat."Session ID";

                Agent := UseriD;
                From := From::Sacco;
                DateTime := CurrentDateTime;

            end;
        }
        field(8; Agent; Code[200])
        {

        }
        field(9; "Session ID"; Text[2048])
        {
            Editable = false;
        }

        field(10; "Closed"; Boolean)
        {
            Editable = false;
        }
        field(11; "Closed By"; Code[50])
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; "GUID", "Member No.")
        {
            Clustered = true;
        }
        key(PK2; "Entry No.")
        {
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        guid := CreateGuid();
    end;
}
