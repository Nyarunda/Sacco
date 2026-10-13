report 50603 "Share Trading Activity"
{
    Caption = 'Share Trading Activity Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/ShareTradingActivity.rdl';

    dataset
    {
        dataitem("Share Trading Match"; "Share Trading Match")
        {
            RequestFilterFields = "Match Date", "Sell Member No.", "Buy Member No.";
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

            // Summary fields
            column(TotalMatches; TotalMatches)
            {
            }
            column(TotalSharesTraded; TotalSharesTraded)
            {
            }
            column(TotalValueTraded; TotalValueTraded)
            {
            }
            column(AveragePrice; AveragePrice)
            {
            }
            column(HighestPrice; HighestPrice)
            {
            }
            column(LowestPrice; LowestPrice)
            {
            }
            column(PostedMatches; PostedMatches)
            {
            }
            column(UnpostedMatches; UnpostedMatches)
            {
            }
            column(UniqueSellers; UniqueSellers)
            {
            }
            column(UniqueBuyers; UniqueBuyers)
            {
            }

            trigger OnPreDataItem()
            begin
                if GetFilter("Match Date") = '' then
                    SetRange("Match Date", Today);

                FilterString := GetFilters;

                // Initialize counters
                TotalMatches := 0;
                TotalSharesTraded := 0;
                TotalValueTraded := 0;
                PostedMatches := 0;
                UnpostedMatches := 0;
                HighestPrice := 0;
                LowestPrice := 999999;

                // Initialize member tracking
                Clear(SellerMembers);
                Clear(BuyerMembers);
            end;

            trigger OnAfterGetRecord()
            var
                Members: Record Members;
            begin
                // Get member names
                SellerMemberName := '';
                if Members.Get("Sell Member No.") then
                    SellerMemberName := Members.Name;

                BuyerMemberName := '';
                if Members.Get("Buy Member No.") then
                    BuyerMemberName := Members.Name;

                // Update counters
                TotalMatches += 1;
                TotalSharesTraded += "Matched Shares";
                TotalValueTraded += "Matched Amount";

                if Posted then
                    PostedMatches += 1
                else
                    UnpostedMatches += 1;

                // Track price ranges
                if "Price per Share" > HighestPrice then
                    HighestPrice := "Price per Share";
                if "Price per Share" < LowestPrice then
                    LowestPrice := "Price per Share";

                // Track unique members
                if not SellerMembers.ContainsKey("Sell Member No.") then
                    SellerMembers.Add("Sell Member No.", true);

                if not BuyerMembers.ContainsKey("Buy Member No.") then
                    BuyerMembers.Add("Buy Member No.", true);
            end;

            trigger OnPostDataItem()
            begin
                // Calculate averages
                if TotalSharesTraded > 0 then
                    AveragePrice := TotalValueTraded / TotalSharesTraded
                else
                    AveragePrice := 0;

                if LowestPrice = 999999 then
                    LowestPrice := 0;

                // Count unique members
                UniqueSellers := SellerMembers.Count;
                UniqueBuyers := BuyerMembers.Count;
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

                    field(ShowPostedOnly; ShowPostedOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Posted Matches Only';
                        ToolTip = 'Show only posted matches';
                    }

                    field(GroupByDate; GroupByDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Date';
                        ToolTip = 'Group matches by date';
                    }

                    field(ShowMemberDetails; ShowMemberDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Member Details';
                        ToolTip = 'Show detailed member information';
                    }

                    field(IncludeSummary; IncludeSummary)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Summary';
                        ToolTip = 'Include summary statistics';
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
            ShowPostedOnly := false;
            GroupByDate := true;
            ShowMemberDetails := true;
            IncludeSummary := true;
            FromDate := Today;
            ToDate := Today;
        end;
    }

    trigger OnPreReport()
    begin
        ReportTitle := 'Share Trading Activity Report';

        if ShowPostedOnly then
            "Share Trading Match".SetRange(Posted, true);

        if (FromDate <> 0D) and (ToDate <> 0D) then begin
            "Share Trading Match".SetRange("Match Date", FromDate, ToDate);
            PeriodText := StrSubstNo('Period: %1 to %2', FromDate, ToDate);
        end else if (FromDate <> 0D) then begin
            "Share Trading Match".SetFilter("Match Date", '>=%1', FromDate);
            PeriodText := StrSubstNo('Period: From %1', FromDate);
        end else if (ToDate <> 0D) then begin
            "Share Trading Match".SetFilter("Match Date", '<=%1', ToDate);
            PeriodText := StrSubstNo('Period: To %1', ToDate);
        end else
            PeriodText := 'Period: All dates';
    end;

    var
        ReportTitle: Text[100];
        FilterString: Text;
        PeriodText: Text[100];
        ShowPostedOnly: Boolean;
        GroupByDate: Boolean;
        ShowMemberDetails: Boolean;
        IncludeSummary: Boolean;
        FromDate: Date;
        ToDate: Date;
        SellerMemberName: Text[100];
        BuyerMemberName: Text[100];
        TotalMatches: Integer;
        TotalSharesTraded: Decimal;
        TotalValueTraded: Decimal;
        AveragePrice: Decimal;
        HighestPrice: Decimal;
        LowestPrice: Decimal;
        PostedMatches: Integer;
        UnpostedMatches: Integer;
        UniqueSellers: Integer;
        UniqueBuyers: Integer;
        SellerMembers: Dictionary of [Code[20], Boolean];
        BuyerMembers: Dictionary of [Code[20], Boolean];
}
