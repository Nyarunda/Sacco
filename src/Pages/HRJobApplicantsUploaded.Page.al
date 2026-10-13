Page 51058 "HR Job Applicants Uploaded"
{
    DeleteAllowed = false;
    Description = 'HR Job Applicants Qualified Card';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Job Applications";
    SourceTableView = where(Uploaded = const(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(JobApplicationNo; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = true;
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
                field(EMail; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                }
                field(DateApplied; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field(JobAppliedforDescription; Rec."Job Applied for Description")
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

