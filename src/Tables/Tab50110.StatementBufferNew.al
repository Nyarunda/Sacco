
/// <summary>
/// Table Statement Buffer (ID 50100).
/// </summary>
table 50110 "Statement Buffer New"
{
    Caption = 'Statement Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "DatePeriod"; Code[20])
        {
            Caption = 'Period Month';
        }
        field(2; "Member No"; Code[20])
        {
            Caption = 'Member No';
        }
        field(3; OpeningBalLoans; Decimal)
        {
            Caption = 'OpeningBalLoans';
        }
        field(4; ClosingBalLoans; Decimal)
        {
            Caption = 'ClosingBalLoans';
        }
        field(5; "New Loans"; Decimal)
        {
            Caption = 'New Loans';
        }
        field(6; "Loan Repayments"; Decimal)
        {
            Caption = 'Loan Repayments';
        }
        field(7; "Interest Dues"; Decimal)
        {
            Caption = 'Interest Dues';
        }
        field(8; "Interest Paid"; Decimal)
        {
            Caption = 'Interest Paid';
        }
        field(9; DepOpeingBal; Decimal)
        {
            Caption = 'DepOpeingBal';
        }
        field(10; "DepContrib."; Decimal)
        {
            Caption = 'DepContrib.';
        }
        field(11; DepClosingBal; Decimal)
        {
            Caption = 'DepClosingBal';
        }
        field(12; MonthlyShares; Decimal)
        {
            Caption = 'Monthly Shares';
        }
        field(13; MonthlyBBF; Decimal)
        {
            Caption = 'Monthly BBF';
        }
        field(14; "Month Contrib."; Decimal)
        {
            Caption = 'Month Contrib.';
        }
        field(15; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Oustanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Oustanding Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; TotalLoans; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Total Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "DatePeriod", "Member No", Date)
        {
            Clustered = true;
        }
    }
}
