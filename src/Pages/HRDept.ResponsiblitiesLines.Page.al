Page 51062 "HR Dept. Responsiblities Lines"
{
    PageType = List;
    SourceTable = "HR Dept. Responsibilities";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Responsibilitycode; Rec."Responsibility code")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityDescription; Rec."Responsibility Description")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
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

