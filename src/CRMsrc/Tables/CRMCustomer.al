table 50400 "CRM Customer"
{
    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; Name; Text[100]) { }
        field(3; "Phone No."; Text[30]) { }
        field(4; "Email"; Text[100]) { }
        field(5; "Customer Type"; Enum "CRM Customer Type") { }
        field(6; "Customer Status"; Enum "CRM Customer Status") { }
        field(7; "Registration Date"; Date) { }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    trigger OnInsert()
    var
        CRMSetup: Record "CRM Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if "No." = '' then begin
            CRMSetup.Get();
            CRMSetup.TestField("Customer Nos.");
            // Get the next number
            "No." := NoSeries.GetNextNo(CRMSetup."Customer Nos.", WorkDate(), true);
        end;

        if "Registration Date" = 0D then
            "Registration Date" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}