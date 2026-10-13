page 50800 "Share Trading Match Subpage"
{
    Caption = 'Order Matches';
    PageType = ListPart;
    SourceTable = "Share Trading Match";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

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

                field("Buy Order ID"; Rec."Buy Order ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the buy order ID';
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

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the match';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PostMatch)
            {
                ApplicationArea = All;
                Caption = 'Post Match';
                Image = Post;
                ToolTip = 'Post this match';
                Enabled = not Rec.Posted;

                trigger OnAction()
                begin
                    if Confirm('Post this match?') then begin
                        Rec.PostMatch();
                        CurrPage.Update();
                        Message('Match posted successfully');
                    end;
                end;
            }

            action(ReverseMatch)
            {
                ApplicationArea = All;
                Caption = 'Reverse Match';
                Image = Undo;
                ToolTip = 'Reverse this posted match';
                Enabled = Rec.Posted;

                trigger OnAction()
                var
                    ReverseReason: Text[250];
                begin
                    if not Confirm('Are you sure you want to reverse this match?') then
                        exit;

                    ReverseReason := CopyStr(GetReverseReason(), 1, MaxStrLen(ReverseReason));
                    if ReverseReason = '' then
                        exit;

                    Rec.ReverseMatch(ReverseReason);
                    CurrPage.Update();
                    Message('Match reversed successfully');
                end;
            }

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

    local procedure GetReverseReason(): Text
    begin
        // Return a default reason since InputQuery is not available in AL
        // In a real implementation, you might want to create a dedicated page for input
        exit('Manual reversal from match subpage');
    end;
}
