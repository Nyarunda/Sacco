page 50802 "Share Trading Setup"
{
    Caption = 'Share Trading Setup';
    PageType = Card;
    SourceTable = "Share Trading Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Enable Share Trading"; Rec."Enable Share Trading")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether share trading is enabled';
                }

                field("Par Value per Share"; Rec."Par Value per Share")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the par value per share for capital conversion';

                    trigger OnValidate()
                    begin
                        if Rec."Par Value per Share" <= 0 then
                            Error('Par value must be greater than zero');
                    end;
                }

                field("Minimum Shareholding"; Rec."Minimum Shareholding")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum shareholding allowed per member';
                }

                field("Maximum Shareholding"; Rec."Maximum Shareholding")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum shareholding allowed per member (0 = no limit)';
                }

                field("Matching Price Method"; Rec."Matching Price Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default price matching method';
                    Editable = not Rec."Enable Negotiation";
                }

                field("Enable Negotiation"; Rec."Enable Negotiation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow buyers to make counter-offers on seller prices';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }

                field("Seller Approval Required"; Rec."Seller Approval Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'All trades require explicit seller approval';
                    Enabled = Rec."Enable Negotiation";
                }

                field("Allow Partial Matching"; Rec."Allow Partial Matching")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow buyers to purchase partial quantities from sell orders';
                    Enabled = not Rec."Enable Negotiation";
                }

                field("Auto Match Orders"; Rec."Auto Match Orders")
                {
                    ApplicationArea = All;
                    ToolTip = 'Automatically match compatible buy and sell orders';
                    Enabled = not Rec."Enable Negotiation";
                }

                field("Negotiation Timeout Days"; Rec."Negotiation Timeout Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of days sellers have to respond to negotiation offers';
                    Enabled = Rec."Enable Negotiation";
                }
            }

            group(TradingHours)
            {
                Caption = 'Trading Hours';

                field("Trading Start Time"; Rec."Trading Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when trading starts each day';
                }

                field("Trading End Time"; Rec."Trading End Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when trading ends each day';
                }

                field("Trading Days"; Rec."Trading Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the trading days (e.g., Monday-Friday)';
                }
            }

            group(AccountSetup)
            {
                Caption = 'Account Setup';

                field("Capital Account"; Rec."Capital Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for share capital';
                }

                field("Commission Account"; Rec."Commission Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for trading commissions';
                }

                field("Transaction Fee Account"; Rec."Transaction Fee Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for trading fees';
                }
            }

            group(Fees)
            {
                Caption = 'Fees & Commissions';

                field("Broker Commission %"; Rec."Broker Commission %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the commission rate as a percentage of transaction value';
                }

                field("Transaction Fee"; Rec."Transaction Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a fixed fee per transaction';
                }
            }

            group(NumberSeries)
            {
                Caption = 'Number Series';

                field("Order Nos."; Rec."Order Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for share trading orders';
                }

                field("Match Nos."; Rec."Match Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for share trading matches';
                }
            }

            group(JournalSetup)
            {
                Caption = 'Journal Setup';

                field("Share Transfer Journal Template"; Rec."Share Transfer Jnl. Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the journal template for share transfers';
                }

                field("Share Transfer Journal Batch"; Rec."Share Transfer Jnl. Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the journal batch for share transfers';
                }
            }

            group(Notifications)
            {
                Caption = 'Notifications';

                field("Email Notifications"; Rec."Email Notifications")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether email notifications should be sent';
                }

                field("SMS Notifications"; Rec."SMS Notifications")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether SMS notifications should be sent';
                }

                field("Require Approval"; Rec."Require Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether share trading orders require approval';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TestSetup)
            {
                ApplicationArea = All;
                Caption = 'Test Setup';
                Image = TestFile;
                ToolTip = 'Test the current setup configuration';

                trigger OnAction()
                begin
                    TestConfiguration();
                end;
            }

            action(RecalculateShareholdings)
            {
                ApplicationArea = All;
                Caption = 'Recalculate Shareholdings';
                Image = Calculate;
                ToolTip = 'Recalculate all member shareholdings';

                trigger OnAction()
                begin
                    RecalculateAllShareholdings();
                end;
            }
        }

        area(navigation)
        {
            action(GLAccounts)
            {
                ApplicationArea = All;
                Caption = 'G/L Accounts';
                Image = ChartOfAccounts;
                RunObject = page "Chart of Accounts";
                ToolTip = 'View the chart of accounts';
            }

            action(ShareTradingOrders)
            {
                ApplicationArea = All;
                Caption = 'Share Trading Orders';
                Image = CustomerLedger;
                RunObject = page "Share Trading Order List";
                ToolTip = 'View share trading orders';
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    local procedure TestConfiguration()
    var
        GLAccount: Record "G/L Account";
        ErrorText: Text;
    begin
        ErrorText := '';

        // Test par value
        if Rec."Par Value per Share" <= 0 then
            ErrorText += 'Par Value per Share must be greater than zero.\';

        // Test G/L accounts
        if Rec."Capital Account" <> '' then begin
            if not GLAccount.Get(Rec."Capital Account") then
                ErrorText += StrSubstNo('Capital Account %1 does not exist.\', Rec."Capital Account");
        end else
            ErrorText += 'Capital Account must be specified.\';

        if Rec."Commission Account" <> '' then begin
            if not GLAccount.Get(Rec."Commission Account") then
                ErrorText += StrSubstNo('Commission Account %1 does not exist.\', Rec."Commission Account");
        end;

        // Test trading hours
        if Rec."Trading Start Time" >= Rec."Trading End Time" then
            ErrorText += 'Trading Start Time must be before Trading End Time.\';

        // Test commission settings
        if Rec."Broker Commission %" < 0 then
            ErrorText += 'Broker Commission % cannot be negative.\';

        // Test negotiation settings
        if Rec."Enable Negotiation" then begin
            if not Rec."Seller Approval Required" then
                ErrorText += 'Seller Approval Required must be enabled when negotiation is enabled.\';

            if Rec."Negotiation Timeout Days" <= 0 then
                ErrorText += 'Negotiation Timeout Days must be greater than zero.\';
        end;

        if ErrorText = '' then
            Message('Setup configuration is valid')
        else
            Error('Setup validation failed:\%1', ErrorText);
    end;

    local procedure RecalculateAllShareholdings()
    var
        Members: Record Members;
        Counter: Integer;
    begin
        if not Confirm('Recalculate shareholdings for all members?') then
            exit;

        if Members.FindSet() then begin
            repeat
                // Simple counter increment - specific recalculation logic would go here
                Counter += 1;
            until Members.Next() = 0;
        end;

        Message('Processed %1 members', Counter);
    end;
}
