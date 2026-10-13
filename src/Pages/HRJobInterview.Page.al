Page 51048 "HR Job Interview"
{
    PageType = List;
    SourceTable = "HR Job Interview";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(InterviewCode; Rec."Interview Code")
                {
                    ApplicationArea = Basic;
                }
                field(InterviewDescription; Rec."Interview Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field(Interviewer; Rec.Interviewer)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(InterviewerName; Rec."Interviewer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action(HiringCriteria)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hiring Criteria';
                    Image = Agreement;
                    Promoted = true;
                    RunObject = Page "HR Hiring Criteria";
                    RunPageLink = "Application Code" = field("Applicant No");
                }
            }
        }
    }
}

