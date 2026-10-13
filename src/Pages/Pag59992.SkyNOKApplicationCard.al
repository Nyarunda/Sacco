page 59992 "Sky NOK Application Card"
{
    ApplicationArea = All;
    Caption = 'Sky Next Of Kin Application Card';
    PageType = Card;
    SourceTable = "Sky Next Of Kin Application";
    PromotedActionCategories = 'Approval Requests';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Change Reason"; Rec."Change Reason")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Approval Details")
            {
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejected Date"; Rec."Rejected Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejected Time"; Rec."Rejected Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = All;
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancelled Date"; Rec."Cancelled Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancelled Time"; Rec."Cancelled Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancellation Reason"; Rec."Cancellation Reason")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Sky NOK Application Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Application No." = field("Application No.");
            }
            group("Audit Trail")
            {
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Application Time"; Rec."Application Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Time"; Rec."Modified Time")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        CheckRequiredFields();
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Application No.", 0, DocumentType::"Sky Next Of Kin Application", '', '', 0);
                        CurrPage.Close();
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
                        DocumentType: Enum "Custom Document Type";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Application No.");
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
                        VarVariant: Variant;
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := DocType::"Sky Next Of Kin Application";

                        ApprovalTracker.Reset();
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Application No.");
                        ApprovalTracker.SetRange("Custom Document Type", DocType);
                        if ApprovalTracker.FindFirst() then
                            ApprovalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }

                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        if (Rec.Status <> Rec.Status::Pending) then begin
                            if not Confirm('Are you sure you want to re-open document?') then
                                exit;

                            Rec.Status := Rec.Status::Pending;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }

    local procedure CheckRequiredFields()
    begin
        Rec.TestField("Application No.");
        Rec.TestField("Member No.");

        NOKAppLines.SetRange("Application No.", Rec."Application No.");
        if not NOKAppLines.FindFirst() then
            Error('At least one NOK application line is required before sending for approval.');
    end;

    var
        NOKAppLines: Record "NOK Application Lines";
}
