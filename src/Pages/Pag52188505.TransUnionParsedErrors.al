page 50811 "TransUnion Parsed Errors"
{
    // Sub-page showing parsed error details in structured format

    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "TransUnion Parsed Error";
    Caption = 'Parsed Error Details';

    layout
    {
        area(Content)
        {
            repeater(ErrorDetails)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Field Value"; Rec."Field Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Error Code"; Rec."Error Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ShowErrorCodeHelp();
                    end;
                }

                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Resolution Suggestion"; Rec."Resolution Suggestion")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    local procedure ShowErrorCodeHelp()
    var
        HelpText: Text;
    begin
        case Rec."Error Code" of
            'ENF051':
                HelpText := 'Account Status Error: Value must be one of A|B|C|D|E|F|G|H|J|K|L|M|N|P';
            'ENF001':
                HelpText := 'Mandatory Field Error: This field cannot be empty';
            'ENF002':
                HelpText := 'Date Format Error: Use YYYYMMDD format (e.g., 20231016 for Oct 16, 2023)';
            'ENF003':
                HelpText := 'Amount Format Error: Use integer format without decimals (e.g., 150000 for 1,500.00)';
            'ENF004':
                HelpText := 'Invalid Character: Field contains invalid characters';
            'ENF005':
                HelpText := 'Length Error: Field value is too long or too short';
            else
                HelpText := 'Error Code: ' + Rec."Error Code" + '\Error Message: ' + Rec."Error Message";
        end;

        Message(HelpText);
    end;
}