page 50801 "Share Trading Match List"
{
    Caption = 'Share Trading Matches';
    PageType = List;
    SourceTable = "Share Trading Match";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Matches)
            {
                field("Match ID"; Rec."Match ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique match ID';
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

                field("Sell Order ID"; Rec."Sell Order ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sell order ID';
                }

                field("Seller Member No."; Rec."Sell Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the seller member number';
                }

                field("Buy Order ID"; Rec."Buy Order ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the buy order ID';
                }

                field("Buyer Member No."; Rec."Buy Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the buyer member number';
                }

                field("Matched Shares"; Rec."Matched Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of shares matched';
                }

                field("Match Price"; Rec."Price per Share")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price at which shares were matched';
                }

                field("Match Amount"; Rec."Matched Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of the match';
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the match has been posted';
                    StyleExpr = PostedStyle;
                }

                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date';
                }

                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who posted the match';
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the match';
                }
            }
        }

        area(factboxes)
        {
            part(MatchDetails; "Share Trading Match Details")
            {
                ApplicationArea = All;
                SubPageLink = "Match ID" = field("Match ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';

                action(PostSelected)
                {
                    ApplicationArea = All;
                    Caption = 'Post Selected';
                    Image = Post;
                    ToolTip = 'Post the selected matches';

                    trigger OnAction()
                    begin
                        PostSelectedMatches();
                    end;
                }

                action(PostAll)
                {
                    ApplicationArea = All;
                    Caption = 'Post All Unposted';
                    Image = PostBatch;
                    ToolTip = 'Post all unposted matches';

                    trigger OnAction()
                    begin
                        PostAllUnpostedMatches();
                    end;
                }

                action(ReverseSelected)
                {
                    ApplicationArea = All;
                    Caption = 'Reverse Selected';
                    Image = Undo;
                    ToolTip = 'Reverse the selected posted matches';

                    trigger OnAction()
                    begin
                        ReverseSelectedMatches();
                    end;
                }
            }

            group(View)
            {
                Caption = 'View';

                action(ViewSellOrder)
                {
                    ApplicationArea = All;
                    Caption = 'View Sell Order';
                    Image = Card;
                    ToolTip = 'View the sell order details';

                    trigger OnAction()
                    var
                        ShareTradingHeader: Record "Share Trading Header";
                    begin
                        if ShareTradingHeader.Get(Rec."Sell Order ID") then
                            Page.Run(Page::"Share Trading Order Card", ShareTradingHeader);
                    end;
                }

                action(ViewBuyOrder)
                {
                    ApplicationArea = All;
                    Caption = 'View Buy Order';
                    Image = Card;
                    ToolTip = 'View the buy order details';

                    trigger OnAction()
                    var
                        ShareTradingHeader: Record "Share Trading Header";
                    begin
                        if ShareTradingHeader.Get(Rec."Buy Order ID") then
                            Page.Run(Page::"Share Trading Order Card", ShareTradingHeader);
                    end;
                }
            }
        }

        area(reporting)
        {
            action(MatchReport)
            {
                ApplicationArea = All;
                Caption = 'Match Report';
                Image = Report;
                ToolTip = 'Print match details';

                trigger OnAction()
                var
                    ShareTradingMatch: Record "Share Trading Match";
                begin
                    ShareTradingMatch := Rec;
                    ShareTradingMatch.SetRecFilter();
                    Report.RunModal(Report::"Share Trading Match Report", true, false, ShareTradingMatch);
                end;
            }
        }
    }

    views
    {
        view(UnpostedMatches)
        {
            Caption = 'Unposted Matches';
            Filters = where(Posted = const(false));
        }

        view(PostedMatches)
        {
            Caption = 'Posted Matches';
            Filters = where(Posted = const(true));
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    var
        PostedStyle: Text;

    local procedure SetStyles()
    begin
        if Rec.Posted then
            PostedStyle := 'Strong'
        else
            PostedStyle := 'Standard';
    end;

    local procedure PostSelectedMatches()
    var
        ShareTradingMatch: Record "Share Trading Match";
        Counter: Integer;
    begin
        CurrPage.SetSelectionFilter(ShareTradingMatch);
        ShareTradingMatch.SetRange(Posted, false);

        if ShareTradingMatch.IsEmpty then begin
            Message('No unposted matches selected');
            exit;
        end;

        if not Confirm('Post %1 selected matches?', false, ShareTradingMatch.Count) then
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

    local procedure ReverseSelectedMatches()
    var
        ShareTradingMatch: Record "Share Trading Match";
        Counter: Integer;
        ReverseReason: Text[250];
    begin
        CurrPage.SetSelectionFilter(ShareTradingMatch);
        ShareTradingMatch.SetRange(Posted, true);

        if ShareTradingMatch.IsEmpty then begin
            Message('No posted matches selected');
            exit;
        end;

        if not Confirm('Reverse %1 selected matches?', false, ShareTradingMatch.Count) then
            exit;

        ReverseReason := CopyStr(GetReverseReason(), 1, MaxStrLen(ReverseReason));
        if ReverseReason = '' then
            exit;

        if ShareTradingMatch.FindSet() then begin
            repeat
                ShareTradingMatch.ReverseMatch(ReverseReason);
                Counter += 1;
            until ShareTradingMatch.Next() = 0;
        end;

        Message('Reversed %1 matches', Counter);
        CurrPage.Update();
    end;

    local procedure GetReverseReason(): Text
    begin
        // Return a default reason since InputQuery is not available in AL
        // In a real implementation, you might want to create a dedicated page for input
        exit('Manual reversal from match list');
    end;
}
