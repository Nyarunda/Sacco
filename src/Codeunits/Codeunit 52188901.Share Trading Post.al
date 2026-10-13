codeunit 50603 "Share Trading Post"
{
    procedure PostMatch(var ShareTradingMatch: Record "Share Trading Match")
    var
        SellOrder: Record "Share Trading Header";
        BuyOrder: Record "Share Trading Header";
        ShareTradingSetup: Record "Share Trading Setup";
        SActivities: Codeunit "Sacco Activities";
        Legacy: Codeunit Legacy;
        Jtemplate: Code[20];
        JBatch: Code[20];
        BalAcctType: Enum "Gen. Journal Account Type";
        ShareAmount: Decimal;
        Commission: Decimal;
        TransactionFee: Decimal;
        TotalSellerAmount: Decimal;
        TotalBuyerCost: Decimal;
        Desc: Text[100];
    begin
        ShareTradingSetup.Get();

        // Get the orders
        SellOrder.Get(ShareTradingMatch."Sell Order ID");
        BuyOrder.Get(ShareTradingMatch."Buy Order ID");

        // Validate posting requirements
        ValidateBeforePosting(ShareTradingMatch, SellOrder, BuyOrder);

        // Get journal template and batch
        SActivities.GetGeneralJournalTemplate(Jtemplate, JBatch);

        // Calculate amounts
        ShareAmount := ShareTradingMatch."Matched Shares" * ShareTradingSetup."Par Value per Share";
        Commission := CalculateCommission(ShareTradingMatch."Matched Amount");
        TransactionFee := ShareTradingSetup."Transaction Fee";

        TotalSellerAmount := ShareTradingMatch."Matched Amount";
        TotalBuyerCost := ShareTradingMatch."Matched Amount";// + (Commission / 2) + (TransactionFee / 2);
        Desc := StrSubstNo('Share Trade - %1 shares @ %2', ShareTradingMatch."Matched Shares", ShareTradingMatch."Price per Share");

        // Initialize journal
        SActivities.JournalInit(Jtemplate, JBatch);

        // Post seller entries
        PostSellerEntries(ShareTradingMatch, SellOrder, ShareAmount, TotalSellerAmount, Commission, TransactionFee, Desc, Jtemplate, JBatch);

        // Post buyer entries
        PostBuyerEntries(ShareTradingMatch, BuyOrder, ShareAmount, TotalBuyerCost, Commission, TransactionFee, Desc, Jtemplate, JBatch);

        // Post commission and fee entries
        //PostCommissionAndFees(ShareTradingMatch, Commission, TransactionFee, Desc, Jtemplate, JBatch);

        // Post the journal
        SActivities.JournalPost(Jtemplate, JBatch);

        // Mark match as posted
        ShareTradingMatch.Posted := true;
        ShareTradingMatch."Posted Date" := Today;
        ShareTradingMatch."Posted By" := UserId;
        ShareTradingMatch.Modify();

        // Update order status
        SellOrder.UpdateMatchedShares();
        BuyOrder.UpdateMatchedShares();

        // Send notifications
        SendPostingNotifications(ShareTradingMatch);
    end;

    local procedure ValidateBeforePosting(ShareTradingMatch: Record "Share Trading Match"; SellOrder: Record "Share Trading Header"; BuyOrder: Record "Share Trading Header")
    var
        ShareTradingSetup: Record "Share Trading Setup";
        ShareTradingMgmt: Codeunit "Share Trading Management";
    begin
        if ShareTradingMatch.Posted then
            Error('Match %1 has already been posted', ShareTradingMatch."Match ID");

        ShareTradingSetup.Get();

        // Validate seller has sufficient shares
        if ShareTradingMgmt.GetMemberAvailableShares(SellOrder."Member No.") < ShareTradingMatch."Matched Shares" then
            Error('Seller %1 has insufficient available shares', SellOrder."Member No.");

        // Validate GL accounts are set up
        ShareTradingSetup.TestField("Capital Account");
        if ShareTradingSetup."Broker Commission %" > 0 then
            ShareTradingSetup.TestField("Commission Account");
        if ShareTradingSetup."Transaction Fee" > 0 then
            ShareTradingSetup.TestField("Transaction Fee Account");
    end;

    local procedure PostSellerEntries(ShareTradingMatch: Record "Share Trading Match"; SellOrder: Record "Share Trading Header"; ShareAmount: Decimal; GrossAmount: Decimal; Commission: Decimal; TransactionFee: Decimal; Desc: Text[100]; Jtemplate: Code[20]; JBatch: Code[20])
    var
        SActivities: Codeunit "Sacco Activities";
        Legacy: Codeunit Legacy;
        ShareTradingSetup: Record "Share Trading Setup";
        BalAcctType: Enum "Gen. Journal Account Type";
        Channel: Enum "Transaction Channel";
        AcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
    begin
        ShareTradingSetup.Get();

        // Debit seller's share capital account (reduce shares)
        SActivities.JournalInsert(
            Jtemplate,
            JBatch,
            ShareTradingMatch."Match ID",
            Today,
            AcctType::Savings, // Use existing account type enum
            Legacy.GetShareCapitalAccount(SellOrder."Member No."),
            CopyStr('Share Sale - ' + Desc, 1, 50),
            BalAcctType::"G/L Account",
            ShareTradingSetup."Capital Account",
            ShareAmount, // Positive = Debit (reduce member's share capital)
            '',
            '',
            TransType::" ", // Use existing transaction type
            '',
            '',
            true,
            Channel::"Account Transfer",
            0
        );

        // Credit seller's deposit account (if net amount > 0)
        if GrossAmount > 0 then begin
            SActivities.JournalInsert(
                Jtemplate,
                JBatch,
                ShareTradingMatch."Match ID",
                Today,
                AcctType::Savings,
                Legacy.GetOrdinaryAccount(SellOrder."Member No."),
                CopyStr('Share Sale Proceeds - ' + Desc, 1, 50),
                BalAcctType::"G/L Account",
                '',
                -GrossAmount, // Negative = Credit (increase member's deposit)
                '',
                '',
                TransType::" ",
                '',
                '',
                true,
                Channel::"Account Transfer",
                0
            );
        end;

        // Debit seller for commission (if applicable)
        if Commission > 0 then begin
            SActivities.JournalInsert(
                Jtemplate,
                JBatch,
                ShareTradingMatch."Match ID",
                Today,
                AcctType::Savings,
                Legacy.GetOrdinaryAccount(SellOrder."Member No."),
                CopyStr('Trading Commission - ' + Desc, 1, 50),
                BalAcctType::"G/L Account",
                ShareTradingSetup."Commission Account",
                Commission, // Positive = Debit (charge commission)
                '',
                '',
                TransType::" ",
                '',
                '',
                true,
                Channel::Portal,
                0
            );
        end;

        // Debit seller for trading fee (if applicable)
        if TransactionFee > 0 then begin
            SActivities.JournalInsert(
                Jtemplate,
                JBatch,
                ShareTradingMatch."Match ID",
                Today,
                AcctType::Savings,
                Legacy.GetOrdinaryAccount(SellOrder."Member No."),
                CopyStr('Trading Fee - ' + Desc, 1, 50),
                BalAcctType::"G/L Account",
                ShareTradingSetup."Transaction Fee Account",
                TransactionFee, // Positive = Debit (charge fee)
                '',
                '',
                TransType::" ",
                '',
                '',
                true,
                Channel::"Account Transfer",
                0
            );
        end;
    end;

    local procedure PostBuyerEntries(ShareTradingMatch: Record "Share Trading Match"; BuyOrder: Record "Share Trading Header"; ShareAmount: Decimal; TotalCost: Decimal; Commission: Decimal; TransactionFee: Decimal; Desc: Text[100]; Jtemplate: Code[20]; JBatch: Code[20])
    var
        SActivities: Codeunit "Sacco Activities";
        Legacy: Codeunit Legacy;
        ShareTradingSetup: Record "Share Trading Setup";
        BalAcctType: Enum "Gen. Journal Account Type";
        Channel: Enum "Transaction Channel";
        AcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
    begin
        ShareTradingSetup.Get();

        // Credit buyer's share capital account (increase shares)
        SActivities.JournalInsert(
            Jtemplate,
            JBatch,
            ShareTradingMatch."Match ID",
            Today,
            AcctType::Savings,
            Legacy.GetShareCapitalAccount(BuyOrder."Member No."),
            CopyStr('Share Purchase - ' + Desc, 1, 50),
            BalAcctType::"G/L Account",
            ShareTradingSetup."Capital Account",
            -ShareAmount, // Negative = Credit (increase member's share capital)
            '',
            '',
            TransType::" ",
            '',
            '',
            true,
            Channel::"Account Transfer",
            0
        );

        // Debit buyer's deposit account for total cost
        SActivities.JournalInsert(
            Jtemplate,
            JBatch,
            ShareTradingMatch."Match ID",
            Today,
            AcctType::Savings,
            Legacy.GetDepositAccounts(BuyOrder."Member No."),
            CopyStr('Share Purchase Payment - ' + Desc, 1, 50),
            BalAcctType::"G/L Account",
            '',
            ShareTradingMatch."Matched Amount", // Positive = Debit (reduce member's deposit)
            '',
            '',
            TransType::" ",
            '',
            '',
            true,
            Channel::"Account Transfer",
            0
        );

        /*
        // Debit buyer for commission (if applicable)
        if Commission > 0 then begin
            SActivities.JournalInsert(
                Jtemplate,
                JBatch,
                ShareTradingMatch."Match ID",
                Today,
                AcctType::Savings,
                Legacy.GetDepositAccount(BuyOrder."Member No."),
                CopyStr('Trading Commission - ' + Desc, 1, 50),
                BalAcctType::"G/L Account",
                ShareTradingSetup."Commission Account",
                Commission, // Positive = Debit (charge commission)
                '',
                '',
                TransType::" ",
                '',
                '',
                true,
                Channel::Portal,
                0
            );
        end;

        // Debit buyer for trading fee (if applicable)
        if TransactionFee > 0 then begin
            SActivities.JournalInsert(
                Jtemplate,
                JBatch,
                ShareTradingMatch."Match ID",
                Today,
                AcctType::Savings,
                Legacy.GetDepositAccount(BuyOrder."Member No."),
                CopyStr('Trading Fee - ' + Desc, 1, 50),
                BalAcctType::"G/L Account",
                ShareTradingSetup."Transaction Fee Account",
                TransactionFee, // Positive = Debit (charge fee)
                '',
                '',
                TransType::" ",
                '',
                '',
                true,
                Channel::Portal,
                0
            );
        end;
        */

    end;

    local procedure PostCommissionAndFees(ShareTradingMatch: Record "Share Trading Match"; Commission: Decimal; TransactionFee: Decimal; Desc: Text[100]; Jtemplate: Code[20]; JBatch: Code[20])
    var
        SActivities: Codeunit "Sacco Activities";
        ShareTradingSetup: Record "Share Trading Setup";
        BalAcctType: Enum "Gen. Journal Account Type";
        Channel: Enum "Transaction Channel";
        TransType: Enum "Transaction Type Enum";
    begin
        ShareTradingSetup.Get();

        // Commission income entry (if applicable)
        if Commission > 0 then begin
            SActivities.JournalInsert(
                Jtemplate,
                JBatch,
                ShareTradingMatch."Match ID",
                Today,
                BalAcctType::"G/L Account",
                ShareTradingSetup."Commission Account",
                CopyStr('Trading Commission Income - ' + Desc, 1, 50),
                BalAcctType::"G/L Account",
                '',
                -Commission, // Negative = Credit (income)
                '',
                '',
                TransType::" ", // No specific transaction type for GL entries
                '',
                '',
                false, // Not a member transaction
                Channel::Portal,
                0
            );
        end;

        // Trading fee income entry (if applicable)
        if TransactionFee > 0 then begin
            SActivities.JournalInsert(
                Jtemplate,
                JBatch,
                ShareTradingMatch."Match ID",
                Today,
                BalAcctType::"G/L Account",
                ShareTradingSetup."Transaction Fee Account",
                CopyStr('Trading Fee Income - ' + Desc, 1, 50),
                BalAcctType::"G/L Account",
                '',
                -(TransactionFee * 2), // Negative = Credit (income from both parties)
                '',
                '',
                TransType::" ", // No specific transaction type for GL entries
                '',
                '',
                false, // Not a member transaction
                Channel::Portal,
                0
            );
        end;
    end;

    local procedure CalculateCommission(MatchAmount: Decimal): Decimal
    var
        ShareTradingSetup: Record "Share Trading Setup";
        Commission: Decimal;
    begin
        ShareTradingSetup.Get();

        if ShareTradingSetup."Broker Commission %" > 0 then
            Commission := MatchAmount * ShareTradingSetup."Broker Commission %" / 100
        else
            Commission := 0;

        exit(Commission);
    end;

    local procedure SendPostingNotifications(ShareTradingMatch: Record "Share Trading Match")
    var
        ShareTradingSetup: Record "Share Trading Setup";
    begin
        ShareTradingSetup.Get();

        if ShareTradingSetup."Email Notifications" then begin
            // TODO: Send email notifications to both parties
        end;

        if ShareTradingSetup."SMS Notifications" then begin
            // TODO: Send SMS notifications to both parties
        end;
    end;

    procedure ReverseMatch(var ShareTradingMatch: Record "Share Trading Match"; ReverseReason: Text[250])
    var
        SActivities: Codeunit "Sacco Activities";
        Jtemplate: Code[20];
        JBatch: Code[20];
        SellOrder: Record "Share Trading Header";
        BuyOrder: Record "Share Trading Header";
    begin
        if not ShareTradingMatch.Posted then
            Error('Cannot reverse an unposted match');

        // Get the orders
        SellOrder.Get(ShareTradingMatch."Sell Order ID");
        BuyOrder.Get(ShareTradingMatch."Buy Order ID");

        // Create reversing journal entries
        CreateReversingJournalEntries(ShareTradingMatch, SellOrder, BuyOrder, ReverseReason);

        // Mark match as reversed
        ShareTradingMatch.Posted := false;
        ShareTradingMatch."Posted Date" := 0D;
        ShareTradingMatch."Posted By" := '';
        ShareTradingMatch."Reversal Reason" := ReverseReason;
        ShareTradingMatch."Reversed Date" := Today;
        ShareTradingMatch."Reversed By" := UserId;
        ShareTradingMatch.Modify();

        // Update orders
        SellOrder.UpdateMatchedShares();
        BuyOrder.UpdateMatchedShares();
    end;

    local procedure CreateReversingJournalEntries(ShareTradingMatch: Record "Share Trading Match"; SellOrder: Record "Share Trading Header"; BuyOrder: Record "Share Trading Header"; ReverseReason: Text[250])
    var
        SActivities: Codeunit "Sacco Activities";
        Legacy: Codeunit Legacy;
        ShareTradingSetup: Record "Share Trading Setup";
        Jtemplate: Code[20];
        JBatch: Code[20];
        BalAcctType: Enum "Gen. Journal Account Type";
        Channel: Enum "Transaction Channel";
        AcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        ShareAmount: Decimal;
        Commission: Decimal;
        TransactionFee: Decimal;
        Desc: Text[100];
    begin
        ShareTradingSetup.Get();

        // Get journal template and batch
        SActivities.GetGeneralJournalTemplate(Jtemplate, JBatch);
        SActivities.JournalInit(Jtemplate, JBatch);

        // Calculate amounts
        ShareAmount := ShareTradingMatch."Matched Shares" * ShareTradingSetup."Par Value per Share";
        Commission := CalculateCommission(ShareTradingMatch."Matched Amount");
        TransactionFee := ShareTradingSetup."Transaction Fee";

        Desc := StrSubstNo('REVERSAL: Share Trade - %1 shares @ %2', ShareTradingMatch."Matched Shares", ShareTradingMatch."Price per Share");

        // Reverse seller entries (opposite of original postings)
        // Credit seller's share capital account (restore shares)
        SActivities.JournalInsert(
            Jtemplate,
            JBatch,
            'REV-' + ShareTradingMatch."Match ID",
            Today,
            AcctType::Savings,
            Legacy.GetShareCapitalAccount(SellOrder."Member No."),
            CopyStr('REVERSE: ' + Desc, 1, 50),
            BalAcctType::"G/L Account",
            ShareTradingSetup."Capital Account",
            -ShareAmount, // Negative = Credit (restore member's share capital)
            '',
            '',
            TransType::" ",
            '',
            '',
            true,
            Channel::Portal,
            0
        );

        // Reverse buyer entries (opposite of original postings)
        // Debit buyer's share capital account (remove shares)
        SActivities.JournalInsert(
            Jtemplate,
            JBatch,
            'REV-' + ShareTradingMatch."Match ID",
            Today,
            AcctType::Savings,
            Legacy.GetShareCapitalAccount(BuyOrder."Member No."),
            CopyStr('REVERSE: ' + Desc, 1, 50),
            BalAcctType::"G/L Account",
            ShareTradingSetup."Capital Account",
            ShareAmount, // Positive = Debit (reduce member's share capital)
            '',
            '',
            TransType::" ",
            '',
            '',
            true,
            Channel::Portal,
            0
        );

        // Post the reversal journal
        SActivities.JournalPost(Jtemplate, JBatch);
    end;
}
