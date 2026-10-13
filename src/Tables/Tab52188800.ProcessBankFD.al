table 50482 "Process Bank FD"
{
    Caption = 'Process Bank FD';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "FD No."; Code[20])
        {
            Caption = 'FD No.';
            TableRelation = "Bank Fixed Deposit Account";
            trigger OnValidate()
            var
                BkFD: Record "Bank Fixed Deposit Account";
            begin
                "FD Type" := '';
                Amount := 0;
                "Start Date" := 0D;
                "End Date" := 0D;
                Name := '';

                BkFD.Get("FD No.");
                "FD Type" := BkFD."FD Type";
                Amount := BkFD."FD Amount";
                "Start Date" := BkFD."fd Start Date";
                "End Date" := BkFD."FD Maturity Date";
                Name := BkFD.Name;
            end;
        }
        field(3; "FD Type"; Code[20])
        {
            TableRelation = "FD Types";
            Caption = 'FD Type';
            Editable = false;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            Editable = false;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(7; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(8; Select; Boolean)
        {
            Caption = 'Select';
        }
        field(9; Processed; Boolean)
        {
            Caption = 'Processed';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
