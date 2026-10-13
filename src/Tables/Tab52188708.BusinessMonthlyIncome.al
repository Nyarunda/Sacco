table 50371 "Business Monthly Income"
{
    Caption = 'Business Monthly Income';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
            DataClassification = ToBeClassified;
        }
        field(2; Period; Date)
        {
            Caption = 'Period';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Period <> 0D then
                    Period := CalcDate('CM', Period);
            end;
        }
        field(3; "Gross Monthly Income"; Decimal)
        {
            Caption = 'Gross Monthly Income';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Appraisal: Record "Member Salary Appraisal";
            begin
                if Appraisal.Get("Appraisal No.") then begin


                    "Monthly Repayment" := Appraisal."Monthly Repayment";
                    "Deficit/Surplus" := "Gross Monthly Income" - Appraisal."Monthly Repayment";
                end;
            end;

        }
        field(4; "Monthly Repayment"; Decimal)
        {
            Caption = 'Monthly Repayment';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Deficit/Surplus"; Decimal)
        {
            Caption = 'Deficit/Surplus';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Total InFlow"; Decimal)
        {
            Caption = 'Total InFlow';
            DataClassification = ToBeClassified;
        }
        field(7; "Total Outflow"; Decimal)
        {
            Caption = 'Total Outflow';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                GetAmounts();
            end;
        }
        field(8; "Sacco Deductions"; Decimal)
        {
            Caption = 'Sacco Deductions';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                GetAmounts();
            end;
        }
        field(9; "Other Personal Expenses"; Decimal)
        {
            Caption = 'Other Personal Expenses';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                GetAmounts();
            end;
        }
        field(10; "Net Profits"; Decimal)
        {
            Caption = 'Net Profits';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Free Money"; Decimal)
        {
            Caption = 'Free Money';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Appraisal No.", Period)
        {
            Clustered = true;
        }
    }

    local procedure GetAmounts()
    var
        myInt: Integer;
    begin
        "Deficit/Surplus" := "Total InFlow" - "Total Outflow";
        "Net Profits" := "Deficit/Surplus" - "Sacco Deductions";
        "Free Money" := "Net Profits" - "Other Personal Expenses";
    end;
}
