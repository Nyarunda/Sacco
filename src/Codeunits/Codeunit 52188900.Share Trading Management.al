codeunit 50602 "Share Trading Management"
{
    procedure ProcessNewOrder(var ShareTradingHeader: Record "Share Trading Header")
    var
        ShareTradingSetup: Record "Share Trading Setup";
    begin
        ShareTradingSetup.Get();
        ShareTradingSetup.CheckTradingHours();

        if ShareTradingSetup."Auto Match Orders" then
            MatchOrder(ShareTradingHeader);
    end;

    procedure MatchOrder(var ShareTradingHeader: Record "Share Trading Header")
    var
        MatchingOrders: Record "Share Trading Header";
        ShareTradingMatch: Record "Share Trading Match";
        ShareTradingSetup: Record "Share Trading Setup";
        Window: Dialog;
        Counter: Integer;
        TotalMatches: Integer;
    begin
        ShareTradingSetup.Get();

        if not ShareTradingSetup."Enable Share Trading" then
            Error('Share trading is currently disabled');

        Window.Open('Matching Orders...\Processing #1#####');

        MatchingOrders.Reset();

        if ShareTradingHeader."Order Type" = ShareTradingHeader."Order Type"::Buy then
            FindMatchingSellOrders(ShareTradingHeader, MatchingOrders)
        else
            FindMatchingBuyOrders(ShareTradingHeader, MatchingOrders);

        if MatchingOrders.FindSet() then begin
            repeat
                Counter += 1;
                Window.Update(1, Counter);

                if CanMatch(ShareTradingHeader, MatchingOrders) then begin
                    CreateMatch(ShareTradingHeader, MatchingOrders);
                    TotalMatches += 1;

                    if ShareTradingHeader."Remaining Shares" = 0 then
                        break;
                end;
            until MatchingOrders.Next() = 0;
        end;

        Window.Close();

        if TotalMatches > 0 then
            Message('Successfully created %1 matches', TotalMatches)
        else
            Message('No matching orders found');
    end;

    procedure GetMemberAvailableShares(MemberNo: Code[20]): Decimal
    var
        Members: Record Members;
        Legacy: Codeunit Legacy;
        ShareTradingSetup: Record "Share Trading Setup";
        CurrentShares: Decimal;
        MAct: Codeunit "Member Activities";
        Shares: Decimal;
    begin
        if not Members.Get(MemberNo) then
            exit(0);

        Shares := MAct.GetAccountBalance(Legacy.GetShareCapitalAccount(MemberNo));

        ShareTradingSetup.Get();

        if ShareTradingSetup."Par Value per Share" > 0 then
            CurrentShares := round(Shares / ShareTradingSetup."Par Value per Share")
        else
            CurrentShares := 0;

        // Subtract pending sell orders
        CurrentShares -= GetPendingSellShares(MemberNo);

        if CurrentShares < 0 then
            CurrentShares := 0;

        exit(CurrentShares);
    end;

    procedure GetMemberShareBalance(MemberNo: Code[20]): Decimal
    var
        Members: Record Members;
        Legacy: Codeunit Legacy;
        ShareTradingSetup: Record "Share Trading Setup";
        MAct: Codeunit "Member Activities";
        Shares: Decimal;
    begin
        if not Members.Get(MemberNo) then
            exit(0);

        Shares := MAct.GetAccountBalance(Legacy.GetShareCapitalAccount(MemberNo));
        ShareTradingSetup.Get();

        if ShareTradingSetup."Par Value per Share" > 0 then
            exit(round(Shares / ShareTradingSetup."Par Value per Share"))
        else
            exit(0);
    end;

    procedure GetPendingSellShares(MemberNo: Code[20]): Decimal
    var
        ShareTradingHeader: Record "Share Trading Header";
    begin
        ShareTradingHeader.Reset();
        ShareTradingHeader.SetRange("Member No.", MemberNo);
        ShareTradingHeader.SetRange("Order Type", ShareTradingHeader."Order Type"::Sell);
        ShareTradingHeader.SetRange(Status, ShareTradingHeader.Status::Active, ShareTradingHeader.Status::"Partially Matched");
        ShareTradingHeader.SetRange(Cancelled, false);
        ShareTradingHeader.CalcSums("Remaining Shares");
        exit(ShareTradingHeader."Remaining Shares");
    end;

    procedure CancelOrder(var ShareTradingHeader: Record "Share Trading Header"; CancelReason: Text[250])
    begin
        if ShareTradingHeader.Posted then
            Error('Cannot cancel a posted order');

        if ShareTradingHeader.Cancelled then
            Error('Order is already cancelled');

        ShareTradingHeader.Cancelled := true;
        ShareTradingHeader."Cancel Reason" := CancelReason;
        ShareTradingHeader.Status := ShareTradingHeader.Status::Open; // Keep original status for reference
        ShareTradingHeader.Modify();

        Message('Order %1 has been cancelled', ShareTradingHeader."Order ID");
    end;

    procedure ProcessAllOpenOrders()
    var
        ShareTradingHeader: Record "Share Trading Header";
        Window: Dialog;
        Counter: Integer;
        Total: Integer;
    begin
        ShareTradingHeader.Reset();
        ShareTradingHeader.SetFilter(Status, '%1|%2', ShareTradingHeader.Status::Open, ShareTradingHeader.Status::"Partially Matched");
        Total := ShareTradingHeader.Count;

        if Total = 0 then begin
            Message('No open orders to process');
            exit;
        end;

        Window.Open('Processing Open Orders...\Order #1####### of #2#######');

        if ShareTradingHeader.FindSet() then begin
            repeat
                Counter += 1;
                Window.Update(1, Counter);
                Window.Update(2, Total);

                MatchOrder(ShareTradingHeader);
                ShareTradingHeader.Get(ShareTradingHeader."Order ID"); // Refresh
            until ShareTradingHeader.Next() = 0;
        end;

        Window.Close();
        Message('Processed %1 orders', Counter);
    end;

    local procedure FindMatchingSellOrders(BuyOrder: Record "Share Trading Header"; var SellOrders: Record "Share Trading Header")
    begin

        if BuyOrder."Bid Type" <> BuyOrder."Bid Type"::Negotiable then begin

            SellOrders.Reset();
            SellOrders.SetRange("Order Type", SellOrders."Order Type"::Sell);
            SellOrders.SetFilter(Status, '%1|%2', SellOrders.Status::Active, SellOrders.Status::"Partially Matched");
            SellOrders.SetFilter("Price per Share", '%1', BuyOrder."Price per Share");
            SellOrders.SetFilter("Member No.", '<>%1', BuyOrder."Member No."); // Prevent self-trading
            SellOrders.SetCurrentKey("Price per Share", "Order Date", "Order Time"); // Price priority, then time priority
            SellOrders.SetAscending("Price per Share", true); // Lowest price first

        end;
    end;

    local procedure FindMatchingBuyOrders(SellOrder: Record "Share Trading Header"; var BuyOrders: Record "Share Trading Header")
    begin

        if SellOrder."Bid Type" <> SellOrder."Bid Type"::Negotiable then begin
            BuyOrders.Reset();
            BuyOrders.SetRange("Order Type", BuyOrders."Order Type"::Buy);
            BuyOrders.SetFilter(Status, '%1|%2', BuyOrders.Status::Active, BuyOrders.Status::"Partially Matched");
            BuyOrders.SetFilter("Price per Share", '%1', SellOrder."Price per Share");
            BuyOrders.SetFilter("Member No.", '<>%1', SellOrder."Member No."); // Prevent self-trading
            BuyOrders.SetCurrentKey("Price per Share", "Order Date", "Order Time"); // Price priority, then time priority
            BuyOrders.SetAscending("Price per Share", false); // Highest price first
        end;
    end;

    local procedure CanMatch(Order1: Record "Share Trading Header"; Order2: Record "Share Trading Header"): Boolean
    var
        ShareTradingMatch: Record "Share Trading Match";
        ShareTradingSetup: Record "Share Trading Setup";
        SellOrder: Record "Share Trading Header";
        BuyOrder: Record "Share Trading Header";
        MatchedShares: Decimal;
        MatchPrice: Decimal;
    begin


        // Determine sell and buy orders
        if Order1."Order Type" = Order1."Order Type"::Sell then begin
            SellOrder := Order1;
            BuyOrder := Order2;
        end else begin
            SellOrder := Order2;
            BuyOrder := Order1;
        end;

        SellOrder.CalcFields("Shares Sold");
        BuyOrder.CalcFields("Shares Bought");

        SellOrder."Remaining Shares" := SellOrder."Total No. Shares" - SellOrder."Shares Sold";
        BuyOrder."Remaining Shares" := BuyOrder."Total No. Shares" - BuyOrder."Shares Bought";

        SellOrder."Remaining Amount" := SellOrder."Price per Share" * SellOrder."Remaining Shares";
        BuyOrder."Remaining Amount" := BuyOrder."Price per Share" * BuyOrder."Remaining Shares";


        BuyOrder.Modify();
        SellOrder.Modify();


        // Check if both orders have remaining shares
        if (SellOrder."Remaining Shares" <= 0) or (BuyOrder."Remaining Shares" <= 0) then
            exit(false);

        // Check if orders are different types
        if SellOrder."Order Type" = BuyOrder."Order Type" then
            exit(false);

        // Check if members are different
        if SellOrder."Member No." = BuyOrder."Member No." then
            exit(false);



        // Check price compatibility
        exit(BuyOrder."Price per Share" = SellOrder."Price per Share");


    end;

    local procedure CreateMatch(var Order1: Record "Share Trading Header"; var Order2: Record "Share Trading Header")
    var
        ShareTradingMatch: Record "Share Trading Match";
        ShareTradingSetup: Record "Share Trading Setup";
        SellOrder: Record "Share Trading Header";
        BuyOrder: Record "Share Trading Header";
        MatchedShares: Decimal;
        MatchPrice: Decimal;
        Legacy: Codeunit Legacy;
    begin
        ShareTradingSetup.Get();

        // Determine sell and buy orders
        if Order1."Order Type" = Order1."Order Type"::Sell then begin
            SellOrder := Order1;
            BuyOrder := Order2;
        end else begin
            SellOrder := Order2;
            BuyOrder := Order1;
        end;

        // Calculate matched shares (minimum of remaining shares)
        MatchedShares := MinValue(SellOrder."Remaining Shares", BuyOrder."Remaining Shares");

        if MatchedShares <= 0 then
            exit;

        MatchPrice := SellOrder."Price per Share";

        /*
        // Calculate match price based on setup
        case ShareTradingSetup."Matching Price Method" of
            ShareTradingSetup."Matching Price Method"::"Sell Price":
                MatchPrice := SellOrder."Price per Share";
            ShareTradingSetup."Matching Price Method"::"Buy Price":
                MatchPrice := BuyOrder."Price per Share";
            ShareTradingSetup."Matching Price Method"::"Average Price":
                MatchPrice := (SellOrder."Price per Share" + BuyOrder."Price per Share") / 2;
        end;
        */

        // Create the match record
        ShareTradingMatch.Init();
        ShareTradingMatch."Sell Order ID" := SellOrder."Order ID";
        ShareTradingMatch."Sell Account No." := Legacy.GetOrdinaryAccount(SellOrder."Member No.");
        ShareTradingMatch."Sell Member No." := SellOrder."Member No.";
        ShareTradingMatch."Sell Member Name" := SellOrder."Member Name";
        ShareTradingMatch."Buy Order ID" := BuyOrder."Order ID";
        ShareTradingMatch."Buy Member No." := BuyOrder."Member No.";
        ShareTradingMatch."Buy Member Name" := BuyOrder."Member Name";
        ShareTradingMatch."Buy Account No." := Legacy.GetOrdinaryAccount(BuyOrder."Member No.");
        ShareTradingMatch."Matched Shares" := MatchedShares;
        ShareTradingMatch."Price per Share" := MatchPrice;
        ShareTradingMatch."Matched Amount" := MatchedShares * MatchPrice;
        ShareTradingMatch.Insert(true);

        // Update the orders
        ShareTradingMatch.UpdateOrdersMatching();

        // Refresh local variables
        Order1.Get(Order1."Order ID");
        Order2.Get(Order2."Order ID");

        // Send notifications
        SendMatchNotification(ShareTradingMatch);
    end;

    local procedure MinValue(Value1: Decimal; Value2: Decimal): Decimal
    begin
        if Value1 < Value2 then
            exit(Value1)
        else
            exit(Value2);
    end;

    local procedure SendMatchNotification(ShareTradingMatch: Record "Share Trading Match")
    var
        ShareTradingSetup: Record "Share Trading Setup";
        SellOrder: Record "Share Trading Header";
        BuyOrder: Record "Share Trading Header";
    begin
        ShareTradingSetup.Get();

        if not (ShareTradingSetup."Email Notifications" or ShareTradingSetup."SMS Notifications") then
            exit;

        SellOrder.Get(ShareTradingMatch."Sell Order ID");
        BuyOrder.Get(ShareTradingMatch."Buy Order ID");

        // TODO: Implement notification sending logic
        // This would integrate with your existing notification system
    end;
}
