
Page 50218 "Dividend Posting Buffer"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Dividend Posting";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(DebitAmount; Rec."Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(CreditAmount; Rec."Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(ProductTypeName; Rec."Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalDocumentNo; Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountType; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountNo; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(LoanProduct; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field(Transaction; Rec.Transaction)
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
            action("Generate Posting Buffer")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Dividend Posting Buffer";
            }
            action("Dividend Analysis Report")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Dividend Analysis Report";
            }

            action("Member Batching")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Member Batching";
            }

            action("Post Entries")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to post these entries') then begin
                        SaccoSetup.Get;

                        Batch.Reset;
                        Batch.SetRange("Document Type", Batch."Document Type"::Dividends);
                        Batch.SetRange(Posted, false);
                        if Batch.FindSet(true) then begin

                            dWindow.Open('Dividend Generation:            #1#########\'
                                                + 'Total Sets:            #2#########\'
                                                + 'Counter:                #3#########\'
                                                + 'Progress:               @4@@@@@@@@@\'
                                                + 'Press Esc to abort');

                            TotalRecords := Batch.Count;
                            dWindow.Update(2, TotalRecords);
                            RecordCounter := 0;

                            repeat
                                RecordCounter += 1;
                                dWindow.Update(1, Batch."Batch No.");
                                dWindow.Update(3, RecordCounter);
                                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));


                                SaccoActivities.PostDividendLines(Batch."Starting No.", Batch."Ending No.", false, SaccoSetup."Dividend Processing Account");

                                Batch.Posted := true;
                                Batch.Modify();

                            until Batch.Next = 0;
                            dWindow.Close;
                        end;
                    end;
                end;
            }
            action("Journal Transfer")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to send these entries to journal?') then begin
                        SaccoSetup.Get;
                        Batch.Reset;
                        Batch.SetRange("Document Type", Batch."Document Type"::Dividends);
                        Batch.SetRange(Posted, false);
                        if Batch.FindSet(true) then begin




                            dWindow.Open('Dividend Generation:            #1#########\'
                                                + 'Total Sets:            #2#########\'
                                                + 'Counter:                #3#########\'
                                                + 'Progress:               @4@@@@@@@@@\'
                                                + 'Press Esc to abort');




                            TotalRecords := Batch.Count;
                            dWindow.Update(2, TotalRecords);
                            RecordCounter := 0;

                            repeat
                                RecordCounter += 1;
                                dWindow.Update(1, Batch."Batch No.");
                                dWindow.Update(3, RecordCounter);
                                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));


                                SaccoActivities.PostDividendLines(Batch."Starting No.", Batch."Ending No.", true, SaccoSetup."Dividend Processing Account");


                            until Batch.Next = 0;
                            dWindow.Close;
                        end;
                    end;
                end;
            }
            action("Journal Reversal")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MemberAccounts: Record "Savings Accounts";

                begin

                    if Confirm('Are you sure you want to send these entries to journal?') then begin
                        SaccoSetup.Get;
                        Members.Reset();
                        Members.setrange("Member Status", Members."Member Status"::Withdrawn);
                        if Members.FindSet(true) then begin




                            dWindow.Open('Dividend Generation:            #1#########\'
                                                + 'Total Sets:            #2#########\'
                                                + 'Counter:                #3#########\'
                                                + 'Progress:               @4@@@@@@@@@\'
                                                + 'Press Esc to abort');




                            TotalRecords := Members.Count;
                            dWindow.Update(2, TotalRecords);
                            RecordCounter := 0;

                            repeat
                                RecordCounter += 1;
                                dWindow.Update(1, Batch."Batch No.");
                                dWindow.Update(3, RecordCounter);
                                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));


                                MemberAccounts.Reset();
                                MemberAccounts.SetRange("Member No.", Members."No.");
                                MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Deposit Contribution");
                                MemberAccounts.setfilter("Date Filter", '..%1', DMY2Date(31, 12, 2022));
                                MemberAccounts.SetFilter("Net Change (LCY)", '<=0');
                                if MemberAccounts.FindFirst() then begin


                                    MemberAccounts.Reset();
                                    MemberAccounts.SetRange("Member No.", Members."No.");
                                    MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Share Capital");
                                    MemberAccounts.setfilter("Date Filter", '..%1', DMY2Date(31, 12, 2022));
                                    MemberAccounts.SetFilter("Net Change (LCY)", '<=0');
                                    if MemberAccounts.FindFirst() then begin

                                        SaccoActivities.ReversePostDividendLines(Members."No.", false, SaccoSetup."Dividend Processing Account");
                                    ENd;
                                end;



                            until Members.Next = 0;
                            dWindow.Close;
                        end;
                    end;
                end;
            }
        }
    }

    var
        Batch: Record "Member Batching";
        Members: Record Members;
        SaccoActivities: Codeunit "Sacco Activities";
        SaccoSetup: Record "Sacco Setup";
        DivPosting: Record "Dividend Posting";
        dWindow: Dialog;
        RecordCounter: Integer;
        TotalRecords: Integer;
}

