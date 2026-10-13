page 50025 "UPG_No Series Line"
{
    ApplicationArea = All;
    Caption = 'UPG_No Series Line';
    PageType = List;
    SourceTable = "No. Series Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Series Code"; Rec."Series Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the number series to which this line applies.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date from which you would like this line to apply.';
                }
                field("Starting No."; Rec."Starting No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first number in the series.';
                }
                field("Ending No."; Rec."Ending No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last number in the series.';
                }
                field("Warning No."; Rec."Warning No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when you want to receive a warning that the number series is running out.';
                }
                field("Increment-by No."; Rec."Increment-by No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size of the interval by which you would like to space the numbers in the number series.';
                }
                field("Last No. Used"; Rec."Last No. Used")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last number that was used from the number series.';
                }
                field(Open; Rec.Open)
                {
                }

                field("Last Date Used"; Rec."Last Date Used")
                {
                }
            }
        }
    }
}
