Page 50447 "ATM Linking Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ATM Linking Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Accounts List";

                }
                field(ATMApplicationNo; Rec."ATM Application No.")
                {
                    ApplicationArea = Basic;
                }
                field(FormNo; Rec."Form No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestType; Rec."Request Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CardType; Rec."Card Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CustomerID; Rec."Customer ID")
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
                    Editable = false;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
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
                Editable = PageEditable;
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
                field(ApprovalDate; Rec."Approval Date")
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
                field(ATMLinkingStatistics; Rec."ATM Linking Statistics")
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
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        Rec.TestField("Account No");
                        Rec.TestField("ATM Application No.");
                        Rec.TestField("Card No");
                        Rec.TestField("Card Expiry Date");
                        Rec.TestField("Account No");
                        Rec.TestField("Form No");
                        Rec.TestField("Card Type");
                        Rec.TestField("Customer ID");
                        Rec.TestField("Terms Read and Understood");
                        VarVariant := Rec;

                        Rec.Validate(Status, Rec.Status::Approved);
                        Rec.Modify();
                        Commit();
                        Message('approved');
                        //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //  CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

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
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
            group(ATMParameters)
            {
                Caption = 'ATM Parameters';
                Visible = false;
                action("Collect ATM")
                {
                    ApplicationArea = Basic;
                    Caption = 'Confirm Card Collection';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        BankingActivities.CollectATM(Rec);
                    end;
                }
                action("Link ATM")
                {
                    ApplicationArea = Basic;
                    Caption = 'Link ATM Card';
                    Image = CreditCard;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var


                    begin
                        BankingActivities.LinkATM(Rec);
                    end;
                }
                action("Issue Pin")
                {
                    ApplicationArea = Basic;
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField("PIN Issued", false);
                        Rec.TestField("Card Issued", true);
                        Rec.TestField("Card No");
                        Rec.TestField("Card Expiry Date");
                        if Confirm(ConfirmPinIssue) then begin

                            if Rec."Card Issued By" = UserId then
                                Error(ErrorIssue) else begin
                                Rec."PIN Issued" := true;
                                Rec."PIN Issued By" := UserId;
                                Rec."PIN Issued Date" := Today;
                            end;
                        end;
                        Message(MSGPINIssued);
                    end;
                }
                action("Delink ATM")
                {
                    ApplicationArea = Basic;
                    Caption = 'DeLink ATM Card';
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var


                    begin
                        //MyComment:=Window.InputBox('Enter reason for changing delinking','account:'+Rec."Account No",'',100,100);
                        //MESSAGE(MyComment);
                        BankingActivities.DeLinkATM(Rec);
                    end;
                }
            }
            group(Requestsforapproval)
            {
                Caption = 'Requests for approval';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PageEditable := true;
        if Rec.Status <> Rec.Status::Open then
            PageEditable := false;
        SetControlAppearance;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Status <> Rec.Status::Open then
            Error(errorTxt, Rec.Status);
    end;

    trigger OnOpenPage()
    begin
        PageEditable := true;
        if Rec.Status <> Rec.Status::Open then
            PageEditable := false;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Enum "Custom Document Type";// Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
        SavingsAccounts: Record "Savings Accounts";
        JTemp: Code[20];
        JBatch: Code[20];
        BankingActivities: Codeunit "Banking Activities";
        PageEditable: Boolean;
        MyDialog: Dialog;
        MyComment: Text;
        EnterComment: label 'Enter Comment';
        SMSText: label 'Your ATM Card is ready for collection. Kindly come to Our offices with original copy of your National ID Card.';
        errorTxt: label 'You cannot modify this document with status %1  ';
        ConfirmPinIssue: label 'Are you sure you want to issue this pin?';
        ErrorIssue: label 'You cannot Issue Pin since you Issued Card';
        MSGPINIssued: label 'PIN Successfully Issued.';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

