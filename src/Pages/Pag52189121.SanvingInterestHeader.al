namespace UnitedWomen_Production.UnitedWomen_Production;

page 50823 "Saving Interest Header"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Savings Interest Header";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Distributed Amount"; Rec."Distributed Amount")
                {
                }
                field("Old Interest Total"; Rec."Old Interest Total")
                {
                }
                field("Total Line Amount"; Rec."Distributed Amount" + Rec."Old Interest Total")
                {
                }
                field("No of Accs."; Rec."No of Accs.")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field(Cashier; Rec.Cashier)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Time Posted"; Rec."Time Posted")
                {
                }
            }
            part(Lines; "Saving Interest Lines")
            {
                Editable = PageEditable;
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Generals)
            {
                action("Generate Entries")
                {
                    Caption = 'Generate Entries';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SelectOpttionsErr: Label 'Select Options';
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('You canot generate entries since the document is already %1', Rec.Status);
                        PeriodicActivities.GenerateSavingssInterest(Rec);
                    end;
                }
                action("Post Entries")
                {
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        PeriodicActivities.PostSavingsInterest(Rec);
                    end;
                }
                //separator()
                // {
                // }
            }
            /*            group(Approval)
                {
                    Caption = 'Approval';
                    action(Approve)
                    {
                        Caption = 'Approve';
                        Image = Approve;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        Visible = OpenApprovalEntriesExistForCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "1535";
                        begin
                            ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                        end;
                    }
                    action(Reject)
                    {
                        Caption = 'Reject';
                        Image = Reject;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        Visible = OpenApprovalEntriesExistForCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "1535";
                        begin
                            ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                        end;
                    }
                    action(Delegate)
                    {
                        Caption = 'Delegate';
                        Image = Delegate;
                        Promoted = true;
                        PromotedCategory = Category4;
                        Visible = OpenApprovalEntriesExistForCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "1535";
                        begin
                            ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                        end;
                    }
                    action(Comment)
                    {
                        Caption = 'Comments';
                        Image = ViewComments;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page 660;
                        Visible = OpenApprovalEntriesExistForCurrUser;
                    }
                }
                group("Request Approval")
                {
                    Caption = 'Request Approval';
                    action(SendApprovalRequest)
                    {
                        Caption = 'Send A&pproval Request';
                        Enabled = NOT OpenApprovalEntriesExist;
                        Image = SendApprovalRequest;
                        Promoted = true;
                        PromotedCategory = Category9;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "1535";
                        begin
                            TESTFIELD("Posting Date");
                            TESTFIELD("Document No.");
                            TESTFIELD(Description);
                            VarVariant := Rec;
                            IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                                CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                    }
                    action(CancelApprovalRequest)
                    {
                        Caption = 'Cancel Approval Re&quest';
                        Enabled = OpenApprovalEntriesExist;
                        Image = Cancel;
                        Promoted = true;
                        PromotedCategory = Category9;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "1535";
                        begin
                            VarVariant := Rec;
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        end;
                    }
                    action(Approvals)
                    {
                        Caption = 'Approvals';
                        Image = Approvals;
                        Promoted = true;
                        PromotedCategory = Category9;

                        trigger OnAction()
                        var
                            ApprovalEntries: Page "658";
                            approvalsMgmt: Codeunit "1535";
                        begin
                            approvalsMgmt.OpenApprovalEntriesPage(RECORDID);
                        end;
                    }
                }
                */
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UpdateControls();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateControls();
    end;

    trigger OnOpenPage()
    begin
        UpdateControls();
    end;

    var
        //InterestBuffer: Record "39004401";
        //InterestBuffer2: Record "39004401";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Sacco Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        //CustomApprovals: Codeunit "39004245";
        ErrNotApproved: Label 'This document has not been approved';
        ErrNoEntries: Label 'This Document has no Lines to post';
        MSGEntriesGenerated: Label 'Entries Generated Successfully';
        MSGConfirmation: Label 'Confirm interest Generation for period starting %1 and Ending %2';
        //SavingsAccounts: Record "39004285";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        //ProductFactory: Record "39004245";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        // BankingUserTemplate: Record "39004337";
        // GenJournalLine: Record "81";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        ErrPosted: Label 'This document has already been posted';
        PageEditable: Boolean;
    //Members: Record "39004255";
    //SaccoTransactions: Codeunit "39004241";
    //SavingsInterestBuffer: Record "39004401";

    procedure UpdateControls()
    begin
        IF (Rec.Posted = TRUE) OR (Rec.Status <> Rec.Status::Open) THEN BEGIN
            PageEditable := FALSE;
        END ELSE
            PageEditable := TRUE;
    end;
}
