Table 51080 "HR Appraisal Header"
{

    fields
    {
        field(1; "Appraisal No"; Code[30])
        {
            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Appraisal No" <> xRec."Appraisal No" then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Appraisal Nos");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Supervisor Name"; Text[100])
        {
        }
        field(3; "Appraisal Type"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraisal Type"));
        }
        field(4; "Appraisal Period"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Appraisal Period"));

            trigger OnValidate()
            begin


                // HRLookUpValues.Reset;
                // HRLookUpValues.SetRange(HRLookUpValues.Type, HRLookUpValues.Type::"Appraisal Period");
                // HRLookUpValues.SetRange(HRLookUpValues.Code, "Appraisal Period");
                // if HRLookUpValues.Find('-') then begin
                //     "Evaluation Period Start" := HRLookUpValues.From;
                //     "Evaluation Period End" := HRLookUpValues."To";
                // end;

            end;
        }
        field(5; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved,Closed,Posted;
        }
        field(6; Recommendations; Text[250])
        {
        }
        field(7; "No Series"; Code[20])
        {
        }
        field(8; "Appraisal Stage"; Option)
        {
            OptionMembers = Appraisee,Supervisor,Completed;
            OptionCaption = 'Appraisee,Supervisor,Completed';

        }
        field(9; Sent; Option)
        {
            OptionCaption = 'Appraisee,Supervisor,Completed,Rated';
            OptionMembers = Appraisee,Supervisor,Completed,Rated;
        }
        field(10; "User ID"; Code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(11; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(12; "Employee No"; Code[30])
        {
            Editable = true;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee No");
                if HREmp.Find('-') then begin
                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Job Title" := HREmp."Job Title";
                    "Date of Employment" := HREmp."Employment Date";
                    "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                    "Job Title" := HREmp."Job Title";
                    //"Contract Type":= HREmp."Contract Type" ;
                    "User ID" := UserId;
                    //HREmp.CalcFields(HREmp.Image);
                    //Picture := HREmp.Image;
                end;
            end;
        }
        field(13; "Employee Name"; Text[60])
        {
            Editable = false;
        }
        field(14; "Date of Employment"; Date)
        {
        }
        field(15; "Job Title"; Code[30])
        {
            Editable = false;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(16; Department; Code[20])
        {
            TableRelation = "HR Appraisal Company Target".Code;

            trigger OnValidate()
            begin
                /*
   IF HRAppraisalRatings.GET(Department) THEN
   "Global Dimension 2 Code":=HRAppraisalRatings.Description;
   Recommendations:=HRAppraisalRatings.Recommendations;
                  */

            end;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(19; "Comments Appraisee"; Text[250])
        {
        }
        field(20; "Comments Appraiser"; Text[250])
        {
        }
        field(21; "Appraisal Date"; Date)
        {
        }
        field(22; "Evaluation Period Start"; Date)
        {
        }
        field(23; "Evaluation Period End"; Date)
        {
        }
        field(24; "Target Type"; Option)
        {
            OptionCaption = ' ,Company Targets,Individual Targets,Peer Targets,Surbodinates Targets,Out Agencies Targets,Company Rating,Individual Rating,Peer Rating,Surbodinates Rating,Out Agencies Rating';
            OptionMembers = " ","Company Targets","Individual Targets","Peer Targets","Surbodinates Targets","Out Agencies Targets","Company Rating","Individual Rating","Peer Rating","Surbodinates Rating","Out Agencies Rating";
        }
        field(25; "Responsibility/Duties Agrd Sco"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter("Core Responsibilities/Duties")));
            Caption = 'Responsibility/Duties Agreed Score';
            ExtendedDatatype = Ratio;
            FieldClass = FlowField;
        }
        field(26; "Attendance&Punctuality Agr Sco"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter("Attendance&Punctuality")));
            Caption = 'Attendance & Punctuality Agreed Score';
            FieldClass = FlowField;
        }
        field(27; "Communication Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter(Communication)));
            ExtendedDatatype = Ratio;
            FieldClass = FlowField;
        }
        field(28; "Cooperation Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter(Cooperation)));
            FieldClass = FlowField;
        }
        field(29; "Customer Service Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter("Internal/External Clients")));
            FieldClass = FlowField;
        }
        field(30; "Initiative Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter(Initiative)));
            FieldClass = FlowField;
        }
        field(31; "Quality Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter(Quality)));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(32; "Teamwork Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter("Team Work")));
            ExtendedDatatype = Ratio;
            FieldClass = FlowField;
        }
        field(33; "Sales Skills Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter("Sales Skills")));
            FieldClass = FlowField;
        }
        field(34; "Leadership Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter(Leadership)));
            FieldClass = FlowField;
        }
        field(35; "Performance Coaching Agreed Sc"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where("Appraisal No" = field("Appraisal No"),
                                                                          "Appraisal Period" = field("Appraisal Period"),
                                                                          "Employee No" = field("Employee No"),
                                                                          Sections = filter("Performance Coaching")));
            Caption = 'Performance Coaching Agreed Score';
            FieldClass = FlowField;
        }
        field(36; "Action Recomended"; Integer)
        {
        }
        field(37; "Job Specific Agreed Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Self Rating" where("Appraisal No" = field("Appraisal No"),
                                                                        "Appraisal Period" = field("Appraisal Period"),
                                                                        "Employee No" = field("Employee No")));
            FieldClass = FlowField;
        }
        field(38; "Employee Subordinates"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Weighted Rating" where("Appraisal No" = field("Appraisal No"),
                                                                            "Appraisal Period" = field("Appraisal Period"),
                                                                            "Employee No" = field("Employee No")));
            Caption = 'Employee Subordinates Agreed Score';
            FieldClass = FlowField;
        }
        field(39; "Employee Peers"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Peer Rating" where("Appraisal No" = field("Appraisal No"),
                                                                        "Appraisal Period" = field("Appraisal Period"),
                                                                        "Employee No" = field("Employee No")));
            Caption = 'Employee Peers Agreed Score';
            FieldClass = FlowField;
        }
        field(40; "Old Job Description"; Text[250])
        {
            CalcFormula = lookup("HR Jobs"."Job Description" where("Job ID" = field("Job Title")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Appraisal Method"; Option)
        {
            OptionCaption = ' ,Normal Appraisal,360 Appraisal';
            OptionMembers = " ","Normal Appraisal","360 Appraisal";
        }
        field(42; "Supervisor Employee No"; Code[50])
        {
            Editable = true;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Supervisor Employee No");
                if HREmp.Find('-') then begin
                    HREmp.TestField(HREmp."User ID");
                    "Supervisor Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Supervisor Job Title" := HREmp."Job Title";
                    "Supervisor UserID" := HREmp."User ID";
                end;
            end;
        }
        field(43; "Supervisor Job Title"; Text[50])
        {
            Editable = true;
        }
        field(50000; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            ////TableRelation = Table52018718.Field1;
        }
        field(50011; "Contract Type"; Option)
        {
            OptionMembers = Permanent,"Temporary",Voluntary,Probation,Contract;
        }
        field(50014; "Appraisal Approval Status"; Option)
        {
            OptionMembers = "Pending Approval",Approved;
        }
        field(50015; "Supervisor UserID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50020; "Prev Appraisal Code"; Code[50])
        {
        }
        field(50021; "Agreed Goals 1"; Text[30])
        {
            Description = 'Agreed goals for the year ahead';
        }
        field(50022; "Responsibility/Duties Comment"; Text[100])
        {
            Caption = 'Responsibility/Duties Agreed Score';
            FieldClass = Normal;
        }
        field(50023; "Attendance&Punctuality Comment"; Text[30])
        {
            Caption = 'Attendance & Punctuality Agreed Score';
            FieldClass = Normal;
        }
        field(50024; "Communication Agreed Comment"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50025; "Cooperation Agreed Comment"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50026; "Customer Service Agr Comment"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50027; "Initiative Agreed Comment"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50028; "Quality Agreed Comment"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50029; "Teamwork Agreed Comment"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50030; "Sales Skills Agreed Comment"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50031; "Leadership Agreed Comment"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50032; "Performance Coaching Comment"; Text[30])
        {
            Caption = 'Performance Coaching Agreed Score';
            FieldClass = Normal;
        }
        field(50033; "Job ID"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs";
            trigger OnValidate()
            var
                HRJobs: Record "HR Jobs";
            begin
                if HRJobs.Get("Job ID") then
                    "Job Description" := HRJobs."Job Description";
            end;
        }
        field(50334; "Job Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50335; "Traninig Attended"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50336; "Areas of Achievement"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50337; "Training Required"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50338; "Expected Performance Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50339; "Resources Required"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50340; "Team Leaders Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
        //Also delete lines
        /*
        HRGoalSettingL.Reset;
        HRGoalSettingL.SetRange(HRGoalSettingL."Appraisal No", "Appraisal No");
        if HRGoalSettingL.Find('-') then begin
            HRGoalSettingL.DeleteAll;
        end;
        */
    end;

    trigger OnInsert()
    var
        Employee: Record Employee;
    begin
        if "Appraisal No" = '' then begin

            HRSetup.Get;
            HRSetup.TestField(HRSetup."Appraisal Nos");
            "Appraisal No" := NoSeries.GetNextNo(HRSetup."Appraisal Nos", WorkDate(), true);

        end;
        "Appraisal Date" := Today;
        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin

            HREmp.TestField("Job ID");
            HREmp.TestField("Job Description");

            "Appraisal Stage" := "Appraisal Stage"::Appraisee;

            "Employee No" := HREmp."No.";
            "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            "Date of Employment" := HREmp."Employment Date";
            "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
            "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
            "Job Title" := HREmp."Job Title";
            "Job ID" := HREmp."Job ID";
            "Job Description" := HREmp."Job Description";
            "User ID" := USERID;
            "Supervisor UserID" := HREmp."Supervisor Code";

            HREmp.Reset;
            HREmp.SetRange(HREmp."User ID", "Supervisor UserID");
            if HREmp.Find('-') then
                "Supervisor Employee No" := HREmp."No.";



            // IF HREmp."Appraisal Method" = HREmp."Appraisal Method"::"0" THEN
            // BEGIN
            //     //Default to value in HR Setup if not filled
            //    // "Appraisal Method":=HRSetup."Min. Leave App. Months";
            // END ELSE
            // BEGIN
            //     //Select appraisal from Employee PIF
            //     "Appraisal Method":=HREmp."Appraisal Method";
            // END;
            //End for 360

        end else begin
            Error('User ID' + ' ' + UserId + ' ' + 'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
        end;


        //Put the open appraisal period
        HRLookUpValues.RESET;
        HRLookUpValues.SETRANGE(HRLookUpValues.Type, HRLookUpValues.Type::"Appraisal Period");
        HRLookUpValues.SETRANGE(HRLookUpValues."Current Appraisal Period", true);
        IF HRLookUpValues.FIND('-') THEN BEGIN
            "Appraisal Period" := HRLookUpValues.Code;
            // "Appraisal Stage" := HRLookUpValues."Appraisal Stage";
            "Evaluation Period Start" := HRLookUpValues.From;
            "Evaluation Period End" := HRLookUpValues."To";
        END
        ELSE BEGIN
            ERROR('There are no open Current Appraisal Period, Please define one in HR Lookup Values');
        END;


    end;

    procedure PopulateTargets()
    var
        i: Integer;
        Employee: Record Employee;
        HRLookUpValue: Record "HR Lookup Values";
        HRAppraisalObjectives: Record "HR Appraisal Objectives";
        HRAppraisalLn: Record "HR Appraisal Line";
    begin

        HRAppraisalLn.Reset();
        HRAppraisalLn.SetRange("Appraisal No", "Appraisal No");
        HRAppraisalLn.SetRange("Entry Type", HRAppraisalLn."Entry Type"::Objectives);
        if not HRAppraisalLn.IsEmpty then
            if not Confirm('Sure to populate the targets, this will delete the existing ones?', false) then
                exit;

        if HRAppraisalLn.FindFirst() then
            HRAppraisalLn.DeleteAll();

        i := 1000;
        HRAppraisalObjectives.Reset();
        HRAppraisalObjectives.SetRange("Job ID", "Job ID");
        if HRAppraisalObjectives.FindSet() then begin
            repeat
                HRAppraisalLn.Init();
                HRAppraisalLn."Entry No" := i;
                HRAppraisalLn."Entry Type" := HRAppraisalLn."Entry Type"::Objectives;
                HRAppraisalLn."Appraisal No" := "Appraisal No";
                HRAppraisalLn.Pillar := HRAppraisalObjectives."Appraisal Pillar";
                HRAppraisalLn.Target := HRAppraisalObjectives.Target;
                HRAppraisalLn."Target in Figures" := HRAppraisalObjectives."Target in Figures";
                HRAppraisalLn."Key Value Driver" := HRAppraisalObjectives."Key Value Driver";
                HRAppraisalLn.Weight := HRAppraisalObjectives.Weight;
                HRAppraisalLn.Insert();
                i += 1000;
            until HRAppraisalObjectives.Next() = 0;
        end else
            Error('Targets have not been set for Job ID %1', "Job ID");

        HRLookUpValue.Reset();
        HRLookUpValue.SetRange(Type, HRLookUpValue.Type::"Appraisal Core Values");
        if HRLookUpValue.FindSet() then begin
            i := 1000;
            repeat
                HRAppraisalLn.Reset();
                HRAppraisalLn.SetRange("Appraisal No", "Appraisal No");
                HRAppraisalLn.SetRange("Entry Type", HRAppraisalLn."Entry Type"::Behaviors);
                HRAppraisalLn.SetRange("Core Value", HRLookUpValue.Description);
                if HRAppraisalLn.IsEmpty then begin
                    HRAppraisalLn.Init();
                    HRAppraisalLn."Entry No" := i;
                    HRAppraisalLn."Entry Type" := HRAppraisalLn."Entry Type"::Behaviors;
                    HRAppraisalLn."Appraisal No" := "Appraisal No";
                    HRAppraisalLn."Core Value" := HRLookUpValue.Description;
                    HRAppraisalLn.Insert();
                end;
                i += 1000;
            until HRLookUpValue.Next() = 0;
        end;

        Message('Targets have been updated successfully!');
    end;

    procedure IsSuperVisor(): Boolean
    begin
        exit("Supervisor UserID" = UserId);
    end;

    var
        HREmp: Record Employee;
        HRLookupValues: Record "HR Lookup Values";
        HRSetup: Record "HR Setup.";
        /*
        HRAppraisalGoalSettingH: Record hr appra UnknownRecord39003995;
        HRGoalSettingL: Record UnknownRecord39003996;
        HRGoalSettingLNext: Record UnknownRecord39003996;
        HRLookUpValues: Record "HR Lookup Values";
        LastAppraisal: Record UnknownRecord39003995;7*/
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        //HrRatings: Record UnknownRecord39003998;
        UserSetup: Record "User Setup";
        Approver: Record "User Setup";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;
        NoSeries: Codeunit "No. Series";

    procedure ValidateAppraisal()
    var
        HRAppraisalLn: Record "HR Appraisal Line";
    begin
        HRAppraisalLn.Reset();
        HRAppraisalLn.SetRange("Appraisal No", Rec."Appraisal No");
        if HRAppraisalLn.FindSet()
        then
            repeat
                if HRAppraisalLn."Entry Type" = HRAppraisalLn."Entry Type"::Objectives then begin

                end;
                if HRAppraisalLn."Entry Type" = HRAppraisalLn."Entry Type"::Behaviors then begin

                end;
            until HRAppraisalLn.Next() = 0;
    end;
}

