Table 51022 "OLD P9 Info"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
        }
        field(2; "Basic Pay"; Decimal)
        {
        }
        field(3; Allowances; Decimal)
        {
        }
        field(4; Benefits; Decimal)
        {
        }
        field(5; "Value Of Quarters"; Decimal)
        {
        }
        field(6; "Defined Contribution"; Decimal)
        {
        }
        field(7; "Owner Occupier Interest"; Decimal)
        {
        }
        field(8; "Gross Pay"; Decimal)
        {
        }
        field(9; "Taxable Pay"; Decimal)
        {
        }
        field(10; "Tax Charged"; Decimal)
        {
        }
        field(11; "Insurance Relief"; Decimal)
        {
        }
        field(12; "Tax Relief"; Decimal)
        {
        }
        field(13; PAYE; Decimal)
        {
        }
        field(14; NSSF; Decimal)
        {
        }
        field(15; NHIF; Decimal)
        {
        }
        field(16; Deductions; Decimal)
        {
        }
        field(17; "Net Pay"; Decimal)
        {
        }
        field(18; "Period Month"; Integer)
        {
        }
        field(19; "Period Year"; Integer)
        {
        }
        field(20; "Payroll Period"; Date)
        {
            //TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(21; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            //TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(22; Pension; Decimal)
        {
        }
        field(23; HELB; Decimal)
        {
        }
        field(24; "Payroll Code"; Code[20])
        {
            //TableRelation = "prPayroll Type";
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Payroll Period")
        {
            Clustered = true;
            SumIndexFields = "Basic Pay", "Gross Pay", "Net Pay", Allowances, Deductions, PAYE, NSSF, NHIF;
        }
    }



    fieldgroups
    {
    }


    trigger OnInsert()
    var
        myInt: Integer;
        P9: Record "Payroll P9 Buffer";
    begin
        P9.Reset();
        P9.SetRange("Employee Code", Rec."Employee Code");
        P9.SetRange("Payroll Period", Rec."Payroll Period");
        if not P9.FindFirst() then begin
            P9.Init;
            P9."Employee Code" := Rec."Employee Code";
            P9."Basic Pay" := rec."Basic Pay";
            P9.Allowances := rec.Allowances;
            P9.Benefits := rec.Benefits;
            P9."Value Of Quarters" := rec."Value Of Quarters";
            P9."Defined Contribution" := rec."Defined Contribution";
            P9."Owner Occupier Interest" := rec."Owner Occupier Interest";
            P9."Gross Pay" := rec."Gross Pay";
            P9."Taxable Pay" := rec."Taxable Pay";
            P9."Tax Charged" := rec."Tax Charged";
            P9."Insurance Relief" := rec."Insurance Relief";
            P9."Tax Relief" := rec."Tax Relief";
            P9.PAYE := rec.PAYE;
            P9.NSSF := rec.NSSF;
            P9.NHIF := rec.NHIF;
            P9.Deductions := rec.Deductions;
            P9."Net Pay" := rec."Net Pay";
            P9."Period Month" := rec."Period Month";
            P9."Period Year" := rec."Period Year";
            P9."Payroll Period" := rec."Payroll Period";
            P9.Insert;
        end;

    end;
}

