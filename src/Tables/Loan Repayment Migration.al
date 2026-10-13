table 50616 "Loan Repayment Migration"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
        }
        field(2; "Member No."; Code[20])
        {
        }
        field(3; "Loan Category"; Code[20])
        {
        }
        field(8; "Closed Date"; Date)
        {
        }
        field(9; "Loan Amount"; Decimal)
        {
        }
        field(14; "Interest Rate"; Decimal)
        {
        }
        field(15; "Monthly Repayment"; Decimal)
        {
        }
        field(17; "Member Name"; Text[30])
        {
        }
        field(21; "Monthly Interest"; Decimal)
        {
        }
        field(25; "Amount Repayed"; Decimal)
        {
            FieldClass = Normal;
        }
        field(26; "Repayment Date"; Date)
        {
        }
        field(27; "Principal Repayment"; Decimal)
        {
        }
        field(28; Paid; Boolean)
        {
        }
        field(29; "Remaining Debt"; Decimal)
        {
            Editable = false;
        }
        field(30; "Instalment No"; Integer)
        {
        }
        field(45; "Actual Loan Repayment Date"; Date)
        {
        }
        field(46; "Repayment Code"; Code[20])
        {
        }
        field(47; "Group Code"; Code[20])
        {
        }
        field(48; "Loan Application No"; Code[20])
        {
        }
        field(49; "Actual Principal Paid"; Decimal)
        {
        }
        field(50; "Actual Interest Paid"; Decimal)
        {
        }
        field(51; "Actual Installment Paid"; Decimal)
        {
        }
        field(52; "Shares Contribution"; Decimal)
        {
        }
        field(53; "Insurance Contribution"; Decimal)
        {
        }
        field(54; "Repayment Day"; Integer)
        {
        }
        field(55; "Repayment Month"; Integer)
        {
        }
        field(56; "Repayment Year"; Integer)
        {
        }
        field(57; "Loan Balance"; Decimal)
        {
        }
        field(58; "Partial Code"; Code[10])
        {
            // TableRelation = "Loan trunch Disburesment"."Document No";
        }
        field(59; "Active Schedule"; Boolean)
        {
        }
        field(60; "Top Up Code"; Code[10])
        {
            //TableRelation = "Loan Top Up."."Document No";
        }
        field(61; Touched; Boolean)
        {
        }
        field(62; "Reschedule Code"; Code[10])
        {
            //TableRelation = "Loan Rescheduling"."Document No";
        }
        field(63; Period; Code[50])
        {
        }
        field(64; "Top Up Date"; Date)
        {
        }
        field(65; "Custom Repay Date"; Integer)
        {
        }
        field(66; "Custom Repay Month"; Integer)
        {
        }
        field(67; "Custom Repay Year"; Integer)
        {
        }
        field(68; "Principle Amount Paid"; Decimal)
        {
        }
        field(69; "Interest Paid"; Decimal)
        {
        }
        field(70; "Insurance Paid"; Decimal)
        {
        }
        field(71; "Instalment Fully Settled"; Boolean)
        {
        }
        field(72; "Loan Refinanced"; Boolean)
        {
            /*             CalcFormula = Exist("Member Ledger Entry" WHERE (Loan No=FIELD(Loan No.),
                                                                         Description=FILTER(Principle-Refinance*|Loan Issued Part Payment*)));
                        FieldClass = FlowField; */
        }
        field(73; "Entry No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Member No.", "Repayment Date", "Partial Code", "Top Up Code")
        {
            SumIndexFields = "Monthly Interest", "Principal Repayment", "Monthly Repayment";
        }
        key(Key2; "Member No.")
        {
        }
        key(Key3; Paid)
        {
        }
        key(Key4; "Loan No.", "Member No.", Paid)
        {
        }
        key(Key5; "Loan Category")
        {
        }
        key(Key6; "Loan No.", "Member No.", Paid, "Loan Category")
        {
        }
    }

    fieldgroups
    {
    }

    var
    /*         NoSeriesMngnt: Codeunit "396";
            SACCOMember: Record "18";
            LoanCategory: Record "51516381"; */
}

