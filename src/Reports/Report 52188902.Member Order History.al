report 50604 "Member Order History"
{
    Caption = 'Member Order History';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/MemberOrderHistory.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Name;
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
            column(PeriodText; PeriodText)
            {
            }

            column(MemberNo; "No.")
            {
            }
            column(MemberName; Name)
            {
            }
            column(MemberCapitalBalance; MemberCapitalBalance)
            {
            }
            column(MemberShareBalance; MemberShareBalance)
            {
            }
            column(AvailableSharesForSale; AvailableSharesForSale)
            {
            }

            // Member summary fields
            column(MemberTotalOrders; MemberTotalOrders)
            {
            }
            column(MemberBuyOrders; MemberBuyOrders)
            {
            }
            column(MemberSellOrders; MemberSellOrders)
            {
            }
            column(MemberTotalShares; MemberTotalShares)
            {
            }
            column(MemberTotalValue; MemberTotalValue)
            {
            }
            column(MemberOpenOrders; MemberOpenOrders)
            {
            }
            column(MemberCompletedOrders; MemberCompletedOrders)
            {
            }

            dataitem("Share Trading Header"; "Share Trading Header")
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = sorting("Member No.", "Order Date", "Order Time");

                column(OrderID; "Order ID")
                {
                }
                column(OrderDate; "Order Date")
                {
                }
                column(OrderTime; "Order Time")
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
                column(MatchedAmount; "Matched Amount")
                {
                }
                column(RemainingAmount; "Remaining Amount")
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
                column(CancelReason; "Cancel Reason")
                {
                }
                column(CreatedBy; "Created By")
                {
                }

                trigger OnPreDataItem()
                begin
                    if (FromDate <> 0D) and (ToDate <> 0D) then
                        SetRange("Order Date", FromDate, ToDate)
                    else if (FromDate <> 0D) then
                        SetFilter("Order Date", '>=%1', FromDate)
                    else if (ToDate <> 0D) then
                        SetFilter("Order Date", '<=%1', ToDate);

                    if ShowActiveOnly then begin
                        SetRange(Cancelled, false);
                        SetFilter(Status, '<>%1', Status::Completed);
                    end;

                    // Initialize member counters
                    MemberTotalOrders := 0;
                    MemberBuyOrders := 0;
                    MemberSellOrders := 0;
                    MemberTotalShares := 0;
                    MemberTotalValue := 0;
                    MemberOpenOrders := 0;
                    MemberCompletedOrders := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    // Update member counters
                    MemberTotalOrders += 1;
                    MemberTotalShares += "Total No. Shares";
                    MemberTotalValue += "Selling/Buying Price";

                    case "Order Type" of
                        "Order Type"::Buy:
                            MemberBuyOrders += 1;
                        "Order Type"::Sell:
                            MemberSellOrders += 1;
                    end;

                    if Status = Status::Completed then
                        MemberCompletedOrders += 1
                    else if not Cancelled then
                        MemberOpenOrders += 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                ShareTradingMgmt: Codeunit "Share Trading Management";
                Legacy: Codeunit Legacy;
                MAct: Codeunit "Member Activities";
            begin
                // Get current member balances using the new method
                MemberCapitalBalance := MAct.GetAccountBalance(Legacy.GetShareCapitalAccount("No."));

                // Calculate share balance and available shares
                MemberShareBalance := ShareTradingMgmt.GetMemberShareBalance("No.");
                AvailableSharesForSale := ShareTradingMgmt.GetMemberAvailableShares("No.");
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

                    field(ShowActiveOnly; ShowActiveOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Active Orders Only';
                        ToolTip = 'Show only active (non-cancelled, non-completed) orders';
                    }

                    field(IncludeMatches; IncludeMatches)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Match Details';
                        ToolTip = 'Include detailed match information';
                    }

                    field(ShowMemberSummary; ShowMemberSummary)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Member Summary';
                        ToolTip = 'Show summary statistics for each member';
                    }
                }

                group(Period)
                {
                    Caption = 'Period';

                    field(FromDate; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                        ToolTip = 'Start date for the report';
                    }

                    field(ToDate; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                        ToolTip = 'End date for the report';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            ShowActiveOnly := false;
            IncludeMatches := true;
            ShowMemberSummary := true;
            FromDate := CalcDate('<-1M>', Today);
            ToDate := Today;
        end;
    }

    trigger OnPreReport()
    begin
        ReportTitle := 'Member Order History';

        FilterString := Members.GetFilters;

        if (FromDate <> 0D) and (ToDate <> 0D) then
            PeriodText := StrSubstNo('Period: %1 to %2', FromDate, ToDate)
        else if (FromDate <> 0D) then
            PeriodText := StrSubstNo('Period: From %1', FromDate)
        else if (ToDate <> 0D) then
            PeriodText := StrSubstNo('Period: To %1', ToDate)
        else
            PeriodText := 'Period: All dates';
    end;

    var
        ReportTitle: Text[100];
        FilterString: Text;
        PeriodText: Text[100];
        ShowActiveOnly: Boolean;
        IncludeMatches: Boolean;
        ShowMemberSummary: Boolean;
        FromDate: Date;
        ToDate: Date;
        MemberCapitalBalance: Decimal;
        MemberShareBalance: Decimal;
        AvailableSharesForSale: Decimal;
        MemberTotalOrders: Integer;
        MemberBuyOrders: Integer;
        MemberSellOrders: Integer;
        MemberTotalShares: Decimal;
        MemberTotalValue: Decimal;
        MemberOpenOrders: Integer;
        MemberCompletedOrders: Integer;
        CounterpartyMemberNo: Code[20];
        CounterpartyMemberName: Text[100];
}
