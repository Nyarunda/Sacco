
Page 50231 "Standing Order Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Standing Order Header";
    PromotedActionCategories = 'New,Process,Report,Stop,Approval Requests';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(SourceAccountType; Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = Savings;
                }
                field(SourceAccountNo; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountNoEtit;
                    LookupPageId = "Member Accounts List";
                }
                field(SourceAccountName; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(IDNumber; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = DescriptionEdit;
                }
                field(AllocatedAmount; Rec."Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field(STOType; Rec."STO Type")
                {
                    ApplicationArea = Basic;
                }
                field("Amount/Percentage"; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = AmountEdit;
                }
                field(TargetAmount; Rec."Target Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AllowPartialDeduction; Rec."Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
                    Editable = AllowPartialEdit;


                    trigger OnValidate()
                    begin
                        NewIncomeType();
                    end;
                }
                field(IncomeType; Rec."Income Type")//TODO - CHAGE OPTIONS 
                {
                    ApplicationArea = Basic;
                    Editable = IncomeTypeEdit;

                }
                field(StandingOrderType; Rec."Standing Order Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        if Rec.Priority <> 0 then begin
                            STO.Reset;
                            STO.SetRange("Source Account No.", Rec."Source Account No.");
                            STO.SetRange(Status, STO.Status::Approved);
                            STO.SetFilter(Priority, '>%1', Rec.Priority);
                            if STO.Find('-') then begin
                                Message('Priority for %1 Standing Order(s) belonging to this member will be pushed one step ahead', STO.Count);
                                if Confirm('Are you sure you want to continue?') then
                                    repeat
                                        STO.Priority += 1;
                                        STO.Modify
                                    until STO.Next = 0;
                            end;
                        end;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        statusControl;
                    end;
                }
                field(EffectiveStartDate; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = EffectiveDateEdit;
                }
                field(FrequencyMonths; Rec."Frequency (Months)")
                {
                    ApplicationArea = Basic;
                    Editable = FrequencyEdit;

                    trigger OnValidate()
                    begin
                        if Rec."Income Type" <> Rec."income type"::Business then
                            Error('Only applicable to Business or Periodic Income Tyes');
                    end;
                }
                field(DurationMonths; Rec."Duration (Months)")
                {
                    ApplicationArea = Basic;
                    Editable = DurationEdit;

                    trigger OnValidate()
                    begin

                        if Rec."Income Type" <> Rec."income type"::Business then
                            Error('Only applicable to Business or Periodic Income Tyes');
                    end;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NextRunDate; Rec."Next Run Date")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control11; "Standing Order Lines")
            {
                SubPageLink = "Document No." = field(Code);
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Stop)
            {
                ApplicationArea = Basic;
                Image = Stop;
                Promoted = true;
                PromotedCategory = category4;

                trigger OnAction()
                var
                    StopConfirm: label 'Are you sure you want to Stop this standing order?';
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if not Confirm(StopConfirm, true) then exit;

                    Rec.Status := Rec.Status::Stopped;
                    Rec.Modify;
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
                    PromotedCategory = category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        STOLines: Record "Standing Order Lines";

                    begin

                        CheckControls;
                        STOLines.Reset();
                        STOLines.SetRange("Document No.", Rec.Code);
                        STOLines.SetRange("Destination Account Type", STOLines."Destination Account Type"::External);
                        if STOLines.FindFirst() then
                            if Rec."Allow Partial Deduction" then
                                Error('You cannot allow partial deductions on External STOs');



                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.Code, 0, Documenttype::STO, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        CalwideApprovals.CancelTracker(VarVariant, Rec.Code);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = category5;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::STO;


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.Code);
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
                            CalwideApprovals.CancelTracker(VarVariant, Rec.Code);
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

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        statusControl;
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        statusControl;
        SetControlAppearance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Source Account Type" := Rec."source account type"::Savings;
    end;

    trigger OnOpenPage()
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        statusControl;
        SetControlAppearance;
    end;

    var
        TransactionTypeEdit: Boolean;
        SourceAccountNoEtit: Boolean;
        DescriptionEdit: Boolean;
        AmountEdit: Boolean;
        AllowPartialEdit: Boolean;
        IncomeTypeEdit: Boolean;
        EffectiveDateEdit: Boolean;
        FrequencyEdit: Boolean;
        DurationEdit: Boolean;
        SOLinesEdit: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        STO: Record "Standing Order Header";
        AmountError: label 'Allocated amount and amount are not the same.';
        StandingOrderLines: Record "Standing Order Lines";


    procedure statusControl()
    begin
        case Rec.Status of
            Rec.Status::Open:
                begin
                    TransactionTypeEdit := true;
                    SourceAccountNoEtit := true;
                    DescriptionEdit := true;
                    AmountEdit := true;
                    AllowPartialEdit := true;
                    IncomeTypeEdit := true;
                    EffectiveDateEdit := true;
                    FrequencyEdit := true;
                    DurationEdit := true;
                    SOLinesEdit := true;
                end;

            Rec.Status::Pending, Rec.Status::Approved, Rec.Status::Rejected, Rec.Status::Stopped:
                begin
                    TransactionTypeEdit := false;
                    SourceAccountNoEtit := false;
                    DescriptionEdit := false;
                    AmountEdit := false;
                    AllowPartialEdit := false;
                    IncomeTypeEdit := false;
                    EffectiveDateEdit := false;
                    FrequencyEdit := false;
                    DurationEdit := false;
                    SOLinesEdit := false;
                end;
        end;
    end;



    procedure NewIncomeType()
    var
        STOTable: Record "Standing Order Header";
        STOPage: Page "Standing Order Card";
        MyEnum: Enum "Repay Mode Enum";
    begin
        STOTable.Reset();
        STOTable.SetFilter("Income Type", '%1|%2', MyEnum::Salary, MyEnum::Business, MyEnum::"Check Off", MyEnum::Dividends, MyEnum::"Internal Standing Order", MyEnum::"External Standing Order", MyEnum::Pension, MyEnum::"Staff Salary");
        STOPage.SetTableView(STOTable);
        STOPage.RunModal();
        //Displays empty list
        Message(STOTable.GetFilter("Income Type"));
        //Returns TestValue1|TestValue3
    end;


    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    procedure CheckControls()
    begin
        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField("Source Account No.");
        Rec.TestField(Amount);
        Rec.TestField("Effective/Start Date");

        if (Rec."Income Type" = Rec."income type"::Business) then begin
            //Rec.TestField("Duration (Months)");
            //Rec.TestField("Frequency (Months)");
        end;

        Rec.CalcFields("Allocated Amount");

        //IF "Next Run Date"<>CALCDATE('-CM',"Next Run Date") THEN
        //ERROR('Next Run Date Must be Begining of the Month');

        if Rec."Allocated Amount" <> Rec.Amount then
            Error(AmountError);

        if Rec."Income Type" = Rec."income type"::" " then
            Error('Specify Income Type');

        StandingOrderLines.Reset;
        StandingOrderLines.SetRange(StandingOrderLines."Document No.", Rec.Code);
        if StandingOrderLines.Find('-') then begin
            repeat
                StandingOrderLines.TestField(StandingOrderLines.Amount);
                if StandingOrderLines."Destination Account Type" <> StandingOrderLines."destination account type"::External then
                    StandingOrderLines.TestField(StandingOrderLines."Destination Account No.");

                case StandingOrderLines."Destination Account Type" of
                    StandingOrderLines."destination account type"::External:
                        begin
                            StandingOrderLines.TestField(StandingOrderLines."Bank Code");
                            /*StandingOrderLines.TESTFIELD(StandingOrderLines."Branch Code");*/
                            //StandingOrderLines.TESTFIELD(StandingOrderLines."Destination Account No.");
                            Rec."Transfered to EFT" := true;
                            Rec.Modify;
                        end;

                    StandingOrderLines."destination account type"::Credit:
                        begin
                            StandingOrderLines.TestField(StandingOrderLines."Loan No.");

                        end;

                end;
            until StandingOrderLines.Next = 0;
        end;

    end;
}

