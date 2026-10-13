Page 50956 "HR Disciplinary Case Card Clsd"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Status,Show';
    SourceTable = "HR Disciplinary Cases NCA";
    SourceTableView = where("Disciplinary Stage Status" = filter(Closed));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CaseNumber; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateofComplaint; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccusedEmployee; Rec."Accused Employee")
                {
                    ApplicationArea = Basic;
                    ShowCaption = true;
                }
                field(AccusedEmployeeName; Rec."Accused Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(HeadofDepartment; Rec."Head of Department")
                {
                    ApplicationArea = Basic;
                }
                field(HeadofDepartmentName; Rec."Head of Department Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(TypeComplaint; Rec."Type Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(DescriptionofComplaint; Rec."Description of Complaint")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(SeverityOftheComplain; Rec."Severity Of the Complain")
                {
                    ApplicationArea = Basic;
                }
                field(DateofComplaintwasReported; Rec."Date of Complaint was Reported")
                {
                    ApplicationArea = Basic;
                }
                field(AccussedBy; Rec."Accussed By")
                {
                    ApplicationArea = Basic;
                }
                field(Reporter; Rec.Reporter)
                {
                    ApplicationArea = Basic;
                }
                field(ReporterName; Rec."Reporter Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NonEmployeeReporter; Rec."Non Employee Reporter")
                {
                    ApplicationArea = Basic;
                }
                field(Witness1; Rec."Witness #1")
                {
                    ApplicationArea = Basic;
                }
                field(Witness1Name; Rec."Witness #1 Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Witness2; Rec."Witness #2")
                {
                    ApplicationArea = Basic;
                }
                field(Witness2Name; Rec."Witness #2  Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateToDiscussCase; Rec."Date To Discuss Case")
                {
                    ApplicationArea = Basic;
                }
                field(BodyHandlingTheComplaint; Rec."Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(BodyHandlingName; Rec."Body Handling Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ModeofLodgingtheComplaint; Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(PolicyGuidlinesInEffect; Rec."Policy Guidlines In Effect")
                {
                    ApplicationArea = Basic;
                }
                field(PolicyDescription; Rec."Policy Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RecommendedAction; Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                    Editable = RecommendedActionEditable;
                }
                field(RecommendedActionDescription; Rec."Recommended Action Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DisciplinaryStageStatus; Rec."Disciplinary Stage Status")
                {
                    ApplicationArea = Basic;
                }
                field(Appealed; Rec.Appealed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(ActionInformation)
            {
                Caption = 'Action Information';
                field(ActionTaken; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(TakenActionDescription; Rec."Taken Action Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DisciplinaryRemarks; Rec."Disciplinary Remarks")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    MultiLine = true;
                }
                field("Investigation Findings"; Rec.Comments)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(ReviewFindings; Rec."Review Findings")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(ActionDurationStartDate; Rec."Action Duration Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(ActionDurationEndDate; Rec."Action Duration End  Date")
                {
                    ApplicationArea = Basic;
                }
                field(InterdictEmployee; Rec."Interdict Employee")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755038; "HR Disciplinary Cases Factbox")
            {
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = field("Case Number");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Case Status")
            {
                action(Appeal)
                {
                    ApplicationArea = Basic;
                    Caption = ' Appeal';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin

                        if Rec.Appealed = true then begin
                            Error('A case can only be Appealed once');
                        end;

                        if Confirm('Are you sure you want to mark this case as "Under Review?"') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::"Under review";
                            Rec.Appealed := true;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Under Review"', Rec."Case Number");
                        end;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    /*trigger OnAction()
                    begin
                        DiscCase.Reset;
                        DiscCase.SetRange(DiscCase."Case Number","Case Number");
                        if DiscCase.Find('-') then
                        Report.Run(Report::"HR Disciplinary Cases",true,true,DiscCase);
                    end;*/
                }
                action("Post to Payroll")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //MESSAGE('yes');
                        //IF Status=Status::Approved THEN BEGIN
                        /*if ("Disciplinary Stage Status"="disciplinary stage status"::Closed)
                          or ("Disciplinary Stage Status"="disciplinary stage status"::"closed by court") then
                          begin
                            salCard.Reset;
                            salCard.SetRange(salCard."Employee Code", "Accused Employee");
                            if salCard.Find('-') then begin
                              salCard."Suspend Pay":=true;
                              salCard."Suspension Date":=Today;
                              salCard."Suspension Reasons":="Type Complaint";
                              salCard.Modify;
                              Message('Successful')
                              end;
                          end;*/
                        //END;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        RecommendedActionEditable := true;
        ActionTakenEditable := true;
        DisciplinaryRemarksEditable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
        RecommendedActionEditable: Boolean;
        ActionTakenEditable: Boolean;
        DisciplinaryRemarksEditable: Boolean;
    //DiscCase: Record UnknownRecord52018696;
    //salCard: Record UnknownRecord39004030;


    procedure UpdateControls()
    begin
        /*
        IF DiscCase.Status=DiscCase.Status::New THEN
        BEGIN
          RecommendedActionEditable:=FALSE;
          ActionTakenEditable:=FALSE;
          DisciplinaryRemarksEditable:=FALSE;
        END;
        
        IF DiscCase.Status=DiscCase.Status::Approved  THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
        END;
        
        IF DiscCase.Status=DiscCase.Status::"Pending Approval"  THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
        END;
        */

    end;
}

