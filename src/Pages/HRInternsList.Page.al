/*
Page 51125 "HR Interns List"
{
    CardPageID = "HR Interns Card";
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = UnknownEmployee;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(FullName; "Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(Sex; Sex)
                {
                    ApplicationArea = Basic;
                }
                field(Institution; Institution)
                {
                    ApplicationArea = Basic;
                }
                field(CourseUndertaken; "Course Undertaken")
                {
                    ApplicationArea = Basic;
                }
                field(Specialization; Specialization)
                {
                    ApplicationArea = Basic;
                }
                field(PostingStatus; "Posting Status")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //StyleText:=HRCodeunit.fn_SetStyle(FORMAT("Posting Status"));
    end;

    var
        StyleText: Text;
        HRCodeunit: Codeunit "HR Codeunit.";
}

*/