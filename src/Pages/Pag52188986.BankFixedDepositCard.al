namespace Wanandage.Wanandage;
using Wanandege.Sales.Customer;
using System.Automation;
using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Journal;
using System.Security.User;
using Microsoft.Service.Item;

page 50688 "Bank Fixed Deposit Card"
{
    ApplicationArea = All;
    Caption = 'Bank Fixed Deposit Card';
    PageType = Card;
    SourceTable = "Bank Fixed Deposit Account";
    PromotedActionCategories = 'New,Process,Report,Approval Requests';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = gedit;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Customer Investiment - List";

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(SavingsAccount; Rec."Savings Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(FixedAccountNo; Rec."Fixed Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(FDType; Rec."FD Type")
                {
                    ApplicationArea = Basic;
                }
                field(FDDuration; Rec."FD Duration")
                {
                    ApplicationArea = Basic;
                }
                field(FDStartDate; Rec."FD Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(FDMaturityDate; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(FDAmount; Rec."FD Amount")
                {
                    ApplicationArea = Basic;
                }
                field(NegotiatedInterest; Rec."Negotiated Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(FDAnnualInterest; Rec."FD Annual Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(FDStatus; Rec."FD Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SavingsAccountBalance; Rec."Savings Account Balance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(FixedAccountBalance; Rec."Fixed Account Balance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(FDMaturityInstructions; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyInterest; Rec."Monthly Interest")
                {
                    ApplicationArea = Basic;
                }
                field(TotalExpectedInterest; Rec."Total Expected Interest")
                {
                    ApplicationArea = Basic;
                }
                field(AccruedInterest; Rec."Accrued Interest")
                {
                    ApplicationArea = Basic;
                }
                field(UntransferedInterest; Rec."Untransfered Interest")
                {
                    ApplicationArea = Basic;
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(UpdateInstructions)
            {

                field(FDMaturityInstruction; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Process)
            {
                action("Activate FDR")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        Rec."FD Status" := Rec."FD Status"::Active;
                        Rec.MOdify;
                        Message('Activated');
                    end;
                }
                action("Process Fixed Deposit")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin


                        Rec.CalcFields("Fixed Account Balance");
                        //if "FD Amount" > "Fixed Account Balance" then
                        //  Error('Insufficient Amount in Fixed Deposit Account');

                        Rec.TestField("FD Start Date");
                        Rec.TestField("Savings Account");
                        Rec.TestField("Fixed Account No.");
                        Rec.TestField("FD Amount");
                        Rec.TestField("FD Duration");
                        Rec.TestField("FD Maturity Date");
                        if Rec."FD Maturity Instructions" = Rec."fd maturity instructions"::" " then
                            Error('Enter FD maturity Instruction');
                        Rec.TestField("Approval Status", Rec."approval status"::Approved);
                        Rec.TestField("FD Status", Rec."fd status"::Active);

                        FixedDepositAccounts.Reset;
                        FixedDepositAccounts.SetRange("No.", Rec."No.");
                        if FixedDepositAccounts.FindFirst then
                            Report.Run(Report::"Process Fixed Deposit", true, false, FixedDepositAccounts);
                    end;
                }
                action("Break Fixed Deposit")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if Confirm('Are You sure you want to Forfeit this Interest') then begin

                            Rec.CalcFields("Fixed Account Balance");
                            if Rec."FD Amount" > Rec."Fixed Account Balance" then
                                Error(
                                    'Fixed Deposit %1 cannot be broken because the fixed account %2 has insufficient balance.\Required FD Amount: %3\Available Fixed Account Balance: %4\Shortage: %5',
                                    Rec."No.",
                                    Rec."Fixed Account No.",
                                    Rec."FD Amount",
                                    Rec."Fixed Account Balance",
                                    Rec."FD Amount" - Rec."Fixed Account Balance");

                            Rec.TestField("FD Start Date");
                            Rec.TestField("Savings Account");
                            Rec.TestField("Fixed Account No.");
                            Rec.TestField("FD Amount");
                            Rec.TestField("FD Duration");
                            Rec.TestField("FD Maturity Date");
                            if Rec."FD Maturity Instructions" = Rec."fd maturity instructions"::" " then
                                Error('Enter FD maturity Instruction');
                            Rec.TestField("Approval Status", Rec."approval status"::Approved);
                            Rec.TestField("FD Status", Rec."fd status"::Active);

                            BankingActivities.BreakBankPlacement(Today, Rec."No.");
                            CurrPage.Update;

                        end;
                    end;
                }
                action("Place Fixed Deposit")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text002: label 'Are you sure you want to convert this application to membership?';
                        DimID: Integer;
                    begin
                        UserSetup.Get(UserId);

                        Rec.TestField(Posted, false);
                        Rec.TestField("Savings Account");
                        Rec.TestField("FD Start Date");
                        Rec.TestField("Fixed Account No.");
                        Rec.TestField("FD Amount");
                        Rec.TestField("FD Duration");
                        Rec.TestField("FD Maturity Date");
                        if Rec."FD Maturity Instructions" = Rec."fd maturity instructions"::" " then
                            Error('Enter FD maturity Instruction');
                        Rec.TestField("Approval Status", Rec."approval status"::Approved);
                        Rec.TestField("FD Status", Rec."fd status"::" ");
                        DimID := UserSetup."Dimension Set ID";


                        if Confirm('Are you sure you want to place this Fixed Deposit?') then begin

                            if Rec."FD Amount" > MemberActivities.GetAccountBalance(Rec."Savings Account") then
                                Error('Insufficient Balance in Savings Account.');


                            SaccoActivities.GetGeneralJournalTemplate(JTemplate, JBatch);
                            SaccoActivities.JournalInit(JTemplate, JBatch);

                            SaccoActivities.JournalInsert(
                                JTemplate,
                                JBatch,
                               Rec."No.",
                               Rec."FD Start Date",
                                Accttype::Savings,
                               Rec."Source Account",
                                'Fixed Deposit Placement',
                                Balaccttype::"Bank Account",
                                '',
                                Rec."FD Amount",
                                Rec."Source Account",
                                '',
                                Transtype::" ",
                                Rec."Global Dimension 1 Code",
                                Rec."Global Dimension 2 Code",
                                true,
                                TChannel::"Bank FD",
                                DimID
                                );

                            SaccoActivities.JournalInsert(
                                JTemplate,
                                JBatch,
                                Rec."No.",
                                Rec."FD Start Date",
                                Accttype::Customer,
                                Rec."Fixed Account No.",
                                'Fixed Deposit Placement',
                                Balaccttype::"G/L Account",
                                '',
                               -Rec."FD Amount",
                                Rec."Savings Account",
                                '',
                                Transtype::" ",
                                Rec."Global Dimension 1 Code",
                                Rec."Global Dimension 2 Code",
                                true,
                                TChannel::"Bank FD",
                                DimID
                                );

                            Rec."FD Status" := Rec."fd status"::Active;
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec.Modify;

                            SaccoActivities.JournalPost(JTemplate, JBatch);
                            Message('Fixed Deposit Placed Successfully');

                        end;
                    end;
                }
            }
            action("Validate Values")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to update these values?') then begin
                        Rec.Validate("FD Type");
                        Rec.Modify;
                    end;
                end;
            }
            action("FDR Certificate")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    FDR: Record "Fixed Deposit Accounts";
                begin
                    FDR.Reset();
                    FDR.SetRange("No.", Rec."No.");
                    if FDR.FindFirst() then
                        report.run(50175, true, false, FDR)

                end;
            }

        }
        area(processing)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        Rec.TestField(Posted, false);

                        Rec.TestField("Approval Status", Rec."approval status"::Open);

                        CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", Rec."FD Amount", Documenttype::FDR, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField("Approval Status", Rec."approval status"::Pending);

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
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: enum "Custom Document Type";
                        //Rec. Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR;
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::FDR;


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Custom Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec."Approval Status" = Rec."approval status"::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec."Approval Status" := Rec."approval status"::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        UpdateControl;
    end;

    var
        gedit: Boolean;
        matEdit: Boolean;
        UserSetup: Record "User Setup";
        FixedDepositAccounts: Record "Fixed Deposit Accounts";
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        BankingActivities: Codeunit "Banking Activities";
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        ProductSetup: Record "Product Setup";
        TChannel: Enum "Transaction Channel";

    local procedure UpdateControl()
    begin


        if Rec."Approval Status" = Rec."approval status"::Open then
            gedit := true
        else
            gedit := false;
    end;

    local procedure CheckControls()
    begin
        Rec."Application Date" := Today;
        Rec."Captured By" := UserId;
        Rec.Modify;


        Rec.TestField("Account No.");
        Rec.TestField("Savings Account");
        Rec.TestField("Fixed Account No.");
        Rec.TestField("FD Type");
        Rec.TestField("FD Start Date");
        Rec.TestField("FD Maturity Date");
        Rec.TestField("FD Amount");
        if Rec."FD Maturity Instructions" = Rec."fd maturity instructions"::" " then
            Error('Enter FD maturity Instruction');

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");

        if Rec."Global Dimension 2 Code" <> UserSetup."Global Dimension 2 Code" then begin
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec.Modify;
        end;
    end;

}
