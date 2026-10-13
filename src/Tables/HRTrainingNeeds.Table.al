Table 51056 "HR Training Needs"
{
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "HR Training Needs List";
    LinkedObject = false;
    LookupPageID = "HR Training Needs List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; Description; Text[250])
        {
        }
        field(3; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Start Date" < Today then Error('Invalid Start Date specified [%1]', "Start Date");
            end;
        }
        field(4; "End Date"; Date)
        {
            Editable = true;

            trigger OnValidate()
            begin
                TestField("Start Date");
                if ("End Date" < Today) or ("End Date" < "Start Date") then Error('Invalid End Date specified [%1]', "End Date");
                "Re-Assessment Date" := 0D;
            end;
        }
        field(5; Duration1; DateFormula)
        {
        }
        field(6; "Total Costs"; Decimal)
        {
            CalcFormula = sum("HR Training Cost".Cost where("Training ID" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Location; Code[50])
        {
        }
        field(8; "Re-Assessment Date"; Date)
        {

            trigger OnValidate()
            begin
                TestField("Start Date");
                TestField("End Date");
                if "Re-Assessment Date" <= "End Date" then Error('Re-Assesment date should be greater than the start date and the end date');
            end;
        }
        field(9; "Need Source"; Option)
        {
            OptionCaption = '  ,Appraisal,Succesion,Training,Employee,Employee Skill Plan,Competency Profiling';
            OptionMembers = "  ",Appraisal,Succesion,Training,Employee,"Employee Skill Plan","Competency Profiling";
        }
        field(10; "Provider Name"; Text[100])
        {
            //TableRelation = Table23.Field50150 where(Field50150 = filter(No));
        }
        field(11; Posted; Boolean)
        {
            Editable = false;
        }
        field(12; Closed; Boolean)
        {
            Editable = false;
        }
        field(13; "Qualification Code"; Code[20])
        {
            TableRelation = "HR Job Qualifications".Code where("Qualification Type" = field("Qualification Type"));

            trigger OnValidate()
            begin
                HRQualifications.Reset;
                if HRQualifications.Get("Qualification Type", "Qualification Code") then
                    "Qualification Description" := HRQualifications.Description;
            end;
        }
        field(14; "Qualification Type"; Code[30])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code where(Type = const("Qualification Type"));
        }
        field(15; "Qualification Description"; Text[80])
        {
        }
        field(16; "External Provider Name"; Text[50])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(17; "Responsibility Center"; Code[10])
        {
            //TableRelation = Table5714.Field1;
        }
        field(18; "Bondage Start Date"; Date)
        {
            Editable = false;
        }
        field(19; "Bondage Duration"; DateFormula)
        {

            trigger OnValidate()
            begin
                "Bondage Release Date" := CalcDate("Bondage Duration", "Bondage Start Date");
            end;
        }
        field(20; "Bondage Release Date"; Date)
        {
            Editable = false;
        }
        field(21; "Inclusive of Non Working Days"; Boolean)
        {
        }
        field(22; "Bondage Required?"; Boolean)
        {

            trigger OnValidate()
            begin
                TestField("Start Date");
                TestField("End Date");

                Clear("Bondage Start Date");
                Clear("Bondage Duration");
                Clear("Bondage Release Date");

                if "Bondage Required?" then begin
                    "Bondage Start Date" := "End Date";
                    Validate("Bondage Duration");
                end;
            end;
        }
        field(23; "No. of Training Cost Items"; Integer)
        {
        }
        field(24; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(25; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(26; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(27; "Currency Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(28; "Allow Early Exit if Bonded?"; Boolean)
        {

            trigger OnValidate()
            begin
                TestField("Bondage Required?", true);
                TestField("Bondage Duration");
            end;
        }
        field(29; "Employee No"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(30; "No. Series"; Code[20])
        {
        }
        field(31; Duration; Duration)
        {
        }
        field(32; "Training Category"; Option)
        {
            OptionMembers = " ",Staff,Interns,Attachees;
        }
        field(33; "Training Type"; Option)
        {
            OptionMembers = " ",Conference,Seminar,Workshop,"Study Tour","Self Sponsored",Other,"Company Sponsorship";
        }
        field(34; Provider; Code[50])
        {
            TableRelation = Vendor where("Vendor Type" = const(Training));

            trigger OnValidate()
            begin

                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", Provider);
                if Vendor.Find('-') then
                    "Provider Name" := Vendor.Name;
            end;
        }
        field(35; "Other Provider"; Text[100])
        {
        }
        field(36; "Duration Units"; Text[50])
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
            HRSetup.TestField(HRSetup."Traning Needs Nos.");
            Code := NoSeries.GetNextNo(HRSetup."Traning Needs Nos.", WorkDate(), true);
        end;
    end;

    var
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        HRCodeunit: Codeunit "HR Codeunit.";
        HRQualifications: Record "HR Job Qualifications";
        Vendor: Record Vendor;

    local procedure calcDuration()
    begin
    end;
}

