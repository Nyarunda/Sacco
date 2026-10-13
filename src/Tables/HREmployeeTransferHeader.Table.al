Table 51051 "HR Employee Transfer Header"
{

    fields
    {
        field(1; "Request No"; Code[50])
        {

            Editable = false;
            trigger OnValidate()
            begin
                if "Request No" <> xRec."Request No" then begin
                    hrsetup.Get;
                    NoSeries.TestManual(hrsetup."Employee Transfer Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Date Requested"; Date)
        {
        }
        field(3; "Date Approved"; Date)
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            Editable = false;
            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    "Date Approved" := Today;
                end;
            end;
        }
        field(5; "No. Series"; Code[10])
        {
        }
        field(6; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            ////TableRelation = Table52018718.Field1;
        }
        field(7; "Transfer details Updated"; Boolean)
        {
        }
        field(8; Details; Text[250])
        {
        }
        field(9; "Reason for Transfer"; Option)
        {
            OptionMembers = " ","Acting Position",Reassignment,Transfer,Relocation;
        }
        field(10; "Job ID"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(11; "Job Description"; Text[100])
        {
        }
        field(12; "Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(13; "Dimension 1 Description"; Text[50])
        {
        }
        field(14; "Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "Dimension 2 Description"; Text[50])
        {
        }
        field(16; "Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(17; "Dimension 3 Description"; Text[50])
        {
        }
        field(18; "New Job ID"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID";

            trigger OnValidate()
            begin
                Jobs.Reset;
                Jobs.SetRange(Jobs."Job ID", "New Job ID");
                if Jobs.Find('-') then
                    "New Job Description" := Jobs."Job Description";
            end;
        }
        field(19; "New Job Description"; Text[100])
        {
        }
        field(20; "New Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "New Dimension 1 Code");
                if DimVal.Find('-') then
                    "New Dimension 1 Description" := DimVal.Name;
            end;
        }
        field(21; "New Dimension 1 Description"; Text[50])
        {
        }
        field(22; "New Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "New Dimension 2 Code");
                if DimVal.Find('-') then
                    "New Dimension 2 Description" := DimVal.Name;
            end;
        }
        field(23; "New Dimension 2 Description"; Text[50])
        {
        }
        field(24; "New Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "New Dimension 3 Code");
                if DimVal.Find('-') then
                    "New Dimension 3 Description" := DimVal.Name;
            end;
        }
        field(25; "New Dimension 3 Description"; Text[50])
        {
        }
        field(26; "Employee No"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Employee No");
                if Employees.Find('-') then begin
                    "Employee Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
                    "Job ID" := Employees."Job Title";
                    "Job Description" := Employees."Job Title";
                    //"Dimension 1 Code" := Employees."Global Dimension 1 Code"
                    //"Dimension 1 Description" := Employees."Employee Classification";
                    //"Dimension 2 Code" := Employees."Global Dimension 2 Code"
                    //"Dimension 2 Description":=Employees."Dimension 2 Description";
                    //"Salary Grade" := Employees."Salary Grade";
                    //"Salary Notch" := Employees."Salary Notch/Step";
                end;
            end;
        }
        field(27; "Employee Name"; Text[100])
        {
        }
        field(28; "Dimension 4 Code"; Code[20])
        {
        }
        field(29; "Dimension 4 Description"; Text[50])
        {
        }
        field(30; "New Dimension 4 Code"; Code[20])
        {
        }
        field(31; "New Dimension 4 Description"; Text[50])
        {
        }
        field(32; "Salary Grade"; Code[20])
        {
        }
        field(33; "Salary Notch"; Code[20])
        {
        }
        field(34; "New Salary Grade"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(35; "New Salary Notch"; Code[20])
        {
            //TableRelation = Table39004049.Field2 where(Field1 = field("New Salary Grade"));
        }
        field(36; "Effective From"; Date)
        {
        }
        field(37; Duration; DateFormula)
        {

            trigger OnValidate()
            begin
                if "Effective From" <> 0D then
                    "Effective To" := CalcDate(Duration, "Effective From")
                else
                    "Effective To" := 0D;
            end;
        }
        field(38; "Effective To"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Request No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Request No" = '' then begin
            hrsetup.Get;
            hrsetup.TestField(hrsetup."Employee Transfer Nos.");
            "Request No" := NoSeries.GetNextNo(hrsetup."Employee Transfer Nos.", WorkDate(), true);
            "Date Requested" := Today;
        end;
    end;

    var
        hrsetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        Employees: Record Employee;
        Jobs: Record "HR Jobs";
        DimVal: Record "Dimension Value";
}

