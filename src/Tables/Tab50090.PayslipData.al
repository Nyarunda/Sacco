table 50090 "Payslip Data"
{
    Caption = 'Payslip Data';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
            DataClassification = ToBeClassified;
        }
        field(3; NSSF; Boolean)
        {
            Caption = 'NSSF';
            DataClassification = ToBeClassified;
        }
        field(4; NHIF; Boolean)
        {
            Caption = 'NHIF';
            DataClassification = ToBeClassified;
        }
        field(5; PAYE; Boolean)
        {
            Caption = 'PAYE';
            DataClassification = ToBeClassified;
        }
        field(6; Pension; Boolean)
        {
            Caption = 'Pension';
            DataClassification = ToBeClassified;
        }
        field(7; "Insurance Certificate"; Boolean)
        {
            Caption = 'Insurance Certificate';
            DataClassification = ToBeClassified;
        }
        field(8; "Suspend Pay"; Boolean)
        {
            Caption = 'Suspend Pay';
            DataClassification = ToBeClassified;
        }
        field(9; "Suspension Reasons"; Text[50])
        {
            Caption = 'Suspension Reasons';
            DataClassification = ToBeClassified;
        }
        field(10; "Disable Personal Relief"; Boolean)
        {
            Caption = 'Disable Personal Relief';
            DataClassification = ToBeClassified;
        }
        field(12; Updated; Boolean)
        {
            Caption = 'Disable Personal Relief';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Employee Code")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        Emp: record Employee;
        Staff: record "Staff Payroll Details";
    begin
        if Emp.Get("Employee Code") then begin
            if Staff.Get("Employee Code") then begin

                Staff."Basic Pay" := "Basic Pay";
                Staff."Pays NSSF" := NSSF;
                Staff."Pays NHIF" := NHIF;
                Staff."Pays PAYE" := PAYE;
                Staff."Pays Pension" := Pension;
                Staff."Insurance Certificate?" := "Insurance Certificate";
                Staff."Suspend Pay" := "Suspend Pay";
                Staff."Suspension Reasons" := "Suspension Reasons";
                Staff."Disable Personal Relief?" := "Disable Personal Relief";
                Staff.Modify();
                Updated := true;
            end
            else begin
                Staff.Init();
                Staff."Employee Code" := "Employee Code";
                Staff."Basic Pay" := "Basic Pay";
                Staff."Pays NSSF" := NSSF;
                Staff."Pays NHIF" := NHIF;
                Staff."Pays PAYE" := PAYE;
                Staff."Pays Pension" := Pension;
                Staff."Insurance Certificate?" := "Insurance Certificate";
                Staff."Suspend Pay" := "Suspend Pay";
                Staff."Suspension Reasons" := "Suspension Reasons";
                Staff."Disable Personal Relief?" := "Disable Personal Relief";
                Staff.Insert();
                Updated := true;
            end;
        end;
    end;
}
