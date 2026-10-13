
Page 50281 "Security Substitution Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Security Sub.";
    PromotedActionCategories = 'New,Process,Report,Post Changes,Approval Request';

    layout
    {
        area(content)
        {
            group(General)
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateControl;
                        CurrPage.Update(false);
                    end;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
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

            part(Replacements; "Security Sub. Replacements")
            {
                ApplicationArea = Basic;
                Caption = 'Replacement Securities(Incoming)';
                SubPageLink = "Header No." = field("No."),
                              "Loan No." = field("Loan No.");
            }
            part(Control9; "Security Sub. Lines")
            {
                Caption = 'Substituted Securities(Current Securities/Outgoing)';
                ApplicationArea = Basic;
                SubPageLink = "Loan No." = field("Loan No."),
                              "Header No." = field("No.");
            }


        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup22)
            {
                action("Post Changes")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField(Status, Rec.Status::Approved);

                        if Confirm('Are you sure you want to post this change?') then begin
                            PostSecuritySubstitution();
                            SendLoanSMS();

                            CurrPage.Close();
                        end;
                    end;
                }
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
                    PromotedCategory = category5;

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

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Guarantor Sub.", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category5;

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
                    PromotedCategory = Category5;

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
                        DocumentType := Documenttype::"Guarantor Sub.";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
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
        UserSetup: Record "User Setup";
        ProductSetup: Record "Product Setup";
        Members: Record Members;
        MemberActivities: Codeunit "Member Activities";
        Source: Enum "SMS Source Enum";

    local procedure UpdateControl()
    begin
        CurrPage.Editable := Rec.Status <> Rec.Status::Approved;
    end;

    local procedure CheckControls()
    begin
        Rec.Date := Today;
        Rec."Captured By" := UserId;
        Rec.Modify;


        Rec.TestField("Member No.");
        Rec.TestField("Loan No.");

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");

        if Rec."Global Dimension 2 Code" <> UserSetup."Global Dimension 2 Code" then begin
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec.Modify;
        end;

        CalculateGuarantorshipSummary;
        ValidateSubstitutionBeforePosting();

        SendLoanSMS();
    end;


    procedure CalculateGuarantorshipSummary()
    var
        ApprovedAmount: Decimal;
        TotalGuaranteed: Decimal;
        GuarantorshipBalance: Decimal;
        Loans: Record Loans;
        LoanSec: Record "Security Sub. Lines";
        Replacement: Record "Security Sub. Replacement";
    begin
        ApprovedAmount := 0;
        TotalGuaranteed := 0;
        GuarantorshipBalance := 0;

        if Loans.Get(Rec."Loan No.") then begin
            Loans.CalcFields("Outstanding Principal");
            ApprovedAmount := Loans."Outstanding Principal";
        end;

        LoanSec.Reset();
        LoanSec.SetRange("Header No.", Rec."No.");
        LoanSec.SetRange("Loan No.", Rec."Loan No.");
        LoanSec.SetRange(Substituted, false);
        LoanSec.CalcSums("Current Committed");
        TotalGuaranteed += LoanSec."Current Committed";

        Replacement.Reset();
        Replacement.SetRange("Header No.", Rec."No.");
        Replacement.SetRange("Loan No.", Rec."Loan No.");
        Replacement.CalcSums("Replacement Amount");
        TotalGuaranteed += Replacement."Replacement Amount";

        ProductSetup.Get(Loans."Loan Product Type");

        if ProductSetup."Minimum Guarantors" > 0 then begin
            if ProductSetup."Guarantorship Type" = ProductSetup."guarantorship type"::Amount then begin

                GuarantorshipBalance := ApprovedAmount - TotalGuaranteed;
                if GuarantorshipBalance > 0 then
                    Error('Loan Not Fully Guaranteed. \Approved Amt: %1\TotalGuaranteed %2', ApprovedAmount, TotalGuaranteed);
            end;
        end;
    end;


    procedure SendLoanSMS()
    var
        CompInfo: Record "Company Information";
        Loans: Record Loans;
        LoanSec: Record "Security Sub. Lines";
        Replacement: Record "Security Sub. Replacement";
    begin

        CompInfo.Get();
        Loans.Get(Rec."Loan No.");

        Replacement.Reset();
        Replacement.SetRange("Header No.", Rec."No.");
        Replacement.SetRange("Loan No.", Rec."Loan No.");
        if Replacement.FindSet() then begin
            repeat

                if Members.Get(Replacement."Member No.") then begin

                    CompInfo.Get;
                    MemberActivities.SendSms(Source::"Loan Guarantors", Members."Mobile Phone No.", 'Your have guaranteed  ' + Loans."Member Name" + ' ' + Loans."Loan Product Type Name" + ' Loan of ' + Format(Replacement."Replacement Amount") +
                   '. If in dispute call' + ' ' + CompInfo."Phone No.", Rec."Loan No.", Loans."Disbursement Account No", true, false);

                end;
            until Replacement.Next() = 0;
        end;

        LoanSec.Reset;
        LoanSec.SetRange("Header No.", Rec."No.");
        LoanSec.SetRange("Loan No.", Rec."Loan No.");
        LoanSec.SetRange(Substituted, true);
        if LoanSec.FindSet() then begin
            repeat

                if Members.Get(LoanSec."Member No") then begin

                    CompInfo.Get;
                    MemberActivities.SendSms(Source::"Loan Guarantors", Members."Mobile Phone No.", 'Your have been removed from guaranting  ' + Loans."Member Name" + ' ' + Loans."Loan Product Type Name" + ' Loan of ' + Format(LoanSec."Current Committed") +
                   '. If in dispute call' + ' ' + CompInfo."Phone No.", Rec."Loan No.", Loans."Disbursement Account No", true, false);

                end;
            until LoanSec.Next = 0;
        end;
    end;

    local procedure PostSecuritySubstitution()
    var
        OldLines: Record "Security Sub. Lines";
        Replacement: Record "Security Sub. Replacement";
        LoanSecurity: Record "Loan Security";
        TotalOldAmount: Decimal;
        TotalNewAmount: Decimal;
    begin
        Rec.TestField(Posted, false);
        Rec.TestField(Status, Rec.Status::Approved);
        Rec.TestField("Loan No.");

        ValidateSubstitutionBeforePosting();

        OldLines.Reset();
        OldLines.SetRange("Header No.", Rec."No.");
        OldLines.SetRange("Loan No.", Rec."Loan No.");
        OldLines.SetRange(Substituted, true);
        if OldLines.FindSet() then
            repeat
                TotalOldAmount += OldLines."Current Committed";
                LoanSecurity.Reset();
                LoanSecurity.SetRange("Loan No.", Rec."Loan No.");
                LoanSecurity.SetRange("Guarantor Type", OldLines."Guarantor Type");
                LoanSecurity.SetRange("Account No.", OldLines."Account No.");
                if OldLines."Collateral Reg. No." <> '' then
                    LoanSecurity.SetRange("Collateral Reg. No.", OldLines."Collateral Reg. No.");
                if LoanSecurity.FindFirst() then begin
                    //LoanSecurity.Validate("Amount Guaranteed", LoanSecurity."Amount Guaranteed" - OldLines."Current Committed");
                    LoanSecurity."Current Committed" := 0;
                    LoanSecurity.Substituted := true;
                    LoanSecurity.Modify(true);

                end;

            until OldLines.Next() = 0;

        Replacement.Reset();
        Replacement.SetRange("Header No.", Rec."No.");
        Replacement.SetRange("Loan No.", Rec."Loan No.");
        if Replacement.FindSet() then
            repeat
                TotalNewAmount += Replacement."Replacement Amount";

                LoanSecurity.Reset();
                LoanSecurity.SetRange("Loan No.", Rec."Loan No.");
                LoanSecurity.SetRange("Guarantor Type", Replacement."Guarantor Type");
                LoanSecurity.SetRange("Account No.", Replacement."Account No.");
                LoanSecurity.SetRange("Collateral Reg. No.", Replacement."Collateral Reg. No.");
                if LoanSecurity.FindFirst() then begin
                    CopyReplacementAvailabilityToLoanSecurity(LoanSecurity, Replacement);
                    if LoanSecurity.Substituted then
                        SetSubstitutionLoanSecurityAmount(LoanSecurity, Replacement."Replacement Amount")
                    else
                        SetSubstitutionLoanSecurityAmount(LoanSecurity, LoanSecurity."Current Committed" + Replacement."Replacement Amount");
                    LoanSecurity.Substituted := false;
                    LoanSecurity."Substituted Member" := Replacement."Substituted Member";
                    LoanSecurity.Modify(true);
                end else begin
                    LoanSecurity.Init();
                    LoanSecurity."Loan No." := Rec."Loan No.";
                    LoanSecurity."Guarantor Type" := Replacement."Guarantor Type";
                    LoanSecurity.Validate("Account No.", Replacement."Account No.");
                    LoanSecurity.Validate("Collateral Reg. No.", Replacement."Collateral Reg. No.");
                    CopyReplacementAvailabilityToLoanSecurity(LoanSecurity, Replacement);
                    SetSubstitutionLoanSecurityAmount(LoanSecurity, Replacement."Replacement Amount");
                    LoanSecurity.Substituted := false;
                    LoanSecurity."Substituted Member" := Replacement."Substituted Member";
                    LoanSecurity.Insert(true);
                end;

            until Replacement.Next() = 0;

        Rec."Posted By" := UserId;
        Rec.Posted := true;
        Rec.Modify(true);

        Message('Security substitution posted successfully. Old Amount: %1, New Amount: %2', TotalOldAmount, TotalNewAmount);
    end;

    local procedure CopyReplacementAvailabilityToLoanSecurity(var LoanSecurity: Record "Loan Security"; Replacement: Record "Security Sub. Replacement")
    begin
        LoanSecurity."Guarantor Deposits" := Replacement."Guarantor Deposits";
        LoanSecurity."Available Guarantorship" := Replacement."Available Guarantorship";
        LoanSecurity."Application Amount Guaranteed" := Replacement."Application Amount Guaranteed";
        LoanSecurity."Total Guarantor Commitment" := Replacement."Total Guarantor Commitment";
    end;

    local procedure SetSubstitutionLoanSecurityAmount(var LoanSecurity: Record "Loan Security"; NewAmountGuaranteed: Decimal)
    begin
        LoanSecurity."Amount Guaranteed" := NewAmountGuaranteed;
        LoanSecurity."Current Committed" := NewAmountGuaranteed;
    end;

    local procedure ValidateSubstitutionBeforePosting()
    var
        OldLines: Record "Security Sub. Lines";
        OldMemberLines: Record "Security Sub. Lines";
        Replacement: Record "Security Sub. Replacement";
        LoanSecurity: Record "Loan Security";
        Loans: Record Loans;
        ProductSetupLocal: Record "Product Setup";
        OldAmount: Decimal;
        NewAmount: Decimal;
        OutgoingReplacementAmount: Decimal;
        OutgoingMemberOldAmount: Decimal;
        RemainingActiveGuarantors: Integer;
        NewGuarantors: Integer;
        FinalGuarantorCount: Integer;
        OldGuarantorsToSubstitute: Integer;
    begin
        OldLines.Reset();
        OldLines.SetRange("Header No.", Rec."No.");
        OldLines.SetRange("Loan No.", Rec."Loan No.");
        OldLines.SetRange(Substituted, true);

        if not OldLines.FindFirst() then
            Error('Select at least one old guarantor/security to substitute.');

        OldLines.CalcSums("Current Committed");
        OldAmount := OldLines."Current Committed";
        OldGuarantorsToSubstitute := OldLines.Count();

        Replacement.Reset();
        Replacement.SetRange("Header No.", Rec."No.");
        Replacement.SetRange("Loan No.", Rec."Loan No.");

        if not Replacement.FindFirst() then
            Error('Enter at least one replacement security.');

        if Replacement.FindSet() then
            repeat
                Replacement.TestField("Account No.");
                Replacement.TestField("Substituted Member");
                Replacement.TestField("Replacement Amount");

                OldLines.Reset();
                OldLines.SetRange("Header No.", Rec."No.");
                OldLines.SetRange("Loan No.", Rec."Loan No.");
                OldLines.SetRange(Substituted, true);
                OldLines.SetRange("Member No", Replacement."Substituted Member");
                if not OldLines.FindFirst() then
                    Error('Incoming %1 %2 must reference outgoing securities for member %3 already marked as substituted.', Replacement."Guarantor Type", Replacement."Account No.", Replacement."Substituted Member");

                NewAmount += Replacement."Replacement Amount";
                NewGuarantors += 1;
            until Replacement.Next() = 0;

        OldLines.Reset();
        OldLines.SetRange("Header No.", Rec."No.");
        OldLines.SetRange("Loan No.", Rec."Loan No.");
        OldLines.SetRange(Substituted, true);
        if OldLines.FindSet() then
            repeat
                Replacement.Reset();
                Replacement.SetRange("Header No.", Rec."No.");
                Replacement.SetRange("Loan No.", Rec."Loan No.");
                Replacement.SetRange("Substituted Member", OldLines."Member No");
                Replacement.CalcSums("Replacement Amount");
                OutgoingReplacementAmount := Replacement."Replacement Amount";

                OldMemberLines.Reset();
                OldMemberLines.SetRange("Header No.", Rec."No.");
                OldMemberLines.SetRange("Loan No.", Rec."Loan No.");
                OldMemberLines.SetRange(Substituted, true);
                OldMemberLines.SetRange("Member No", OldLines."Member No");
                OldMemberLines.CalcSums("Current Committed");
                OutgoingMemberOldAmount := OldMemberLines."Current Committed";

                if OutgoingReplacementAmount < OutgoingMemberOldAmount then
                    Message(
                        'Replacement security is insufficient for outgoing member.\Loan No.: %1\Outgoing Member No.: %2\Outgoing Name: %3\Old Commitment: %4\Total Replacement Amount: %5',
                        Rec."Loan No.", OldLines."Member No", OldLines.Name, OutgoingMemberOldAmount, OutgoingReplacementAmount);
            until OldLines.Next() = 0;

        if NewAmount < OldAmount then
            Message(
                'Replacement security is insufficient. Old commitment is %1, replacement amount is %2.',
                OldAmount,
                NewAmount);

        if Loans.Get(Rec."Loan No.") then begin
            if ProductSetupLocal.Get(Loans."Loan Product Type") then begin
                LoanSecurity.Reset();
                LoanSecurity.SetRange("Loan No.", Rec."Loan No.");
                LoanSecurity.SetRange(Substituted, false);
                RemainingActiveGuarantors := LoanSecurity.Count();

                FinalGuarantorCount := RemainingActiveGuarantors - OldGuarantorsToSubstitute + NewGuarantors;

                if ProductSetupLocal."Minimum Guarantors" > 0 then
                    if FinalGuarantorCount < ProductSetupLocal."Minimum Guarantors" then
                        Error(
                            'Minimum guarantors not met. Required: %1, Final after substitution: %2.',
                            ProductSetupLocal."Minimum Guarantors",
                            FinalGuarantorCount);
            end;
        end;
    end;

}
