
Page 50267 "Savings Ledger Entries"
{
    DataCaptionFields = "Account No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Savings Ledger Entry";
    SourceTableView = sorting("Account No.", "Posting Date")
                      order(descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the document number on the bank account entry.';
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the bank account used for the entry.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the description of the bank account entry.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry denominated in the applicable foreign currency.';
                }
                field(AmountLCY; Rec."Amount (LCY)")
                {
                    ApplicationArea = Advanced;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry in LCY.';
                    Visible = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(GroupCode; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                }
                field(CreationDate; Rec."Creation Date")
                {
                    ApplicationArea = Basic;
                }
                field(CreationTime; Rec."Creation Time")
                {
                    ApplicationArea = Basic;
                }
                field(StaffNo; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(DebitAmount; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = false;
                }
                field(DebitAmountLCY; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits, expressed in LCY.';
                    Visible = false;
                }
                field(CreditAmount; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = false;
                }
                field(CreditAmountLCY; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits, expressed in LCY.';
                    Visible = false;
                }
                field(BalAccountType; Rec."Bal. Account Type")
                {
                    ApplicationArea = Advanced;
                    Editable = false;
                    ToolTip = 'Specifies the type of account that a balancing entry is posted to, such as BANK for a cash account.';
                    Visible = false;
                }
                field(BalAccountNo; Rec."Bal. Account No.")
                {
                    ApplicationArea = Advanced;
                    Editable = false;
                    ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account that the balancing entry is posted to, such as a cash account for cash purchases.';
                    Visible = false;
                }

                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies if the entry has been part of a reverse transaction.';
                    Visible = false;
                }
                field(ReversedbyEntryNo; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the number of the correcting entry that replaced the original entry in the reverse transaction.';
                    Visible = false;
                }
                field(ReversedEntryNo; Rec."Reversed Entry No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the number of the original entry that was undone by the reverse transaction.';
                    Visible = false;
                }
                field(EntryNo; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field(Channel; Rec.Channel)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field(DimensionSetID; Rec."Dimension Set ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                    Visible = false;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the transaction number that the entry is associated with.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Entry)
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action(CheckLedgerEntries)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Check Ledger E&ntries';
                    Image = CheckLedger;
                    RunObject = Page "Check Ledger Entries";
                    RunPageLink = "Bank Account Ledger Entry No." = field("Entry No.");
                    RunPageView = sorting("Bank Account Ledger Entry No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View check ledger entries that result from posting transactions in a payment journal for the relevant bank account.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action(SetDimensionFilter)
                {
                    ApplicationArea = Suite;
                    Caption = 'Set Dimension Filter';
                    Ellipsis = true;
                    Image = "Filter";
                    ToolTip = 'Limit the entries according to dimension filters that you specify.';

                    trigger OnAction()
                    begin
                        Rec.SetFilter("Dimension Set ID", DimensionSetIDFilter.LookupFilter);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(ReverseTransaction)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reverse Transaction';
                    Ellipsis = true;
                    Image = ReverseRegister;
                    ToolTip = 'Undo an erroneous journal posting.';

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        Clear(ReversalEntry);
                        if Rec.Reversed then
                            ReversalEntry.AlreadyReversedEntry(Rec.TableCaption, Rec."Entry No.");
                        if Rec."Journal Batch Name" = '' then
                            ReversalEntry.TestFieldError;
                        Rec.TestField("Transaction No.");
                        ReversalEntry.ReverseTransaction(Rec."Transaction No.");
                    end;
                }
            }
            action(Navigate)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if UserSetup.Get(UserId) then begin
            if Memb.Get(Rec."Account No.") then begin
                if Main.Get(Memb."Member No.") then begin
                    if Main."Member Category" = Main."Member Category"::"Staff Members" then begin
                        if Main."Payroll/Staff No." <> UserSetup."Staff No" then begin
                            if UserSetup."View Staff Accounts" = false then
                                Error('You Are Not SetUp to View Other Staff''s Accounts');
                        end;
                    end;

                    if Main."Special Account" then begin
                        if UserSetup."View Special Accounts" = false then
                            Error('You Are Not SetUp to View Special Accounts');
                    end;
                end;
            end;
        end else
            Error('You Are Not SetUp to View Other Staff''s Accounts');

        if UserSetup.Get(UserId) then begin
            if Memb.Get(Rec."Account No.") then begin
                if Memb."Member Category" = Memb."member category"::"Board Members" then begin
                    if UserSetup."View Board Accounts" = false then
                        Error('You Are Not SetUp to View Board Members Accounts');
                end;
            end;
        end else
            Error('You Are Not SetUp to View Board Members Accounts');
    end;

    trigger OnOpenPage()
    begin


        UserSetup.Get(UserId);
        if not UserSetup."View Staff Accounts" then begin
            Rec.FilterGroup(2);
            //SetFilter("Member Category", '<>%1', "member category"::"Staff Members");
        end;
    end;

    var
        Navigate: Page Navigate;
        DimensionSetIDFilter: Page "Dimension Set ID Filter";
        UserSetup: Record "User Setup";
        Memb: Record "Savings Accounts";
        Main: Record Members;

    local procedure EnsureTransactionHasSameDocumentNo(TransactionNo: Integer; DocumentNo: Code[20])
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
    begin
        SavingsLedgerEntry.Reset();
        SavingsLedgerEntry.SetRange(Reversed, false);
        SavingsLedgerEntry.SetRange("Transaction No.", TransactionNo);
        SavingsLedgerEntry.SetFilter("Document No.", '<>%1', DocumentNo);
        if SavingsLedgerEntry.FindFirst() then
            Error(
                'Transaction No. %1 contains savings ledger entry %2 with a different document no. %3. Reverse from the correct document or review the transaction first.',
                TransactionNo,
                SavingsLedgerEntry."Entry No.",
                SavingsLedgerEntry."Document No.");
    end;
}

