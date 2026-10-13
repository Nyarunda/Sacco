table 50401 "Ticket Header"
{
    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; Title; Text[100]) { }
        field(3; "Customer No."; Code[20]) { }
        field(4; "Ticket Type"; Enum "Ticket Type") { }
        field(5; "Ticket Source"; Enum "Ticket Source") { }
        field(6; Priority; Enum "Ticket Priority") { }
        field(7; Status; Enum "Ticket Status") { }
        field(8; "Assigned To"; Code[50])
        {
            TableRelation = "Support Personnel";
            trigger OnValidate()
            var
                myInt: Integer;
                Support: Record "Support Personnel";
            begin
                "Department Code" := '';
                if Support.Get("Assigned To") then
                    "Department Code" := Support."Department Code";
            end;
        }
        field(9; "Department Code"; Code[20])
        {
            TableRelation = "CRM Department";
        }
        field(10; "Created DateTime"; DateTime) { }
        field(11; "Created Date"; Date) { }
        field(12; "Created Time"; Time) { }
        field(13; Description; Text[2000]) { }
        field(14; "SLA Breached"; boolean) { }
        field(15; "Customer Name"; Text[100]) { }
        field(16; "Due Date"; Date) { }
        field(17; "Due Time"; Time) { }
        field(18; "Resolved Date"; Date) { }
        field(19; "Resolved DateTime"; DateTime) { }
        field(20; "Resolution Hours"; Integer) { }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    trigger OnInsert()
    var
        CRMSetup: Record "CRM Setup";
        NoSeries: Codeunit "No. Series";
        Customer: Record "CRM Customer";
    begin
        if "No." = '' then begin
            CRMSetup.Get();
            CRMSetup.TestField("Ticket Nos.");
            // Get the next number
            "No." := NoSeries.GetNextNo(CRMSetup."Ticket Nos.", WorkDate(), true);
        end;

        // Set creation timestamps
        if "Created DateTime" = 0DT then
            "Created DateTime" := CurrentDateTime;
        if "Created Date" = 0D then
            "Created Date" := Today;
        if "Created Time" = 0T then
            "Created Time" := Time;

        // Auto-populate customer name if customer number is provided
        if ("Customer No." <> '') and ("Customer Name" = '') then begin
            if Customer.Get("Customer No.") then
                "Customer Name" := Customer.Name;
        end;
    end;

    trigger OnModify()
    var
        Customer: Record "CRM Customer";
    begin
        // Update customer name if customer number changed
        if ("Customer No." <> xRec."Customer No.") and ("Customer No." <> '') then begin
            if Customer.Get("Customer No.") then
                "Customer Name" := Customer.Name
            else
                "Customer Name" := '';
        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}