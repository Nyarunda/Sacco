Table 51053 "HR Asset Transfer Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Employee Asset Transfer No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
        }
        field(5; "Issuing Admin/Asst"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Issuing Admin/Asst");
                if Employees.Find('-') then
                    "Issuing Admin/Asst Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
            end;
        }
        field(6; "Issuing Admin/Asst Name"; Text[50])
        {
        }
        field(7; "Document Type"; Option)
        {
            OptionCaption = 'Asset Transfer';
            OptionMembers = "Asset Transfer";
        }
        field(8; "Currency Code"; Code[10])
        {
        }
        field(9; "No. Series"; Code[10])
        {
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(11; Transfered; Boolean)
        {
        }
        field(12; "Date Transfered"; Date)
        {
        }
        field(13; "Transfered By"; Code[20])
        {
        }
        field(14; "Time Transferred"; Time)
        {
        }
        field(50000; "Raised by"; Code[50])
        {
        }
        field(50001; "Responsibility Center"; Code[50])
        {
            ////TableRelation = Table52018718.Field1;
        }
        field(50002; "Current Holder"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Current Holder");
                if Employees.Find('-') then
                    "Current Holder Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
            end;
        }
        field(50003; "Current Holder Name"; Text[100])
        {
        }
        field(50004; "New Holder"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "New Holder");
                if Employees.Find('-') then
                    "New Holder Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
            end;
        }
        field(50005; "New Holder Name"; Text[100])
        {
        }
        field(50006; "Asset to Transfer"; Code[20])
        {
            TableRelation = "Misc. Article Information"."Misc. Article Code";
            /* where("Employee No." = 
            field("Current Holder"),
                                                  "In USe" = const(true));*/

            trigger OnValidate()
            begin
                EmployeeAssets.Reset;
                EmployeeAssets.SetRange(EmployeeAssets."Employee No.", "Current Holder");
                EmployeeAssets.SetRange(EmployeeAssets."Misc. Article Code", "Asset to Transfer");
                if EmployeeAssets.Find('-') then begin
                    "Asset Description" := EmployeeAssets.Description;
                    "Serial No." := EmployeeAssets."Serial No.";
                end;
            end;
        }

        field(50007; "Asset Description"; Text[50])
        {
        }
        field(50008; "Serial No."; Text[30])
        {
        }
        field(50021; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50022; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Employee Asset Transfer No.");
            "No." := NoSeries.GetNextNo(HRSetup."Employee Asset Transfer No.", WorkDate(), true);
            "Document Date" := Today;
            "Raised by" := UserId;
        end;
    end;

    var
        fasetup: Record "FA Setup";
        Employees: Record Employee;
        fasset: Record "Fixed Asset";
        NoSeries: Codeunit "No. Series";
        DimValue: Record "Dimension Value";
        EmployeeAssets: Record "Misc. Article Information";
        HRSetup: Record "HR Setup.";
}

