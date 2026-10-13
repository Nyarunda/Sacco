table 50096 "UPGX HR Employee Transfer"
{
    Caption = 'HR Employee Transfer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = ToBeClassified;
        }
        field(3; "Date Of Joining"; Date)
        {
            Caption = 'Date Of Joining';
            DataClassification = ToBeClassified;
        }
        field(4; "Date Of Leaving"; Date)
        {
            Caption = 'Date Of Leaving';
            DataClassification = ToBeClassified;
        }
        field(5; Status; Text[30])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(6; "Full / Part Time"; Text[30])
        {
            Caption = 'Full / Part Time';
            DataClassification = ToBeClassified;
        }
        field(7; "Contract End Date"; Date)
        {
            Caption = 'Contract End Date';
            DataClassification = ToBeClassified;
        }
        field(8; "ID Number"; Text[30])
        {
            Caption = 'ID Number';
            DataClassification = ToBeClassified;
        }
        field(9; NSSF; Text[30])
        {
            Caption = 'NSSF';
            DataClassification = ToBeClassified;
        }
        field(10; NHIF; Text[30])
        {
            Caption = 'NHIF';
            DataClassification = ToBeClassified;
        }
        field(11; PIN; Text[30])
        {
            Caption = 'PIN';
            DataClassification = ToBeClassified;
        }
        field(12; "Bank Account Number"; Text[30])
        {
            Caption = 'Bank Account Number';
            DataClassification = ToBeClassified;
        }
        field(13; "Updated"; boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        Employee: Record Employee;
    begin
        if Employee.get("No.") then begin
            Employee."Birth Date" := "Date of Birth";
            Employee."Employment Date" := "Date Of Joining";
            Employee."Termination Date" := "Date Of Leaving";
            Employee.Status := Employee.Status::Active;
            if Status = 'Inactive' then
                Employee.Status := Employee.Status::Inactive;

            Employee."National Id" := "ID Number";
            Employee."NSSF No." := NSSF;
            Employee."NHIF No." := NHIF;
            Employee.PIN := PIN;
            Employee."Bank Account No." := "Bank Account Number";
            Employee.Modify();
        end;

    end;

}
