Page 51063 "HR Employee Confirmation List"
{
    CardPageID = "HR Employee confirmation";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Confirmation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(RequestDate; Rec."Request Date")
                {
                    ApplicationArea = Basic;
                }
                field(ProbationStartDate; Rec."Probation Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(ProbationEndDate; Rec."Probation End Date")
                {
                    ApplicationArea = Basic;
                }
                field(ConfirmationDate; Rec."Confirmation Date")
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

