Page 50415 "Sky Mobile Transactions"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Sky M-Banking Transactions";
    SourceTableView = sorting("Transaction Date", "Transaction Time") order(descending) where(reversed = const(false),
                            "Transaction Type" = filter(<> "Loan Full-Statement" & <> "Account Full-Statement" & <> "Account Mini-Statement"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = Basic;
                }
                field("Receiver Account"; Rec."Receiver Account")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account"; Rec."Savings Account")
                {
                    ApplicationArea = Basic;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = Basic;
                }
                field("UWS Posting Date"; Rec."UWS Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("UWS Posting Time"; Rec."UWS Posting Time")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account"; Rec."Source Account")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; MemberName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("Destination Account"; Rec."Destination Account")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }

                field(Description; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec."Transaction Amount")
                {
                    ApplicationArea = Basic;
                }
                field(NeedsChange; Rec."Needs Change")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                /* field(Keyword; Rec.Keyword)
                {
                    ApplicationArea = Basic;
                }
                field(PaybillMemberID; Rec."Paybill Member ID")
                {
                    ApplicationArea = Basic;
                } */
                field(DatePosted; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                /*  field(TimePosted; Rec."Time Posted")
                 {
                     ApplicationArea = Basic;
                 } */
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                /* field(OldTransactionDate; Rec."Old Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field(DateReversed; Rec."Date Reversed")
                {
                    ApplicationArea = Basic;
                }
                field(TimeReversed; Rec."Time Reversed")
                {
                    ApplicationArea = Basic;
                }
                field(ReversedBy; Rec."Reversed By")
                {
                    ApplicationArea = Basic;
                }
                field(ReversalID; Rec."Reversal ID")
                {
                    ApplicationArea = Basic;
                }
                field(SessionID; Rec."Session ID")
                {
                    ApplicationArea = Basic;
                } */
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                /* field(VendorCommission; Rec."Vendor Commission")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoFee; Rec."Sacco Fee")
                {
                    ApplicationArea = Basic;
                }
                field(MobileNo; Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field(StatementMaxRows; Rec."Statement Max Rows")
                {
                    ApplicationArea = Basic;
                }
                field(StatementStartDate; Rec."Statement Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(StatementEndDate; Rec."Statement End Date")
                {
                    ApplicationArea = Basic;
                }
                field(AccounttoCheck; Rec."Account to Check")
                {
                    ApplicationArea = Basic;
                } */
                field(ChangedBy; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field(DateChanged; Rec."Changed Date")
                {
                    ApplicationArea = Basic;
                }
                field("Originator ID"; Rec."Originator ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Update Paybill")
            {
                ApplicationArea = Basic;
                RunObject = Page "Sky Update Paybill ID";
                RunPageLink = "Transaction ID" = field("Transaction ID");
            }


            action("Corect Transactions")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                    MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
                    MTRans: Codeunit "Sky MBanking";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    //        TestField(Posted, false);
                    if Confirm('Are you sure you want to correct this mpesa withdrawal?') then begin
                        /* Rec.TestField(Amount, 0);
                        //MARK BUFFER AS POSTED
                        MobileWithdrawalsBuffer.Reset;
                        MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Reference No", Rec."Entry No.");
                        MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
                        MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Account No", Rec."Member Account");
                        if MobileWithdrawalsBuffer.Find('-') then begin
                            Rec.Amount := MobileWithdrawalsBuffer.Amount;
                            Rec.SkipCharge := true;
                            Rec.Posted := false;
                            Rec.Modify();
                            Message('updated');
                        end; */
                    end;
                end;
            }

            action("Mark As Needs Change")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to mark/unmark this transaction as needs change?') then begin

                        if Rec."Needs Change" then
                            Rec."Needs Change" := false
                        else
                            Rec."Needs Change" := true;
                        Rec.Modify;
                    end;
                end;
            }
            action("Mark As Reversed")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to mark/unmark this transaction as reversed?') then begin

                        if Rec.Reversed then
                            Rec.Reversed := false
                        else
                            Rec.Reversed := true;

                        Rec.Modify;
                    end;
                end;
            }
            /* action("Reset Posted After Bank Reversal")
            {
                ApplicationArea = Basic;
                Caption = 'Reset Posted After Bank Reversal';
                Image = ReOpen;
                ToolTip = 'Sets the transaction as unposted so it can be reposted, but only when all related bank ledger entries have already been reversed.';

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    ResetPostedAfterBankReversal();
                end;
            } */
            action("Post Single Transaction - Sky M-Banking")
            {
                ApplicationArea = Basic;
                Caption = 'Post Single Transaction - Sky M-Banking';
                Image = Post;
                ToolTip = 'Posts the selected Mpesa Deposit or Loan Repayment transaction using Sky M-Banking Transactions.';

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                    SkyMbankingTransactions: Codeunit "Sky M-Banking Transactions";
                    PostedOk: Boolean;
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    Rec.TestField("Needs Change", false);
                    Rec.TestField("Transaction ID");

                    if not (Rec."Transaction Type" in [Rec."Transaction Type"::"Mpesa Deposit", Rec."Transaction Type"::"Loan Repayment"]) then
                        Error('Only Mpesa Deposit and Loan Repayment transactions can be posted using this action.');

                    if not Confirm('Are you sure you want to post transaction %1 using Sky M-Banking Transactions?', false, Rec."Transaction ID") then
                        exit;

                    PostedOk := SkyMbankingTransactions.PostMpesaDepositsTransaction(Rec."Transaction ID");
                    if PostedOk then
                        Message('Transaction %1 has been posted successfully.', Rec."Transaction ID")
                    else
                        Message('Transaction %1 was not posted. Kindly check if it still exists, is unposted, and does not need change.', Rec."Transaction ID");

                    CurrPage.Update(false);
                end;
            }
            action("Post All Transactions")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                    //Sky: COdeunit "Sky MBanking";
                    Sky: COdeunit "Sky M-Banking Transactions";
                    SkyMBanking: Record "Sky Transactions.";
                    TransactionsToPost: Record "Sky M-Banking Transactions";
                    PostedCount: Integer;
                    TotalCount: Integer;
                    Window: Dialog;
                    PostingValidationError: Text[250];
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    //Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to post this transactions?') then begin
                        TransactionsToPost.Reset();
                        TransactionsToPost.SetRange(Posted, false);
                        TransactionsToPost.SetRange("Needs Change", false);
                        TransactionsToPost.SetFilter("Transaction Type", '%1|%2',
                            TransactionsToPost."Transaction Type"::"Mpesa Deposit",
                            TransactionsToPost."Transaction Type"::"Loan Repayment");

                        TotalCount := TransactionsToPost.Count();
                        if TotalCount = 0 then begin
                            Message('There are no unposted Mpesa Deposit or Loan Repayment transactions to post.');
                            exit;
                        end;

                        Window.Open('Posting transactions...\\Transaction #1##########\\Progress @2@@@@@@@@@@@@@@@@');
                        if TransactionsToPost.FindSet() then
                            repeat
                                PostedCount += 1;
                                Window.Update(1, TransactionsToPost."Transaction ID");
                                Window.Update(2, Round(PostedCount / TotalCount * 10000, 1));
                                PostingValidationError := GetMpesaPostingLengthValidationError(TransactionsToPost);
                                if PostingValidationError = '' then
                                    Sky.PostMpesaDepositsTransaction(TransactionsToPost."Transaction ID")
                                else begin
                                    TransactionsToPost."Needs Change" := true;
                                    TransactionsToPost.Remarks := CopyStr(PostingValidationError, 1, MaxStrLen(TransactionsToPost.Remarks));
                                    TransactionsToPost.Modify();
                                end;
                            until TransactionsToPost.Next() = 0;
                        Window.Close();

                        Message('Posting completed. Processed %1 transaction(s).', PostedCount);
                    end;
                end;
            }
            action("Update Loan Accounts")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                    SKy: Codeunit "Sky MBanking";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to update loan accounts?') then begin

                        SKy.UpdateLoanAccounts();
                        Message('Updated');
                    end;
                end;
            }
            action("Update Old Paybill Transactions")
            {
                ApplicationArea = Basic;
                RunObject = report "Update Old Paybill Transaction";

                //RunPageLink = "Transaction ID" = field("Transaction ID");

            }
        }
    }
    trigger onopenpage()
    // Var
    //     SkyTrans: Record "Sky Transactions.";
    begin
        //     SkyTrans.Reset();
        //     SkyTrans.setrange("Transaction ID", 'RGE6IHIOFO');
        //     if SkyTrans.FindFirst() then begin
        //         SkyTrans.Reversed := true;
        //         SkyTrans."Date Reversed" := Today;
        //         SkyTrans.Modify();
        //     end;
    end;

    trigger OnAfterGetRecord()
    begin
        MemberName := GetDisplayMemberName();
    end;

    /*  trigger OnAfterGetCurrRecord()
     var
         myInt: Integer;
     begin
         Rec.SetAutoCalcFields("Member Name");

     end; */

    local procedure GetMpesaPostingLengthValidationError(SkyTransaction: Record "Sky M-Banking Transactions"): Text[250]
    begin
        if StrLen(SkyTransaction."Transaction ID") > 20 then
            exit(StrSubstNo('Transaction ID %1 exceeds 20 characters and cannot be posted automatically.', SkyTransaction."Transaction ID"));

        if StrLen(SkyTransaction."Savings Account") > 20 then
            exit(StrSubstNo('Savings Account %1 exceeds 20 characters and cannot be posted automatically.', SkyTransaction."Savings Account"));

        if StrLen(SkyTransaction."Receiver Account") > 20 then
            exit(StrSubstNo('Receiver Account %1 exceeds 20 characters and cannot be posted automatically.', SkyTransaction."Receiver Account"));

        exit('');
    end;

    local procedure ResetPostedAfterBankReversal()
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        TotalBankEntries: Integer;
    begin
        Rec.TestField(Posted, true);
        Rec.TestField(Reversed, true);

        BankLedgerEntry.Reset();
        BankLedgerEntry.SetRange("Document No.", Rec."Transaction ID");
        TotalBankEntries := BankLedgerEntry.Count();
        if TotalBankEntries = 0 then
            Error('No bank ledger entries were found for transaction %1. Reverse the bank ledger entries first.', Rec."Transaction ID");

        BankLedgerEntry.SetRange(Reversed, false);
        if not BankLedgerEntry.IsEmpty() then
            Error('Transaction %1 cannot be reset. Some related bank ledger entries are not reversed.', Rec."Transaction ID");

        if not Confirm('Set transaction %1 as Posted = No so it can be reposted?', false, Rec."Transaction ID") then
            exit;

        Rec.Posted := false;
        Rec."Posting Date" := 0D;
        Rec."Posting Time" := 0T;
        Rec."Posted By" := '';
        Rec."Needs Change" := false;
        //Rec.Remarks := CopyStr('Reset for repost after bank ledger reversal by ' + UserId, 1, MaxStrLen(Rec.Remarks));
        Rec.Modify(false);

        Message('Transaction %1 is now unposted and can be reposted.', Rec."Transaction ID");
    end;

    local procedure GetDisplayMemberName(): Text[100]
    var
        SavingsAccount: Record "Savings Accounts";
        Member: Record Members;
        OldMemberNo: Code[20];
    begin
        if Rec."Savings Account" <> '' then
            if SavingsAccount.Get(CopyStr(Rec."Savings Account", 1, 20)) then
                exit(SavingsAccount.Name);

        if Rec."Source Account" <> '' then
            if SavingsAccount.Get(CopyStr(Rec."Source Account", 1, 20)) then
                exit(SavingsAccount.Name);

        OldMemberNo := GetOldMemberNoFromReference(Rec."Savings Account");
        if OldMemberNo <> '' then begin
            Member.SetRange("Old Member No.", OldMemberNo);
            if Member.FindFirst() then
                exit(Member.Name);
        end;

        OldMemberNo := GetOldMemberNoFromReference(Rec."Source Account");
        if OldMemberNo <> '' then begin
            Member.SetRange("Old Member No.", OldMemberNo);
            if Member.FindFirst() then
                exit(Member.Name);
        end;

        exit(Rec."Source Name");
    end;

    local procedure GetOldMemberNoFromReference(AccountReference: Text[100]): Code[20]
    var
        SeparatorPosition: Integer;
    begin
        SeparatorPosition := StrPos(AccountReference, '#');
        if SeparatorPosition <= 1 then
            exit('');

        exit(CopyStr(AccountReference, 1, SeparatorPosition - 1));
    end;

    var
        MemberName: Text[100];


}

