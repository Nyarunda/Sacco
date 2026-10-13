Table 50384 "Agent Biometric Data"
{

    fields
    {
        field(1; DocumentNo; Code[20])
        {
        }
        field(2; IDNO; Code[10])
        {
        }
        field(3; PassportPhoto; Blob)
        {
            SubType = Bitmap;
        }
        field(4; IDFront; Blob)
        {
            SubType = Bitmap;
        }
        field(5; IDBack; Blob)
        {
            SubType = Bitmap;
        }
        field(6; Signature; Blob)
        {
            SubType = Bitmap;
        }
        field(7; FingerOne; Blob)
        {
            SubType = Bitmap;
        }
        field(8; FingerTwo; Blob)
        {
            SubType = Memo;
        }
        field(9; FingerThree; Blob)
        {
            SubType = Memo;
        }
        field(10; FingerFour; Blob)
        {
            SubType = Memo;
        }
        field(11; ApplicationFormFront; Blob)
        {
            SubType = Bitmap;
        }
        field(12; ApplicationFormBack; Blob)
        {
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; IDNO)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

