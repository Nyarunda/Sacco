table 50596 "Employee Gym Claims"
{
    Caption = 'Employee Gym Claims';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if "Employee Code" = '' then begin
                    "Employee Name" := '';
                    exit;
                end;

                PopulateEmployeeName();
            end;
        }
        field(2; "Payroll Period"; Date)
        {
            TableRelation = "Payroll Periods"."Date Opened" where(Closed = const(false));

            trigger OnValidate()
            var
                PayrollPeriod: Record "Payroll Periods";
            begin
                if "Payroll Period" = 0D then begin
                    "Period Month" := 0;
                    "Period Year" := 0;
                    exit;
                end;

                PayrollPeriod.Get("Payroll Period");
                if PayrollPeriod.Closed then
                    Error('You can only claim gym allowance in an open payroll period.');

                "Period Month" := PayrollPeriod."Period Month";
                "Period Year" := PayrollPeriod."Period Year";
            end;
        }
        field(3; "Claim Amount"; Decimal)
        {
            MinValue = 0;
        }
        field(4; "Gross Amount"; Decimal)
        {
            Editable = false; // calculated on posting
        }
        field(5; "Marginal Tax Rate"; Decimal)
        {
            Editable = false; // captured at time of processing
        }
        field(6; Status; Option)
        {
            OptionMembers = Open,Approved,Posted;
        }
        field(7; "Posted"; Boolean)
        {
            Editable = false;
        }
        field(8; "Period Month"; Integer) { }
        field(9; "Period Year"; Integer) { }

        field(11; "Transaction Code"; Code[20])
        {
            TableRelation = "Payroll Codes"."Transaction Code";
        }
        field(12; "Last Modified By"; Code[50])
        {
            Editable = false;
        }
        field(13; "Last Modified DateTime"; DateTime)
        {
            Editable = false;
        }
        field(14; "Employee Name"; text[70])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Payroll Period")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        PopulateEmployeeName();
        AssertOpenPayrollPeriod();
        "Last Modified By" := UserId;
        "Last Modified DateTime" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        PopulateEmployeeName();
        AssertOpenPayrollPeriod();
        "Last Modified By" := UserId;
        "Last Modified DateTime" := CurrentDateTime;
    end;

    trigger OnDelete()
    begin
        if Posted or (Status = Status::Posted) then
            Error('You cannot delete a posted gym claim.');
    end;

    local procedure PopulateEmployeeName()
    var
        Employee: Record Employee;
    begin
        if "Employee Code" = '' then begin
            "Employee Name" := '';
            exit;
        end;

        Employee.Get("Employee Code");
        "Employee Name" := CopyStr(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name", 1, MaxStrLen("Employee Name"));
    end;

    local procedure AssertOpenPayrollPeriod()
    var
        PayrollPeriod: Record "Payroll Periods";
    begin
        if "Payroll Period" = 0D then
            exit;

        PayrollPeriod.Get("Payroll Period");
        if PayrollPeriod.Closed then
            Error('You can only claim gym allowance in an open payroll period.');
    end;
}
