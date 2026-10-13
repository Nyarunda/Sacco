table 50362 "HR Vehicle List"
{
    Caption = 'HR Vehicle List';
    LookupPageId = "HR Vehicle List";
    DrillDownPageId = "HR Vehicle List";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Registration No"; Code[10])
        {
            Caption = 'Registration No';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Make"; Text[50])
        {
            Caption = 'Make ';
            DataClassification = ToBeClassified;
        }
        field(4; Model; Text[50])
        {
            Caption = 'Model';
            DataClassification = ToBeClassified;
        }
        field(5; "Year of Manufacture"; Integer)
        {
            Caption = 'Year of Manufacture';
            DataClassification = ToBeClassified;
        }
        field(6; "Assigned Driver"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(7; "Assigned Driver Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."First Name" where("No." = field("Assigned Driver")));

        }
        field(8; "Insurance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Expiry; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Registration No")
        {
            Clustered = true;
        }
    }
}
