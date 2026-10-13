Table 50595 "HR Employee Beneficiary"
{
    Caption = 'Employee Relative';

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Employee"."No.";
        }
        field(2; Relationship; Text[30])
        {
            Description = 'LookUp to Relationships Table';
            TableRelation = "Relationship";
        }
        field(3; SurName; Text[50])
        {
            NotBlank = true;
        }
        field(4; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
        field(5; "ID No."; Text[50])
        {


        }
        field(6; "Date Of Birth"; Date)
        {
        }
        field(7; Occupation; Text[100])
        {
        }
        field(8; Address; Text[250])
        {
        }
        field(9; "Mobile Phone No."; Code[50])
        {


        }
        field(10; "Home Tel No"; Text[50])
        {
        }
        field(12; Type; Option)
        {
            OptionMembers = "Next of Kin",Beneficiary;
        }
        field(13; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(14; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Employee Relative"),
                                                                     "No." = field("Employee Code"),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; "Guardian Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Guardian Phone No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Guardian ID No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "E-mail"; Text[60])
        {
        }
        field(50001; "Verification Document"; Option)
        {
            Editable = false;
            OptionMembers = "National ID",Passport,"Military ID","Diplomatic ID","Alien ID","Drivers Licence","Birth Certificate";
        }

        field(50003; "Country Code"; Code[10])
        {
        }
        field(50004; Allocation; Decimal)
        {
            Caption = 'Allocation %';
            MinValue = 0;

            trigger OnValidate()
            var
                NBeneficiary: Record "HR Employee Beneficiary";
                TotalAllocation: Decimal;
            begin
                NBeneficiary.Reset;
                NBeneficiary.SetRange(NBeneficiary."Employee Code", "Employee Code");
                NBeneficiary.SetFilter(NBeneficiary."Line No.", '<>%1', "Line No.");
                if NBeneficiary.FindFirst then NBeneficiary.CalcSums(Allocation);
                TotalAllocation := NBeneficiary.Allocation;

                if TotalAllocation + Allocation > 100 then Error(ErrAllocation);
            end;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Type, Relationship, SurName, "Other Names", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."table name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee Code");
        HRCommentLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        EnsureIdentificationOrDateOfBirth();
    end;

    trigger OnModify()
    begin
        EnsureIdentificationOrDateOfBirth();
    end;

    local procedure EnsureIdentificationOrDateOfBirth()
    begin
        if "ID No." = '' then
            TestField("Date Of Birth");
    end;


    var

        CountryRegion: Record "Country/Region";
        ErrAllocation: label 'Total allocation cannot be more than 100%.';


}
