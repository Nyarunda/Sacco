page 50462 "Business Monthly Income"
{
    Caption = 'Business Monthly Income';
    PageType = ListPart;
    SourceTable = "Business Monthly Income";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field("Total InFlow"; Rec."Total InFlow")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total InFlow field.';
                }
                field("Total Outflow"; Rec."Total Outflow")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Outflow field.';
                }
                field("Deficit/Surplus"; Rec."Deficit/Surplus")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deficit/Surplus field.';
                }
                field("Sacco Deductions"; Rec."Sacco Deductions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sacco Deductions field.';
                }
                field("Net Profits"; Rec."Net Profits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Profits field.';
                }
                field("Other Personal Expenses"; Rec."Other Personal Expenses")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Personal Expenses field.';
                }
                field("Free Money"; Rec."Free Money")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Free Money field.';
                }
            }
        }
    }
}
