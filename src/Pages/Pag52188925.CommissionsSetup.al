page 50627 "Commissions Setup"
{
    ApplicationArea = All;
    Caption = 'Commissions Steup';
    PageType = List;
    SourceTable = "Registration Commissions Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Primary Key"; Rec."Primary Key")
                { }
                field("Minimum Deposits"; Rec."Minimum Deposits")
                {
                    ToolTip = 'Specifies the value of the Minimum Deposits field.';
                }
                field("Minimum No. Members"; Rec."Minimum No. Members")
                {
                    ToolTip = 'Specifies the value of the Minimum No. Members field.';
                }
                field("Minimum Reg. Fee"; Rec."Minimum Reg. Fee")
                {
                    ToolTip = 'Specifies the value of the Minimum Reg. Fee field.';
                }

                field("Commission Amount"; Rec."Commission Amount")
                {

                }

            }
        }
    }
}
