Table 50014 "Bulk Email Lines"
{
    Caption = 'Bulk Email Lines';

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bulk Email Header".No;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Member No."; Code[20])
        {
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                if Members.Get("Member No.") then begin
                    "E-Mail" := Members."E-Mail";
                    Password := Members."ID No.";
                end
                else
                    "E-Mail" := '';
            end;
        }
        field(4; "E-Mail"; Text[100])
        {
        }
        field(5; Password; Text[100])
        {
            Editable = false;
        }
        field(6; "Email Subject"; Text[250])
        {
        }
        field(7; "Email Body"; Text[2000])
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = Pending,Sent,Failed;
        }
        field(9; "Result Message"; Text[250])
        {
        }
        field(10; "Sent DateTime"; DateTime)
        {
        }
        field(11; "Savings Account No."; Code[20])
        {
            TableRelation = "Savings Accounts"."No.";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; No, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Status = Status::Pending then
            exit;

        Status := Status::Pending;
    end;

    var
        Members: Record Members;
}
