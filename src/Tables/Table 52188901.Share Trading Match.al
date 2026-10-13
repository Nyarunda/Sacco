table 50603 "Share Trading Match"
{
    Caption = 'Share Trading Match';
    DrillDownPageID = "Share Trading Match List";

    fields
    {
        field(1; "Match ID"; Code[20])
        {
            Caption = 'Match ID';
            Editable = false;
        }

        field(2; "Sell Order ID"; Code[20])
        {
            Caption = 'Sell Order ID';
            TableRelation = "Share Trading Header"."Order ID" where("Order Type" = const(Sell));

            trigger OnValidate()
            begin
                if SellOrder.Get("Sell Order ID") then begin
                    "Sell Member No." := SellOrder."Member No.";
                    "Sell Member Name" := SellOrder."Member Name";
                end;
            end;
        }

        field(3; "Buy Order ID"; Code[20])
        {
            Caption = 'Buy Order ID';
            TableRelation = "Share Trading Header"."Order ID" where("Order Type" = const(Buy));

            trigger OnValidate()
            begin
                if BuyOrder.Get("Buy Order ID") then begin
                    "Buy Member No." := BuyOrder."Member No.";
                    "Buy Member Name" := BuyOrder."Member Name";
                end;
            end;
        }

        field(4; "Matched Shares"; Decimal)
        {
            Caption = 'Matched Shares';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if "Matched Shares" <= 0 then
                    Error('Matched shares must be greater than zero');

                CalcMatchedAmount();
            end;
        }

        field(5; "Price per Share"; Decimal)
        {
            Caption = 'Price per Share';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "Price per Share" <= 0 then
                    Error('Price per share must be greater than zero');

                CalcMatchedAmount();
            end;
        }

        field(6; "Matched Amount"; Decimal)
        {
            Caption = 'Matched Amount';
            Editable = false;
            DecimalPlaces = 2 : 2;
        }

        field(7; "Match Date"; Date)
        {
            Caption = 'Match Date';
            Editable = false;
        }

        field(8; "Match Time"; Time)
        {
            Caption = 'Match Time';
            Editable = false;
        }

        field(9; "Match DateTime"; DateTime)
        {
            Caption = 'Match DateTime';
            Editable = false;
        }

        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }

        field(11; "Sell Member No."; Code[20])
        {
            Caption = 'Sell Member No.';
            Editable = false;
            TableRelation = Members."No.";
        }

        field(12; "Sell Member Name"; Text[100])
        {
            Caption = 'Sell Member Name';
            Editable = false;
        }

        field(13; "Buy Member No."; Code[20])
        {
            Caption = 'Buy Member No.';
            Editable = false;
            TableRelation = Members."No.";
        }

        field(14; "Buy Member Name"; Text[100])
        {
            Caption = 'Buy Member Name';
            Editable = false;
        }

        field(15; "Posted"; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }

        field(16; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            Editable = false;
        }

        field(17; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }

        field(18; "Reversed"; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }

        field(19; "Reversed Date"; Date)
        {
            Caption = 'Reversed Date';
            Editable = false;
        }

        field(20; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
        }

        field(21; "Reversal Reason"; Text[250])
        {
            Caption = 'Reversal Reason';
        }

        field(22; "Sell Account No."; Code[50])
        {
            Caption = 'Sell Account No.';
            Editable = false;
        }
        field(23; "Buy Account No."; Code[50])
        {
            Caption = 'Buy Account No.';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Match ID")
        {
            Clustered = true;
        }

        key(SellOrder; "Sell Order ID", "Match DateTime")
        {
        }

        key(BuyOrder; "Buy Order ID", "Match DateTime")
        {
        }

        key(DateTime; "Match DateTime")
        {
        }

        key(Members; "Sell Member No.", "Buy Member No.", "Match DateTime")
        {
        }
    }

    trigger OnInsert()
    begin
        ShareTradingSetup.Get();

        if "Match ID" = '' then
            "Match ID" := NoSeriesManagement.GetNextNo(ShareTradingSetup."Match Nos.", Today, true);

        "Match Date" := Today;
        "Match Time" := Time;
        "Match DateTime" := CurrentDateTime;
        "Created By" := UserId;

        ValidateMatch();
    end;

    trigger OnModify()
    begin
        if Posted then
            Error('Cannot modify posted match');

        if Reversed then
            Error('Cannot modify reversed match');
    end;

    trigger OnDelete()
    begin
        if Posted then
            Error('Cannot delete posted match');

        if Reversed then
            Error('Cannot delete reversed match');
    end;

    var
        SellOrder: Record "Share Trading Header";
        BuyOrder: Record "Share Trading Header";
        ShareTradingSetup: Record "Share Trading Setup";
        NoSeriesManagement: Codeunit "No. Series";

    local procedure CalcMatchedAmount()
    begin
        "Matched Amount" := "Matched Shares" * "Price per Share";
    end;

    local procedure ValidateMatch()
    begin
        // Validate sell order
        if not SellOrder.Get("Sell Order ID") then
            Error('Sell Order %1 does not exist', "Sell Order ID");

        if SellOrder."Order Type" <> SellOrder."Order Type"::Sell then
            Error('Order %1 is not a sell order', "Sell Order ID");

        if SellOrder.Status in [SellOrder.Status::Completed, SellOrder.Status::Cancelled] then
            Error('Sell Order %1 is %2', "Sell Order ID", SellOrder.Status);

        // Validate buy order
        if not BuyOrder.Get("Buy Order ID") then
            Error('Buy Order %1 does not exist', "Buy Order ID");

        if BuyOrder."Order Type" <> BuyOrder."Order Type"::Buy then
            Error('Order %1 is not a buy order', "Buy Order ID");

        if BuyOrder.Status in [BuyOrder.Status::Completed, BuyOrder.Status::Cancelled] then
            Error('Buy Order %1 is %2', "Buy Order ID", BuyOrder.Status);

        // Validate shares don't exceed remaining
        if "Matched Shares" > SellOrder."Remaining Shares" then
            Error('Matched shares (%1) exceed sell order remaining shares (%2)',
                  "Matched Shares", SellOrder."Remaining Shares");

        if "Matched Shares" > BuyOrder."Remaining Shares" then
            Error('Matched shares (%1) exceed buy order remaining shares (%2)',
                  "Matched Shares", BuyOrder."Remaining Shares");

        // Validate price is acceptable
        if "Price per Share" > BuyOrder."Price per Share" then
            Error('Match price (%1) exceeds buy order price (%2)',
                  "Price per Share", BuyOrder."Price per Share");

        if "Price per Share" < SellOrder."Price per Share" then
            Error('Match price (%1) is below sell order price (%2)',
                  "Price per Share", SellOrder."Price per Share");

        // Validate same member doesn't buy/sell to themselves
        if SellOrder."Member No." = BuyOrder."Member No." then
            Error('Member cannot trade with themselves');
    end;

    procedure UpdateOrdersMatching()
    begin
        // Update sell order
        if SellOrder.Get("Sell Order ID") then
            SellOrder.UpdateMatchedShares();

        // Update buy order
        if BuyOrder.Get("Buy Order ID") then
            BuyOrder.UpdateMatchedShares();
    end;

    procedure PostMatch()
    var
        ShareTradingPost: Codeunit "Share Trading Post";
    begin
        TestField(Posted, false);
        TestField(Reversed, false);

        ShareTradingPost.PostMatch(Rec);

        Posted := true;
        "Posted Date" := Today;
        "Posted By" := UserId;
        Modify();
    end;

    procedure ReverseMatch(ReasonText: Text[250])
    var
        ShareTradingPost: Codeunit "Share Trading Post";
    begin
        TestField(Posted, true);
        TestField(Reversed, false);

        ShareTradingPost.ReverseMatch(Rec, ReasonText);

        Reversed := true;
        "Reversed Date" := Today;
        "Reversed By" := UserId;
        "Reversal Reason" := ReasonText;
        Modify();
    end;
}
