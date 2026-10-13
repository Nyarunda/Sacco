Page 51020 "HR 360 Appraisals List"
{
    ApplicationArea = All;
    CardPageID = "HR 360 Appraisal Card";// "HR Appraisal Supervisor Card";
    Caption = 'Appraisal Balance Score Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";
    SourceTableView = where("Appraisal Stage" = const(Appraisee));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AppraisalNo; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalType; Rec."Appraisal Type")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalPeriod; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalStage; Rec."Appraisal Stage")
                {
                    ApplicationArea = Basic;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control26; Outlook)
            {
            }
            systempart(Control27; Notes)
            {
            }
            systempart(Control28; MyNotes)
            {
            }
            systempart(Control29; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1000000004)
            {
                Caption = 'Functions';
                action(ReturnAppraisee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Appraisee';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        //TestField("Appraisal Stage", "appraisal stage"::"Target Approval");

                        if Confirm('Return to appraisee?', false) = false then exit;

                        // "Appraisal Stage" := "appraisal stage"::"Target Setting";
                        Rec.Modify;
                        Message('Appraisal returned to appraisee');
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
                        // TestField("Appraisal Stage", "appraisal stage"::"Target Approval");
                        Rec.TestField("Employee No");

                        if Confirm('Approve targets?', false) = false then exit;

                        // "Appraisal Stage" := "appraisal stage"::"End Year Evalauation";
                        // Modify;
                        // Message('Appraisal targets approved');
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(-1);
        Rec.SetFilter("User ID", UserId);
        Rec.SetFilter("Supervisor UserID", UserId);
        Rec.SetRange("Appraisal Stage", Rec."Appraisal Stage"::Appraisee);
        If Rec.FindSet() then
            Repeat
                Rec.Mark(true);
            until Rec.Next() = 0;
        Rec.MarkedOnly(true);
    end;
}

