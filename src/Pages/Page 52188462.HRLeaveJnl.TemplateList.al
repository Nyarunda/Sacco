Page 50125 "HR Leave Jnl. Template List"
{
    Caption = 'Leave Jnl. Template List';
    Editable = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Template';
    SourceTable = "HR Leave Journal Template.";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(FormID; Rec."Form ID")
                {
                    ApplicationArea = Basic;
                }
                field(FormName; Rec."Form Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Template)
            {
                Caption = 'Template';
                action(Batches)
                {
                    ApplicationArea = Basic;
                    Caption = '&Batches';
                    Image = ChangeBatch;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
            }
        }
    }
}

