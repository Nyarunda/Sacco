table 50602 "Share Trading Header"
{
    Caption = 'Share Trading Header';
    LookupPageID = "Share Trading Order List";
    DrillDownPageID = "Share Trading Order List";

    fields
    {
        field(1; "Order ID"; Code[20])
        {
            Caption = 'Order ID';
            Editable = false;
        }

        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                if Members.Get("Member No.") then begin
                    "Member Name" := Members.Name;
                    UpdateMemberCapitalBalance();
                    Validate("Order Type");
                end;
            end;
        }

        field(3; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = false;
        }

        field(4; "Order Type"; Enum "Share Order Type")
        {
            Caption = 'Order Type';

            trigger OnValidate()
            begin
                if "Order Type" = "Order Type"::Sell then
                    ValidateSellerAvailability();
            end;
        }

        field(5; "Total No. Shares"; Decimal)
        {
            Caption = 'Total No. Shares';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if "Total No. Shares" <= 0 then
                    Error('Total shares must be greater than zero');

                CalcTotalAmount();

            end;
        }

        field(6; "Price per Share"; Decimal)
        {
            Caption = 'Price per Share';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "Price per Share" <= 0 then
                    Error('Price per share must be greater than zero');

                CalcTotalAmount();
            end;
        }

        field(7; "Matched Shares"; Decimal)
        {
            Caption = 'Matched Shares';
            Editable = false;
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                "Remaining Shares" := "Total No. Shares" - "Matched Shares";
                CalcMatchedAmount();
            end;
        }

        field(8; "Remaining Shares"; Decimal)
        {
            Caption = 'Remaining Shares';
            Editable = false;
            DecimalPlaces = 0 : 0;
        }

        field(9; Status; Enum "Share Order Status")
        {
            Caption = 'Status';
            Editable = false;
        }

        field(10; "Selling/Buying Price"; Decimal)
        {
            Caption = 'Total Amount';
            DecimalPlaces = 2 : 2;
            trigger OnValidate()
            begin
                if "Total No. Shares" > 0 then
                    "Price per Share" := Round("Selling/Buying Price" / "Total No. Shares");

                CalcTotalAmount();
            end;
        }

        field(11; "Matched Amount"; Decimal)
        {
            Caption = 'Matched Amount';
            Editable = false;
            DecimalPlaces = 2 : 2;
        }

        field(12; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
            Editable = false;
            DecimalPlaces = 2 : 2;
        }

        field(13; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Editable = false;
        }

        field(14; "Order Time"; Time)
        {
            Caption = 'Order Time';
            Editable = false;
        }

        field(15; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }

        field(16; "Posted"; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }

        field(17; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            Editable = false;
        }

        field(18; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }

        field(19; "Cancelled"; Boolean)
        {
            Caption = 'Cancelled';
            Editable = false;
        }

        field(20; "Cancelled Date"; Date)
        {
            Caption = 'Cancelled Date';
            Editable = false;
        }

        field(21; "Cancelled By"; Code[50])
        {
            Caption = 'Cancelled By';
            Editable = false;
        }

        field(22; "Cancel Reason"; Text[250])
        {
            Caption = 'Cancel Reason';
        }

        field(23; "Available Shares"; Decimal)
        {
            Caption = 'Available Shares';
            Editable = false;
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
            CalcFormula = sum("Share Trading Header"."Remaining Shares"
                             where("Member No." = field("Member No."),
                                   "Order Type" = const(Sell),
                                   Status = filter(Open | "Partially Matched")));
        }

        field(24; "Member Capital Balance"; Decimal)
        {
            Caption = 'Member Capital Balance';
            Editable = false;
            DecimalPlaces = 2 : 2;
            FieldClass = Normal;
        }
        field(25; "Par Value per Share"; Decimal)
        {
            Caption = 'Par Value per Share';
            Editable = false;
            DecimalPlaces = 2 : 2;
        }



        field(26; "Active"; Boolean)
        {
            Caption = 'Active';
            Editable = false;
        }


        field(27; "Bid Type"; Enum "Bid Type")
        {
            Caption = 'Bid Type';

            trigger OnValidate()
            begin
            end;
        }


        field(28; "Shares Sold"; Decimal)
        {
            Caption = 'Shares Sold';
            Editable = false;
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
            CalcFormula = sum("Share Trading Match"."Matched Shares"
                             where("Sell Order ID" = field("Order ID")));
        }

        field(29; "Shares Bought"; Decimal)
        {
            Caption = 'Shares Bought';
            Editable = false;
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
            CalcFormula = sum("Share Trading Match"."Matched Shares"
                             where("Buy Order ID" = field("Order ID")));
        }



        field(30; "Shares To Trade"; Decimal)
        {
            Caption = 'Shares To Trade';
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                "Total No. Shares" := "Shares To Trade" / "Par Value per Share";
                CalcTotalAmount();

            end;
        }
    }

    keys
    {
        key(PK; "Order ID")
        {
            Clustered = true;
        }

        key(Member; "Member No.", "Order Date", "Order Time")
        {
        }

        key(OrderType; "Order Type", Status, "Price per Share")
        {
        }

        key(Status; Status, "Order Date", "Order Time")
        {
        }
    }

    trigger OnInsert()
    begin
        ShareTradingSetup.Get();

        if "Order ID" = '' then
            "Order ID" := NoSeriesManagement.GetNextNo(ShareTradingSetup."Order Nos.", Today, true);

        "Order Date" := Today;
        "Order Time" := Time;
        "Created By" := UserId;
        Status := Status::Open;
        "Remaining Shares" := "Total No. Shares";
    end;

    trigger OnModify()
    begin
        TestStatusAllowEdit();
    end;

    trigger OnDelete()
    begin
        TestStatusAllowEdit();

        // Check for matches
        ShareTradingMatch.Reset();
        ShareTradingMatch.SetRange("Sell Order ID", "Order ID");
        ShareTradingMatch.SetRange("Buy Order ID", "Order ID");
        if not ShareTradingMatch.IsEmpty then
            Error('Cannot delete order with existing matches');
    end;

    var
        Members: Record Members;
        ShareTradingSetup: Record "Share Trading Setup";
        ShareTradingMatch: Record "Share Trading Match";
        NoSeriesManagement: Codeunit "No. Series";

    local procedure CalcTotalAmount()
    begin
        "Selling/Buying Price" := "Total No. Shares" * "Price per Share";
        "Remaining Amount" := "Remaining Shares" * "Price per Share";
        "Shares To Trade" := "Total No. Shares" * "Par Value per Share";


        if "Order Type" = "Order Type"::Sell then
            ValidateSellerAvailability();
    end;

    local procedure CalcMatchedAmount()
    begin
        "Matched Amount" := "Matched Shares" * "Price per Share";
        "Remaining Amount" := "Remaining Shares" * "Price per Share";
    end;

    local procedure ValidateSellerAvailability()
    var
        CurrentOpenShares: Decimal;
        AvailableShares: Decimal;
        MemberCapitalBalance: Decimal;
        ParValuePerShare: Decimal;
        Members: Record Members;
        Legacy: Codeunit Legacy;
        MAct: Codeunit "Member Activities";
        Shares: Decimal;
    begin
        if ("Order Type" <> "Order Type"::Sell) or ("Member No." = '') then
            exit;



        if "Shares To Trade" > "Member Capital Balance" then
            Error('Insufficient capital balance to place this order');

        ShareTradingSetup.Get();
        ParValuePerShare := ShareTradingSetup."Par Value per Share";

        if ParValuePerShare <= 0 then
            Error('Par Value per Share must be configured in Share Trading Setup');

        // Get member's current capital balance using the new method
        if not Members.Get("Member No.") then
            exit;

        Shares := MAct.GetAccountBalance(Legacy.GetShareCapitalAccount("Member No."));
        MemberCapitalBalance := Shares;

        // Calculate available shares from capital balance
        AvailableShares := MemberCapitalBalance / ParValuePerShare;

        // Get current open sell orders for this member
        CurrentOpenShares := GetMemberOpenSellShares();

        // Validate seller can place this order
        if (CurrentOpenShares + "Total No. Shares") > AvailableShares then
            Error('Insufficient shares available. Available: %1, Already on sale: %2, Requested: %3',
                  AvailableShares, CurrentOpenShares, "Total No. Shares");


    end;

    local procedure GetMemberOpenSellShares(): Decimal
    var
        ShareTradingHeaderLocal: Record "Share Trading Header";
        OpenShares: Decimal;
    begin
        ShareTradingHeaderLocal.Reset();
        ShareTradingHeaderLocal.SetRange("Member No.", "Member No.");
        ShareTradingHeaderLocal.SetRange("Order Type", ShareTradingHeaderLocal."Order Type"::Sell);
        ShareTradingHeaderLocal.SetRange(Posted, false);
        ShareTradingHeaderLocal.SetFilter(Status, '<>%1', Status::Cancelled);
        ShareTradingHeaderLocal.SetFilter("Order ID", '<>%1', "Order ID"); // Exclude current record

        if ShareTradingHeaderLocal.FindSet() then begin
            repeat
                OpenShares += ShareTradingHeaderLocal."Remaining Shares";
            until ShareTradingHeaderLocal.Next() = 0;
        end;

        exit(OpenShares);
    end;

    local procedure TestStatusAllowEdit()
    begin
        //if Status in [Status::Completed, Status::Cancelled] then
        //  Error('Cannot modify %1 order', Status);

        if Posted then
            Error('Cannot modify posted order');
    end;

    procedure UpdateMatchedShares()
    var
        TotalMatched: Decimal;
    begin



        if "Order Type" = "Order Type"::Sell then begin
            CalcFields("Shares Sold");
            TotalMatched := "Shares Sold";
        end
        else begin
            CalcFields("Shares Bought");
            TotalMatched := "Shares Bought";
        end;




        "Matched Shares" := TotalMatched;
        "Remaining Shares" := "Total No. Shares" - "Matched Shares";

        // Update status based on matching
        if "Remaining Shares" = 0 then
            Status := Status::Completed
        else if "Matched Shares" > 0 then
            Status := Status::"Partially Matched";

        CalcMatchedAmount();
        Modify();
    end;

    procedure CancelOrder(Reason: Text[250])
    begin
        TestStatusAllowEdit();

        if "Matched Shares" > 0 then
            Error('Cannot cancel order with existing matches');

        Cancelled := true;
        "Cancelled Date" := Today;
        "Cancelled By" := UserId;
        "Cancel Reason" := Reason;
        Status := Status::Cancelled;

        Modify();
    end;

    procedure GetAvailableSharesFromCapital(): Decimal
    var
        ParValuePerShare: Decimal;
        Members: Record Members;
        Legacy: Codeunit Legacy;
        MAct: Codeunit "Member Activities";
        Shares: Decimal;
    begin
        ShareTradingSetup.Get();
        ParValuePerShare := ShareTradingSetup."Par Value per Share";

        if ParValuePerShare <= 0 then
            exit(0);

        if not Members.Get("Member No.") then
            exit(0);

        Shares := MAct.GetAccountBalance(Legacy.GetShareCapitalAccount("Member No."));
        exit(round(Shares / ParValuePerShare));
    end;

    procedure UpdateMemberCapitalBalance()
    var
        Members: Record Members;
        Legacy: Codeunit Legacy;
        MAct: Codeunit "Member Activities";
        ShareTradingSetup: Record "Share Trading Setup";
    begin
        if "Member No." = '' then
            exit;
        ShareTradingSetup.get();
        ShareTradingSetup.TestField("Par Value per Share");
        "Par Value per Share" := ShareTradingSetup."Par Value per Share";
        if not Members.Get("Member No.") then
            exit;

        "Member Capital Balance" := MAct.GetAccountBalance(Legacy.GetShareCapitalAccount("Member No."));
    end;
}
