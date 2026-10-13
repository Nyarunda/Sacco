Page 50815 "Sky Mobile Trans. Reversed"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky M-Banking Transactions";
    SourceTableView = SORTING("Transaction ID") WHERE(Reversed = CONST(true));
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
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
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
            action("Reset Posted After Bank Reversal")
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
            }
            action("Post Single Transaction")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                    Sky: COdeunit "Sky MBanking";
                    SkyTrans: COdeunit "Sky M-Banking Transactions";
                    SkyMBanking: Record "Sky Transactions.";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to post this transactions?') then begin

                        if Rec."Transaction Type" = Rec."Transaction Type"::"Mpesa Deposit" then
                            SkyTrans.PostMpesaDeposits(Rec."Transaction ID");

                        if Rec."Transaction Type" = Rec."Transaction Type"::"Bank Transfer" then
                            SkyTrans.PostWithdrawals(Rec."Transaction ID");

                        if Rec."Transaction Type" = Rec."Transaction Type"::"Mpesa Withdrawal" then
                            SkyTrans.PostWithdrawals(Rec."Transaction ID");

                        if Rec."Transaction Type" = Rec."Transaction Type"::"Account Balance Enquiry" then
                            SkyTrans.PostBalanceEquiryTransaction(Rec."Transaction ID");

                        // /Message('Done');
                    end;
                end;
            }
            action("Post All Transactions")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                    Sky: COdeunit "Sky MBanking";
                    SkyMBanking: Record "Sky Transactions.";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to post this transactions?') then begin

                        Sky.PostMpesaTransaction('');

                        // /Message('Done');
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

    /*  trigger OnAfterGetCurrRecord()
     var
         myInt: Integer;
     begin
         Rec.SetAutoCalcFields("Member Name");

     end; */

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
        Rec.Remarks := CopyStr('Reset for repost after bank ledger reversal by ' + UserId, 1, MaxStrLen(Rec.Remarks));
        Rec.Modify(false);

        Message('Transaction %1 is now unposted and can be reposted.', Rec."Transaction ID");
    end;


}
