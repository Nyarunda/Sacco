namespace Wanandage.Wanandage;
using System.Automation;

Page 50177 "UW Agent Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Agent List";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(AgentCode; Rec."Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(CustomerIDNo; Rec."Customer ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(MobileNo; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateApproved; Rec."Date Approved")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeApproved; Rec."Time Approved")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApprovedBy; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateRejected; Rec."Date Rejected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeRejected; Rec."Time Rejected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RejectedBy; Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(PlaceofBusiness; Rec."Place of Business")
                {
                    ApplicationArea = Basic;
                }
                field(CommissionsAccount; Rec."Commissions Account")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        //CheckControls;

                        VarVariant := Rec;
                        //CalwideApprovals.CreateCustomTracker(VarVariant,"Agent Code",0,Documenttype::Agents,'','',0);
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
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Member Application","Loan Application";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Agent Code");
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
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Overdraft,Imprest,"Imprest Surrender",Teller,"Mbanking Application",Agents;
                        ApprovalTracker: Record "Approval Tracker";
                        VarVariant: Variant;
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::Agents;


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Agent Code");
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
                action("Agent Report")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange("No.", Rec."Account No.");
                        if Cust.FindFirst then
                            Report.Run(50023, true, false, Cust);
                    end;
                }
            }
        }
    }

    var
        Cust: Record Members;
}
