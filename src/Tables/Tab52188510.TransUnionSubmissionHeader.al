table 50566 "TransUnion Submission Header"
{
    // TransUnion Submission Header for batch processing

    DataClassification = CustomerContent;
    Caption = 'TransUnion Submission Header';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(10; "Submission Date"; Date)
        {
            Caption = 'Submission Date';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(20; "Snapshot Date"; Date)
        {
            Caption = 'Snapshot Date';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(30; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }

        field(40; "Creation Date Time"; DateTime)
        {
            Caption = 'Creation Date Time';
            DataClassification = SystemMetadata;
        }

        field(50; "Submission Type"; Option)
        {
            Caption = 'Submission Type';
            DataClassification = CustomerContent;
            OptionMembers = "Daily Payment","Update","Closure";
            OptionCaption = 'Daily Payment,Update,Closure';
        }

        field(60; Status; Option)
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;
            OptionMembers = "Not Submitted","Submitted","Error","Partially Submitted";
            OptionCaption = 'Not Submitted,Submitted,Error,Partially Submitted';
            Editable = false;
        }

        field(70; "Total Records"; Integer)
        {
            Caption = 'Total Records';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("TransUnion Submission Line" where("Header Entry No." = field("Entry No.")));
        }

        field(80; "Records Submitted"; Integer)
        {
            Caption = 'Records Submitted';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("TransUnion Submission Line" where("Header Entry No." = field("Entry No."),
                                                                   "Submission Status" = const(Submitted)));
        }

        field(90; "Records with Errors"; Integer)
        {
            Caption = 'Records with Errors';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("TransUnion Submission Line" where("Header Entry No." = field("Entry No."),
                                                                   "Submission Status" = const(Error)));
        }

        field(100; "Account Category Filter"; Option)
        {
            Caption = 'Account Category Filter';
            DataClassification = CustomerContent;
            OptionMembers = " ",Individual,Joint,Business;
            OptionCaption = ' ,Individual,Joint,Business';
        }

        field(110; "Date Filter From"; Date)
        {
            Caption = 'Date Filter From';
            DataClassification = CustomerContent;
        }

        field(120; "Date Filter To"; Date)
        {
            Caption = 'Date Filter To';
            DataClassification = CustomerContent;
        }

        field(130; "Loan No. Filter"; Code[20])
        {
            Caption = 'Loan No. Filter';
            DataClassification = CustomerContent;
        }

        field(140; "Member No. Filter"; Code[20])
        {
            Caption = 'Member No. Filter';
            DataClassification = CustomerContent;
        }

        field(150; "Loan Product Filter"; Code[20])
        {
            Caption = 'Loan Product Filter';
            DataClassification = CustomerContent;
        }

        field(160; "Last Submission Date Time"; DateTime)
        {
            Caption = 'Last Submission Date Time';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(170; "TransUnion Batch ID"; Text[100])
        {
            Caption = 'TransUnion Batch ID';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(180; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(190; "Include Closed Loans"; Boolean)
        {
            Caption = 'Include Closed Loans';
            DataClassification = CustomerContent;
        }

        field(200; "Clear Existing Records"; Boolean)
        {
            Caption = 'Clear Existing Records';
            DataClassification = CustomerContent;
        }

        field(210; "Last Generation Date Time"; DateTime)
        {
            Caption = 'Last Generation Date Time';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(DateKey; "Submission Date", "Snapshot Date")
        {
        }

        key(StatusKey; Status, "Submission Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Creation Date Time" := CurrentDateTime;
        "Created By" := UserId;

        if "Submission Date" = 0D then
            "Submission Date" := Today;

        if "Snapshot Date" = 0D then
            "Snapshot Date" := Today;
    end;

    trigger OnDelete()
    var
        TransUnionLine: Record "TransUnion Submission Line";
    begin
        // Delete associated lines
        TransUnionLine.SetRange("Header Entry No.", "Entry No.");
        TransUnionLine.DeleteAll(true);
    end;
}