namespace UnitedWomen_Production.UnitedWomen_Production;

page 50821 "Old Div Pages"
{
    ApplicationArea = All;
    Caption = 'Old Div List';
    PageType = List;
    SourceTable = " Old Dividend Progresion";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ToolTip = 'Specifies the value of the Processing Date field.', Comment = '%';
                }
                field(Product; Rec.Product)
                {
                    ToolTip = 'Specifies the value of the Product field.', Comment = '%';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ToolTip = 'Specifies the value of the Product Name field.', Comment = '%';
                }


                field("Qualifying Shares"; Rec."Qualifying Shares")
                {
                    ToolTip = 'Specifies the value of the Qualifying Shares field.', Comment = '%';
                }
                field(Shares; Rec.Shares)
                {
                    ToolTip = 'Specifies the value of the Shares field.', Comment = '%';
                }
                field("Gross Dividends"; Rec."Gross Dividends")
                {
                    ToolTip = 'Specifies the value of the Gross Dividends field.', Comment = '%';
                }
                field("Net Dividends"; Rec."Net Dividends")
                {
                    ToolTip = 'Specifies the value of the Net Dividends field.', Comment = '%';
                }


                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
            }
        }
    }
}
