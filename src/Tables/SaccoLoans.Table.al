Table 50011 SaccoLoans
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
        }
        field(2; "Application Date"; Date)
        {
        }
        field(3; "Member No."; Code[20])
        {
        }
        field(4; "Loan Product Type"; Code[20])
        {
        }
        field(5; "Requested Amount"; Decimal)
        {
        }
        field(6; "Approved Amount"; Decimal)
        {
        }
        field(7; Installments; Integer)
        {
        }
        field(8; Interest; Decimal)
        {
        }
        field(9; "Issued Date"; Date)
        {
        }
        field(10; "Loan Account"; Code[20])
        {
        }
        field(11; "Instalment Period"; Text[200])
        {
        }
        field(12; "Repayment Method"; text[200])
        {
        }
        field(13; "Repayment Frequency"; Text[200])
        {
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(15; "Branch Code"; Code[20])
        {
        }
        field(16; "Date Approved"; Date)
        {
        }
        field(17; "Repayment Start Date"; Date)
        {
        }
        field(18; "BOSA No"; Code[20])
        {
        }
        field(19; "Disbursement Account No"; Code[20])
        {
        }
        field(20; "Defaulter SMS Date"; Date)
        {
        }
        field(21; "payslip month"; Code[20])
        {
        }
        field(22; "Sasra Main"; Code[20])
        {
        }
        field(23; "Sasra Sub I"; Code[20])
        {
        }
        field(24; "Sasra Sub II"; Code[20])
        {
        }
        field(25; "Captured By"; Code[200])
        {
        }
        field(26; "Repay Mode"; Text[20])
        {
        }
        field(27; "Outstanding Balance"; Decimal)
        {
        }
        field(28; "Oustanding Interest"; Decimal)
        {
        }
        field(29; "Outstanding Bal"; Decimal)
        {
        }
        field(30; "Created"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

