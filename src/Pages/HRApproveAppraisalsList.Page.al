Page 51138 "HR Approve Appraisals List"
{
    ApplicationArea = All;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";

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
            group(Appraisal)
            {
                Caption = 'Appraisal';
                action(SendSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to Supervisor';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        //  TestField("Appraisal Stage", "appraisal stage"::"Target Setting");
                        Rec.TestField("Employee No");

                        if Confirm('Send to supervisor?', false) = false then exit;

                        //  "Appraisal Stage":="appraisal stage"::"Target Approval";
                        Rec.Modify;
                        Message('Appraisal sent to supervisor');
                    end;
                }
            }
        }
    }
}

