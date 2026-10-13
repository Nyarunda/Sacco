Page 50866 "HR Employee Kin"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(EmployeeDetails)
            {
                Caption = 'Employee Details';
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
                field(PostCode; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                    Visible = false;
                }
                field(EMail; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
            }
            /*part(Control1102755008;Rec."HR Employee Kin SF")
            {
                SubPageLink = "Employee Code" = field("No.");
            }*/
        }
        area(factboxes)
        {
            systempart(Control1102755002; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    var
        D: Date;
        EmpNames: Text[30];
        HREmp: Record Employee;
        Text19032351: label 'Next Of Kin/Beneficiaries';
}

