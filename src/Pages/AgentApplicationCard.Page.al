namespace Wanandage.Wanandage;
using System.Automation;
Page 50542 "Agent Application Card"
{
    PageType = Card;
    SourceTable = "Agent Applications";
    SourceTableView = where("Approval Status" = filter(Open | Pending | Rejected));

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
                    Editable = false;
                }
                field(DocumentSerialNo; Rec."Document Serial No")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Accounts List";
                }
                field(CommissionAccount; Rec."Comm Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Commission Account';
                    LookupPageId = "Member Accounts List";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CustomerIDNo; Rec."Customer ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MobileNo; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(InternalAgent; Rec."Internal Agent")
                {
                    ApplicationArea = Basic;
                }
                field(NameoftheProposedAgent; Rec."Name of the Proposed Agent")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofBusiness; Rec."Type of Business")
                {
                    ApplicationArea = Basic;
                }
                field(PlaceofBusiness; Rec."Place of Business")
                {
                    ApplicationArea = Basic;
                }
                field(BusinessWorkExperience; Rec."Business/Work Experience")
                {
                    ApplicationArea = Basic;
                }
                field(NameofBanker; Rec."Name of Banker")
                {
                    ApplicationArea = Basic;
                }
                field(PINKRA; Rec."PIN(KRA)")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawalLimitCode; Rec."Withdrawal Limit Code")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawalLimitAmount; Rec."Withdrawal Limit Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
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
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
            }
            group(DeviceandAuth)
            {
                Caption = 'Device and Auth';
                field(DeviceIMEI; Rec."Device IMEI")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        AgentApplications.Reset;
                        AgentApplications.SetFilter("Agent Code", '<>%1', Rec."Agent Code");
                        AgentApplications.SetRange("Device IMEI", Rec."Device IMEI");
                        if AgentApplications.FindFirst then Error('The Device IMEI Already Exists');
                    end;
                }
                field(DeviceSerialNo; Rec."Device Serial No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        AgentApplications.Reset;
                        AgentApplications.SetFilter("Agent Code", '<>%1', Rec."Agent Code");
                        AgentApplications.SetRange("Device Serial No", Rec."Device Serial No");
                        if AgentApplications.FindFirst then Error('The Device Serial Number Already Exists');
                    end;
                }
                field(SoftwareID; Rec."Software ID")
                {
                    ApplicationArea = Basic;
                }
                field(ProcessorID; Rec."Processor ID")
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
            group(ActionGroup1000000043)
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
                        //ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: variant;
                    begin
                        Rec.TestField("Approval Status", Rec."Approval Status"::Open);
                        EnsureRequiredFieldsHaveValues();
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Agent Code", 0, Documenttype::"Agent Application", '', '', 0);
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
                        //ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: variant;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Member Application","Loan Application";
                    begin
                        Rec.TestField("Approval Status", Rec."Approval Status"::Pending);

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
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        //ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Enum "Approval Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                        VarVariant: variant;
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Loan Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Agent Code");
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then;
                        //approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if (Rec."Approval Status" <> Rec."Approval Status"::Open) and (Rec."Approval Status" <> Rec."Approval Status"::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then
                                exit;
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,Agency,"Agent Code";
        DocMustbePending: label 'Application must be pending approval';
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
        AgentApplications: Record "Agent Applications";
        SavingsAccounts: Record "Savings Accounts";

    local procedure EnsureRequiredFieldsHaveValues()
    begin
        Rec.TestField("Name of the Proposed Agent");
        Rec.TestField(Name);
        Rec.TestField("Place of Business");
        Rec.TestField("Mobile No");
        Rec.TestField("Device IMEI");
        Rec.TestField("Device Serial No");
        //TESTFIELD("Device ID");
    end;
}

