
Page 50207 "Collateral Return Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Collateral Collection";
    PromotedActionCategories = 'New,Process,Report,Approval Request';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PEditable;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralNo; Rec."Collateral No.")
                {
                    ApplicationArea = Basic;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Collateral ")
            {
                Editable = false;
                field(CollateralType; Rec."Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field(Collateral; Rec.Collateral)
                {
                    ApplicationArea = Basic;
                }
                field(CollateralName; Rec."Collateral Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralMultiplier; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralValue; Rec."Collateral Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralLimit; Rec."Collateral Limit")
                {
                    ApplicationArea = Basic;
                }
                field(ChargedValue; Rec."Charged Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralDetails; Rec."Collateral Details")
                {
                    ApplicationArea = Basic;
                }
                field(ValuationType; Rec."Valuation Type")
                {
                    ApplicationArea = Basic;
                }
                field(RegisteredOwner; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field(InwardOutward; Rec."Inward/Outward")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LastValuationDate; Rec."Last Valuation Date")
                {
                    ApplicationArea = Basic;
                }
                field(ForcedSaleValue; Rec."Forced Sale Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralPerfected; Rec."Collateral Perfected")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(NextValuationDate; Rec."Next Valuation Date")
                {
                    ApplicationArea = Basic;
                }
                field(InsuranceExpiryDate; Rec."Insurance Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReOpenedBy; Rec."Re-Opened By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateReOpened; Rec."Date Re-Opened")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LegallyCleared; Rec."Legally Cleared")
                {
                    ApplicationArea = Basic;
                }
                field("Cleared By"; Rec."Cleared By")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Collection)
            {
                Editable = PEditable;
                field(CollectionStatus; Rec."Collection Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CollectorIDNo; Rec."Collector ID No")
                {
                    ApplicationArea = Basic;
                }
                field(CollectorName; Rec."Collector Name")
                {
                    ApplicationArea = Basic;
                }
                field(CollectorPhoneNo; Rec."Collector Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateCollected; Rec."Date Collected")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;


                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Collateral Return", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        Rec.TestField(Status, Rec.Status::Pending);

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
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Collateral Return";


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

                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                        end
                        else begin

                            if Confirm('Are you sure you want to re-open this document?') then begin
                                Rec.Status := Rec.Status::Open;
                                Rec.Modify;
                            end;

                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        PEditable: Boolean;
        LoanSecurity: Record "Loan Security";
        Loan: Record Loans;
        UserSetup: Record "User Setup";
        Text009: Label 'You do not permission to create/view collateral. Please contact ICT';

    local procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Open then
            PEditable := true
        else
            PEditable := false;

        UserSetup.Get(UserId);
        if not UserSetup."Collateral Reg" then
            Error(Text009);
    end;


    procedure CheckControls()
    begin

        //TestField(Status, Status::Approved);
        Rec.TestField(Status, Rec.Status::Open);


        Rec.TestField("Collector ID No");
        Rec.TestField("Collector Name");
        Rec.TestField("Collector Phone No.");

        LoanSecurity.Reset;
        LoanSecurity.SetRange("Collateral Reg. No.", Rec."No.");
        LoanSecurity.SetFilter("Current Committed", '>0');
        if LoanSecurity.FindSet() then
            repeat
                // Appraisal-only collateral is not a commitment against a loan
                // and must therefore not prevent collateral return.
                if Loan.Get(LoanSecurity."Loan No.") and Loan.Posted then
                    Error('This Collateral still has a current commitment of %1 on posted Loan %2 - %3: %4.', LoanSecurity."Current Committed", LoanSecurity."Loan No.", LoanSecurity."Member No", LoanSecurity."Loanee Name");
            until LoanSecurity.Next() = 0;
    end;
}

