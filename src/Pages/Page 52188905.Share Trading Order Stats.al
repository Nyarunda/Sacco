page 50803 "Share Trading Order Stats"
{
    Caption = 'Order Statistics';
    PageType = CardPart;
    SourceTable = "Share Trading Header";

    layout
    {
        area(content)
        {
            group(OrderInfo)
            {
                Caption = 'Order Details';

                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order type';
                    StyleExpr = OrderTypeStyle;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order status';
                    StyleExpr = StatusStyle;
                }

                field("Total No. Shares"; Rec."Total No. Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total shares';
                }

                field("Price per Share"; Rec."Price per Share")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price per share';
                }

                field("Selling/Buying Price"; Rec."Selling/Buying Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount';
                }
            }

            group(Progress)
            {
                Caption = 'Execution Progress';

                field("Matched Shares"; Rec."Matched Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies matched shares';
                    StyleExpr = 'Favorable';
                }

                field("Remaining Shares"; Rec."Remaining Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies remaining shares';
                    StyleExpr = RemainingStyle;
                }

                field("Fill Percentage"; FillPercentage)
                {
                    ApplicationArea = All;
                    Caption = 'Fill %';
                    ToolTip = 'Specifies the fill percentage';
                    DecimalPlaces = 1 : 1;
                    StyleExpr = FillStyle;
                }

                field("Match Count"; MatchCount)
                {
                    ApplicationArea = All;
                    Caption = 'Matches';
                    ToolTip = 'Specifies the number of matches';
                }
            }

            group(MemberInfo)
            {
                Caption = 'Member Info';
                Visible = Rec."Member No." <> '';

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number';
                }

                field("Member Capital Balance"; Rec."Member Capital Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies member capital balance';
                }

                field("Available Shares"; AvailableShares)
                {
                    ApplicationArea = All;
                    Caption = 'Available Shares';
                    ToolTip = 'Specifies available shares for sale';
                    Visible = Rec."Order Type" = Rec."Order Type"::Sell;
                }
            }

            group(Timing)
            {
                Caption = 'Timing';

                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order date';
                }

                field("Order Time"; Rec."Order Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order time';
                }

                field("Age in Days"; AgeInDays)
                {
                    ApplicationArea = All;
                    Caption = 'Age (Days)';
                    ToolTip = 'Specifies order age in days';
                    StyleExpr = AgeStyle;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcFields();
        SetStyles();
    end;

    var
        FillPercentage: Decimal;
        MatchCount: Integer;
        AvailableShares: Decimal;
        AgeInDays: Integer;
        OrderTypeStyle: Text;
        StatusStyle: Text;
        RemainingStyle: Text;
        FillStyle: Text;
        AgeStyle: Text;

    local procedure CalcFields()
    var
        ShareTradingMatch: Record "Share Trading Match";
        ShareTradingMgmt: Codeunit "Share Trading Management";
    begin
        // Calculate fill percentage
        if Rec."Total No. Shares" > 0 then
            FillPercentage := (Rec."Matched Shares" / Rec."Total No. Shares") * 100
        else
            FillPercentage := 0;

        // Count matches
        ShareTradingMatch.Reset();
        ShareTradingMatch.SetFilter("Sell Order ID", Rec."Order ID");
        MatchCount := ShareTradingMatch.Count();

        ShareTradingMatch.Reset();
        ShareTradingMatch.SetFilter("Buy Order ID", Rec."Order ID");
        MatchCount += ShareTradingMatch.Count();

        // Get available shares for sell orders
        if (Rec."Order Type" = Rec."Order Type"::Sell) and (Rec."Member No." <> '') then
            AvailableShares := ShareTradingMgmt.GetMemberAvailableShares(Rec."Member No.")
        else
            AvailableShares := 0;

        // Calculate age
        AgeInDays := Today - Rec."Order Date";
    end;

    local procedure SetStyles()
    begin
        // Order Type styling
        case Rec."Order Type" of
            Rec."Order Type"::Buy:
                OrderTypeStyle := 'Favorable';
            Rec."Order Type"::Sell:
                OrderTypeStyle := 'Unfavorable';
        end;

        // Status styling
        case Rec.Status of
            Rec.Status::Open:
                StatusStyle := 'Standard';
            Rec.Status::"Partially Matched":
                StatusStyle := 'Attention';
            Rec.Status::Completed:
                StatusStyle := 'Favorable';
        end;

        if Rec.Cancelled then
            StatusStyle := 'Unfavorable';

        // Remaining shares styling
        if Rec."Remaining Shares" = 0 then
            RemainingStyle := 'Favorable'
        else if Rec."Remaining Shares" = Rec."Total No. Shares" then
            RemainingStyle := 'Unfavorable'
        else
            RemainingStyle := 'Attention';

        // Fill percentage styling
        if FillPercentage = 100 then
            FillStyle := 'Favorable'
        else if FillPercentage > 50 then
            FillStyle := 'Attention'
        else if FillPercentage > 0 then
            FillStyle := 'Standard'
        else
            FillStyle := 'Unfavorable';

        // Age styling
        if AgeInDays = 0 then
            AgeStyle := 'Favorable'
        else if AgeInDays <= 7 then
            AgeStyle := 'Standard'
        else if AgeInDays <= 30 then
            AgeStyle := 'Attention'
        else
            AgeStyle := 'Unfavorable';
    end;
}
