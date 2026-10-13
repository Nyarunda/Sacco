Page 51023 "HR 360 Appraisal Card"
{
    ApplicationArea = All;
    PageType = Card;
    Caption = 'Balance Score Card';
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";
    layout
    {
        area(content)
        {
            group("HR Appraisal Header")
            {
                Editable = Rec."Appraisal Stage"=Rec."Appraisal Stage"::Appraisee;

                field(AppraisalNo; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(AppraisalDate; Rec."Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorEmployeeNo; Rec."Supervisor Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorName; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SupervisorJobTitle; Rec."Supervisor Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SupervisorUserID; Rec."Supervisor UserID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AppraisalPeriod; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(EvaluationPeriodStart; Rec."Evaluation Period Start")
                {
                    ApplicationArea = Basic;
                }
                field(EvaluationPeriodEnd; Rec."Evaluation Period End")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalStage; Rec."Appraisal Stage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }

                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Personal Development")
            {
                Editable = Rec."Appraisal Stage"=Rec."Appraisal Stage"::Appraisee;
                field("Traninig Attended"; Rec."Traninig Attended")
                {
                    ApplicationArea = Basic;
                }
                field("Areas of Achievement"; Rec."Areas of Achievement")
                {
                    ApplicationArea = Basic;
                }
                field("Training Required"; Rec."Training Required")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Performance Indicator"; Rec."Expected Performance Indicator")
                {
                    ApplicationArea = Basic;
                }
                field("Resources Required"; Rec."Resources Required")
                {
                    ApplicationArea = Basic;
                }

            }
            group(Supervisor)
            {
                Editable = IsASuperVisor;
                field("Team Leaders Comments"; Rec."Team Leaders Comments")
                {
                    ApplicationArea = Basic;
                }
            }
            part("HR Appraisal Objectives"; "HR Appraisal Objectives")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
            }
            part("HR Appraisal Behaviors"; "HR Appraisal Behaviours")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
            }

            /*
            part("Training/Development";Rec."HR Appraissal Training")
            {
                Caption = 'Training/Development';
                ShowFilter = false;
                SubPageLink = "Employee No." = field("Employee No"),
                              "Appraisal No." = field("Appraisal No"),
                              "Appraissal Period" = field("Appraisal Period");
                Visible = SubPageVisible;
            }
            */

        }
        area(factboxes)
        {
            systempart(Control43; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1000000008)
            {
                Caption = 'Functions';
                action(PopulateTargets)
                {
                    ApplicationArea = Basic;
                    Caption = 'Populate Targets';
                    Image = FileContract;
                    Promoted = true;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    begin
                        Rec.PopulateTargets();
                    end;

                }
                action(SendSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to Supervisor';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Appraisal Stage", Rec."Appraisal Stage"::Appraisee);
                        Rec.TestField("User ID", UserId);
                        Rec.ValidateAppraisal();
                        if Confirm('Send to supervisor?', false) = false then exit;

                        Rec."Appraisal Stage" := Rec."Appraisal Stage"::Supervisor;
                        Rec.Status := Rec.Status::"Pending Approval";
                        Rec.Modify();
                        Message('Appraisal sent to supervisor');
                    end;
                }
                /*  action(ReturnAppraisee)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Return to Appraisee';
                      Image = ReopenCancelled;
                      Promoted = true;
                      PromotedCategory = Category5;

                      trigger OnAction()
                      begin
                          TestField(Status, Status::"Pending Approval");

                          if Confirm('Return to appraisee?', false) = false then exit;
                          Rec.Status := Rec.Status::Open;

                          Message('Appraisal returned to appraisee');
                      end;
                  }*/
                /*action(ReturnSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Supervisor';
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Confirm('Return to supervisor?', false) = false then exit;

                        Rec.Status := Rec.Status::"Pending Approval";
                        Message('Appraisal returned to supervisor');
                    end;
                }*/
                action(ApproveTargets)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve Targets';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Confirm('Approve targets?', false) = false then exit;
                        Rec.TestField("Appraisal Stage", Rec."Appraisal Stage"::Supervisor);
                        Rec.TestField("Supervisor UserID", UserId);
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();

                        Message('Appraisal targets approved');
                    end;
                }
                action(MarkAsCompleted)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Completed';
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Confirm('Mark Completed?', false) = false then exit;

                        Rec.TestField("Appraisal Stage", Rec."Appraisal Stage"::Supervisor);
                        Rec.TestField("Supervisor UserID", UserId);
                        Rec."Appraisal Stage" := Rec."Appraisal Stage"::Completed;
                        Rec.Modify();

                        Message('Appraisal Completed');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*
      //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
      HREmp.RESET;
      IF HREmp.GET("Employee No") THEN
      BEGIN
          "Employee Name":=HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
          "Date of Employment":=HREmp."Date Of Join";
          "Global Dimension 1 Code":=HREmp."Dimension 1 Code";
          "Global Dimension 2 Code":=HREmp."Dimension 2 Code";
          "Job Title":=HREmp."Job ID";
          "Contract Type":= HREmp."Contract Type" ;
          "User ID":=HREmp."User ID";
          //Supervisor
          //Supervisor:=HREmpCard.GetSupervisor("User ID");
          //Superisor ID
          //"Supervisor ID":=HREmpCard.GetSupervisorID("User ID");
          HREmp.CALCFIELDS(HREmp.Picture);
          Picture:=HREmp.Picture;


      END ELSE
      BEGIN
          ERROR('Employee No'+' '+"Employee No"+' '+'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
      END;


         */
        //Show Hide Subpages

        fn_ShowSubPages;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Insert current appraisal period
        HRLookupVal.Reset;
        HRLookupVal.SetRange(HRLookupVal.Type, HRLookupVal.Type::"Appraisal Period");
        if HRLookupVal.Find('-') then begin
            Rec."Appraisal Period" := HRLookupVal.Code;
        end else begin
            Error('No appraisal period have been defined');
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        IsASuperVisor := Rec.IsSuperVisor()
    end;

    var
        //HRAppEvalAreas: Record UnknownRecord39003997;
        //HRAppLines: Record UnknownRecord39003996;
        Text0001: label 'Load Appraisal Sections?. \\NB: Existing Lines will be deleted';
        //HRAppLines2: Record UnknownRecord39003996;
        HREmp: Record Employee;
        //HREmpCard: Page "HR Employee Card";
        //HRAppHeader: Record UnknownRecord39003995;
        Text0002: label 'No job specific sections for [Job ID: %1] are defined for the appraisal period %2';
        LastLineNo: Integer;
        HRJobResp: Record "HR Job Responsiblities";
        HRSetup: Record "HR Setup.";
        HREmp2: Record Employee;
        SubPageVisible: Boolean;
        Text0003: label 'Change Appraisal Method to [%1]? \\NB: Existing Lines will be deleted';
        HRLookupVal: Record "HR Lookup Values";
        IsASuperVisor: Boolean;


    procedure enableDisable() enableDisable: Boolean
    begin
        enableDisable := false;
    end;


    procedure fn_LoadSections()
    begin
        //Load Job Specific Evaluation Sections

        /*
        repeat
            //Get last no.
            HRAppLines2.Reset;
            if HRAppLines2.Find('+') then begin
                LastLineNo := HRAppLines2."Line No";
            end else begin
                LastLineNo := 1;
            end;
            HRAppLines.Init;
            HRAppLines."Line No" := LastLineNo + 1;
            HRAppLines."Appraisal No" := "Appraisal No";
            HRAppLines."Appraisal Period" := "Appraisal Period";
            HRAppLines."Employee No" := "Employee No";
            HRAppLines."Categorize As" := HRAppEvalAreas."Categorize As";
            HRAppLines."Sub Category" := HRAppEvalAreas."Sub Category";
            HRAppLines."Perfomance Goals and Targets" := HRAppEvalAreas.Description;
            HRAppLines."Unit of Measure" := HRAppEvalAreas."Unit of Measure";
            HRAppLines.Insert;
        until HRAppEvalAreas.Next = 0;
        */
    end;


    procedure fn_Load360Sections()
    begin

        //Employee's Subordinates
        /*
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."categorize as"::"Employee's Subordinates");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", "Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", "Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", "Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", "Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."categorize as"::"Employee's Subordinates");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;
        */

        //Employee's Peers
        /*
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."categorize as"::"Employee's Peers");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", "Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", "Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", "Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", "Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."categorize as"::"Employee's Peers");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;


        //External Sources (Vendors and Customers)
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."categorize as"::"External Sources");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", "Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", "Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", "Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", "Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."categorize as"::"External Sources");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;
        */
    end;


    procedure fn_ShowSubPages()
    begin
        //Visbility of Subpages
        if Rec."Appraisal Method" <> Rec."appraisal method"::"360 Appraisal" then begin
            SubPageVisible := false;
        end else begin
            SubPageVisible := true;
        end;
    end;
}

