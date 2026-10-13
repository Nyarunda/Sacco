Page 50441 "Approved ATM Application Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "ATM Applications";
    PromotedActionCategories = 'New,Process,Report,Approval';
    SourceTableView = where(Status = filter(Approved | "Pending Approval"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(FormNo; Rec."Form No")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerID; Rec."Customer ID")
                {
                    ApplicationArea = Basic;
                }
                field(RequestType; Rec."Request Type")
                {
                    ApplicationArea = Basic;
                }
                field(CardType; Rec."Card Type")
                {
                    ApplicationArea = Basic;
                }
                field(SalesAgent; Rec."Sales Agent")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
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
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(CaptureDate; Rec."Capture Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            group(Communication)
            {
                Editable = false;
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("ATM Parameters")
            {
                Editable = false;
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(CardNo; Rec."Card No")
                {
                    ApplicationArea = Basic;
                }
                field(DateIssued; Rec."Date Issued")
                {
                    ApplicationArea = Basic;
                }
                field(Limit; Rec.Limit)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TermsReadandUnderstood; Rec."Terms Read and Understood")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CardExpiryDate; Rec."Card Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Receivedfromcoop; Rec."Received from coop")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivedfromcoopBy; Rec."Received from coop By")
                {
                    ApplicationArea = Basic;
                }
                field(IssueToBranch; Rec."Issue To Branch")
                {
                    ApplicationArea = Basic;
                }
                field(IssueToBranchBy; Rec."Issue To Branc By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue To Branch By';
                }
                field(ReceiveFromBranch; Rec."Receive From Branch")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivefromBranchBy; Rec."Receive from Branch By")
                {
                    ApplicationArea = Basic;
                }
            }
            group("ATM Linking")
            {
                Editable = false;
                field(CardIssued; Rec."Card Issued")
                {
                    ApplicationArea = Basic;
                }
                field(LinkedDate; Rec."Linked Date")
                {
                    ApplicationArea = Basic;
                }
                field(ATMLinked; Rec."ATM Linked")
                {
                    ApplicationArea = Basic;
                }
                field(CardStatus; Rec."Card Status")
                {
                    ApplicationArea = Basic;
                }
                field(DateActivated; Rec."Date Activated")
                {
                    ApplicationArea = Basic;
                }
                field(DateFrozen; Rec."Date Frozen")
                {
                    ApplicationArea = Basic;
                }
                field(ReplacementForCardNo; Rec."Replacement For Card No")
                {
                    ApplicationArea = Basic;
                }
                field(Collected; Rec.Collected)
                {
                    ApplicationArea = Basic;
                }
                field(CardIssuedBy; Rec."Card Issued By")
                {
                    ApplicationArea = Basic;
                }
                field(DateCollected; Rec."Date Collected")
                {
                    ApplicationArea = Basic;
                }
                field(DelinkedBy; Rec."Delinked By")
                {
                    ApplicationArea = Basic;
                }
                field(ATMDelinked; Rec."ATM Delinked")
                {
                    ApplicationArea = Basic;
                }
                field(ATMDelinkedDate; Rec."ATM Delinked Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group("PIN Details")
            {
                Editable = false;
                field(PINIssued; Rec."PIN Issued")
                {
                    ApplicationArea = Basic;
                }
                field(PINIssuedDate; Rec."PIN Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field(PINIssuedBy; Rec."PIN Issued By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(PesaPointATMCard)
            {
                Caption = 'Pesa Point ATM Card';
                action("Charge Card Fee")
                {
                    ApplicationArea = Basic;
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("ATM Charges Applied", false);
                        bankingActivities.PostATMApplicationCharges(Rec);
                    end;
                }
                action(ConfirmCardCollection)
                {
                    ApplicationArea = Basic;
                    Caption = 'Confirm Card Collection';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //SaccoTransactions.CollectATM(Rec);
                    end;
                }
                action("Issue Pin")
                {
                    ApplicationArea = Basic;
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("PIN Issued", false);
                        Rec.TestField("Card Issued", true);
                        if Confirm('Are you sure you want to issue this pin?') then begin
                            if Rec."Card Issued By" = UserId then
                                Error('You cannot Issue Pin since you Issued Card') else begin
                                Rec."PIN Issued" := true;
                                Rec."PIN Issued By" := UserId;
                                Rec."PIN Issued Date" := Today;
                                Rec.Modify;
                            end;
                        end;
                    end;
                }
                action(LinkATMCard)
                {
                    ApplicationArea = Basic;
                    Caption = 'Link ATM Card';
                    Image = CreditCard;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //SaccoTransactions.LinkATM(Rec);
                    end;
                }
                action("Confirm Collection From Coop")
                {
                    ApplicationArea = Basic;
                    Image = ItemAvailbyLoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if not Confirm('Confirm Card Receipt from coop') then exit;
                        Rec.TestField("ATM Charges Applied", true);
                        Rec."Received from coop" := true;
                        Rec."Received from coop By" := UserId;
                        // IF SavingsAcc.GET("Account No") THEN
                        //                             BEGIN
                        //                            SendSMS.SendSms(SourceType::"ATM Collection",SavingsAcc."Mobile Phone No",Txt004,"No.",SavingsAcc."No.",FALSE);
                        //                              END;
                        Rec.Modify;
                    end;
                }
                action("Issue To Branch")
                {
                    ApplicationArea = Basic;
                    Image = BinContent;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if not Confirm('Confirm Card Issue to branch') then exit;
                        Rec.TestField("ATM Charges Applied", true);

                        Rec."Issue To Branch" := true;
                        Rec."Issue To Branc By" := UserId;
                        Rec.Modify;
                    end;
                }
                action("Receive From Branch")
                {
                    ApplicationArea = Basic;
                    Image = Bin;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if not Confirm('Confirm Card Receipt') then exit;
                        Rec.TestField("ATM Charges Applied", true);
                        Rec."Receive From Branch" := true;
                        Rec."Receive from Branch By" := UserId;
                        if SavingsAcc.Get(Rec."Account No") then begin
                            MemberActivities.SendSms(Sourcetype::"ATM Collection", SavingsAcc."Mobile Phone No.", Txt004, Rec."No.", SavingsAcc."No.", false, false);
                        end;
                        Rec.Modify;
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit System.automation."Approvals Mgmt.";
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
        SavingsAccounts: Record "Savings Accounts";
        JTemp: Code[20];
        JBatch: Code[20];
        SaccoActivities: Codeunit "Sacco Activities";
        BankingActivities: Codeunit "Banking Activities";
        SavingsAcc: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        SourceType: Enum "SMS Source Enum";
        Txt004: label 'Your ATM Card is ready for collection. Kindly visit your branch for collection.';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;




}

