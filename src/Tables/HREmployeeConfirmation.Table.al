Table 51069 "HR Employee Confirmation"
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Employee Number"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin

                HREmployees.Reset;
                HREmployees.SetRange(HREmployees."No.", "Employee Number");
                if HREmployees.Find('-') then begin
                    "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                    /*
                    "Shortcut Dimension code1" := HREmployees.Office;
                    "Shortcut Dimension code2" := HREmployees."Department Code";
                    Designation := HREmployees."Job Title";
                    //   "Probation Start Date":=HREmployees."Date Of Join";
                    "Probation End Date" := HREmployees."End Of Probation Date";
                    */
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Request Date"; Date)
        {
        }
        field(5; "Shortcut Dimension code1"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(6; "Shortcut Dimension code2"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(7; Reason; Text[250])
        {
        }
        field(8; "Probation Start Date"; Date)
        {
        }
        field(9; "Probation End Date"; Date)
        {
        }
        field(10; "Confirmation Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Confirmation Date" < "Probation End Date" then
                    Error(Txt001);
            end;
        }
        field(11; Designation; Code[30])
        {
        }
        field(12; Grade; Code[10])
        {
        }
        field(13; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(14; "Responsibility Center"; Code[20])
        {
            ////TableRelation = Table52018718.Field1;
        }
        field(15; User; Code[20])
        {
        }
        field(16; "No series"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //No. Series
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Employee Confirmation No.");
            No := NoSeries.GetNextNo(HRSetup."Employee Confirmation No.", WorkDate(), true);
        end;
    end;

    var
        HREmployees: Record Employee;
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        Txt001: label 'Confirmation date can not be before Probation end date';
}

