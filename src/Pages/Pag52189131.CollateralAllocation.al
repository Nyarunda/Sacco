namespace UnitedWomen.UnitedWomen;

page 50833 "Collateral Allocation"
{
    ApplicationArea = All;
    Caption = 'Collateral Allocation';
    PageType = ListPart;
    SourceTable = "Collateral Allocation";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Collateral No."; Rec."Collateral No.")
                {
                    ToolTip = 'Specifies the value of the Collateral No. field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Collateral Allocation"; Rec."Collateral Allocation")
                {
                    ToolTip = 'Specifies the value of the Collateral Allocation field.', Comment = '%';
                }
            }
        }
    }
}
