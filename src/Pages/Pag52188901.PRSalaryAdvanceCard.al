page 50603 "PR Salary Advance Card"
{
    Caption = 'PR Salary Advance Card';
    PageType = Card;
    SourceTable = "PR Salary Advance";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }

                field(" Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  Application Date field.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                }
                field("Advance Amount Requested"; Rec."Advance Amount Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Advance Amount Requested field.';
                }

                field("Reasons for Advance Amount"; Rec."Reasons for Advance Amount")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Reasons for Advance Amount field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
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
                    begin

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, DocumentType::"Salary Advance", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        DocType: Enum "Custom Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocType::"Salary Advance");
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(status, Rec.status::Approved);
                        if not Confirm('Are you sure you want to re-open document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
            }

            group(PostAdvance)
            {
                action(post)
                {
                    Image = PostDocument;
                    ApplicationArea = Basic;
                    trigger OnAction()
                    var
                        SaccoActivities: Codeunit "Sacco Activities";
                        PRProcessing: codeunit "Payroll Processing";
                        ErrPosted: Label 'The Record %1 is already posted';
                        USetup: Record "User Setup";

                    begin
                        Rec.Testfield(status, Rec.status::Approved);
                        if Rec.Posted = true then Error(ErrPosted, Rec."No.");
                        USetup.get(UserId);
                        if USetup."Post Mid-Month Salary" = true then begin
                            SaccoActivities.PostSalaryAdvance(Rec);

                            UpdateSalaryAdvance();

                        end;

                    end;
                }
            }

        }
    }
    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then CurrPage.Editable := false;
    end;

    var
        CalwideApprovals: Codeunit "Calwide Approvals";


    Procedure UpdateSalaryAdvance()
    var
        PRTrans: Record "Payroll Employee Transactions";
        TCode: Record "Payroll Codes";
        PRPeriod: Record "Payroll Periods";

    begin
        PRPeriod.Reset();
        PRPeriod.SetRange(Closed, false);
        if PRPeriod.FindFirst() then;

        Tcode.Reset();
        Tcode.setrange("Special Transactions", Tcode."Special Transactions"::"Salary Advance");
        if Tcode.FindFirst() then begin
            PRTrans.init;
            PRTrans."Employee Code" := Rec."Staff No.";
            PRTrans."Transaction Type" := PRTrans."Transaction Type"::Deduction;
            PRTrans."Transaction Code" := TCode."Transaction Code";
            PRTrans."Transaction Name" := Tcode."Transaction Name";
            PRTrans."Sub-Ledger Account" := Tcode."Sub-Ledger Account";
            PRTrans."Payroll Period" := PRPeriod."Date Opened";
            PRTrans."Period Month" := PRPeriod."Period Month";
            PRTrans."Period Year" := PRPeriod."Period Year";
            PRTrans.Amount := Rec."Advance Amount Requested";
            PRTrans.Insert(true);

        end;



    end;
}
