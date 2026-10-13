Page 50444 "ATM Application Card"
{
    PageType = Card;
    SourceTable = "ATM Applications";
    SourceTableView = where(Status = filter(<> Approved));
    PromotedActionCategories = 'New,Process,Report,Approvals';
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
                field(FormNo; Rec."Form No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(CardType; Rec."Card Type")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    ValuesAllowed = Savings;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    LookupPageId = "Member Accounts List";
                }
                field(RequestType; Rec."Request Type")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CardReplacement;
                    end;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerID; Rec."Customer ID")
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
                field(SalesAgentType; Rec."Sales Agent Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(SalesAgent; Rec."Sales Agent")
                {
                    ApplicationArea = Basic;
                    Visible = SalesAgentVisible;
                }
                field(CaptureDate; Rec."Capture Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedBy; Rec."Approved  By")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalDate; Rec."Approval Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Communication)
            {
                Editable = PageEditable;
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
                field(ATMChargesApplied; Rec."ATM Charges Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateIssued; Rec."Date Issued")
                {
                    ApplicationArea = Basic;
                }
                field(Limit; Rec.Limit)
                {
                    ApplicationArea = Basic;
                }
                field(TermsReadandUnderstood; Rec."Terms Read and Understood")
                {
                    ApplicationArea = Basic;
                }
                field(ReplacementForCardNo; Rec."Replacement For Card No")
                {
                    ApplicationArea = Basic;
                    Editable = ReplaceEditable;
                }
            }
            group("ATM Linking")
            {
                Editable = false;
                Visible = false;
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
                field(Collected; Rec.Collected)
                {
                    ApplicationArea = Basic;
                }
                field(CardIssuedBy; Rec."Card Issued By")
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
                field(DateCollected; Rec."Date Collected")
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
                action("Charge Card Fee")
                {
                    ApplicationArea = Basic;
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        PeriodicActivities.PostATMApplicationCharges(Rec);
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
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        //NoSeriesMgt: Codeunit NoSeriesManagement;
                        SavingsAccounts: Record "Savings Accounts";
                        Members: Record Members;
                        SavingsAccountss: Record "Savings Accounts";
                        TChargeAmount: Decimal;
                        TCharges: Decimal;
                        ChargeAmount: Decimal;
                        GenSetup: Record "Sacco Setup";
                        Account: Record "Savings Accounts";
                        AvailableBalance: Decimal;
                        MinBalance: Decimal;
                        ATMCardTypes: Record "ATM Card Types";
                        UserSetup: Record "User Setup";
                        ATMApplications: Record "ATM Applications";
                        CashierTransactions: Record "Teller Transaction";
                        SavingsACC: Record "Savings Accounts";
                        MemberActivities: Codeunit "Member Activities";
                        SourceType: enum "SMS Source Enum";
                        GeneralSetUp: Record "Sacco Setup";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        ErrRejectCard: label 'This account do not have minimum balance of KES %1 to apply for ATM Card.';
                        Txt004: label 'Dear Member, Your account donot have sufficient funds to apply for ATM card';
                    begin
                        //TESTFIELD("ATM Charges Applied",TRUE);
                        Rec.TestField("Account No");
                        Rec.TestField("Form No");
                        Rec.TestField("Card Type");
                        //TESTFIELD("Customer ID");
                        Rec.TestField("Terms Read and Understood");
                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");


                        ATMApplications.Reset;
                        ATMApplications.SetRange(ATMApplications."Account No", Rec."Account No");
                        ATMApplications.SetRange(ATMApplications."ATM Delinked", false);
                        if ATMApplications.Find('-') then begin
                            repeat
                                if ATMApplications."ATM Charges Applied" = false then
                                    if ATMApplications."No." <> Rec."No." then
                                        Error('This Account has an active ATM application');
                            until ATMApplications.Next = 0;
                        end;

                        Rec.TestField("Card Type");
                        UserSetup.Get(UserId);
                        TChargeAmount := 0;
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange(SavingsAccounts."No.", Rec."Account No");
                        if SavingsAccounts.Find('-') then begin

                            CashierTransactions.Reset;
                            CashierTransactions.SetRange("Account No.", Rec."Account No");
                            CashierTransactions.SetRange(Remarks, 'ATM Application Charges');
                            CashierTransactions.SetRange(Posted, true);
                            CashierTransactions.SetRange(Type, CashierTransactions.Type::Lien);
                            if CashierTransactions.FindFirst then begin
                                CashierTransactions.ModifyAll("Cheque Status", CashierTransactions."cheque status"::Stopped);
                            end;

                            Members.Reset;
                            Members.SetRange(Members."No.", SavingsAccounts."Member No.");

                            AvailableBalance := MemberActivities.GetAccountBalance(SavingsAccounts."No.");

                            GenSetup.Get;
                            ChargeAmount := 0;

                            ATMCardTypes.Reset;
                            ATMCardTypes.SetRange(ATMCardTypes.Code, Rec."Card Type");
                            if ATMCardTypes.Find('-') then begin
                                if Rec."Request Type" = Rec."request type"::New then begin

                                    Value := 0;
                                    ChargeAmount := 0;
                                    ChargeDuty := 0;
                                    ChargeAcctType := Chargeaccttype::"G/L Account";
                                    ChargeAcct := '';
                                    MemberActivities.GetGeneralChargeAmount(ATMCardTypes."Application Charge Code", Value, ChargeAmount, ChargeDuty, ChargeAcctType, ChargeAcct);

                                    TChargeAmount := ChargeDuty + ChargeAmount;

                                end
                                else
                                    if Rec."Request Type" = Rec."request type"::Replacement then begin


                                        Value := 0;
                                        ChargeAmount := 0;
                                        ChargeDuty := 0;
                                        ChargeAcctType := Chargeaccttype::"G/L Account";
                                        ChargeAcct := '';
                                        MemberActivities.GetGeneralChargeAmount(ATMCardTypes."Replacement Charge Code", Value, ChargeAmount, ChargeDuty, ChargeAcctType, ChargeAcct);

                                        TChargeAmount := ChargeDuty + ChargeAmount;

                                    end;
                            end;
                        end;

                        if AvailableBalance < TChargeAmount then begin
                            Error(ErrRejectCard, (TChargeAmount - AvailableBalance));
                        end;

                        /* //   MESSAGE('T charges %1 and %2',TChargeAmount,ChargeAmount);
                        CashierTransactions.INIT;
                        CashierTransactions.No:='';
                        CashierTransactions."Account No":="Account No";
                        CashierTransactions."Account Name":="Account Name";
                        CashierTransactions."Available Balance":=AvailableBalance;
                        CashierTransactions."Global Dimension 1 Code":="Shortcut Dimension 1 Code";
                        CashierTransactions."Global Dimension 2 Code":="Shortcut Dimension 2 Code";
                        CashierTransactions."ID No":='';
                        CashierTransactions."Responsibility Center":="Responsibility Center";
                        CashierTransactions.Amount:=TChargeAmount;
                        CashierTransactions.Cashier:=USERID;
                        CashierTransactions.Remarks:='ATM Application Charges';
                        CashierTransactions.Posted:=TRUE;
                        CashierTransactions.Type:=CashierTransactions.Type::Lien;
                        CashierTransactions.INSERT(TRUE);
                        */

                        VarVariant := Rec;
                        //Validate(Status, Status::Approved);
                        //Message('Approved');
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"ATM App.", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
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
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
                action("send sms")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        // //                           IF SavingsAcc.GET(ATMApplications."Account No") THEN
                        //                             BEGIN
                        //                            SendSMS.SendSms(SourceType::"ATM Collection",SavingsAcc."Mobile Phone No",Txt004,ATMApplications."No.",SavingsAccounts."No.",FALSE);
                        //                              END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        CardReplacement;
        UpdateControls;
    end;

    trigger OnInit()
    begin
        CompanyInformation.Get();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CardReplacement
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //CardReplacement;
    end;

    trigger OnOpenPage()
    begin
        CompanyInformation.Get();
        CardReplacement;
        UpdateControls;
    end;

    var

        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        SharingAmt: Decimal;
        SharingChargeAcctType: Enum "Gen. Journal Account Type";
        SharingChargeAcct: Code[20];
        Value: Decimal;
        TotalCharge: Decimal;
        TotalDuty: Decimal;
        CompanyInformation: Record "Company Information";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Enum "Custom Document Type";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
        SavingsAccounts: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Banking Activities";
        JTemp: Code[20];
        JBatch: Code[20];
        ReplaceEditable: Boolean;
        PageEditable: Boolean;
        SalesAgentVisible: Boolean;
        SharingAmount: Decimal;
        SharingDuty: Decimal;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    local procedure CardReplacement()
    begin
        if Rec."Request Type" = Rec."request type"::New then
            ReplaceEditable := false else
            ReplaceEditable := true;
    end;


    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Open then begin
            PageEditable := false;
        end else
            PageEditable := true;
        CompanyInformation.Get();
        //if CompanyInformation."Use Sales Agents" then
        //  SalesAgentVisible := true else
        //SalesAgentVisible := false;
    end;
}

