
Table 50213 "Inward file Buffer_"
{

    fields
    {
        field(1; "Clearing System"; Code[20])
        {
        }
        field(2; "Serial No"; Code[6])
        {
        }
        field(3; "Sort Code"; Code[6])
        {
        }
        field(4; "Branch No"; Code[20])
        {
        }
        field(5; "Account No"; Code[20])
        {
        }
        field(6; "Presenting Bank"; Code[2])
        {
        }
        field(7; "Cheque No"; Code[20])
        {
        }
        field(8; Currency; Code[2])
        {
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; "Posting Date"; Code[20])
        {
        }
        field(11; "Processing Date"; Code[20])
        {
        }
        field(12; "Bank No"; Code[2])
        {
        }
        field(13; "Unpaid Reason"; Code[20])
        {
        }
        field(14; "Unpaid Code"; Code[20])
        {
        }
        field(15; "Unused 3"; Code[20])
        {
        }
        field(16; "Bank Code 2"; Code[20])
        {
        }
        field(17; "Branch Code 3"; Code[20])
        {
        }
        field(18; "Unused 4"; Code[20])
        {
        }
        field(19; "Unused 5"; Code[20])
        {
        }
        field(20; "Unused 6"; Code[20])
        {
        }
        field(21; "Unused 7"; Code[20])
        {
        }
        field(22; CurrentUserID; Code[100])
        {
        }
        field(23; Primary; Integer)
        {
        }
        field(24; "Transaction Code2"; Code[20])
        {
        }
        field(25; "Voucher Type"; Code[2])
        {
        }
        field(26; Indicator; Code[10])
        {
        }
        field(27; Session; Code[2])
        {
        }
        field(28; "Sacco Account No."; Code[14])
        {
        }
    }

    keys
    {
        key(Key1; "Sort Code", "Serial No", "Clearing System")
        {
            Clustered = true;
        }
        key(Key2; "Clearing System")
        {
        }
    }

    fieldgroups
    {
    }
}

