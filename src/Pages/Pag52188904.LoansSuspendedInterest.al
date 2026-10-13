page 50606 "Loans Suspended Interest"
{
    ApplicationArea = All;
    Caption = 'Loans Suspneded Interest';
    PageType = List;
    SourceTable = "Suspend Interest Accounts";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Amount field.';
                }
                field("Interest Date"; Rec."Interest Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Date field.';
                }
                field("Transfered to Income Ac"; Rec."Transfered to Income Ac")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfered to Income Ac field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issued Date field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Interest Income Account"; Rec."Interest Income Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Income Account field.';
                }
                field("Suspended Account No."; Rec."Suspended Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suspended Account No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Suspended Interest")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SuspendedInterest: Record "Suspend Interest Accounts";
                    DocNo: Code[20];
                    Description: Text[150];
                    ProgressDialog: Dialog;
                    CurrentLine: Integer;
                    TotalLines: Integer;
                begin
                    UserSetup.Get(UserId);
                    UserSetup.TestField("General Journal Template");
                    UserSetup.TestField("General Journal Batch");

                    JTemplate := UserSetup."General Journal Template";
                    JBatch := UserSetup."General Journal Batch";

                    SuspendedInterest.Reset();
                    SuspendedInterest.SetRange(Posted, false);
                    if not SuspendedInterest.FindSet() then
                        Error('There are no unposted suspended interest transactions.');

                    TotalLines := SuspendedInterest.Count();
                    if not Confirm('%1 suspended interest transaction(s) will be posted. Continue?', false, TotalLines) then
                        exit;

                    SaccoActivities.JournalInit(JTemplate, JBatch);
                    ProgressDialog.Open('Posting suspended interest...\Line #1#### of #2####\Loan No. #3############\Document No. #4############');
                    repeat
                        CurrentLine += 1;
                        SuspendedInterest.TestField("Account No.");
                        SuspendedInterest.TestField("Suspended Account No.");
                        SuspendedInterest.TestField("Interest Amount");

                        DocNo := CopyStr(
                            UpperCase(Format(SuspendedInterest."Interest Date", 0, '<Month Text,3> <Year4>')) + '-SUS',
                            1,
                            MaxStrLen(DocNo));
                        Description := SuspendedInterest.Description;
                        if Description = '' then
                            Description := CopyStr(SuspendedInterest."Loan No." + ': Suspended Interest', 1, MaxStrLen(Description));

                        TransType := TransType::"Interest Due";
                        ExtDocNo := SuspendedInterest."Loan No.";
                        ProgressDialog.Update(1, CurrentLine);
                        ProgressDialog.Update(2, TotalLines);
                        ProgressDialog.Update(3, SuspendedInterest."Loan No.");
                        ProgressDialog.Update(4, DocNo);

                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            SuspendedInterest."Interest Date",
                            AcctType::Credit,
                            SuspendedInterest."Account No.",
                            CopyStr(Description, 1, 100),
                            AcctType::"G/L Account",
                            SuspendedInterest."Suspended Account No.",
                            SuspendedInterest."Interest Amount",
                            ExtDocNo,
                            SuspendedInterest."Loan No.",
                            TransType,
                            SuspendedInterest."Global Dimension 1 Code",
                            SuspendedInterest."Global Dimension 2 Code",
                            true,
                            TChannel::"Interest Billing",
                            0);

                        SuspendedInterest.Posted := true;
                        SuspendedInterest.Modify();

                        SaccoActivities.JournalPost(JTemplate, JBatch);
                    until SuspendedInterest.Next() = 0;
                    ProgressDialog.Close();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Bill Interest" then
            Error('You do not have permission to Loan Interest Billing. Contact your administrator');
    end;

    var
        SaccoActivities: Codeunit "Sacco Activities";
        UserSetup: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        ExtDocNo: Code[20];
        TransType: Enum "Transaction Type Enum";
        TChannel: Enum "Transaction Channel";
}
