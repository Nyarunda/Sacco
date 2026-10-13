
Page 50339 "Cheque Discounting"
{
    PageType = Card;
    SourceTable = "Teller Transaction";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(TransactionNo; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(DiscountingAmount; Rec."Discounting Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Discounting Amount';
                    Editable = Edit;
                }
                field(DiscountedAmount; Rec."Discounted Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChequeDiscounting; Rec."Cheque Discounting")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Cheque Discounting")
            {
                ApplicationArea = Basic;
                Image = MakeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Banking Activities";
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Members.Reset;
                    Members.SetRange("No.", Rec."Member No.");
                    Members.SetFilter("Cheques Bounced", '>0');
                    if Members.FindFirst then begin
                        Members.CalcFields("Cheques Bounced");
                        Msg := 'Please NOTE that this Member Deposited ' + Format(Members."Cheques Bounced") + ' Cheques that bounced.';
                        if not Confirm(Msg + ' Do you want to continue?') then
                            Error('Process Aborted');
                    end;
                    SaccoT.ChequeDiscounting(Rec);
                end;
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

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
                        Rec.TestField("Discounting Amount");
                        Rec.TestField("Cheque Discounting");
                        Rec.TestField(Status, Rec.Status::Open);

                        VarVariant := Rec;

                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Transaction No.", 0, Documenttype::"Teller Transaction", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.Amount);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Transaction No.");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Overdraft,Imprest,"Imprest Surrender",Teller;
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Teller Transaction";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Transaction No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
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

                        if Rec.Status = Rec.Status::"Pending Approval" then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."Transaction No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    var
        DiscountingAmount: Decimal;
        Members: Record Members;
        Msg: Text;
        VarVariant: Variant;
        OpenApprovalEntriesExist: Boolean;
        Edit: Boolean;
        StatusChangePermissions: Record "User Setup";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin

        //OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

