table 50560 "TransUnion Daily Payment"
{
    // TransUnion Kenya Daily Payment Information Record

    DataClassification = CustomerContent;
    Caption = 'TransUnion Daily Payment Information';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(10; "Account Number"; Code[50])
        {
            Caption = 'Account Number';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(20; "Snapshot Date"; Date)
        {
            Caption = 'Snapshot Date';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(30; "Client Type"; Code[10])
        {
            Caption = 'Client Type';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnLookup()
            begin
                // A = Individual, B = Corporate
                if Confirm('Select Client Type:\Yes for Individual (A)\No for Corporate (B)') then
                    "Client Type" := 'A'
                else
                    "Client Type" := 'B';
            end;
        }

        field(40; Surname; Text[50])
        {
            Caption = 'Surname';
            DataClassification = CustomerContent;
        }

        field(50; "Forename 1"; Text[50])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }

        field(60; "Forename 2"; Text[50])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }

        field(70; "Forename 3"; Text[50])
        {
            Caption = 'Other Name';
            DataClassification = CustomerContent;
        }

        field(80; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            DataClassification = CustomerContent;
        }

        field(90; "Primary ID Doc Type"; Enum "TransUnion ID Document Type")
        {
            Caption = 'Primary ID Document Type';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(100; "Primary ID Doc Number"; Text[50])
        {
            Caption = 'Primary ID Document Number';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(110; "Currency Code"; Code[10])
        {
            Caption = 'Currency of Facility';
            DataClassification = CustomerContent;
            NotBlank = true;
            InitValue = 'KES';
        }

        field(120; "Original Amount"; Decimal)
        {
            Caption = 'Original Amount';
            DataClassification = CustomerContent;
            NotBlank = true;
            MinValue = 0;
        }

        field(130; "Payment Amount"; Decimal)
        {
            Caption = 'Payment Amount';
            DataClassification = CustomerContent;
            NotBlank = true;
            MinValue = 0;
        }

        field(140; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(150; "Current Balance"; Decimal)
        {
            Caption = 'Current Balance';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(160; "Installments in Arrears"; Integer)
        {
            Caption = 'Installments in Arrears';
            DataClassification = CustomerContent;
            MinValue = 0;
        }

        field(170; "Days in Arrears"; Integer)
        {
            Caption = 'Days in Arrears';
            DataClassification = CustomerContent;
            MinValue = 0;
        }

        field(180; "Account Status"; Enum "TransUnion Account Status")
        {
            Caption = 'Account Status';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(200; "Submission Status"; Option)
        {
            Caption = 'Submission Status';
            DataClassification = SystemMetadata;
            OptionMembers = "Not Submitted","Submitted","Error","Resubmit Required";
            OptionCaption = 'Not Submitted,Submitted,Error,Resubmit Required';
        }

        field(210; "Submission Date Time"; DateTime)
        {
            Caption = 'Submission Date Time';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(220; "Last Error Message"; Text[250])
        {
            Caption = 'Last Error Message';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(230; "TransUnion Callback ID"; Text[100])
        {
            Caption = 'TransUnion Callback ID';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(240; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(250; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(AccountKey; "Account Number", "Snapshot Date")
        {
        }

        key(SubmissionKey; "Submission Status", "Snapshot Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Snapshot Date" = 0D then
            "Snapshot Date" := Today;

        if "Payment Date" = 0D then
            "Payment Date" := Today;
    end;
}