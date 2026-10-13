namespace UnitedWomen.UnitedWomen;
page 50618 "Loan Collateral Allocation"
{
    ApplicationArea = All;
    Caption = 'Loan Collateral Allocation';
    PageType = List;
    SourceTable = "Collateral Allocation";
    UsageCategory = Lists;
    
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
