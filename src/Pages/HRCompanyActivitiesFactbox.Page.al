Page 51069 "HR Company Activities Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Company Activities";

    layout
    {
        area(content)
        {
            group(Control1102755018)
            {
                label(Control1102755019)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text1;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(AcitivityDescription; Rec."Acitivity Description")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeResponsible; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Responsible';
                }
                field(EmailMessage; Rec."Email Message")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755020)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text2;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Costs; Rec.Costs)
                {
                    ApplicationArea = Basic;
                }
                field(ContributionAmountIfAny; Rec."Contribution Amount (If Any)")
                {
                    ApplicationArea = Basic;
                }
                field(GLAccountNo; Rec."G/L Account No")
                {
                    ApplicationArea = Basic;
                }
                field(GLAccountName; Rec."G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountType; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountNo; Rec."Bal. Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755012)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text3;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field(ActivityStatus; Rec."Activity Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Activity Description';
        Text2: label 'Activity Cost';
        Text3: label 'Activity Status';
}

