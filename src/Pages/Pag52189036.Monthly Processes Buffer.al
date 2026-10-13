//namespace CentralDB.CentralDB;

page 50738 "Monthly Processes Buffer"
{
    ApplicationArea = All;
    Caption = 'Monthly Processes Buffer';
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Monthly Processes Buffer";
    SourceTableView = sorting("Member No.", "Entry No.") where(Posted = const(false));
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the member linked to this buffer line.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Annual Interest %"; Rec."Annual Interest %")
                {
                    ToolTip = 'Specifies the value of the Annual Interest field.', Comment = '%';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the value of the Bal. Account No. field.', Comment = '%';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of the Bal. Account Type field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.', Comment = '%';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ToolTip = 'Specifies the value of the Employer Code field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ToolTip = 'Specifies the value of the Issued Date field.', Comment = '%';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field("Loan Product type"; Rec."Loan Product type")
                {
                    ToolTip = 'Specifies the value of the Loan Product type field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ToolTip = 'Specifies the value of the Outstanding Balance field.', Comment = '%';
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ToolTip = 'Specifies the value of the Outstanding Interest field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SUSBuffer: Record "Suspend Interest Accounts";
                begin
                    if Confirm('Are you sure you want to Post Monthly process buffer') then begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("General Journal Template");
                        UserSetup.TestField("General Journal Batch");

                        Rec.JTemplate := UserSetup."General Journal Template";
                        Rec.JBatch := UserSetup."General Journal Batch";

                        SaccoActivities.JournalInit(Rec.JTemplate, Rec.JBatch);

                        Batch.Reset;
                        Batch.SetRange("Created By", UserId);
                        Batch.SetRange("Document Type", Batch."Document Type"::"Monthly Processes");
                        Batch.SetRange(Posted, false);
                        if Batch.FindSet(true) then begin

                            dWindow.Open('Monthly Processes:            #1#########\'
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

                                IntBuffer.Reset;
                                IntBuffer.SetCurrentKey("Member No.", "Entry No.");
                                IntBuffer.SetRange(Posted, false);
                                IntBuffer.SetRange("Account No", Batch."Starting No.", Batch."Ending No.");
                                if IntBuffer.FindFirst then begin
                                    //if Confirm(Format(IntBuffer.Count) + ' line(s) will be posted. Continue?') then
                                    repeat
                                        //ExtDocNo := IntBuffer."Loan No.";
                                        SaccoActivities.JournalInsert(
                                                Rec.JTemplate,
                                                Rec.JBatch,
                                                IntBuffer."Document No.",
                                                IntBuffer."Posting Date",
                                                IntBuffer."Account Type",
                                                IntBuffer."Account No",
                                                IntBuffer.Description,
                                                IntBuffer."Bal. Account Type",
                                                IntBuffer."Bal. Account No.",
                                                IntBuffer.Amount,
                                                IntBuffer."External Document No.",
                                                IntBuffer."Loan No.",
                                                IntBuffer."Transaction Type",
                                                IntBuffer."Global Dimension 1 Code",
                                                IntBuffer."Global Dimension 2 Code",
                                                true,
                                                TChannel::Recovery,
                                                IntBuffer."Dimension Set ID"
                                                );

                                        IntBuffer.Posted := true;
                                        IntBuffer.Modify;

                                    until IntBuffer.Next = 0;

                                    SaccoActivities.JournalPost(Rec.JTemplate, Rec.JBatch);
                                end;
                            until Batch.Next = 0;

                            //Batch.Posted := true;
                            Batch.Modify();

                            dWindow.Close;

                        end;
                    end;
                end;
            }
            action(TransferJournal)
            {
                ApplicationArea = Basic;
                Caption = 'Transfer to Journal';
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SUSBuffer: Record "Suspend Interest Accounts";
                begin
                    if Confirm('Are you sure you want to transfer Monthly Process Buffer lines to journal?') then begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("General Journal Template");
                        UserSetup.TestField("General Journal Batch");

                        Rec.JTemplate := UserSetup."General Journal Template";
                        Rec.JBatch := UserSetup."General Journal Batch";

                        SaccoActivities.JournalInit(Rec.JTemplate, Rec.JBatch);

                        Batch.Reset;
                        Batch.SetRange("Created By", UserId);
                        Batch.SetRange("Document Type", Batch."Document Type"::"Monthly Processes");
                        Batch.SetRange(Posted, false);
                        if Batch.FindSet(true) then begin

                            dWindow.Open('Monthly Processes:            #1#########\'
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

                                IntBuffer.Reset;
                                IntBuffer.SetCurrentKey("Member No.", "Entry No.");
                                IntBuffer.SetRange(Posted, false);
                                IntBuffer.SetRange("Account No", Batch."Starting No.", Batch."Ending No.");
                                if IntBuffer.FindFirst then begin
                                    //if Confirm(Format(IntBuffer.Count) + ' line(s) will be posted. Continue?') then
                                    repeat
                                        //ExtDocNo := IntBuffer."Loan No.";
                                        SaccoActivities.JournalInsert(
                                                Rec.JTemplate,
                                                Rec.JBatch,
                                                IntBuffer."Document No.",
                                                IntBuffer."Posting Date",
                                                IntBuffer."Account Type",
                                                IntBuffer."Account No",
                                                IntBuffer.Description,
                                                IntBuffer."Bal. Account Type",
                                                IntBuffer."Bal. Account No.",
                                                IntBuffer.Amount,
                                                IntBuffer."External Document No.",
                                                IntBuffer."Loan No.",
                                                IntBuffer."Transaction Type",
                                                IntBuffer."Global Dimension 1 Code",
                                                IntBuffer."Global Dimension 2 Code",
                                                true,
                                                TChannel::Recovery,
                                                IntBuffer."Dimension Set ID"
                                                );

                                        IntBuffer.Posted := true;
                                        IntBuffer.Modify;

                                    until IntBuffer.Next = 0;

                                    Batch.Posted := true;
                                    Batch.Modify();
                                end;
                            until Batch.Next = 0;

                            dWindow.Close;

                            Message('Monthly Process Buffer lines have been transferred to journal %1/%2. Please review and post the journal.', Rec.JTemplate, Rec.JBatch);
                        end;
                    end;
                end;
            }

            action("Clear Unposted Transaction")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    susBuffer: Record "Suspend Interest Accounts";
                begin
                    if Confirm('Are you sure you want to Clear Unposted Transaction') then begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("General Journal Template");
                        UserSetup.TestField("General Journal Batch");

                        Rec.JTemplate := UserSetup."General Journal Template";
                        Rec.JBatch := UserSetup."General Journal Batch";


                        IntBuffer.Reset;
                        IntBuffer.SetRange(Posted, false);
                        if IntBuffer.FindFirst then begin
                            IntBuffer.DeleteAll;
                        end;

                    end;
                end;
            }
            action("Member Batching")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Monthly Process Batching";
            }
            action("Generate Loans Penalty")
            {
                ApplicationArea = RelationshipMgmt;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Caption = 'Generate Loans Penalty';


                RunObject = Report "Generate Loan Penalty";
            }
            action("Recover Reg. Fee From Deposits")
            {
                ApplicationArea = RelationshipMgmt;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Visible = false;


                RunObject = report "Recover Registration From Depo";
            }
            action("Recover Share Capital Deposits")
            {
                ApplicationArea = RelationshipMgmt;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Visible = false;

                RunObject = report "Share Capital Recovery";
            }
            action("Recovery Loan Lien")
            {
                ApplicationArea = RelationshipMgmt;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Visible = false;


                RunObject = report "Recover Arrears Lien";
            }
            action("Charge Ledger Fee")
            {
                ApplicationArea = RelationshipMgmt;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Visible = false;


                RunObject = report "Charge Ledger Fee";
            }
            action("Charge Penalty Fee")
            {
                ApplicationArea = RelationshipMgmt;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Visible = false;

                RunObject = report "Charge Savings Penalty";
            }
            action("Recovery STO Loans")
            {
                ApplicationArea = RelationshipMgmt;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Visible = false;

                RunObject = report "Recover Sto Loans";
            }
            action("Transfer Int. Overpayment")
            {
                ApplicationArea = RelationshipMgmt;
                Image = "Order";
                Visible = false;
                RunObject = Report "Transfer Overpayment Interest";
            }
            action("Allocate UnAllocated Funds")
            {
                ApplicationArea = RelationshipMgmt;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Visible = true;

                RunObject = report "Transfer UnAllocated";
            }
        }
    }

    var
        IntBuffer: Record "Monthly Processes Buffer";
        SaccoActivities: Codeunit "Sacco Activities";
        UserSetup: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        ExtDocNo: Code[20];
        TransType: Enum "Transaction Type Enum";
        TChannel: Enum "Transaction Channel";
        Batch: Record "Member Batching";
        Members: Record Members;
        SaccoSetup: Record "Sacco Setup";
        DivPosting: Record "Dividend Posting";
        dWindow: Dialog;
        RecordCounter: Integer;
        TotalRecords: Integer;
}
