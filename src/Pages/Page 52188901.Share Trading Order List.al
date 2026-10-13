page 50799 "Share Trading Order List"
{
    Caption = 'Share Trading Orders';
    PageType = List;
    SourceTable = "Share Trading Header";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageID = "Share Trading Order Card";

    layout
    {
        area(content)
        {
            repeater(OrderRepeater)
            {
                field("Order ID"; Rec."Order ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique order ID';
                }

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

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number';
                }

                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member name';
                }

                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this is a Buy or Sell order';
                    StyleExpr = OrderTypeStyle;
                }

                field("Total No. Shares"; Rec."Total No. Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total number of shares';
                }

                field("Price per Share"; Rec."Price per Share")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price per share';
                }

                field("Selling/Buying Price"; Rec."Selling/Buying Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total order amount';
                }

                field("Matched Shares"; Rec."Matched Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of shares already matched';
                }

                field("Remaining Shares"; Rec."Remaining Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of shares remaining to be matched';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order status';
                    StyleExpr = StatusStyle;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the order';
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the order has been posted';
                }

                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the order has been cancelled';
                }
            }
        }

        area(factboxes)
        {
            part(OrderStats; "Share Trading Order Stats")
            {
                ApplicationArea = All;
                SubPageLink = "Order ID" = field("Order ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(OrderActions)
            {
                Caption = 'Orders';

                action(NewBuyOrder)
                {
                    ApplicationArea = All;
                    Caption = 'New Buy Order';
                    Image = New;
                    ToolTip = 'Create a new buy order';

                    trigger OnAction()
                    var
                        ShareTradingHeader: Record "Share Trading Header";
                    begin
                        ShareTradingHeader.Init();
                        ShareTradingHeader."Order Type" := ShareTradingHeader."Order Type"::Buy;
                        ShareTradingHeader.Insert(true);
                        Page.Run(Page::"Share Trading Order Card", ShareTradingHeader);
                    end;
                }

                action(NewSellOrder)
                {
                    ApplicationArea = All;
                    Caption = 'New Sell Order';
                    Image = New;
                    ToolTip = 'Create a new sell order';

                    trigger OnAction()
                    var
                        ShareTradingHeader: Record "Share Trading Header";
                    begin
                        ShareTradingHeader.Init();
                        ShareTradingHeader."Order Type" := ShareTradingHeader."Order Type"::Sell;
                        ShareTradingHeader.Insert(true);
                        Page.Run(Page::"Share Trading Order Card", ShareTradingHeader);
                    end;
                }

                action(MatchAllOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Match All Orders';
                    Image = CreateForm;
                    ToolTip = 'Process matching for all open orders';

                    trigger OnAction()
                    var
                        ShareTradingMgmt: Codeunit "Share Trading Management";
                    begin
                        if Confirm('Process matching for all open orders?') then begin
                            ShareTradingMgmt.ProcessAllOpenOrders();
                            Message('Order matching completed');
                            CurrPage.Update();
                        end;
                    end;
                }

                action(PostAllMatches)
                {
                    ApplicationArea = All;
                    Caption = 'Post All Matches';
                    Image = Post;
                    ToolTip = 'Post all unposted matches';

                    trigger OnAction()
                    begin
                        PostAllUnpostedMatches();
                    end;
                }
            }

            group(Reports)
            {
                Caption = 'Reports';

                action(OrderBook)
                {
                    ApplicationArea = All;
                    Caption = 'Order Book';
                    Image = Report;
                    ToolTip = 'View the current order book';

                    trigger OnAction()
                    begin
                        Report.Run(Report::"Share Trading Order Book");
                    end;
                }

                action(TradingActivity)
                {
                    ApplicationArea = All;
                    Caption = 'Trading Activity';
                    Image = Report;
                    ToolTip = 'View trading activity report';

                    trigger OnAction()
                    begin
                        Report.Run(Report::"Share Trading Activity");
                    end;
                }
            }
        }

        area(navigation)
        {
            action(Setup)
            {
                ApplicationArea = All;
                Caption = 'Share Trading Setup';
                Image = Setup;
                RunObject = page "Share Trading Setup";
                ToolTip = 'Configure share trading parameters';
            }

            action(Matches)
            {
                ApplicationArea = All;
                Caption = 'All Matches';
                Image = List;
                RunObject = page "Share Trading Match List";
                ToolTip = 'View all trading matches';
            }
        }
    }

    views
    {
        view(OpenOrders)
        {
            Caption = 'Open Orders';
            Filters = where(Status = const(Open),
                          Cancelled = const(false));
            OrderBy = ascending("Order Date", "Order Time");
        }

        view(BuyOrders)
        {
            Caption = 'Buy Orders';
            Filters = where("Order Type" = const(Buy),
                          Status = const(Open),
                          Cancelled = const(false));
            OrderBy = descending("Price per Share");
        }

        view(SellOrders)
        {
            Caption = 'Sell Orders';
            Filters = where("Order Type" = const(Sell),
                          Status = const(Open),
                          Cancelled = const(false));
            OrderBy = ascending("Price per Share");
        }

        view(FullyMatched)
        {
            Caption = 'Fully Matched';
            Filters = where(Status = const("Completed"));
            OrderBy = descending("Order Date", "Order Time");
        }

        view(PostedOrders)
        {
            Caption = 'Posted Orders';
            Filters = where(Posted = const(true));
            OrderBy = descending("Order Date");
        }

        view(CancelledOrders)
        {
            Caption = 'Cancelled Orders';
            Filters = where(Cancelled = const(true));
            OrderBy = descending("Order Date");
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    var
        OrderTypeStyle: Text;
        StatusStyle: Text;

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

        if Rec.Posted then
            StatusStyle := 'Strong';
    end;

    local procedure PostAllUnpostedMatches()
    var
        ShareTradingMatch: Record "Share Trading Match";
        Counter: Integer;
    begin
        ShareTradingMatch.Reset();
        ShareTradingMatch.SetRange(Posted, false);

        if ShareTradingMatch.IsEmpty then begin
            Message('No unposted matches found');
            exit;
        end;

        if not Confirm('Post %1 unposted matches?', false, ShareTradingMatch.Count) then
            exit;

        if ShareTradingMatch.FindSet() then begin
            repeat
                ShareTradingMatch.PostMatch();
                Counter += 1;
            until ShareTradingMatch.Next() = 0;
        end;

        Message('Posted %1 matches', Counter);
        CurrPage.Update();
    end;
}
