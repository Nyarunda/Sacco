Table 51067 "HR Medical Claims"
{
    DrillDownPageID = "HR Medical Claims List";
    LookupPageID = "HR Medical Claims List";

    fields
    {
        field(1; "Member No"; Code[10])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Member No");
                if Employees.Find('-') then
                    "Member Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
            end;
        }
        field(2; "Claim Type"; Option)
        {
            OptionMembers = Inpatient,Outpatient;
        }
        field(3; "Claim Date"; Date)
        {
        }
        field(4; "Patient Name"; Text[100])
        {
        }
        field(5; "Document Ref"; Text[50])
        {
        }
        field(6; "Date of Service"; Date)
        {
        }
        field(7; "Attended By"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(8; "Amount Charged"; Decimal)
        {
        }
        field(9; Comments; Text[250])
        {
        }
        field(10; "Claim No"; Code[10])
        {

            trigger OnValidate()
            begin

                if "Claim No" <> xRec."Claim No" then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Medical Claims Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(11; Dependants; Code[50])
        {
            TableRelation = "HR Employee Kin"."Other Names" where("Employee Code" = field("Member No"));

            trigger OnValidate()
            begin
                /*
                MDependants.Reset;
                MDependants.SetRange(MDependants."Employee Code", Dependants);
                if MDependants.Find('-') then begin
                    "Patient Name" := MDependants.SurName + ' ' + MDependants."Other Names";
                end;
                */
            end;
        }
        field(12; "Member Name"; Text[100])
        {
        }
        field(3967; "No. Series"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Claim No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Claim No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Medical Claims Nos");
            "Claim No" := NoSeries.GetNextNo(HRSetup."Medical Claims Nos", WorkDate(), true);
        end;
    end;

    var
        //MDependants: Record  UnknownRecord39003911;
        NoSeries: Codeunit "No. Series";
        HRSetup: Record "HR Setup.";
        Employees: Record Employee;
}

