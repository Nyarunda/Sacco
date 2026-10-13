Page 50449 "Approved ATM Linking Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "ATM Linking Applications";
    PromotedActionCategories = 'New,Process,Report,Apprvals';
    SourceTableView = where(Status = filter(Approved));

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
                field(BranchCode; Rec."Branch Code")
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
                Editable = PageEditable;
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(CardNo; Rec."Card No")
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
                field("Linked By"; Rec."Linked By")
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
            group(ATMParameters)
            {
                Caption = 'ATM Parameters';
                action("Collect ATM")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collect ATM';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        BankingActivities.CollectATM(Rec);
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
                        if Confirm('Are you sure you want to issue this pin?') then begin

                            if Rec."Card Issued By" = UserId then
                                Error('You cannot Issue Pin since you Issued Card')

                            else begin
                                //BankingActivities.LinkATMPIN(Rec);
                                Rec."PIN Issued" := true;
                                Rec."PIN Issued By" := UserId;
                                Rec."PIN Issued Date" := Today;

                                SavingsAccounts.Reset;
                                SavingsAccounts.SetRange(SavingsAccounts."No.", Rec."Account No");
                                if SavingsAccounts.Find('-') then begin
                                    SavingsAccounts."ATM No." := Rec."Card No";
                                    Rec."Linked Date" := Today;
                                    Rec."Linked By" := UserId;
                                    Rec."ATM Delinked Date" := Today;
                                    Rec."Card Status" := Rec."card status"::Active;
                                    Rec."ATM Linked" := true;
                                    Rec."ATM Delinked" := false;
                                    SavingsAccounts.Modify;
                                end;
                            end;
                            Rec.Modify;
                        end;
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
        SavingsAccounts: Record "Savings Accounts";
        JTemp: Code[20];
        JBatch: Code[20];
        BankingActivities: Codeunit "Banking Activities";
        PageEditable: Boolean;
}

