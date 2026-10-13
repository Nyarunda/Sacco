Table 51116 "HR Batches"
{
    //DrillDownPageID = UnknownPage39005682;
    //LookupPageID = UnknownPage39005682;

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                if "Batch No." <> xRec."Batch No." then begin
                    /*
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Batch Nos.");
                    "No. Series" := '';
                    */
                end;
            end;
        }
        field(2; "Description/Remarks"; Text[30])
        {
        }
        field(3; Posted; Boolean)
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",,Approved,Rejected;
        }
        field(5; "Date Created"; Date)
        {
        }
        field(6; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Posting Date" > Today then
                    Error('Posting Date cannot be in the future');
            end;
        }
        field(7; "Posted By"; Code[20])
        {
        }
        field(8; "Prepared By"; Code[20])
        {
        }
        field(9; "Batch Date"; Date)
        {
        }
        field(10; "Mode Of Disbursement"; Option)
        {
            OptionCaption = ',Individual Cheques,Cheque,Transfer to FOSA,FOSA Loans';
            OptionMembers = ,"Individual Cheques",Cheque,"Transfer to FOSA","FOSA Loans";

            trigger OnValidate()
            begin
            end;
        }
        field(11; "Document No."; Code[20])
        {
        }
        field(12; "BOSA Bank Account"; Code[20])
        {
            //TableRelation = "G/L Account"."No.";;

            trigger OnValidate()
            begin
            end;
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Approvals Remarks"; Text[150])
        {
        }

        field(17; "Cheque No."; Code[20])
        {
        }
        field(18; "Batch Type"; Option)
        {
            OptionMembers = ,Loans,Imprest,Overtime;

            trigger OnValidate()
            begin
                EntryNo := 0;


                /*
                ApprovalsSetup.RESET;
                ApprovalsSetup.SETRANGE(ApprovalsSetup."Approval Type","Batch Type");
                IF ApprovalsSetup.FIND('-') THEN BEGIN
                MovementTracker.INIT;
                MovementTracker."Entry No.":=EntryNo;
                MovementTracker."Document No.":="Batch No.";
                MovementTracker."Approval Type":=ApprovalsSetup."Approval Type";
                MovementTracker.Stage:=ApprovalsSetup.Stage;
                MovementTracker."Current Location":=TRUE;
                MovementTracker.Status:=MovementTracker.Status::"Being Processed";
                MovementTracker.Description:=ApprovalsSetup.Description;
                MovementTracker.Station:=ApprovalsSetup.Station;
                MovementTracker."Date/Time In":=CREATEDATETIME(TODAY,TIME);
                MovementTracker.INSERT(TRUE);*/




                /*IF "Batch Type" = "Batch Type"::Loans THEN
                "Mode Of Disbursement":="Mode Of Disbursement"::"Individual Cheques";*/

            end;
        }
        field(19; "Special Advance Posted"; Boolean)
        {
        }
        field(20; "FOSA Bank Account"; Code[20])
        {
            //TableRelation = Table270.Field1;
        }
        field(22; "Post to Loan Control"; Boolean)
        {

            trigger OnValidate()
            begin
                /*IF "Batch Type" <> "Batch Type"::"7" THEN
                ERROR('Only applicable for branch loans'); */

            end;
        }
        field(23; "Total Appeal Amount"; Decimal)
        {
            Editable = false;
        }
        field(24; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(26; "Finance Approval"; Boolean)
        {
        }
        field(27; "Audit Approval"; Boolean)
        {
        }
        field(28; "Responcibility Center"; Code[30])
        {
            //TableRelation = Table39005523.Field1;
        }
    }

    keys
    {
        key(Key1; "Batch No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You can not delete a posted batch.');
    end;

    trigger OnInsert()
    begin
        if "Batch No." = '' then begin
            /*
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Loan Batch Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Batch Nos.", xRec."No. Series", 0D, "Batch No.", "No. Series");
            */

        end;
        //ERROR('You dont have permission to create %1 batches',"Batch Type")
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('You can not modify a posted batch.');
    end;

    var
        //SalesSetup: Record "HR Setup.";
        EntryNo: Integer;
}

