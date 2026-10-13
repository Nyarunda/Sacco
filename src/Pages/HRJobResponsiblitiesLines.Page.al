Page 50845 "HR Job Responsiblities Lines"
{
    PageType = List;
    SourceTable = "HR Job Responsiblities";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(JobID; Rec."Job ID")
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

