Page 50918 "HR Applicants UnQualified Card"
{
    PageType = Card;
    SourceTable = "HR Job Applications";
    SourceTableView = where(Qualified = const(false));

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
                field(JobAppliedforDescription; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Qualified; Rec.Qualified)
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

