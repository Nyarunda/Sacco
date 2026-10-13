namespace CentralDB.CentralDB;

page 50660 "Core Compentencies List"
{
    ApplicationArea = All;
    Caption = 'Core Compentencies List';
    PageType = List;
    SourceTable = "Core Compentencies";
    PromotedActionCategories = 'Value Dictionary';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }

        }
    }
    actions
    {
        area(Navigation)
        {
            action("Value Dictionary")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Value Dictionary List";
                RunPageLink = Code = field(Code);
            }
        }
    }
}
