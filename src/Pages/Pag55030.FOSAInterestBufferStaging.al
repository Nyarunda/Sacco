namespace UnitedWomen_Production.UnitedWomen_Production;
using System.Security.User;

page 55030 "FOSA Interest Buffer Staging"
{
    ApplicationArea = All;
    Caption = 'FOSA Interest Buffer Staging';
    PageType = List;
    SourceTable = "FOSA Interest Buffer Staging";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic;
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
                    LookupPageID = "Member Listing";
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Debit Amount" := 0;
                        Rec."Credit Amount" := 0;
                        if Rec.Amount > 0 then
                            Rec."Debit Amount" := Rec.Amount;
                        if Rec.Amount < 0 then
                            Rec."Credit Amount" := Rec.Amount * -1;
                    end;
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
            }
        }

    }
    actions
    {
        area(Creation)
        {
            action("Post FOSA Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Controls;
                trigger OnAction()
                var
                    FOSAInterestHeader: Record "FOSA Interest Header";
                    SaccoActivities: Codeunit "Sacco Activities";
                    FOSABuffer: Record "FOSA Interest Buffer";
                    FOSAGetBatch: Record "FOSA Interest Buffer";
                    UserSetup: Record "User Setup";
                    JTemplate: Code[10];
                    JBatch: Code[10];
                    dWindow: Dialog;
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    LastBatchNo: code[10];
                    CurrentBatchNo: code[10];
                    FosaAcc: Record "Savings Accounts";
                    TChannel: Enum "Transaction Channel";
                    PSetup: Record "Product Setup";
                    Staging: Record "FOSA Interest Buffer Staging";
                    Savings: Record "Savings Accounts";
                begin
                    if not Confirm('Are you sure you want to post these FOSA Interest') then
                        exit;

                    UserSetup.Get(UserId);
                    UserSetup.TestField("Payment Journal Template");
                    UserSetup.TestField("Payment Journal Batch");
                    UserSetup.TestField("Dimension Set ID");

                    JBatch := UserSetup."Payment Journal Batch";
                    JTemplate := UserSetup."Payment Journal Template";

                    Staging.RESET;
                    Staging.SetRange(Selected, true);
                    iF Staging.FindFirst then begin
                        dWindow.Open('Post FOSA Interest :        #1#########\'
                                    + 'Accounts:             #2#########\'
                                    + 'Counter:              #3#########\'
                                    + 'Progress:             @4@@@@@@@@@\'
                                    + 'Batch No:              #5#########\'

                                    + 'Press Esc to abort');



                        CurrentRecordNo := 0;
                        NoOfRecords := Staging.Count;
                        dWindow.Update(2, NoOfRecords);

                        SaccoActivities.JournalInit(JTemplate, JBatch);
                        repeat
                            CurrentRecordNo += 1;
                            dWindow.Update(3, CurrentRecordNo);
                            dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                            dWindow.Update(5, CurrentBatchNo);

                            if FOSABuffer."Account Type" = FOSABuffer."Account Type"::"G/L Account" then begin

                                SaccoActivities.JournalInsert(JTemplate,
                                        JBatch,
                                        FOSABuffer."Document No.",
                                        FOSABuffer."Posting Date",
                                        FOSABuffer."Account Type",
                                        FOSABuffer."Account No.",
                                        FOSABuffer.Description,
                                        FOSABuffer."Bal. Account Type",
                                        FOSABuffer."Bal. Account No.",
                                        FOSABuffer.Amount,
                                        FOSABuffer."External Document No.",
                                        FOSABuffer."Loan No",
                                        FOSABuffer."Transaction Type",
                                        FOSABuffer."Shortcut Dimension 1 Code",
                                        FOSABuffer."Shortcut Dimension 2 Code",
                                        true,
                                        TChannel::"FOSA Interest",
                                        UserSetup."Dimension Set ID"
                                        );

                                FOSABuffer.Posted := true;
                                FOSABuffer.Modify;

                            end;


                        until FOSABuffer.Next = 0;

                        SaccoActivities.JournalPost(JTemplate, JBatch);

                        dWindow.Close;
                    end;

                end;

            }

        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CheckControls();
        CurrPage.Editable := Controls;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CheckControls();
        CurrPage.Editable := Controls;
    end;

    local procedure CheckControls()
    var
        myInt: Integer;
    begin
        Controls := true;
        userSetup.Get(UserId);
        if not userSetup."FOSA Interest Endyear" then
            Controls := false;
    end;

    var
        userSetup: Record "User Setup";
        Controls: Boolean;
}
