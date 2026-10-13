page 50820 "P2F Keywords"
{
    ApplicationArea = All;
    Caption = 'P2F Keywords';
    PageType = List;
    SourceTable = "P2F Keywords";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Keyword; Rec.Keyword)
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product code")
                {
                    ApplicationArea = Basic;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Name field.', Comment = '%';
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Type field.', Comment = '%';
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}
