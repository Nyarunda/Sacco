page 50466 "Coop Transaction Codes"
{
    Caption = 'Coop Transaction Codes';
    PageType = List;
    SourceTable = "Coop Transaction Codes";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
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
                field("Daily Limit"; Rec."Daily Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Daily Limit field.';
                }
                field("Coop Bank Account"; Rec."Coop Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Coop Bank Account field.';
                }
            }
        }
    }


    actions
    {
        area(navigation)
        {

            action("Charges")
            {
                ApplicationArea = Basic;
                Image = ClearFilter;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Coop ATM Charges";
                RunPageLink = Code = field("Code"), Terminal = field(Terminal), Channel = field(Channel);
            }

        }

    }



}
