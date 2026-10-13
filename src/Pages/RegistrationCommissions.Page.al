Page 50409 "Registration Commissions"
{
    PageType = List;
    SourceTable = "Registration Commissions";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Line No.';
                }
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
                field("Commission Paid"; Rec."Commission Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Commission Paid"; Rec."Sales Commission Paid")
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
            action("Get Commissions")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Get Commissions";
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
                    if Confirm('Are you sure you want to Post Generated Commissions') then begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("General Journal Template");
                        UserSetup.TestField("General Journal Batch");

                        JTemplate := UserSetup."General Journal Template";
                        JBatch := UserSetup."General Journal Batch";

                        SaccoActivities.JournalInit(JTemplate, JBatch);
                        Buffer.Reset;
                        Buffer.SetRange(Posted, false);
                        if Buffer.FindFirst then begin
                            if Confirm(Format(Buffer.Count) + ' line(s) will be posted. Continue?') then
                                repeat

                                    SaccoActivities.JournalInsert(
                                        JTemplate,
                                        JBatch,
                                        Buffer."Document No.",
                                        Buffer."Posting Date",
                                        Buffer."Account Type",
                                        Buffer."Account No.",
                                        Buffer.Description,
                                        Buffer."Bal. Account Type",
                                        Buffer."Bal. Account No.",
                                        Buffer.Amount,
                                        Buffer."External Document No.",
                                        Buffer."Loan No",
                                        Buffer."Transaction Type",
                                        Buffer."Shortcut Dimension 1 Code",
                                        Buffer."Shortcut Dimension 2 Code",
                                        true,
                                        TChannel::" ",
                                        UserSetup."Dimension Set ID"
                                        );

                                    Buffer.Posted := true;
                                    Buffer.Modify;
                                    Members.Get(Buffer."External Document No.");
                                    Members."Commission Paid" := true;
                                    Members.Modify;

                                until Buffer.Next = 0;
                        end;

                        SaccoActivities.JournalPost(JTemplate, JBatch);
                    end;
                end;
            }
        }
    }

    var
        Members: Record Members;
        Buffer: Record "Registration Commissions";
        UserSetup: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        SaccoActivities: Codeunit "Sacco Activities";
        TChannel: Enum "Transaction Channel";
}

