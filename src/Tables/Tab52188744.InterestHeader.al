table 50418 "FOSA Interest Header"
{
    Caption = 'Interest Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[10])
        {
            Caption = 'FOSA Interest No';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    NSetup.Get;
                    NoSeries.TestManual(NSetup."FOSA Interest Nos.");

                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(3; "EndDate"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //  "Period Name" := Format("EndDate", 0, '<Month Text>') + ' ' + Format(Date2DMY("EndDate", 3));

            end;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Period Name"; Code[30])
        {
            Caption = 'Period Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(7; "Created By"; Code[100])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(8; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(9; "Posted By"; Code[100])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(10; "Savings Product"; Code[10])
        {
            Caption = 'Savings Product';
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
            trigger OnValidate()
            var
                ProductList: Record "Product Setup";

            begin
                ProductList.GET("Savings Product");
                "Savings Product Description" := ProductList.Description;
                "Disbursement Period" := ProductList."Disbursement Period";
            end;
        }
        field(11; "Savings Product Description"; Text[50])
        {
            Caption = 'Savings Product Description';
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected,';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(13; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                If Posted = True Then begin
                    "Date Posted" := Today;
                    "Posted By" := UserId;
                end;
            end;

        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No Series';
            DataClassification = ToBeClassified;
        }
        field(15; "All Savings Products"; Boolean)
        {
            Caption = 'All Savings Products';
            DataClassification = ToBeClassified;

        }
        field(16; "No Of Lines"; Integer)
        {
            Caption = 'No Of Lines';
            CalcFormula = count("FOSA Interest Lines" where("Header No" = field(No)));
            Editable = false;
            FieldClass = FlowField;


        }
        field(17; "Total Interest"; Decimal)
        {
            Caption = 'Total Interest';
            CalcFormula = sum("FOSA Interest Lines".Amount where("Header No" = field(No)));
            Editable = false;
            FieldClass = FlowField;

        }
        field(18; "Batch Entries"; Integer)
        {
            Caption = 'Batch Entries';
            DataClassification = ToBeClassified;

        }
        field(19; "No Of Batches"; Code[10])
        {
            Caption = 'No Of Batches';
            DataClassification = ToBeClassified;
        }
        field(20; "Disbursement Period"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Monthly,Annually;
        }

    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        //NO SERIES
        if No = '' then begin
            NSetup.Get;
            NSetup.TestField("FOSA Interest Nos.");
            No := NoSeries.GetNextNo(NSetup."FOSA Interest Nos.", WorkDate(), true);

        end;
        "Created By" := UserId;
        "Date Created" := Today;
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        Error('Error deleting')
    end;

    var
        NSetup: Record "Sales & Receivables Setup";
        ProductSetup: Record "Product Setup";
        NoSeries: Codeunit "No. Series";
}
