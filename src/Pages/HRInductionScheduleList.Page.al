Page 51055 "HR Induction Schedule List"
{
    CardPageID = "HR Induction Schedule Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Induction Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(InductionCode; Rec."Induction Code")
                {
                    ApplicationArea = Basic;
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(InductionDuration; Rec."Induction Duration")
                {
                    ApplicationArea = Basic;
                }
                field(InductionStartDate; Rec."Induction Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(InductionEndDate; Rec."Induction End Date")
                {
                    ApplicationArea = Basic;
                }
                field(HODNotified; Rec."HOD Notified?")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        "Induction`": Record "HR Staff  Induction";
        DepartmentName: Text[40];
        sDate: Date;
        Inductionschedule: Record "HR Staff  Induction";
        Number: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
        //ApprovalEntries: Page "Approval Entries";
        HRJobs: Record "HR Jobs";
        Department: Record "Dimension Value";


    procedure TESTFIELDS()
    begin

        //Inductionschedule.TestField(Inductionschedule."Global Dimension 1 Code");
        //Inductionschedule.TestField(Inductionschedule."Induction Start Date");
        //Inductionschedule.TestField(Inductionschedule."Induction End Date");
        //Inductionschedule.TestField(Inductionschedule."Induction Duration");
        //Inductionschedule.TESTFIELD(HRTrainingApplications.Duration);
        //Inductionschedule.TESTFIELD(HRTrainingApplications."Cost Of Training");
        //Inductionschedule.TESTFIELD(HRTrainingApplications.Location);
        //Inductionschedule.TESTFIELD(HRTrainingApplications.Provider);
        //Inductionschedule.TESTFIELD(Inductionschedule.Comments");
    end;


    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        Department.Reset;
        if Department.Get(Rec."Global Dimension 1 Code") then begin
            Rec."Global Dimension 2 Code" := Department.Name;
            //Department:=HREmp."Global Dimension 2";
            //"Job Title":=HREmp."Job Description";
            //END ELSE BEGIN
            //Department:='';
        end;

        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        /*HRJobs.RESET;
        IF HRJobs.GET("Job Title") THEN
        BEGIN
        "Job Title":=HRJobs."Job Description";
        END ELSE BEGIN
        "Job Title":='';
        END;
        */
        //GET THE APPROVER NAMES
        /*HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",Supervisor);
        IF HREmp.FIND('-') THEN
        BEGIN
        "Supervisor Name":=HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        END ELSE BEGIN
        "Supervisor Name":='';
        END;
        */

    end;


    procedure UpdateControls()
    begin

        /* IF Status=Status::New THEN BEGIN
         CurrForm."Application No".EDITABLE:=TRUE;
         CurrForm."User ID".EDITABLE:=TRUE;
         CurrForm."Staff Names".EDITABLE:=TRUE;
         CurrForm."Job Title".EDITABLE:=TRUE;
         CurrForm.Supervisor.EDITABLE:=TRUE;
         CurrForm."Supervisor Name".EDITABLE:=TRUE;
         CurrForm."Course Title".EDITABLE:=TRUE;
         CurrForm."Purpose of Training".EDITABLE:=TRUE;
         CurrForm.Status.EDITABLE:=TRUE;
         CurrForm."Employee No.".EDITABLE:=TRUE;
         CurrForm.Selected.EDITABLE:=TRUE;
         CurrForm.Recommendations.EDITABLE:=TRUE;
         CurrForm.Status.EDITABLE:=TRUE;
         CurrForm."Responsibility Center".EDITABLE:=TRUE;
         END ELSE BEGIN
         CurrForm."Application No".EDITABLE:=FALSE;
         CurrForm."User ID".EDITABLE:=FALSE;
         CurrForm."Staff Names".EDITABLE:=FALSE;
         CurrForm."Job Title".EDITABLE:=FALSE;
         CurrForm.Supervisor.EDITABLE:=FALSE;
         CurrForm."Supervisor Name".EDITABLE:=FALSE;
         CurrForm."Course Title".EDITABLE:=FALSE;
         CurrForm."Purpose of Training".EDITABLE:=FALSE;
         CurrForm.Status.EDITABLE:=FALSE;
         CurrForm."Employee No.".EDITABLE:=FALSE;
         CurrForm.Selected.EDITABLE:=FALSE;
         CurrForm.Recommendations.EDITABLE:=FALSE;
         CurrForm.Status.EDITABLE:=FALSE;
         CurrForm."Responsibility Center".EDITABLE:=FALSE;
         END;
         */

    end;


    procedure GetTrainingTypes("Course Title": Text[50])
    begin
    end;
}

