report 50605 "Share Trading Match Report"
{
    Caption = 'Share Trading Match Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/ShareTradingMatchReport.rdl';

    dataset
    {
        dataitem("Share Trading Match"; "Share Trading Match")
        {
            RequestFilterFields = "Match ID", "Match Date", "Sell Member No.", "Buy Member No.";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>'))
            {
            }
            column(UserID; UserId)
            {
            }

            column(MatchID; "Match ID")
            {
            }
            column(MatchDate; "Match Date")
            {
            }
            column(MatchTime; "Match Time")
            {
            }
            column(SellOrderID; "Sell Order ID")
            {
            }
            column(SellerMemberNo; "Sell Member No.")
            {
            }
            column(SellerMemberName; SellerMemberName)
            {
            }
            column(BuyOrderID; "Buy Order ID")
            {
            }
            column(BuyerMemberNo; "Buy Member No.")
            {
            }
            column(BuyerMemberName; BuyerMemberName)
            {
            }
            column(MatchedShares; "Matched Shares")
            {
            }
            column(MatchPrice; "Price per Share")
            {
            }
            column(MatchAmount; "Matched Amount")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedDate; "Posted Date")
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(CreatedBy; "Created By")
            {
            }

            // Order details
            column(SellOrderDate; SellOrderDate)
            {
            }
            column(SellOrderTime; SellOrderTime)
            {
            }
            column(SellOrderPrice; SellOrderPrice)
            {
            }
            column(BuyOrderDate; BuyOrderDate)
            {
            }
            column(BuyOrderTime; BuyOrderTime)
            {
            }
            column(BuyOrderPrice; BuyOrderPrice)
            {
            }

            // Financial details
            column(CommissionAmount; CommissionAmount)
            {
            }
            column(TradingFee; TradingFee)
            {
            }
            column(NetSellerAmount; NetSellerAmount)
            {
            }
            column(TotalBuyerCost; TotalBuyerCost)
            {
            }

            trigger OnAfterGetRecord()
            var
                Members: Record Members;
                SellOrder: Record "Share Trading Header";
                BuyOrder: Record "Share Trading Header";
                ShareTradingSetup: Record "Share Trading Setup";
            begin
                // Get member names
                SellerMemberName := '';
                if Members.Get("Sell Member No.") then
                    SellerMemberName := Members.Name;

                BuyerMemberName := '';
                if Members.Get("Buy Member No.") then
                    BuyerMemberName := Members.Name;

                // Get order details
                if SellOrder.Get("Sell Order ID") then begin
                    SellOrderDate := SellOrder."Order Date";
                    SellOrderTime := SellOrder."Order Time";
                    SellOrderPrice := SellOrder."Price per Share";
                end;

                if BuyOrder.Get("Buy Order ID") then begin
                    BuyOrderDate := BuyOrder."Order Date";
                    BuyOrderTime := BuyOrder."Order Time";
                    BuyOrderPrice := BuyOrder."Price per Share";
                end;

                // Calculate financial details
                if not ShareTradingSetup.Get() then
                    ShareTradingSetup.Init();

                CalcFinancialDetails(ShareTradingSetup, "Matched Amount");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(ShowOrderDetails; ShowOrderDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Order Details';
                        ToolTip = 'Show details of the original orders';
                    }

                    field(ShowFinancialBreakdown; ShowFinancialBreakdown)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Financial Breakdown';
                        ToolTip = 'Show commission and fee breakdown';
                    }

                    field(PrintMemberDetails; PrintMemberDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Member Details';
                        ToolTip = 'Include detailed member information';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            ShowOrderDetails := true;
            ShowFinancialBreakdown := true;
            PrintMemberDetails := true;
        end;
    }

    trigger OnPreReport()
    begin
        ReportTitle := 'Share Trading Match Report';
        FilterString := "Share Trading Match".GetFilters;
    end;

    local procedure CalcFinancialDetails(ShareTradingSetup: Record "Share Trading Setup"; MatchedAmount: Decimal)
    begin
        // Calculate commission using available field
        CommissionAmount := 0;
        if ShareTradingSetup."Broker Commission %" > 0 then
            CommissionAmount := MatchedAmount * ShareTradingSetup."Broker Commission %" / 100;

        // Get trading fee
        TradingFee := ShareTradingSetup."Transaction Fee";

        // Calculate net amounts (simplified calculation)
        NetSellerAmount := MatchedAmount - (CommissionAmount / 2) - (TradingFee / 2);
        TotalBuyerCost := MatchedAmount + (CommissionAmount / 2) + (TradingFee / 2);
    end;

    var
        ReportTitle: Text[100];
        FilterString: Text;
        ShowOrderDetails: Boolean;
        ShowFinancialBreakdown: Boolean;
        PrintMemberDetails: Boolean;
        SellerMemberName: Text[100];
        BuyerMemberName: Text[100];
        SellOrderDate: Date;
        SellOrderTime: Time;
        SellOrderPrice: Decimal;
        BuyOrderDate: Date;
        BuyOrderTime: Time;
        BuyOrderPrice: Decimal;
        CommissionAmount: Decimal;
        TradingFee: Decimal;
        NetSellerAmount: Decimal;
        TotalBuyerCost: Decimal;
}
