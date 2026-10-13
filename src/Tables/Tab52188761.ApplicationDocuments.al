table 50542 "Attachment Documents"
{
    Caption = 'Attachment Documents';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Attachment Documents";
    LookupPageId = "Attachment Documents";

    fields
    {
        field(1; "Document ID"; Code[10])
        {
            Caption = 'Document ID';
        }
        field(2; "Document Decsription"; Text[500])
        {
            Caption = 'Document Decsription';
        }
        field(3; "Application Type"; Option)
        {
            Caption = 'Application Type';
            OptionMembers = Individual,Joint,Chama,"Group",Business,Loan,Member;
            OptionCaption = 'Individual,Joint,Chama,Group,Business,Loan Application,Member';

        }
        field(4; "Active"; Option)
        {
            Caption = 'Active';
            OptionMembers = Yes,No;

        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = Any,Image,PDF;

        }
    }
    keys
    {
        key(PK; "Document ID")
        {
            Clustered = true;
        }
    }
}
