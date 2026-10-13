page 50091 "Transaction Keyword Setup"
{
    ApplicationArea = All;
    Caption = 'Transaction Keyword Setup';
    PageType = List;
    SourceTable = "Transaction Keyword Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Keyword Code"; Rec."Keyword Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the keyword to detect, for example SAV, BLN, J, or M.';
                }
                field("Keyword Type"; Rec."Keyword Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how the keyword is matched against the transaction account or description.';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the product setup code to use when the keyword is matched.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description for this keyword mapping.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this keyword mapping is active.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the matching priority. Lower values are checked first.';
                }
            }
        }
    }
}
