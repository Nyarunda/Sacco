table 50583 "Junior Images"
{
    Caption = 'Junior Images';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Junior Account No."; Code[20])
        {
            Caption = 'Junior Account No.';
            NotBlank = true;

        }

        field(2; "Member No."; Code[20])
        {
            Caption = 'Parent Member No.';

        }

        // 3. The Images
        field(3; Picture; Blob)
        {

            DataClassification = ToBeClassified;
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(4; Signature; Blob)
        {
            Caption = 'Signature';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
    }

    keys
    {
        key(PK; "Junior Account No.")
        {
            Clustered = true;
        }

        key(SK; "Member No.")
        {
        }
    }
}
