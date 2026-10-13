table 59991 "Security Sub. Audit"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Header No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Old Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Old Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "New Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "New Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "New Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Posted Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(HeaderKey; "Header No.", "Loan No.")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo();
    end;

    local procedure GetNextEntryNo(): Integer
    var
        Audit: Record "Security Sub. Audit";
    begin
        Audit.LockTable();
        if Audit.FindLast() then
            exit(Audit."Entry No." + 1);

        exit(1);
    end;
}
