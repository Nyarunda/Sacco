Table 50010 SaccoAccounts
{

    fields
    {
        field(1; "No."; Code[200])
        {
        }
        field(2; Name; Text[2000])
        {
        }
        field(3; "Phone No."; Code[200])
        {
        }
        field(4; "Global Dimension 1 Code"; Code[200])
        {
        }
        field(5; "Global Dimension 2 Code"; Code[200])
        {
        }
        field(6; "Customer Posting Group"; Code[200])
        {
        }
        field(7; "Customer Type"; Text[2000])
        {
        }
        field(8; Status; Text[200])
        {
        }
        field(9; "Savings Account"; Code[200])
        {
        }
        field(10; "Payroll/Staff No"; Code[200])
        {
        }
        field(11; "ID No."; Code[200])
        {
        }
        field(12; "Mobile Phone No"; Code[200])
        {
        }
        field(13; "Account Category"; Text[2000])
        {
        }
        field(14; "MPESA Mobile No"; Code[200])
        {
        }
        field(15; "Product Type"; Code[200])
        {
        }
        field(16; "Product Name"; Text[2000])
        {
        }
        field(17; "Account Product Category"; Text[2000])
        {
        }
        field(18; Blocked; Code[200])
        {
        }
        field(19; "Member No."; Code[200])
        {
        }
        field(200; "Loan Disbursement Account"; Code[200])
        {
        }
        field(21; "Employer Code"; Code[200])
        {
        }
        field(22; Blocked2; Code[200])
        {
        }
        field(23; "Balance (LCY)"; Decimal)
        {
        }
        field(24; "Registration Date"; Date)
        {
        }
        field(25; Created; Boolean)
        {
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
}

