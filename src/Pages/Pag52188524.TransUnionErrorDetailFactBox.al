page 50816 "TransUnionError Detail FactBox"
{
    // TransUnion Error Detail FactBox

    PageType = CardPart;
    SourceTable = "TransUnion Parsed Error";
    Caption = 'Error Details';

    layout
    {
        area(Content)
        {
            group(ErrorInfo)
            {
                Caption = 'Error Information';

                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Account number with the error';
                }

                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Field that failed validation';
                }

                field("Field Value"; Rec."Field Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Value that caused the error';
                    Style = Unfavorable;
                }

                field("Error Code"; Rec."Error Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'TransUnion error code';
                }
            }

            group(Resolution)
            {
                Caption = 'Resolution';

                field("Resolution Suggestion"; Rec."Resolution Suggestion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Suggested resolution for this error';
                    MultiLine = true;
                    Style = Attention;
                }
            }

            group(ErrorMessage)
            {
                Caption = 'Full Error Message';

                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Complete error message from TransUnion';
                    MultiLine = true;
                }
            }
        }
    }
}