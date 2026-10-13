//namespace CentralDB.CentralDB;

page 50668 "Collateral History Card"
{
    ApplicationArea = All;
    Caption = 'Collateral History Card';
    PageType = Card;
    SourceTable = "Collateral Valuation History";
    DeleteAllowed = false;


    PromotedActionCategories = 'RequestApproval,Request Approval';
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

                field("Col. Reg. No."; Rec."Col. Reg. No.")
                {
                    ToolTip = 'Specifies the value of the Col. Reg. No. field.';
                }
                field("Original Charged Value"; Rec."Original Charged Value")
                {
                    ToolTip = 'Specifies the value of the Original Charged Value field.';
                }
                field("Charged Value"; Rec."Charged Value")
                {
                    ToolTip = 'Specifies the value of the Charged Value field.';
                }
                field("Date Charged"; Rec."Date Charged")
                {
                    ToolTip = 'Specifies the value of the Date Charged field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("Valuation Date"; Rec."Valuation Date")
                {
                    ToolTip = 'Specifies the value of the Valuation Date field.';
                }
                field("Original Valuation Value"; Rec."Original Valuation Value")
                {
                    ToolTip = 'Specifies the value of the Original Valuation Value field.';
                }
                field("Valuation Value"; Rec."Valuation Value")
                {
                    ToolTip = 'Specifies the value of the Valuation Value field.';
                }
                field("Valuer Code"; Rec."Valuer Code")
                {
                    ApplicationArea = Basic;
                }
                field(Valuer; Rec.Valuer)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post")
            {
                ApplicationArea = Basic;
                Image = Customer;
                //Enabled = Rec.Posted = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Members: Record Members;
                begin
                    Rec.TestField(Posted, false);
                    Rec.UpdateChanges(Rec);

                    Rec.User := UserId;
                    Rec.Posted := true;
                    Rec."Date Charged" := Today;
                    Rec.Modify();
                end;
            }
        }
        area(Navigation)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    //Caption = 'Approve Document';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        if Confirm('Are you sure you want to Approve this Document?') then begin
                            Rec.TestField(Status, Rec.Status::Open);

                            VarVariant := Rec;
                            CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Valuation History", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                        end;
                    end;

                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

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
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page System.Automation."Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Asset Transfer","Valuation History";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Valuation History";


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
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CheckControls();
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CheckControls();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CheckControls();
    end;

    local procedure CheckControls()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable := false;
    end;

}
