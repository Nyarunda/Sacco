table 50430 "Escalation Rules"
{
    Caption = 'Escalation Rules';
    DataClassification = CustomerContent;
    LookupPageId = "Escalation Rules List";
    DrillDownPageId = "Escalation Rules List";

    fields
    {
        field(1; "Rule Code"; Code[20])
        {
            Caption = 'Rule Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }

        field(2; "Rule Name"; Text[100])
        {
            Caption = 'Rule Name';
            DataClassification = CustomerContent;
        }

        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(4; "Source Type"; Enum "Escalation Source Type")
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
        }

        field(5; "Priority Level"; Enum "Escalation Priority")
        {
            Caption = 'Priority Level';
            DataClassification = CustomerContent;
        }

        field(6; "Escalation Trigger"; Enum "Escalation Trigger Type")
        {
            Caption = 'Escalation Trigger';
            DataClassification = CustomerContent;
        }

        field(7; "Trigger Value"; Integer)
        {
            Caption = 'Trigger Value';
            DataClassification = CustomerContent;
            MinValue = 0;
        }

        field(8; "Time Unit"; Enum "Time Unit")
        {
            Caption = 'Time Unit';
            DataClassification = CustomerContent;
        }

        field(9; "Escalate To User ID"; Code[50])
        {
            Caption = 'Escalate To User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup"."User ID";
        }

        field(10; "Escalate To User Name"; Text[80])
        {
            Caption = 'Escalate To User Name';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }

        field(11; "CC User ID"; Code[50])
        {
            Caption = 'CC User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup"."User ID";
        }

        field(12; "Email Template Code"; Code[20])
        {
            Caption = 'Email Template Code';
            DataClassification = CustomerContent;
        }

        field(13; "Active"; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(14; "Auto Execute"; Boolean)
        {
            Caption = 'Auto Execute';
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(15; "Customer Filter"; Code[20])
        {
            Caption = 'Customer Filter';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(16; "Item Category Filter"; Code[20])
        {
            Caption = 'Item Category Filter';
            DataClassification = CustomerContent;
            TableRelation = "Item Category".Code;
        }

        field(17; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(18; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }

        field(19; "Last Modified Date"; Date)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(20; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }

        field(21; "Last Execution Date"; DateTime)
        {
            Caption = 'Last Execution Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(22; "Execution Count"; Integer)
        {
            Caption = 'Execution Count';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(23; "Business Hours Only"; Boolean)
        {
            Caption = 'Business Hours Only';
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(24; "Working Days Only"; Boolean)
        {
            Caption = 'Working Days Only';
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(25; "Max Escalations"; Integer)
        {
            Caption = 'Max Escalations';
            DataClassification = CustomerContent;
            MinValue = 0;
            InitValue = 3;
        }
    }

    keys
    {
        key(PK; "Rule Code")
        {
            Clustered = true;
        }
        key(Priority; "Priority Level", "Active")
        {
        }
        key(Source; "Source Type", "Active")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Rule Code", "Rule Name", "Priority Level", "Active")
        {
        }
        fieldgroup(Brick; "Rule Code", "Rule Name", "Description", "Priority Level")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := Today;
        "Created By" := CopyStr(UserId, 1, MaxStrLen("Created By"));
        "Last Modified Date" := Today;
        "Last Modified By" := CopyStr(UserId, 1, MaxStrLen("Last Modified By"));
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := Today;
        "Last Modified By" := CopyStr(UserId, 1, MaxStrLen("Last Modified By"));
    end;

    trigger OnDelete()
    var
        EscalationHistory: Record "Escalation History";
    begin
        EscalationHistory.SetRange("Rule Code", "Rule Code");
        if not EscalationHistory.IsEmpty then
            Error('Cannot delete escalation rule %1 because escalation history exists.', "Rule Code");
    end;

    procedure ValidateRule(): Boolean
    begin
        if "Rule Code" = '' then
            Error('Rule Code cannot be empty.');

        if "Rule Name" = '' then
            Error('Rule Name cannot be empty.');

        if "Escalate To User ID" = '' then
            Error('Escalate To User ID cannot be empty.');

        if "Trigger Value" <= 0 then
            Error('Trigger Value must be greater than 0.');

        exit(true);
    end;

    procedure GetEscalateToUserName(): Text[80]
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get("Escalate To User ID") then
            exit(UserSetup."User ID");
        exit('');
    end;

    procedure IncrementExecutionCount()
    begin
        "Execution Count" += 1;
        "Last Execution Date" := CurrentDateTime;
        Modify(true);
    end;
}