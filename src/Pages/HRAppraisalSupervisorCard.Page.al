Page 51033 "HR Appraisal Supervisor Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";
    SourceTableView = where(Status = const("Pending Approval"));

    layout
    {
        area(content)
        {
            group("HR Appraisal Header")
            {
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
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(AppraisalMethod; Rec."Appraisal Method")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        //Testfields
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Appraisal Method");

                        /*if Confirm(Text0003, false, "Appraisal Method") = false then begin
                            Error('Process aborted, Press F5 to discard changes');
                        end else begin
                            //Delete Lines
                            HRAppLines.Reset;
                            HRAppLines.SetRange(HRAppLines."Appraisal No", "Appraisal No");
                            HRAppLines.SetRange(HRAppLines."Appraisal Period", "Appraisal Period");
                            HRAppLines.SetRange(HRAppLines."Employee No", "Employee No");
                            if HRAppLines.Find('-') then begin
                                HRAppLines.DeleteAll;
                                //Subpage Visibility
                                fn_ShowSubPages;
                            end;

                        end;Rec.*/
                    end;
                }
                field(AppraisalStage; Rec."Appraisal Stage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
            }
            part(PersonalObjectives; "HR 360 Appraisal Lines - PG")
            {
                ShowFilter = false;
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Appraisal Period" = field("Appraisal Period"),
                              "Employee No" = field("Employee No");
            }
            part("Self Appraisal"; "HR 360 Appraisal Lines - JS")
            {
                Caption = 'Self Appraisal';
                ShowFilter = false;
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Appraisal Period" = field("Appraisal Period"),
                              "Employee No" = field("Employee No");
            }
            part("Qualitative Appraisal"; "HR Qualitative Appraisal Line")
            {
                Caption = 'Qualitative Appraisal';
                ShowFilter = false;
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Employee No" = field("Employee No"),
                              "Appraisal Period" = field("Appraisal Period");
            }
            part(PeerObjectives; "HR 360 Appraisal Lines - EP")
            {
                ShowFilter = false;
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Appraisal Period" = field("Appraisal Period"),
                              "Employee No" = field("Employee No");
                Visible = SubPageVisible;
            }
            part(ExternalSourcesObjectives; "HR 360 Appraisal Lines - ExS")
            {
                ShowFilter = false;
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Appraisal Period" = field("Appraisal Period"),
                              "Employee No" = field("Employee No");
                Visible = SubPageVisible;
            }
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
                action("Load Appraisal Sections")
                {
                    ApplicationArea = Basic;
                    Image = CreateInteraction;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("Job Title");
                        Rec.TestField(Status, Rec.Status::Open);
                        // TestField("Appraisal Stage", "appraisal stage"::"Target Setting");


                        /*if Confirm(Text0001, false) = false then exit;

                        //Job Specific
                        HRAppEvalAreas.Reset;
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."categorize as"::"Job Specific");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Assign To", "Job Title");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", "Appraisal Period");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas.Blocked, false);
                        if HRAppEvalAreas.Find('-') then begin
                            HRAppLines.Reset;
                            HRAppLines.SetRange(HRAppLines."Appraisal No", "Appraisal No");
                            HRAppLines.SetRange(HRAppLines."Appraisal Period", "Appraisal Period");
                            HRAppLines.SetRange(HRAppLines."Employee No", "Employee No");
                            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."categorize as"::"Job Specific");
                            if HRAppLines.Find('-') then begin
                                HRAppLines.DeleteAll;
                                fn_LoadSections;
                            end else begin
                                fn_LoadSections;
                            end;
                        end else begin
                            //if no sections are found
                            Error(Text0002, "Job Title", "Appraisal Period");
                        end;
                        */

                        //360 Sections
                        /*case "Appraisal Method" of
                            "appraisal method"::"360 Appraisal":
                                begin
                                    fn_Load360Sections;
                                end;
                        end;Rec.*/
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
                        //TESTFIELD("Appraisal Stage","Appraisal Stage"::"Target Setting");
                        if Confirm('Send to supervisor?', false) = false then exit;

                        Rec.Status := Rec.Status::"Pending Approval";
                        Message('Appraisal sent to supervisor');
                    end;
                }
                action(ReturnAppraisee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Appraisee';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        if Confirm('Return to appraisee?', false) = false then exit;
                        Rec.Status := Rec.Status::Open;

                        Message('Appraisal returned to appraisee');
                    end;
                }
                action(ReturnSupervisor)
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
                }
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

                        Rec.Status := Rec.Status::Approved;

                        Message('Appraisal targets approved');
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
            // Error('No appraisal period have been defined');
        end;
    end;

    var
        /* HRAppEvalAreas: Record UnknownRecord39003997;
        HRAppLines: Record UnknownRecord39003996;
        Text0001: label 'Load Appraisal Sections?. \\NB: Existing Lines will be deleted';
        HRAppLines2: Record UnknownRecord39003996;
        HREmp: Record Employee;
        HREmpCard: Page "HR Employee Card";
        HRAppHeader: Record UnknownRecord39003995;Rec.*/
        Text0002: label 'No job specific sections for [Job ID: %1] are defined for the appraisal period %2';
        LastLineNo: Integer;
        HRJobResp: Record "HR Job Responsiblities";
        HRSetup: Record "HR Setup.";
        HREmp2: Record Employee;
        SubPageVisible: Boolean;
        Text0003: label 'Change Appraisal Method to [%1]? \\NB: Existing Lines will be deleted';
        HRLookupVal: Record "HR Lookup Values";


    procedure enableDisable() enableDisable: Boolean
    begin
        enableDisable := false;
    end;


    procedure fn_LoadSections()
    begin
        //Load Job Specific Evaluation Sections

        /*repeat
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
        until HRAppEvalAreas.Next = 0;Rec.*/
    end;


    /*procedure fn_Load360Sections()
    begin

        //Employee's Subordinates
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

        //Employee's Peers
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
    end;Rec.*/


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

