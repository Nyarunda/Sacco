Table 51108 "HR Company Activities"
{

    fields
    {
        field(1; "Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Company Activities");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Acitivity Description"; Text[50])
        {
        }
        field(3; Date; DateTime)
        {
        }
        field(4; Venue; Text[200])
        {
        }
        field(5; "Employee Responsible"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee Responsible");
                if HREmp.Find('-') then begin
                    EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Employee Name" := EmpName;
                end;
            end;
        }
        field(6; Costs; Decimal)
        {
        }
        field(7; "G/L Account No"; Code[20])
        {
            NotBlank = true;
            //TableRelation = 

            trigger OnValidate()
            begin
                GLAccts.Reset;
                GLAccts.SetRange(GLAccts."No.", "G/L Account No");
                if GLAccts.Find('-') then begin
                    "G/L Account Name" := GLAccts.Name;
                end;
            end;
        }
        field(8; "Bal. Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";

            trigger OnValidate()
            begin
                //{
                //IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
                //GLAccts.GET(GLAccts."No.")
                //ELSE
                //Banks.GET(Banks."No.");
                //}
            end;
        }
        field(9; "Bal. Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset";
        }
        field(11; Posted; Boolean)
        {
            Editable = false;
        }
        field(16; "Email Message"; Text[1000])
        {
        }
        field(17; "No. Series"; Code[10])
        {
        }
        field(18; Closed; Boolean)
        {
            Editable = false;
        }
        field(19; "Contribution Amount (If Any)"; Decimal)
        {
        }
        field(20; "Activity Status"; Option)
        {
            OptionCaption = 'Planning,On going,Complete';
            OptionMembers = Planning,"On going",Complete;
        }
        field(21; "G/L Account Name"; Text[50])
        {
        }
        field(22; "Employee Name"; Text[50])
        {
        }
        field(23; "Responsibility Center"; Code[20])
        {
            ////TableRelation = Table52018718.Field1;
        }
        field(24; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(25; "Start Date"; Date)
        {
        }
        field(26; "End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Company Activities");
            NoSeries.GetNextNo(HRSetup."Company Activities", WorkDate(), true);
        end;
    end;

    var
        GLAccts: Record "G/L Account";
        Banks: Record "Bank Account";
        Text000: label 'You have canceled the create process.';
        Text001: label 'Replace existing attachment?';
        Text002: label 'You have canceled the import process.';
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        HREmp: Record Employee;
        EmpName: Text;
}

