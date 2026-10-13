table 50614 "Share Trading Setup"
{
    Caption = 'Share Trading Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(2; "Par Value per Share"; Decimal)
        {
            Caption = 'Par Value per Share';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "Par Value per Share" <= 0 then
                    Error('Par Value per Share must be greater than zero');
            end;
        }

        field(3; "Minimum Shareholding"; Decimal)
        {
            Caption = 'Minimum Shareholding';
            DecimalPlaces = 0 : 0;
        }

        field(4; "Maximum Shareholding"; Decimal)
        {
            Caption = 'Maximum Shareholding';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if ("Maximum Shareholding" > 0) and ("Maximum Shareholding" < "Minimum Shareholding") then
                    Error('Maximum Shareholding cannot be less than Minimum Shareholding');
            end;
        }

        field(5; "Order Nos."; Code[20])
        {
            Caption = 'Order Nos.';
            TableRelation = "No. Series";
        }

        field(6; "Match Nos."; Code[20])
        {
            Caption = 'Match Nos.';
            TableRelation = "No. Series";
        }

        field(7; "Allow Partial Matching"; Boolean)
        {
            Caption = 'Allow Partial Matching';
        }

        field(8; "Auto Match Orders"; Boolean)
        {
            Caption = 'Auto Match Orders';
        }

        field(9; "Matching Price Method"; Enum "Share Matching Price Method")
        {
            Caption = 'Matching Price Method';
        }

        field(10; "Trading Start Time"; Time)
        {
            Caption = 'Trading Start Time';
        }

        field(11; "Trading End Time"; Time)
        {
            Caption = 'Trading End Time';
        }

        field(12; "Trading Days"; Text[50])
        {
            Caption = 'Trading Days';
        }

        field(13; "Enable Share Trading"; Boolean)
        {
            Caption = 'Enable Share Trading';
        }

        field(14; "Broker Commission %"; Decimal)
        {
            Caption = 'Broker Commission %';
            DecimalPlaces = 2 : 5;
        }

        field(15; "Transaction Fee"; Decimal)
        {
            Caption = 'Transaction Fee';
            DecimalPlaces = 2 : 2;
        }

        field(16; "Capital Account"; Code[20])
        {
            Caption = 'Capital Account';
            TableRelation = "G/L Account" where("Account Type" = const(Posting));
        }

        field(17; "Commission Account"; Code[20])
        {
            Caption = 'Commission Account';
            TableRelation = "G/L Account" where("Account Type" = const(Posting));
        }

        field(18; "Transaction Fee Account"; Code[20])
        {
            Caption = 'Transaction Fee Account';
            TableRelation = "G/L Account" where("Account Type" = const(Posting));
        }

        field(19; "Share Transfer Jnl. Template"; Code[10])
        {
            Caption = 'Share Transfer Journal Template';
            TableRelation = "Gen. Journal Template";
        }

        field(20; "Share Transfer Jnl. Batch"; Code[10])
        {
            Caption = 'Share Transfer Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Share Transfer Jnl. Template"));
        }

        field(21; "Require Approval"; Boolean)
        {
            Caption = 'Require Approval';
        }

        field(22; "Email Notifications"; Boolean)
        {
            Caption = 'Email Notifications';
        }

        field(23; "SMS Notifications"; Boolean)
        {
            Caption = 'SMS Notifications';
        }

        field(24; "Enable Negotiation"; Boolean)
        {
            Caption = 'Enable Negotiation';
            ToolTip = 'Allow buyers to make counter-offers on seller prices';
        }

        field(25; "Seller Approval Required"; Boolean)
        {
            Caption = 'Seller Approval Required';
            ToolTip = 'All trades require explicit seller approval';
        }

        field(26; "Negotiation Timeout Days"; Integer)
        {
            Caption = 'Negotiation Timeout Days';
            ToolTip = 'Number of days sellers have to respond to negotiation offers';
            MinValue = 1;
            MaxValue = 30;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Primary Key" := '';
        "Allow Partial Matching" := false; // Changed for exact matching model
        "Auto Match Orders" := false;
        "Matching Price Method" := "Matching Price Method"::"Average Price";
        "Trading Start Time" := 080000T; // 8:00 AM
        "Trading End Time" := 170000T;   // 5:00 PM
        "Trading Days" := 'Monday-Friday';
        "Enable Share Trading" := true;
        "Email Notifications" := true;
        "SMS Notifications" := false;
        "Require Approval" := true; // Changed for negotiation model
        "Enable Negotiation" := true;
        "Seller Approval Required" := true;
        "Negotiation Timeout Days" := 7;
    end;

    procedure CheckTradingHours()
    begin
        if not "Enable Share Trading" then
            Error('Share trading is currently disabled');

        if (Time < "Trading Start Time") or (Time > "Trading End Time") then
            Error('Trading is only allowed between %1 and %2', "Trading Start Time", "Trading End Time");
    end;

    procedure ValidateShareholding(MemberNo: Code[20]; NewShareBalance: Decimal)
    var
        Members: Record Members;
    begin
        if NewShareBalance < "Minimum Shareholding" then
            Error('Member %1 shareholding (%2) would be below minimum required (%3)',
                  MemberNo, NewShareBalance, "Minimum Shareholding");

        if ("Maximum Shareholding" > 0) and (NewShareBalance > "Maximum Shareholding") then
            Error('Member %1 shareholding (%2) would exceed maximum allowed (%3)',
                  MemberNo, NewShareBalance, "Maximum Shareholding");
    end;

    procedure ValidateNegotiationOffer(BuyOrderPrice: Decimal; SellOrderPrice: Decimal): Boolean
    begin
        if not "Enable Negotiation" then
            Error('Share price negotiation is not enabled');

        if not "Seller Approval Required" then
            Error('Seller approval is required for negotiations');

        // Allow any reasonable negotiation attempt
        if BuyOrderPrice <= 0 then
            Error('Buy offer price must be greater than zero');

        // Return true if this is a valid negotiation scenario
        exit(BuyOrderPrice <> SellOrderPrice);
    end;

    procedure GetNegotiationTimeoutDate(): Date
    begin
        exit(Today + "Negotiation Timeout Days");
    end;
}
