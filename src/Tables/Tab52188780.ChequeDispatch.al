table 50462 "Cheque Dispatch"
{
    Caption = 'Cheque Dispatch';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[20])
        {
            Caption = '';
        }
        field(2; Date; Date)
        {
            Editable = false;
        }
        field(3; "Captured By"; Code[30])
        {
            Editable = false;
        }
        field(4; "Collected By"; Text[100])
        {
        }
        field(5; "Collector ID"; Code[20])
        {
        }
        field(6; "Collector Mobile No."; Code[13])
        {
        }
        field(7; Purpose; Text[50])
        { }
        field(8; "Cheque Number"; Integer)
        {
        }
        field(9; "Payee Name"; Text[100])
        { }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Dispatch Method"; Option)
        {
            OptionMembers = " ","Regular Mail","Courier Service";
        }
        field(13; "Dispatch Date"; Date)
        { }
        field(14; Status; Option)
        {
            OptionMembers = Pending,Processing,Dispatched,Delivered,Returned,Cancelled,Completed;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Cheque Dispatch Nos");
            "No." := NoSeries.GetNextNo(SalesSetup."Cheque Dispatch Nos", WorkDate(), true);
        end;
        "Captured By" := UserId;
        Date := Today;

    end;

    var

        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
}
