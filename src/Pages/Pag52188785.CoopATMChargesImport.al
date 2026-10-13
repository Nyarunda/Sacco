page 50467 "Coop ATM Charges Import"
{
    Caption = 'Coop ATM Charges Import';
    PageType = List;
    SourceTable = "Coop ATM Charges";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum field.';
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum field.';
                }
                field("Bank Commission"; Rec."Bank Commission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Commission field.';
                }
                field("Sacco Commission"; Rec."Sacco Commission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sacco Commission field.';
                }
                field(Terminal; Rec.Terminal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Terminal field.';
                }
                field(Channel; Rec.Channel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field("Sacco Per Every"; Rec."Sacco Per Every")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sacco Per Every field.';
                }
                field("Daily Limit"; Rec."Daily Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Daily Limit field.';
                }
            }
        }
    }
}
