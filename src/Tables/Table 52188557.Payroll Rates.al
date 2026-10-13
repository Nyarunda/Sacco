
Table 50220 "Payroll Rates"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Tax Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Relief]';
        }
        field(3; "Insurance Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Relief]';
        }
        field(4; "Max Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Relief]';
        }
        field(5; "Mortgage Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Relief]';
        }
        field(6; "Max Pension Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Pension]';
        }
        field(7; "Tax On Excess Pension"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Pension]';
        }
        field(8; "Loan Market Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Loans]';
        }
        field(9; "Loan Corporate Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Loans]';
        }
        field(10; "Taxable Pay (Normal)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Housing]';
        }
        field(11; "Taxable Pay (Agricultural)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Housing]';
        }
        field(12; "NHIF Based on"; Option)
        {
            DataClassification = ToBeClassified;
            Description = '[NHIF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(13; "NSSF Employee"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[NSSF]';
        }
        field(14; "NSSF Employer Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[NSSF]';
        }
        field(15; "OOI Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[OOI]';
        }
        field(16; "OOI December"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[OOI]';
        }
        field(17; "Security Day (U)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(18; "Security Night (U)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(19; "Ayah (U)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(20; "Gardener (U)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(21; "Security Day (R)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(22; "Security Night (R)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(23; "Ayah (R)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(24; "Gardener (R)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(25; "Benefit Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Servant]';
        }
        field(26; "NSSF Based on"; Option)
        {
            DataClassification = ToBeClassified;
            Description = '[NSSF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(27; "Value Posting"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Disbled Tax Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Minimum Relief Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Secondary Tax Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Mortgage Relief Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "NHF - Maximum Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Leave Allowance Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Incremental percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Max. Leave Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Acting Allowance Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Acting Allowance Based On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Basic Pay,Gross Pay';
            OptionMembers = " ","Basic Pay","Gross Pay";
        }
        field(39; "Acting Allowance Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Leave Allowance Based On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Basic Pay","Gross Pay","Net Pay";
        }
        field(42; "Training Deduction Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Based On Hours worked"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,BasedOnWorkedHrs';
            OptionMembers = " ",BasedOnWorkedHrs;

            trigger OnValidate()
            var
                i: Integer;
            begin
                /*
                HREmp.RESET;
                IF HREmp.FIND('-') THEN
                BEGIN
                    REPEAT
                         i:=i+1;
                        HREmp."Based On Hours worked":="Based On Hours worked";
                        HREmp.VALIDATE(HREmp."Based On Hours worked");
                         HREmp.MODIFY;
                    UNTIL HREmp.NEXT =0;
                    MESSAGE('%1 Employees Payroll will be calculated Based on attendance records',i);
                END;
                */

            end;
        }
        field(44; "Monthly Expected Work Hrs"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; prVitalSetup; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Salary increment %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "NITA Amount"; Decimal)
        {
        }
        field(48; "NITA Number"; Code[20])
        {
        }
        field(49; "NHIF Relief"; Decimal)
        {
        }
        field(50; "Housing Levy Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '[Housing Relief]';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

