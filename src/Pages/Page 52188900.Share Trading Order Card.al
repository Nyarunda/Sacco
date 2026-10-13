page 50798 "Share Trading Order Card"
{
    Caption = 'Share Trading Order';
    PageType = Card;
    SourceTable = "Share Trading Header";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Order ID"; Rec."Order ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique order ID';
                }

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }

                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member name';
                }
                field("Member Capital Balance"; Rec."Member Capital Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member''s current capital balance';
                }

                field("Par Value per Share"; Rec."Par Value per Share")
                {
                    ApplicationArea = All;
                    Caption = 'Par Value per Share';
                    ToolTip = 'Specifies the par value per share';
                    Editable = false;
                }

                field("Available Shares for Sale"; AvailableShares)
                {
                    ApplicationArea = All;
                    Caption = 'Available Shares';
                    ToolTip = 'Specifies the number of shares available for sale';
                    Editable = false;
                }

                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this is a Buy or Sell order';

                    trigger OnValidate()
                    begin
                        UpdateControls();
                        CurrPage.Update();
                    end;
                }

                field("Shares To Trade"; Rec."Shares To Trade")
                {
                    ApplicationArea = All;
                    Caption = 'Shares To Trade';
                    ToolTip = 'Specifies the total shares to trade based on par value';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order status';
                }
            }

            group(OrderDetails)
            {
                Caption = 'Order Details';


                field("Bid Type"; Rec."Bid Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bid type';
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

                field("Buying Price"; Rec."Selling/Buying Price")
                {
                    ApplicationArea = All;
                    Caption = 'Buying Price';
                    Visible = buy_bool;
                    ToolTip = 'Specifies the total order price';
                }


                field("Selling Price"; Rec."Selling/Buying Price")
                {
                    ApplicationArea = All;
                    Caption = 'Selling Price';
                    Visible = sell_bool;
                    ToolTip = 'Specifies the total order price';
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

                field("Matched Amount"; Rec."Matched Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount already matched';
                }

                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount remaining to be matched';
                }
            }


            group(Timestamps)
            {
                Caption = 'Timestamps';

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

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the order';
                }
            }

            group(PostingInfo)
            {
                Caption = 'Posting Information';
                Visible = Rec.Posted or Rec.Cancelled;

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the order has been posted';
                }

                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date';
                }

                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who posted the order';
                }

                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the order has been cancelled';
                }

                field("Cancelled Date"; Rec."Cancelled Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cancellation date';
                    Visible = Rec.Cancelled;
                }

                field("Cancelled By"; Rec."Cancelled By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who cancelled the order';
                    Visible = Rec.Cancelled;
                }

                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cancellation reason';
                    MultiLine = true;
                }
            }

            part(SellMatches; "Share Trading Match Subpage")
            {
                ApplicationArea = All;
                Caption = 'Sell Matches';
                SubPageLink = "Sell Order ID" = field("Order ID");
            }

            part(BuyMatches; "Share Trading Match Subpage")
            {
                ApplicationArea = All;
                Caption = 'Buy Matches';
                SubPageLink =
                              "Buy Order ID" = field("Order ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PlaceOrder)
            {
                ApplicationArea = All;
                Caption = 'Place Order';
                Image = CreateForm;
                ToolTip = 'Find and create matches for this order';

                trigger OnAction()
                var
                    ShareTradingMgmt: Codeunit "Share Trading Management";
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField("Price per Share");
                    Rec.TestField("Total No. Shares");
                    Rec.TestField("Selling/Buying Price");
                    Rec.TestField("Member No.");
                    Rec.Validate("Member No.");
                    Rec.Validate("Total No. Shares");

                    if rec."Selling/Buying Price" > Rec."Member Capital Balance" then
                        Error('Insufficient capital balance to place this order');

                    Rec.Status := Rec.Status::Active;
                    ShareTradingMgmt.MatchOrder(Rec);
                    CurrPage.Update();

                end;
            }
            action(MatchOrder)
            {
                ApplicationArea = All;
                Caption = 'Match Order';
                Image = CreateForm;
                ToolTip = 'Find and create matches for this order';

                trigger OnAction()
                var
                    ShareTradingMgmt: Codeunit "Share Trading Management";
                begin
                    Rec.TestField(Status, Rec.Status::Active);
                    ShareTradingMgmt.MatchOrder(Rec);
                    CurrPage.Update();
                end;
            }

            action(CancelOrder)
            {
                ApplicationArea = All;
                Caption = 'Cancel Order';
                Image = Cancel;
                ToolTip = 'Cancel this order';

                trigger OnAction()
                var
                    ShareTradingMgmt: Codeunit "Share Trading Management";
                begin

                    if not Confirm('Are you sure you want to cancel this order?') then
                        exit;

                    if Rec."Cancel Reason" = '' then begin
                        Message('Please enter a cancel reason in the Cancel Reason field before cancelling the order.');
                        exit;
                    end;

                    ShareTradingMgmt.CancelOrder(Rec, Rec."Cancel Reason");
                    CurrPage.Update();
                end;
            }

            action(PostMatches)
            {
                ApplicationArea = All;
                Caption = 'Post Matches';
                Image = Post;
                ToolTip = 'Post all unposted matches for this order';

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Active);
                    PostOrderMatches();
                    CurrPage.Update();
                end;
            }
        }

        area(navigation)
        {
            action(MemberCard)
            {
                ApplicationArea = All;
                Caption = 'Member Card';
                Image = Customer;
                RunObject = page "Member Card";
                RunPageLink = "No." = field("Member No.");
                ToolTip = 'View the member card';
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcAvailableShares();
        UpdateControls();
    end;

    trigger OnOpenPage()
    begin
        UpdateControls();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
    end;

    local procedure CalcAvailableShares()
    var
        ShareTradingMgmt: Codeunit "Share Trading Management";
    begin
        if Rec."Member No." <> '' then
            AvailableShares := ShareTradingMgmt.GetMemberAvailableShares(Rec."Member No.")
        else
            AvailableShares := 0;
    end;

    local procedure PostOrderMatches()
    var
        ShareTradingMatch: Record "Share Trading Match";
        ShareTradingPost: Codeunit "Share Trading Post";
        Counter: Integer;
        MatchCount: Integer;
    begin
        ShareTradingMatch.Reset();
        ShareTradingMatch.SetRange("Sell Order ID", Rec."Order ID");
        ShareTradingMatch.SetRange("Buy Order ID", Rec."Order ID");
        ShareTradingMatch.SetRange(Posted, false);

        if ShareTradingMatch.IsEmpty then begin
            Message('No unposted matches found for this order');
            exit;
        end;

        MatchCount := ShareTradingMatch.Count;
        if not Confirm(StrSubstNo('Post %1 unposted matches?', MatchCount)) then
            exit;

        if ShareTradingMatch.FindSet() then begin
            repeat
                ShareTradingMatch.PostMatch();
                Counter += 1;
            until ShareTradingMatch.Next() = 0;
        end;

        Message('Posted %1 matches', Counter);
    end;



    local procedure UpdateControls()
    var
        myInt: Integer;
    begin
        if Rec."Order Type" = Rec."Order Type"::Buy then begin
            buy_bool := true;
            sell_bool := false;
        end
        else begin
            buy_bool := false;
            sell_bool := true;
        end;
    end;

    var
        buy_bool: Boolean;
        sell_bool: Boolean;


        AvailableShares: Decimal;
}
