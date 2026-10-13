page 50804 "Share Trading Match Details"
{
    Caption = 'Match Details';
    PageType = CardPart;
    SourceTable = "Share Trading Match";

    layout
    {
        area(content)
        {
            group(MatchInfo)
            {
                Caption = 'Match Information';

                field("Match ID"; Rec."Match ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the match ID';
                }

                field("Match Date"; Rec."Match Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the match date';
                }

                field("Match Time"; Rec."Match Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the match time';
                }

                field("Matched Shares"; Rec."Matched Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies matched shares';
                    StyleExpr = 'Strong';
                }

                field("Match Price"; Rec."Price per Share")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the match price';
                    StyleExpr = 'Strong';
                }

                field("Match Amount"; Rec."Matched Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the match amount';
                    StyleExpr = 'Strong';
                }
            }

            group(Orders)
            {
                Caption = 'Orders';

                field("Sell Order ID"; Rec."Sell Order ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sell order ID';
                }

                field("Seller Member No."; Rec."Sell Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the seller member';
                }

                field("Buy Order ID"; Rec."Buy Order ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the buy order ID';
                }

                field("Buyer Member No."; Rec."Buy Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the buyer member';
                }
            }

            group(Status)
            {
                Caption = 'Status';

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if posted';
                    StyleExpr = PostedStyle;
                }

                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies posting date';
                    Visible = Rec.Posted;
                }

                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who posted';
                    Visible = Rec.Posted;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created';
                }
            }

            group(Calculations)
            {
                Caption = 'Calculations';

                field("Commission Amount"; CommissionAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Commission';
                    ToolTip = 'Specifies commission amount';
                    DecimalPlaces = 2 : 2;
                }

                field("Trading Fee"; TradingFee)
                {
                    ApplicationArea = All;
                    Caption = 'Trading Fee';
                    ToolTip = 'Specifies trading fee';
                    DecimalPlaces = 2 : 2;
                }

                field("Net Seller Amount"; NetSellerAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Net to Seller';
                    ToolTip = 'Specifies net amount to seller';
                    DecimalPlaces = 2 : 2;
                    StyleExpr = 'Favorable';
                }

                field("Total Buyer Cost"; TotalBuyerCost)
                {
                    ApplicationArea = All;
                    Caption = 'Total Buyer Cost';
                    ToolTip = 'Specifies total cost to buyer';
                    DecimalPlaces = 2 : 2;
                    StyleExpr = 'Unfavorable';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcAmounts();
        SetStyles();
    end;

    var
        CommissionAmount: Decimal;
        TradingFee: Decimal;
        NetSellerAmount: Decimal;
        TotalBuyerCost: Decimal;
        PostedStyle: Text;

    local procedure CalcAmounts()
    var
        ShareTradingSetup: Record "Share Trading Setup";
    begin
        if not ShareTradingSetup.Get() then
            ShareTradingSetup.Init();

        // Calculate commission using the correct field name
        if ShareTradingSetup."Broker Commission %" > 0 then begin
            CommissionAmount := Rec."Matched Amount" * ShareTradingSetup."Broker Commission %" / 100;
        end else
            CommissionAmount := 0;

        // Get trading fee using the correct field name
        TradingFee := ShareTradingSetup."Transaction Fee";

        // Calculate net amounts (simplified since setup fields for commission allocation don't exist)
        NetSellerAmount := Rec."Matched Amount" - (CommissionAmount / 2) - (TradingFee / 2);
        TotalBuyerCost := Rec."Matched Amount" + (CommissionAmount / 2) + (TradingFee / 2);
    end;

    local procedure SetStyles()
    begin
        if Rec.Posted then
            PostedStyle := 'Strong'
        else
            PostedStyle := 'Standard';
    end;
}
