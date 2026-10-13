Table 50318 "Portal Uploads"
{
    LookupPageId = "Portal Uploads";
    DrillDownPageId = "Portal Uploads";

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Type; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Name; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Format; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Effected,Rejected;
        }
        field(10; Path; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Blob; Blob)
        {
            Caption = 'Blob';
        }
        field(14; "Loan Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }


        field(16; "Blob Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Blob Url"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(19; GUID; Guid)
        {
            DataClassification = ToBeClassified;
        }




        field(20; Document; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Documents";
            trigger OnValidate()
            var
                myInt: Integer;
                LoanDoc: Record "Loan Documents";
            begin
                Type := '';
                if LoanDoc.Get(Document) then
                    Type := LoanDoc.Description;
            end;
        }
    }

    keys
    {
        key(Key1; ID, GUID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

