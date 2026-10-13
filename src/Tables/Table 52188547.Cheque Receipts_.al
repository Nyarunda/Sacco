
Table 50210 "Cheque Receipts_"
{
    //DrillDownPageID = UnknownPage51532134;
    //LookupPageID = UnknownPage51532134;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    //  NoSeriesmgt.TestManual(SalesSetup."Cheque Receipts Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Refference Document"; Code[20])
        {
        }
        field(4; "Transaction Time"; Time)
        {
        }
        field(5; "Created By"; Code[60])
        {
        }
        field(6; "Posted By"; Code[60])
        {
        }
        field(7; Posted; Boolean)
        {
        }
        field(8; "No. Series"; Code[10])
        {
        }
        field(9; "Unpaid By"; Code[60])
        {
            Editable = false;
        }
        field(10; Unpaid; Boolean)
        {
            Editable = false;
        }
        field(11; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Charges".Code where(Type = const("Sacco_Co-op Charge"));
        }
        field(12; "Clearing Bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(13; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        /*
        IF "No." = '' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD(SalesSetup."Cheque Receipts Nos");
          NoSeriesmgt.InitSeries(SalesSetup."Cheque Receipts Nos",xRec."No. Series",0D,"No.","No. Series");
        END;
        */

        "Transaction Time" := Time;
        "Transaction Date" := Today;

    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
}

