report 50602 "Share Trading Order Book"
{
    Caption = 'Share Trading Order Book';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/ShareTradingOrderBook.rdl';

    dataset
    {
        dataitem("Share Trading Header"; "Share Trading Header")
        {
            RequestFilterFields = "Order Date", "Order Type", Status, "Member No.";
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

            column(OrderID; "Order ID")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(OrderTime; "Order Time")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(OrderType; "Order Type")
            {
            }
            column(TotalShares; "Total No. Shares")
            {
            }
            column(PricePerShare; "Price per Share")
            {
            }
            column(TotalAmount; "Selling/Buying Price")
            {
            }
            column(MatchedShares; "Matched Shares")
            {
            }
            column(RemainingShares; "Remaining Shares")
            {
            }
            column(Status; Status)
            {
            }
            column(Posted; Posted)
            {
            }
            column(Cancelled; Cancelled)
            {
            }
            column(CreatedBy; "Created By")
            {
            }

            // Summary fields
            column(TotalBuyOrders; TotalBuyOrders)
            {
            }
            column(TotalSellOrders; TotalSellOrders)
            {
            }
            column(TotalBuyShares; TotalBuyShares)
            {
            }
            column(TotalSellShares; TotalSellShares)
            {
            }
            column(TotalBuyAmount; TotalBuyAmount)
            {
            }
            column(TotalSellAmount; TotalSellAmount)
            {
            }
            column(OpenBuyOrders; OpenBuyOrders)
            {
            }
            column(OpenSellOrders; OpenSellOrders)
            {
            }
            column(OpenBuyShares; OpenBuyShares)
            {
            }
            column(OpenSellShares; OpenSellShares)
            {
            }

            trigger OnPreDataItem()
            begin
                SetFilter(Status, '<>%1', Status::Completed);
                SetRange(Cancelled, false);

                if GetFilter("Order Date") = '' then
                    SetRange("Order Date", Today);

                FilterString := GetFilters;

                // Initialize counters
                TotalBuyOrders := 0;
                TotalSellOrders := 0;
                TotalBuyShares := 0;
                TotalSellShares := 0;
                TotalBuyAmount := 0;
                TotalSellAmount := 0;
                OpenBuyOrders := 0;
                OpenSellOrders := 0;
                OpenBuyShares := 0;
                OpenSellShares := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                // Count totals
                case "Order Type" of
                    "Order Type"::Buy:
                        begin
                            TotalBuyOrders += 1;
                            TotalBuyShares += "Total No. Shares";
                            TotalBuyAmount += "Selling/Buying Price";
                            if Status = Status::Open then begin
                                OpenBuyOrders += 1;
                                OpenBuyShares += "Remaining Shares";
                            end;
                        end;
                    "Order Type"::Sell:
                        begin
                            TotalSellOrders += 1;
                            TotalSellShares += "Total No. Shares";
                            TotalSellAmount += "Selling/Buying Price";
                            if Status = Status::Open then begin
                                OpenSellOrders += 1;
                                OpenSellShares += "Remaining Shares";
                            end;
                        end;
                end;
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

                    field(IncludePartiallyMatched; IncludePartiallyMatched)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Partially Matched Orders';
                        ToolTip = 'Include orders that are partially matched';
                    }

                    field(GroupByOrderType; GroupByOrderType)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Order Type';
                        ToolTip = 'Group orders by Buy/Sell type';
                    }

                    field(ShowSummary; ShowSummary)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Summary';
                        ToolTip = 'Show summary statistics';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            IncludePartiallyMatched := true;
            GroupByOrderType := true;
            ShowSummary := true;
        end;
    }

    trigger OnPreReport()
    begin
        ReportTitle := 'Share Trading Order Book';

        if not IncludePartiallyMatched then begin
            "Share Trading Header".SetFilter(Status, '%1', "Share Trading Header".Status::Open);
        end;
    end;

    var
        ReportTitle: Text[100];
        FilterString: Text;
        IncludePartiallyMatched: Boolean;
        GroupByOrderType: Boolean;
        ShowSummary: Boolean;
        TotalBuyOrders: Integer;
        TotalSellOrders: Integer;
        TotalBuyShares: Decimal;
        TotalSellShares: Decimal;
        TotalBuyAmount: Decimal;
        TotalSellAmount: Decimal;
        OpenBuyOrders: Integer;
        OpenSellOrders: Integer;
        OpenBuyShares: Decimal;
        OpenSellShares: Decimal;
}
