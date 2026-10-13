Table 51052 "HR Employee Transfer Lines"
{

    fields
    {
        field(1; "Request No"; Code[50])
        {
            TableRelation = "HR Employee Transfer Header"."Request No";
        }
        field(2; "Employee No"; Code[50])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if Employees.Get("Employee No") then begin
                    "Employee Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
                    "Global Dimension 1 Code" := Employees."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employees."Global Dimension 2 Code"
                    //"Shortcut Dimension 3 Code":=Employees."Shortcut Dimension 3 Code";
                    //"Current Department Name":=Employees."Department Name";
                    //"Current Region Name":= Employees."Station Name";
                    //"Current Directorate Name":= Employees."Directorate Name"
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Global Dimension 1 Code"; Code[50])
        {
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(5; "New Global Dimension 1 Code"; Code[50])
        {
            Caption = 'New Global Dimension 1 Code';
            Description = 'Stores the reference to the New first global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SetRange(Dimn.Code, "New Global Dimension 1 Code");
                if Dimn.Find('-') then begin
                    "Dimension 3 Description" := Dimn.Name;
                end;
            end;
        }
        field(6; "Global Dimension 2 Code"; Code[50])
        {
            Caption = 'Global Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(7; "New Global Dimension 2 Code"; Code[50])
        {
            Caption = 'New Global Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SetRange(Dimn.Code, "New Global Dimension 2 Code");
                if Dimn.Find('-') then begin
                    "New Dimension 3 Description" := Dimn.Name;
                end;
            end;
        }
        field(8; "Shortcut Dimension 3 Code"; Code[50])
        {
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(9; "New Shortcut Dimension 3 Code"; Code[50])
        {
            Caption = 'New Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the New Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SetRange(Dimn.Code, "New Shortcut Dimension 3 Code");
                if Dimn.Find('-') then begin
                    "New Dimension 1 Description" := Dimn.Name;
                end;
            end;
        }
        field(10; "Dimension 1 Description"; Text[100])
        {
        }
        field(11; "New Dimension 1 Description"; Text[100])
        {
        }
        field(12; "Dimension 2 Description"; Text[100])
        {
        }
        field(13; "New Dimension 2 Description"; Text[100])
        {
        }
        field(14; "Dimension 3 Description"; Text[100])
        {
            //CalcFormula = lookup(Table349.Field3 where(Field9 = filter(2),
            //                                          Field2 = field("New Global Dimension 2 Code")));
            //FieldClass = FlowField;
        }
        field(15; "New Dimension 3 Description"; Text[100])
        {
        }
        field(16; "Line No"; Integer)
        {
            AutoIncrement = true;
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

    var
        hrsetup: Record "HR Setup.";
        Employees: Record Employee;
}

