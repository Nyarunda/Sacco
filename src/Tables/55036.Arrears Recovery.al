table 55036 "Arrears Recovery"
{
    Caption = 'Arrears Recovery';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Arrears Recovery";
    LookupPageId = "Arrears Recovery";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
            TableRelation = Loans where("Member No." = field("Member No."), "Total Outstanding Balance" = filter(> 0));
            trigger OnValidate()
            var
                ExpAmt: Decimal;
                AmtPaid: Decimal;
                DefAmt: Decimal;
                DaysDef: Integer;
                ArrearsDate: Date;
                Loans: Record Loans;
                GracePeriod: DateFormula;
                SaccoActivities: Codeunit "Sacco Activities";
            begin
                AmtPaid := 0;
                DefAmt := 0;
                DaysDef := 0;
                ArrearsDate := 0D;
                Loans.Get("Loan No");
                "Loan Name" := Loans."Loan Product Type Name";
                "Interest Arrears" := SaccoActivities.GetInterestArrears(Loans."Loan No.", Today);
                SaccoActivities.GetDefaultedAmount(Loans."Loan No.", Today, ExpAmt, AmtPaid, DefAmt, DaysDef, ArrearsDate, true, GracePeriod);
                "Principal Arrears" := DefAmt;
            end;
        }
        field(2; "Interest Arrears"; Decimal)
        {
            Caption = 'Interest Arrears';
            Editable = false;
        }
        field(3; "Principal Arrears"; Decimal)
        {
            Caption = 'Principal Arrears';
            Editable = false;
        }
        field(4; "Interest Arrears Recovered"; Decimal)
        {
            Caption = 'Interest Arrears Recovered';
        }
        field(5; "Principal Arrears Recovered"; Decimal)
        {
            Caption = 'Principal Arrears Recovered';
        }
        field(6; "Member No."; Code[20])
        {
            TableRelation = Members;
        }
        field(7; "Application No."; Code[20])
        {
        }
        field(8; "Loan Name"; Code[50])
        {
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Application No.", "Member No.", "Loan No")
        {
            Clustered = true;
        }
    }
}
