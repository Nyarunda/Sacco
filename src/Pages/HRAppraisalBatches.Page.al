Page 51043 "HR Appraisal Batches"
{
    PageType = List;
    SourceTable = "HR Appraisal Journal Batch";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDescription; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
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

