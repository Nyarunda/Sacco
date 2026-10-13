//namespace CentralDB.CentralDB;

page 50731 "Loan Security Changes Card"
{
    ApplicationArea = All;
    Caption = 'Loan Security Changes Card';
    PageType = Card;
    DeleteAllowed = false;
    PromotedActionCategories = 'Request Approval';
    SourceTable = "Loan Security Change";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.', Comment = '%';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.', Comment = '%';
                }
                field("Outstanding  Interest"; Rec."Outstanding Interest")
                {
                    ToolTip = 'Specifies the value of the Outstanding Interest field.', Comment = '%';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ToolTip = 'Specifies the value of the Outstanding Balance field.', Comment = '%';
                }
                field(Effected; Rec.Effected)
                {
                    ToolTip = 'Specifies the value of the Effected field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }


            }

            part(c; "Loan Changes Lines")
            {
                SubPageLink = "Loan No" = field("Loan No");
            }

        }
    }
    actions
    {
        area(Reporting)
        {
            action(PostChanges)
            {
                ApplicationArea = All;
                Caption = 'PostChanges', comment = 'NLB="YourLanguageCaption"';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SecurityChangesLine: Record "Loan Security Lines Changes";
                    Security: Record "Loan Security";
                begin

                    Rec.TestField(Effected, false);
                    REc.TestField(Status, Rec.Status::Approved);

                    SecurityChangesLine.Reset();
                    SecurityChangesLine.SetRange("Loan No", Rec."Loan No");
                    SecurityChangesLine.SetRange(Subtituted, true);
                    SecurityChangesLine.SetFilter("New Commited Amount", '=0');
                    if SecurityChangesLine.FindSet then
                        repeat
                            Security.Reset();
                            Security.SetRange("Loan No.", SecurityChangesLine."Loan No");
                            Security.SetRange("Account No.", SecurityChangesLine."Security Account");
                            if Security.FindFirst() then begin
                                Security.Substituted := SecurityChangesLine.Subtituted;
                                Security.Modify();
                            end;
                        until SecurityChangesLine.Next() = 0;

                    SecurityChangesLine.Reset();
                    SecurityChangesLine.SetRange("Loan No", Rec."Loan No");
                    SecurityChangesLine.SetFilter("New Commited Amount", '>0');
                    if SecurityChangesLine.FindSet then
                        repeat
                            Security.Reset();
                            Security.SetRange("Loan No.", SecurityChangesLine."Loan No");
                            Security.SetRange("Account No.", SecurityChangesLine."Security Account");
                            if Security.FindFirst() then begin
                                Security."Current Committed" := SecurityChangesLine."New Commited Amount";
                                //Security."Amount Guaranteed" := SecurityChangesLine."New Commited Amount";
                                Security."Total Committed" := SecurityChangesLine."New Commited Amount";
                                Security.Modify();
                            end;
                        until SecurityChangesLine.Next() = 0;

                    Rec.Effected := true;
                    Rec.Modify();

                    Message('Effected');
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
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.No, 0, Documenttype::"Security Changes", '', '', 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: variant;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Member Application","Loan Application";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.No);
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
                        DocType: Enum "Custom Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                        VarVariant: variant;
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Security Changes";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.No);
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
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
        if Rec.Effected then
            CurrPage.Editable := false;
    end;
}
