Page 50917 "HR Applicants Qualified Card"
{
    PageType = Card;
    SourceTable = "HR Job Applications";
    SourceTableView = where(Qualified = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(JobApplicationNo; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(JobAppliedFor; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                }
                field(DateofInterview; Rec."Date of Interview")
                {
                    ApplicationArea = Basic;
                }
                field(FromTime; Rec."From Time")
                {
                    ApplicationArea = Basic;
                }
                field(ToTime; Rec."To Time")
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                }
                field(InterviewType; Rec."Interview Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

