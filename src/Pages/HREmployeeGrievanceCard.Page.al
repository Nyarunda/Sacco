Page 50876 "HR Employee Grievance Card"
{
    PageType = Card;
    SourceTable = "HR Employee Grievance";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeFirstName; Rec."Employee First Name")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeLastName; Rec."Employee Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(DateOfGrievance; Rec."Date Of Grievance")
                {
                    ApplicationArea = Basic;
                }
                field(CauseOfGrievance; Rec."Cause Of Grievance")
                {
                    ApplicationArea = Basic;
                }
                field(ReleaseDate; Rec."Release Date")
                {
                    ApplicationArea = Basic;
                }
                field(FollowUpDate; Rec."Follow Up Date")
                {
                    ApplicationArea = Basic;
                }
                field(FollowUpCompleted; Rec."Follow Up Completed")
                {
                    ApplicationArea = Basic;
                }
                field(FollowUpDateActualDate; Rec."Follow Up Date (Actual Date)")
                {
                    ApplicationArea = Basic;
                }
                field(OutcomeOfGrievance; Rec."Outcome Of Grievance")
                {
                    ApplicationArea = Basic;
                }
                field(LetterSentToEmployee; Rec."Letter Sent To Employee")
                {
                    ApplicationArea = Basic;
                }
                field(LetterSentByWhom; Rec."Letter Sent By Whom")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;

                trigger OnAction()
                begin
                    Message('Send For Approval');
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Image = Approvals;
                Promoted = true;

                trigger OnAction()
                begin
                    Message('Approvals');
                end;
            }
            action("Cancel Approvals Request")
            {
                ApplicationArea = Basic;
                Image = Cancel;
                Promoted = true;

                trigger OnAction()
                begin
                    Message('Cancel Approval Request');
                end;
            }
        }
    }
}

