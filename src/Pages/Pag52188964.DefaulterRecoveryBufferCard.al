
page 50666 "Defaulter Recovery Buffer Card"
{
    ApplicationArea = All;
    Caption = 'Defaulter Recovery Buffer Card';
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Defaulter Loan Recovery";
    PromotedActionCategories = 'New,Request Approval,PostEntries';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.';
                }

                field("Total Deduction Loans"; Rec."Total Deduction Loans")
                {
                    ToolTip = 'Specifies the value of the Total Deduction field.';
                }
                field("Total Deduction Savings"; Rec."Total Deduction Savings")
                {
                    ToolTip = 'Specifies the value of the Total Deduction field.';
                }
                field("Total Count"; Rec."Total Count")
                {
                    ToolTip = 'Specifies the value of the Total Count field.';
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Mamber No. field.';
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    ToolTip = 'Specifies the value of the Source Account field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Recovered; Rec.Recovered)
                {
                    Editable = False;
                    ToolTip = 'Specifies the value of the Recovered field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Loan Product"; Rec."Loan Product")
                {
                }
                field("Skip Loan Category Check"; Rec."Skip Loan Category Check")
                {
                }
                field("Entered By"; Rec."Entered By")
                {
                    ToolTip = 'Specifies the value of the Entered By field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }

            }

            part(defaulterBuffer; "Defaulter Recovery Buffer")
            {
                SubPageLink = "Header No." = field("No.");
            }
        }

    }
    actions
    {
        area(Navigation)
        {
            action(GenerateDefaulterEntries)
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    OptionNumber: Integer;
                    StrText: Text[80];

                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField(Description);
                    Rec.TestField(Recovered, false);

                    if not Rec."Skip Loan Category Check" then begin
                        StrText := ' ,Watch,Substandard,Doubtful,Loss';
                        OptionNumber := STRMENU(StrText, 1);
                    end;

                    if Confirm('Are you sure you want to Generate Defaulter Entries ?') then begin

                        DivPosting.reset();
                        DivPosting.setrange("Header No.", Rec."No.");
                        if DivPosting.findfirst() then DivPosting.DeleteAll();


                        SaccoActivities.DefauterLoanOffset('', OptionNumber - 1, Rec);

                    end;
                end;
            }
            action(GenerateGuarantorEntries)
            {
                ApplicationArea = Basic;
                Image = GeneralLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    OptionNumber: Integer;
                    StrText: Text[80];
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField(Description);
                    Rec.TestField(Recovered, false);

                    StrText := ' ,Watch,Substandard,Doubtful,Loss';
                    if Confirm('Are you sure you want to Generate Guarantor Entries?') then begin

                        DivPosting.reset();
                        DivPosting.setrange("Header No.", Rec."No.");
                        if DivPosting.findfirst() then DivPosting.DeleteAll();

                        OptionNumber := STRMENU(StrText, 1);
                        SaccoActivities.GuarantorLoanOffset('', OptionNumber - 1, Rec);
                    end;
                end;
            }
            action(GenerateMCashLoansDefaulterEntries)
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Recover Mobile Loans";
            }
            action(PostEntries)
            {
                ApplicationArea = Basic;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField(recovered, false);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm('Are you sure you want to Post Entries?') then begin
                        SaccoActivities.PostBufferLines(Rec."No.", FALSE);

                        Rec.Recovered := True;
                        Rec."Posting Date" := Today();
                        Rec.Modify();
                    end;
                end;
            }
            action(JournalEntries)
            {
                ApplicationArea = Basic;
                Image = Translation;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to Transfer To Journal Entries?') then begin
                        SaccoActivities.PostBufferLines(Rec."No.", True);
                    end;
                end;
            }
            action(ReverseUploadedEntries)
            {
                ApplicationArea = Basic;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField(recovered, true);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm('Are you sure you want to Generate Reversal Entries?') then begin
                        SaccoActivities.PostDefRecReversals(Rec."No.");
                    end;
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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        Rec.TestField(Description);
                        Rec.TestField(Status, Rec.Status::Open);
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Def. Recovery", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        ApprovalEntries: Page System.Automation."Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Def. Recovery";

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", ApprovalTracker."Document Type"::"Def. Recovery");
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec.Source := Rec.Source::Buffer;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl;
    end;

    trigger OnAfterGetRecord()
    begin
        //UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        UpdateControl;
    end;

    local procedure UpdateControl()
    begin


        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;

        if Rec.Recovered then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    var
        SaccoActivities: Codeunit "Sacco Activities";
        DivPosting: Record "Defaulter Recovery Buffer";
}
