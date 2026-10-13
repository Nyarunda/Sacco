
TableExtension 50172 tableextension52188409 extends "Company Information"
{
    fields
    {
        field(50050; "KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Teller Slip Msg"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Letter Head"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50053; "Year Start"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50054; "Year End"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50055; "Bank Details Image"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50056; "Credit Message"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50057; "Fosa Signature"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50058; "Document Watermark"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50059; "Sacco Society No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "SMS Line"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "CEO Signature"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
    }
}

