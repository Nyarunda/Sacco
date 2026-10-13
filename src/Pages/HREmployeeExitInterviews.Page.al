Page 50992 "HR Employee Exit Interviews"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Exit Interview';
    SourceTable = "HR Employee Exit Interviews";
    SourceTableView = where(Status = filter(<> Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ExitInterviewNo; Rec."Exit Interview No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateOfInterview; Rec."Date Of Interview")
                {
                    ApplicationArea = Basic;
                }
                field(InterviewDoneBy; Rec."Interview Done By")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ReasonForLeaving; Rec."Reason For Leaving")
                {
                    ApplicationArea = Basic;
                }
                field(ReasonForLeavingOther; Rec."Reason For Leaving (Other)")
                {
                    ApplicationArea = Basic;
                }
                field(DateOfLeaving; Rec."Date Of Leaving")
                {
                    ApplicationArea = Basic;
                }
                field(ReEmployInFuture; Rec."Re Employ In Future")
                {
                    ApplicationArea = Basic;
                }
                field("What did you enjoy most?"; Rec."What did you enjoy most?")
                {
                    ApplicationArea = Basic;
                }
                field("What did you dislike?"; Rec."What did you dislike?")
                {
                    ApplicationArea = Basic;
                }
                field("Do you think you were equipped"; Rec."Do you think you were equipped")
                {
                    ApplicationArea = Basic;
                }
                field("If no what was not given?"; Rec."If no what was not given?")
                {
                    ApplicationArea = Basic;
                }
                field("Did your job align to you?"; Rec."Did your job align to you?")
                {
                    ApplicationArea = Basic;
                }
                field("How was the working relationship?"; Rec."How was the working relationship?")
                {
                    ApplicationArea = Basic;
                }

                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(FormSubmitted; Rec."Form Submitted")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(SF; "Misc. Article Information List")
            {
                Caption = 'Allocated Assets';
                SubPageLink = "Employee No." = field("Employee No.");
                SubPageView = where("In Use" = filter(true));
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755010; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ExitInterview)
            {
                Caption = '&Exit Interview';
                action("Close Interview")
                {
                    ApplicationArea = Basic;
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField("Form Submitted");
                        Rec.TestField("Reason For Leaving");
                        Rec.TestField("Employee No.");


                        if Confirm(Text001, true) = false then exit;

                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."Employee No.");
                        if HREmp.Find('-') then begin
                            /*HREmp."Date Of Leaving the Company" := "Date Of Leaving";
                            HREmp."Termination Category" := "Reason For Leaving";
                            HREmp."Exit Interview Date" := "Date Of Interview";
                            HREmp."Exit Interview Done by" := "Interview Done By";
                            HREmp."Allow Re-Employment In Future" := "Re Employ In Future";*/
                            HREmp.Status := HREmp.Status::InActive;
                            HREmp.Modify;
                            Rec.Closed := true;
                        end;
                    end;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    //ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    ////CustomApprovals: Codeunit UnknownCodeunit39004245;
                    begin

                        VarVariant := Rec;
                        /*//if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            //CustomApprovals.OnSendDocForApproval(VarVariant);*/
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    //ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    ////CustomApprovals: Codeunit UnknownCodeunit39004245;
                    begin
                        VarVariant := Rec;
                        ////CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*
       IF HREmp.GET(Dependants) THEN BEGIN
       JobTitle:=HREmp."Job Title";
       sUserID:=HREmp."User ID";
       END ELSE BEGIN
       JobTitle:='';
       sUserID:='';
       END;


       SETRANGE(Dependants);
       DAge:='';
       DService:='';
       DPension:='';
       DMedical:='';

       RecalcDates;
            */

        UpdateControls;

    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        JobTitle: Text[30];
        Supervisor: Text[60];
        HREmp: Record Employee;
        //Dates: Codeunit "HR Codeunit";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        // HREmpForm: Page "HR Employee Card";
        sUserID: Code[30];
        //DoclLink: Record "HR Company Attachments";
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        D: Date;
        Misc: Record "Misc. Article Information";
        Text19062217: label 'Misc Articles';
        Text001: label 'Closing this interview will deactivate the employee. Do you want to continue?';
        Text002: label 'Exit interview successfully closed.';
        VarVariant: Variant;


    procedure RecalcDates()
    begin
    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        /*
       CurrPage.SAVERECORD;
       FILTERGROUP := 2;
       //Misc.SETRANGE(Misc."Employee No.",Dependants);
       FILTERGROUP := 0;
       IF Misc.FIND('-') THEN;
       CurrPage.UPDATE(FALSE);
         */

    end;


    procedure UpdateControls()
    begin
        if Rec.Closed then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;
}

