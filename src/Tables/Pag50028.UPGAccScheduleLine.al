page 50028 UPG_AccScheduleLine
{
    Caption = 'UPG_AccScheduleLine';
    PageType = List;
    SourceTable = "Acc. Schedule Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Schedule Name"; Rec."Schedule Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Schedule Name field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Row No."; Rec."Row No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a number that identifies the line.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies text that will appear on the account schedule line.';
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Totaling field.';
                }
                field("Totaling Type"; Rec."Totaling Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the totaling type for the account schedule line. The type determines which accounts within the totaling interval you specify in the Totaling field will be totaled. ';
                }
                field("New Page"; Rec."New Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether there will be a page break after the current account when the account schedule is printed.';
                }
                field(Indentation; Rec.Indentation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Indentation field.';
                }
                field(Show; Rec.Show)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the account schedule line will be printed on the report.';
                }
                field("Dimension 1 Totaling"; Rec."Dimension 1 Totaling")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which dimension value amounts will be totaled on this line.';
                }
                field("Dimension 2 Totaling"; Rec."Dimension 2 Totaling")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which dimension value amounts will be totaled on this line.';
                }
                field("Dimension 3 Totaling"; Rec."Dimension 3 Totaling")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which dimension value amounts will be totaled on this line.';
                }
                field("Dimension 4 Totaling"; Rec."Dimension 4 Totaling")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which dimension value amounts will be totaled on this line.';
                }
                field(Bold; Rec.Bold)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to print the amounts in this row in bold.';
                }
                field(Italic; Rec.Italic)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to print the amounts in this row in italics.';
                }
                field(Underline; Rec.Underline)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to underline the amounts in this row.';
                }
                field("Show Opposite Sign"; Rec."Show Opposite Sign")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to show debits in reports as negative amounts with a minus sign and credits as positive amounts.';
                }
                field("Row Type"; Rec."Row Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the row type for the account schedule row. The type determines how the amounts in the row are calculated.';
                }
                field("Amount Type"; Rec."Amount Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of entries that will be included in the amounts in the account schedule row.';
                }
                field("Double Underline"; Rec."Double Underline")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to double underline the amounts in this row.';
                }
            }
        }
    }
}
