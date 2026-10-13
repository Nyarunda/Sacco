
Page 50209 "Loan Changes Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Changes";
    PromotedActionCategories = 'New,Process,Report,Post change,Approval Requests';

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofChange; Rec."Type of Change")
                {
                    ApplicationArea = Basic;
                    // ValuesAllowed = " ", "Loan Rescheduling", "Repay Mode", "Stop Interest", "Debt Collector", "Adjusted Repayment";

                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstanding; Rec."Total Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field("Dont Send SMS"; Rec."Dont Send SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Don''t Send SMS';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }

            }
            group(LoanDetails)
            {
                Caption = 'Loan Details';
                Visible = updateLoanBool;
                field("Account Manager"; Rec."Account Manager")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Account Manager"; Rec."New Account Manager")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Rescheduling)
            {
                Caption = 'Rescheduling';
                Visible = ReschdulingBool;
                field(ReschedulingType; Rec."Rescheduling Type")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduleStartDate; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduling Date"; Rec."Rescheduling Date")
                {
                    ApplicationArea = Basic;
                }
                field(NewInterestDue; Rec."New Interest Due")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChargeType; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field(Charges; Rec.Charges)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Interest Calc. Method"; Rec."New Interest Calc. Method")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field(OriginalInstallments; Rec."Original Installments")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumInstallments; Rec."Maximun Installments")
                {
                    ApplicationArea = Basic;
                }
                field(RemainingInstallments; Rec."Remaining Installments")
                {
                    ApplicationArea = Basic;
                }
                field(NewInstallments; Rec."New Installments")
                {
                    ApplicationArea = Basic;
                }
                field(OldRepayment; Rec."Old Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(NewRepayment; Rec."New Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Insurance Amount"; Rec."New Insurance Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Contribution"; Rec."Deposit Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("NewDepositContribution"; Rec."New Deposit Contribution")
                {
                    ApplicationArea = basic;
                }
                field(AdjustedRepayment; Rec."Adjusted Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(NewLoanAmount; Rec."New Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field(NewScheduleAmount; Rec."New Schedule Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the amount to use when generating the rescheduled repayment schedule. If blank or zero, the schedule uses the current loan balance.';
                }
            }
            group(Moratorium)
            {
                Caption = 'Loan Moratorium';
                Visible = MoratoriumBool;

                field("Loan Moratorium Start Date"; Rec."Loan Moratorium Start Date")
                {
                    ApplicationArea = Basic;
                }

                field("Loan Moratorium End Date"; Rec."Loan Moratorium End Date")
                {
                    ApplicationArea = Basic;
                }
            }

            group(AdjustmentAmount)
            {
                Caption = 'Adjust Repayment Amount';
                Visible = AdjustRepayment;


                field("Old Repayment"; Rec."Old Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AdjustedRepaymentt; Rec."Adjusted Repayment")
                {
                    ApplicationArea = Basic;
                }
            }
            group(InsuranceAdjustment)
            {
                Caption = 'Insurance Adjustment';
                Visible = InsuranceBool;

                field(InsuranceEffectiveDate; Rec."Rescheduling Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Effective Repayment Date';
                }
                field(CurrentInsuranceAmount; Rec."Insurance Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Insurance Amount';
                    Editable = false;
                }
                field(NewScheduleInsuranceAmount; Rec."New Insurance Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Insurance Amount';
                }
            }
            group(ChargeControl)
            {
                Caption = 'Interest, Penalty and Insurance Control';
                Visible = ChargeControlVisible;

                field(ChargeControlEffectiveDate; Rec."Rescheduling Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Effective Date';
                }
                field(InterestCurrentlyStopped; Rec."Interest Currently Stopped")
                {
                    ApplicationArea = Basic;
                }
                field(InterestAction; Rec."Interest Action")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyCurrentlyStopped; Rec."Penalty Currently Stopped")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyAction; Rec."Penalty Action")
                {
                    ApplicationArea = Basic;
                }
                field(InsuranceCurrentlyStopped; Rec."Insurance Currently Stopped")
                {
                    ApplicationArea = Basic;
                }
                field(InsuranceAction; Rec."Insurance Action")
                {
                    ApplicationArea = Basic;
                }
                field(ResumeInsuranceAmount; Rec."New Insurance Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Amount on Resume';
                    ToolTip = 'Required when Insurance Action is Resume. Future repayment schedule entries will use this amount.';
                }
            }
            group(AdjustDepositContrib)
            {
                Caption = 'Adjust Deposit Contribution';
                Visible = AdjustDepContrib;
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Current Deposit Contribution"; Rec."Current Deposit Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Deposit Contribution"; Rec."New Deposit Contribution")
                {
                    ApplicationArea = Basic;
                }
            }

            group(DebtCollection)
            {
                Caption = 'Debt Collector';
                Visible = DebtBool;
                field("Debt Coll. Def Amount"; Rec."Debt Coll. Def Amount")
                {
                    Caption = 'Amount Defaulted';
                    ApplicationArea = Basic;
                }
                field("Debt Collector Type"; Rec."Debt Collector Type")
                {
                    ApplicationArea = Basic;
                }
                field("Debt Collector"; Rec."Debt Collector")
                {
                    ApplicationArea = Basic;
                }
                field("Debt Collector Name"; Rec."Debt Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(InterestChanges)
            {
                Caption = 'Interest Changes';
                Visible = false;

                field(InterestRate; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NewInterestRate; Rec."New Interest Rate")
                {
                    ApplicationArea = Basic;
                }
            }
            group(InterestCalMethod)
            {
                Caption = 'Interest Calculation Method';
                Visible = InterestCalcBool;
                field("Interest Calculation Method_"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Interest Calc. Method_"; Rec."New Interest Calc. Method")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Schedule Start Date"; Rec."Schedule Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Balance"; Rec."Schedule Balance")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the balance to use when generating the revised repayment schedule. This does not change the actual outstanding loan balance.';
                }
            }
            group(ProductType)
            {
                Caption = 'Update Product Type';
                Visible = LoanProductVisible;

                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("New Loan Product Type"; Rec."New Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("New Loan Product Type Name"; Rec."New Loan Product Type Name")
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
            action("Post Change")
            {
                ApplicationArea = Basic;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField(Processed, false);

                    SaccoActivities.LoanChangesFn(Rec);
                    Message('Process Completed');
                    CurrPage.close();
                end;
            }
            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Schedule Report';
                Image = Link;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    LoanChangeRec: Record "Loan Changes";
                begin

                    Rec.TestField("Loan No.");

                    if Rec."Type of Change" in [Rec."Type of Change"::"Loan Rescheduling", Rec."Type of Change"::"Adjust Deposit Contribution", Rec."Type of Change"::"Interest Calculation Method", Rec."Type of Change"::"Loan Moratorium"] then begin
                        CheckControls;
                        SaccoActivities.GenerateLoanReschedulingPreview(Rec);
                        Commit;
                        LoanChangeRec.Get(Rec."No.");
                        LoanChangeRec.SetRecFilter();
                        Report.Run(Report::"Loan Repayment Schedule Prev", true, false, LoanChangeRec);
                    end else begin
                        LoanRec.Reset();
                        LoanRec.SetRange("Loan No.", Rec."Loan No.");
                        if LoanRec.FindFirst() then
                            Report.Run(Report::"Loan Repay Schedule Full Date", true, false, LoanRec);
                    end;
                end;
            }
            action("Loan Rescheduling Back Page")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Rescheduling Back Page';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                Visible = ReschdulingBool;

                trigger OnAction()
                var
                    LoanChangeRec: Record "Loan Changes";
                begin
                    Rec.TestField("Type of Change", Rec."Type of Change"::"Loan Rescheduling");
                    Rec.TestField("Loan No.");

                    LoanChangeRec.Get(Rec."No.");
                    LoanChangeRec.SetRecFilter();
                    Report.Run(Report::"Loan Rescheduling Back Page", true, false, LoanChangeRec);
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
                    PromotedCategory = Category5;

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

                        CheckControls;
                        //Rec
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Loan Changes", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Custom Document Type", DocumentType::"Loan Changes");
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
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
        updateLoanBool: Boolean;
        RecoveryBool: Boolean;
        InterestBool: Boolean;
        InterestCalcBool: Boolean;
        ReschdulingBool: Boolean;
        DebtBool: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
        Loans: Record Loans;
        LoanSuspensionBool: Boolean;
        LoanProductVisible: Boolean;
        LoanRepaymentDate: Boolean;
        AdjustRepayment: Boolean;
        ExemptRecovery: Boolean;
        ScheduleStartDate: Boolean;
        AdjustDepContrib: Boolean;
        InsuranceBool: Boolean;
        ChargeControlVisible: Boolean;
        LoanRec: Record Loans;
        MoratoriumBool: Boolean;

    local procedure UpdateControls()
    begin

        InterestBool := false;
        InterestCalcBool := false;
        ReschdulingBool := false;
        RecoveryBool := false;
        LoanSuspensionBool := false;
        LoanProductVisible := false;
        DebtBool := false;
        ExemptRecovery := false;
        ScheduleStartDate := False;
        updateLoanBool := false;
        AdjustDepContrib := false;
        InsuranceBool := false;
        ChargeControlVisible := false;
        MoratoriumBool := false;


        if Rec."Type of Change" = Rec."type of change"::"Debt Collector" then
            DebtBool := true;

        if Rec."Type of Change" = Rec."type of change"::"Loan Rescheduling" then
            ReschdulingBool := true;


        if Rec."Type of Change" = Rec."type of change"::"Interest Calculation Method" then
            InterestCalcBool := true;


        if Rec."Type of Change" = Rec."type of change"::"Exempt Recovery" then
            ExemptRecovery := true;


        if Rec."Type of Change" = rec."Type of Change"::"Update Account Manager" then
            updateLoanBool := true;

        if Rec."Type of Change" = rec."Type of Change"::"Adjust Deposit Contribution" then
            AdjustDepContrib := true;

        if Rec."Type of Change" = Rec."Type of Change"::Insurance then
            InsuranceBool := true;

        if Rec."Type of Change" = Rec."Type of Change"::"Manage Interest Penalty Insurance" then
            ChargeControlVisible := true;

        if Rec."Type of Change" = Rec."Type of Change"::"Loan Moratorium" then
            MoratoriumBool := true;



        LoanProductVisible := Rec."Type of Change" = Rec."Type of Change"::"Update Product Type";
        // LoanProductVisible := "Type of of Change"="Type of of Change"
        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;
    end;

    local procedure CheckControls()
    begin
        Rec.TestField(Processed, false);

        if Rec."Type of Change" = Rec."type of change"::"Loan Rescheduling" then begin
            Rec."Rescheduling Type" := Rec."Rescheduling Type"::"Update Existing Loan";

            if Rec."Rescheduling Type" = Rec."rescheduling type"::" " then
                Error('Enter Rescheduling Type');

            Rec.TestField("New Installments");
            Rec.TestField("New Repayment");
            //Rec.TestField("Adjusted Repayment");
            Rec.TestField("Rescheduling Date");
        end;

        if Rec."Type of Change" = Rec."Type of Change"::Insurance then begin
            Rec.TestField("Rescheduling Date");
            Rec.TestField("New Insurance Amount");
        end;

        if Rec."Type of Change" = Rec."Type of Change"::"Loan Moratorium" then begin
            Rec.TestField("Loan Moratorium Start Date");
            Rec.TestField("Loan Moratorium End Date");
            Rec.TestField(Remarks);

            if Rec."Loan Moratorium End Date" < Rec."Loan Moratorium Start Date" then
                Error('Moratorium End Date cannot be before Moratorium Start Date.');
        end;

        if Rec."Type of Change" = Rec."Type of Change"::"Update Account Manager" then begin
            Rec.TestField("Account Manager");
            Rec.TestField("New Account Manager");

            if Rec."New Account Manager" = Rec."Account Manager" then
                Error('New Account Manager must be different from the current Account Manager.');
        end;

        /* if Rec."Charge Type" = Rec."Type of Change"::"Adjust Deposit Contribution" then begin
            Rec.TestField("New Deposit Contribution");
        end; */

        if Rec."Type of Change" = Rec."Type of Change"::"Manage Interest Penalty Insurance" then begin
            Rec.TestField("Rescheduling Date");
            Rec.TestField(Remarks);
            if (Rec."Interest Action" = Rec."Interest Action"::"No Change") and
               (Rec."Penalty Action" = Rec."Penalty Action"::"No Change") and
               (Rec."Insurance Action" = Rec."Insurance Action"::"No Change")
            then
                Error('Select Stop or Resume for at least one component.');
            if Rec."Insurance Action" = Rec."Insurance Action"::Resume then
                Rec.TestField("New Insurance Amount");
        end;
    end;
}
