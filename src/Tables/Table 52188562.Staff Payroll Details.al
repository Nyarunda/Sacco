
Table 50225 "Staff Payroll Details"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Text0000: label 'Do you want to change the Basic Pay for this Employee %1 and Update his/her Employee Card?';
                HREmp: Record Employee;
                Text0001: label 'Aborted. Press F5 to discard the changes';
                Text0002: label 'Employee %1 does not exist in HR Employees list. Please liase with HR Officer to Create this Employee';
            begin
                "1/3 Basic" := 1 / 3 * "Basic Pay";
                /*
    //*************************DW******************************************
    // TO ENSURE PR SALARY CARD BASIC PAY AND HR EMPLOYEES BASIC
    // PAY ARE SAME WHEN CHANGED
       IF HREmp.GET("Employee Code") THEN
       BEGIN
          HREmp."New Basic Pay":="Rate Per Day";
          HREmp."Basic Pay":="Basic Pay";
          HREmp.MODIFY;
       END ELSE
       BEGIN
          ERROR(Text0002,"Employee Code");
       END;

    // For NIB MWEA :: Function to check if Employee is Paid Daily
    // and place a check mark on the field is "Is Paid Daily" on this table
                //  fnIsEmployeePaidDaily;
    //*********************************************************************
                 */

            end;
        }
        field(3; "Payment Mode"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Bank Transfer,Cheque,Cash,FOSA';
            OptionMembers = "Bank Transfer",Cheque,Cash,FOSA;
        }
        field(4; Currency; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Pays NSSF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Pays NHIF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Pays PAYE"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Payslip Message"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Suspend Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Suspension Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Suspension Reasons"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(18; Exists; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Bank Account Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Bank Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Employee's Bank"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = "Payroll Posting Group".Code;
        }
        field(28; "No. Overtime Day(s) Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Identification Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Mobile Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; Nationality; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Scheme Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Job Title"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Job Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Address; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Employment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(38; Status; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "PIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Bank Account No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Job Group"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Company E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Days Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60000; "Grade Level"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "Gratuity %"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "Gratuity Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60003; Gratuity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "No.Of Days PDM"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "Rate Per Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "Scheme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('SCHEME'));
        }
        field(60008; "No. of Days Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Is Paid Daily?"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'FOR MWEA';
        }
        field(60010; "No. of Sundays / Holidays Work"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'FOR MWEA';
        }
        field(60011; "Assign Resp Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'FOR MWEA';
        }
        field(60012; "Not Based on Rates"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'FOR MWEA';
        }
        field(60013; "Insurance Certificate?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60014; "PAYE Relief?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60016; "Is Security?"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'FOR MIAD';
        }
        field(60018; "Disable Personal Relief?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60019; "1/3 Basic"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "1/3 Basic" := 1 / 3 * "Basic Pay";
            end;
        }
        field(60020; "Insurance Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60021; "Process NITA"; Boolean)
        {
        }

        field(60022; "Pays Pension"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(60023; "Stop Employer Pension"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60024; "Defined Pension"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60025; "Pays Housing Levy"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

