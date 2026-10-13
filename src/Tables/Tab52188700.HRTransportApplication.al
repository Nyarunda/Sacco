table 50363 "HR Transport Application"
{
    Caption = 'HR Transport Application';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                HRSetup: Record "HR Setup.";
                NoSeries: Codeunit "No. Series";
            begin
                if Code <> xRec.Code then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Transport Application Nos");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Vehicle; Code[10])
        {
            Caption = 'Vehicle';
            TableRelation = "HR Vehicle List";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                HRVehicle: Record "HR Vehicle List";
            begin
                HRVehicle.get(Vehicle);
                "Vehicle Desc." := HRVehicle.Description;
            end;
        }
        field(5; "Purpose"; Text[100])
        {
            Caption = 'Purpose ';
            DataClassification = ToBeClassified;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(8; "No series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Estimated Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Estimated End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Driver; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                HREmp: Record Employee;
            begin
                "Driver Name" := '';
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee No");
                if HREmp.Find('-') then begin
                    "Driver Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                end;
            end;
        }
        field(13; "Driver Name"; Code[60])
        {
        }
        field(14; "Mileage Start"; decimal)
        {
        }
        field(15; "Mileage Stop"; decimal)
        {
        }
        field(16; Status; Option)
        {
            Editable = true;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            DataClassification = ToBeClassified;
        }
        field(17; "Vehicle Desc."; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        HREmp: Record Employee;
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
    begin

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        HREmp.SetRange(HREmp."Employee Type", HREmp."employee type"::Permanent);
        if HREmp.Find('-') then begin
            if HREmp.Status <> HREmp.Status::Active then begin

                Error('You cannot apply Leave while inactive');
            end;
            if HREmp."Employee Type" <> HREmp."employee type"::Permanent then begin
                Error('Applicable to Permanent staff only');
            end;
        end
        else
            Error('User ID not linked to employee card or Staff is not Permanent');

        "Employee No" := HREmp."No.";
        "Employee Name" := HREmp.FullName();

        //No. Series
        if code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Transport Application Nos");
            Code := NoSeries.GetNextNo(HRSetup."Transport Application Nos", WorkDate(), true);
        end;

    end;
}
