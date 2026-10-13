Table 50088 "HR Training Feedback Form"
{
    //DrillDownPageID = UnknownPage39005542;
    //LookupPageID = UnknownPage39005542;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                HRSetup.Get;
                NoSeries.TestManual(HRSetup."Back To Office Nos");
                "No. Series" := '';
            end;
        }
        field(2; "Course Title"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Training App Header"."Course Title" where(Status = const(Approved));

            trigger OnValidate()
            begin
                HRTrainApp.Reset;
                HRTrainApp.SetRange(HRTrainApp."Course Title", "Course Title");
                if HRTrainApp.Find('-') then
                    Description := HRTrainApp."Course Description";
                "From Date" := HRTrainApp."Actual Start Date";
                "To Date" := HRTrainApp."Actual End Date";
                //Duration:=HRTrainApp."Actual Duration";
                "Cost Of Training" := HRTrainApp."Training Cost Cstimated";
                Location := HRTrainApp."Training Venue";
                Provider := HRTrainApp."Training Institution Name";
                //"Provider Name" := HRTrainingNeeds."External Provider Name";
                "Training Status" := HRTrainApp."Training Status";
                //"Employee No.":=HRTrainApp."Employee No.";
                //"Employee Name":=HRTrainApp."Employee Names";
                Department := HRTrainApp."Global Dimension 1 Code";






                /*
                HRTrainingNeeds.RESET;
                HRTrainingNeeds.SETRANGE(HRTrainingNeeds.Code,"Course Title");
                IF HRTrainingNeeds.GET("Course Title") THEN
                //"Course Title":=HRTrainingNeeds.Code;
                Description:=HRTrainingNeeds.Description;
                "From Date":=HRTrainingNeeds."Start Date";
                "To Date":=HRTrainingNeeds."End Date";
                //"Duration Units":=HRTrainingNeeds.Duration;
                //Duration:=HRTrainingNeeds.Duration;
                "Cost Of Training":=HRTrainingNeeds.Costs;
                Location:=HRTrainingNeeds.Location;
                Provider:=HRTrainingNeeds.Provider;
                "Provider Name":=HRTrainingNeeds."Provider Name";
                "Training Status":=HRTrainingNeeds.Status;
                
                
                //"No of Required Participants":=HRTrainingNeeds."No of Participants Required";
                
                HRTrainingNeeds.SETRANGE(HRTrainingNeeds.Code,"Course Title");
                //IFTraining category"<> "Training category"::Group THEN
                
                //  ERROR(mcontent3);
                */

            end;
        }
        field(3; "From Date"; Date)
        {
            Editable = true;
        }
        field(4; "To Date"; Date)
        {
            Editable = true;
        }
        field(5; "Duration Units"; Option)
        {
            Editable = true;
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(6; Duration; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin

                begin
                    if (Duration <> 0) and ("From Date" <> 0D) then
                        //"To Date" :=HRTrainApp.DetermineLeaveReturnDate("From Date",Duration);
                        Modify;
                end;
            end;
        }
        field(7; "Cost Of Training"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = true;
        }
        field(8; Location; Text[30])
        {
            Editable = true;
        }
        field(12; Description; Text[250])
        {
            Editable = true;
        }
        field(28; "Training Evaluation Results"; Option)
        {
            OptionMembers = "Not Evaluated",Passed,Failed;

            trigger OnValidate()
            begin
                if "Training Status" <> "training status"::"Completed Successfully" then
                    Error(mcontent4);
            end;
        }
        field(30; Provider; Code[20])
        {
            Editable = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", Provider);
                if Vend.Find('-') then begin
                    "Provider Name" := Vend.Name;
                end;
            end;
        }
        field(31; "Purpose of Training"; Text[100])
        {
        }
        field(32; Status; Option)
        {
            Editable = true;
            OptionCaption = 'New,Pending Approval,Approved,Rejected.';
            OptionMembers = New,"Pending Approval",Approved,"Rejected.";
        }
        field(33; "Employee No."; Code[10])
        {
            NotBlank = false;
            TableRelation = eMPLOYEE."No.";

            trigger OnValidate()
            begin
                if "Training category" <> "training category"::Group then begin
                    HREmp.Get("Employee No.");
                    Directorate := HREmp."Department";
                    "Employee Name" := HREmp.FullName;
                end;
            end;
        }
        field(36; "No. Series"; Code[10])
        {
        }
        field(40; "User ID"; Code[50])
        {
        }
        field(41; "Responsibility Center"; Code[10])
        {
            //TableRelation = "Responsibility Center B".Code;
        }
        field(42; Directorate; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Directorate);
                if Dimn.Find('-') then begin
                    "Directorate Name" := Dimn.Name;
                end;
            end;
        }
        field(43; "Employee Name"; Text[50])
        {
        }
        field(44; "Provider Name"; Text[50])
        {
        }
        field(45; "Training category"; Option)
        {
            OptionCaption = 'Individual,Group';
            OptionMembers = Individual,Group;
        }
        field(46; "Table ID"; Integer)
        {
        }
        field(47; Supervisor; Code[50])
        {
        }
        field(48; "Supervisor Name"; Text[100])
        {
        }
        field(50000; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Department);
                if Dimn.Find('-') then begin
                    "Department Name" := Dimn.Name;
                end;

                /*
                HREmp.RESET;
                HREmp.SETRANGE(HREmp."No.","Employee No.");
                HREmp.SETRANGE(HREmp."Department Code",Directorate);
                HREmp.SETRANGE(HREmp.County,Department);
                IF HREmp.FIND() THEN BEGIN
                IF TranPart.GET("Document No")THEN BEGIN
                 TranPart.INIT;
                 TranPart."Employee Code":=HREmp."No.";
                 TranPart."Employee name":=HREmp."First Name"+'-'+HREmp."Middle Name"+'-'+HREmp."Last Name";
                 TranPart.INSERT;
                END;
                END;
                */

            end;
        }
        field(50002; Branch; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Branch);
                if Dimn.Find('-') then begin
                    "Branch Name" := Dimn.Name;
                end;
            end;
        }
        field(50003; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50005; "Training Status"; Option)
        {
            OptionCaption = ' ,Suspended,Deferred,Cancelled,Completed Successfully';
            OptionMembers = " ",Suspended,Deferred,Cancelled,"Completed Successfully";

            trigger OnValidate()
            begin
                if Status <> Status::Approved then
                    Error(mcontent5);
            end;
        }
        field(50006; "Text 1"; Text[200])
        {
        }
        field(50007; "Text 2"; Text[200])
        {
        }
        field(50008; "Text 3"; Text[200])
        {
        }
        field(50009; "Text 4"; Text[200])
        {
        }
        field(50010; "Text 5"; Text[200])
        {
        }
        field(50011; "Text 6"; Text[200])
        {
        }
        field(50012; "Text 9"; Text[200])
        {
        }
        field(50013; "Text 10"; Text[200])
        {
        }
        field(50014; "Department Name"; Text[50])
        {
        }
        field(50015; "Branch Name"; Text[50])
        {
        }
        field(50016; "Directorate Name"; Text[50])
        {
        }
        field(50017; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50018; "Training Application No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Employee No." <> xRec."Employee No." then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Training Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
        key(Key2; "Course Title")
        {
            Enabled = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*IF Status <> Status::New THEN
        ERROR(mcontent);
        */

    end;

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Back To Office Nos");
            "Document No" := NoSeries.GetNextNo(HRSetup."Back To Office Nos", WorkDate(), true);
        end;

        "User ID" := UserId;


        "Table ID" := Database::Employee;
        "User ID" := UserId;

        if "Training category" <> "training category"::Group then begin
            //TESTFIELD("Employee No.");
            HREmp.Reset;
            //HREmp.SETRANGE(HREmp."User ID",USERID);
            /*
            IF HREmp.FIND('-') THEN BEGIN
            "Employee No.":=HREmp."No.";
            HREmp.GET(HREmp."No.");
            "Employee Name":=HREmp."Full Name";

            "User ID":=USERID;
            END ELSE BEGIN
            ERROR('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee')
            END;
            */

        end;

        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            Supervisor := UserSetup."Approver ID";
            UserSetup.Reset;
            if UserSetup.Get(Supervisor) then
                "Supervisor Name" := UserSetup."E-Mail";
        end;

    end;

    trigger OnModify()
    begin
        //CALCFIELDS("Occupied Positions");
        //IF "Occupied Positions">0 THEN
        //ERROR('Cannot modify job if it has occupants');
        //IF Status <> Status::New THEN
        //ERROR(mcontent2);
    end;

    var
        HRTrainingNeeds: Record "HR Job Training Needs";
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        mcontent: label 'Status must be new on Training Application No.';
        mcontent2: label 'You cannot modify approved request, Please cancel the approval request and try again';
        HREmp: Record Employee;
        Vend: Record "Savings Accounts";
        UserSetup: Record "User Setup";
        mcontent3: label 'Training category must be ''Group'' to allow for training application';
        HRTrainApp: Record "HR Training App Header";
        mcontent4: label 'You cannot evaluate a training which is not successfully completed.';
        mcontent5: label 'You cannot change training status if the status is not approved';
        Dimn: Record "Dimension Value";
}

