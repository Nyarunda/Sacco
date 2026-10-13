Page 50541 "Agent Approved Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Agent Applications";
    SourceTableView = where("Approval Status" = const(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field(AgentCode; Rec."Agent Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DocumentSerialNo; Rec."Document Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(FloatBalance; Rec."Float Balance")
                {
                    ApplicationArea = Basic;
                }
                field(CommisionBalance; Rec."Commision Balance")
                {
                    ApplicationArea = Basic;
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CommissionAccount; Rec."Comm Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Commission Account';
                    Editable = false;
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
                field(Role; Rec.Role)
                {
                    ApplicationArea = Basic;
                }
                field(MobileNo; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
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
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field(DateApproved; Rec."Date Approved")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(TimeApproved; Rec."Time Approved")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(ApprovedBy; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
            }
            group(DeviceandAuth)
            {
                Caption = 'Device and Auth';
                Editable = true;
                field(DeviceIMEI; Rec."Device IMEI")
                {
                    ApplicationArea = Basic;
                }
                field(DeviceSerialNo; Rec."Device Serial No")
                {
                    ApplicationArea = Basic;
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
                Caption = 'Approvals';
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //TESTFIELD("Mobile No");
                        VarVariant := Rec;
                        //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant)
                        //then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                        //ApprovalMgt.ApproveRecordApprovalRequest(Rec.RecordId);
                        //ApprovalMgt.SendAgencyApprRequest(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //ApprovalMgt.CancelAgencyAppr(Rec,TRUE,TRUE);
                        if Rec."Approval Status" <> Rec."approval status"::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
                action("Create/Edit Auth Details")
                {
                    ApplicationArea = Basic;
                    Image = CreateDocument;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD("Software ID");
                        Rec.TestField("Device Serial No");
                        Rec.TestField("Device IMEI");
                        //TESTFIELD("Processor ID");

                        SkyAgencyAuth.Reset;
                        SkyAgencyAuth.SetRange(SkyAgencyAuth."Agent Code", Rec."Agent Code");
                        if SkyAgencyAuth.FindFirst then begin
                            SkyAgencyAuth."Software ID" := Rec."Software ID";
                            SkyAgencyAuth."Device Serial Number" := Rec."Device Serial No";
                            SkyAgencyAuth."Device IMEI" := Rec."Device IMEI";
                            SkyAgencyAuth."Processor ID" := Rec."Processor ID";
                            SkyAgencyAuth.Password := '1234';
                            SkyAgencyAuth."PIN Encrypted" := false;
                            SkyAgencyAuth."Software Activated" := true;
                            SkyAgencyAuth.Modify;
                            Message('Updated Succesfully');
                        end else begin
                            SkyAgencyAuth.Init;
                            SkyAgencyAuth."Agent Code" := Rec."Agent Code";
                            SkyAgencyAuth.Password := '1234';
                            SkyAgencyAuth.Username := Rec."Agent Code";
                            SkyAgencyAuth."Software ID" := Rec."Software ID";
                            SkyAgencyAuth."Device Serial Number" := Rec."Device Serial No";
                            SkyAgencyAuth."Device IMEI" := Rec."Device IMEI";
                            SkyAgencyAuth."Processor ID" := Rec."Processor ID";
                            SkyAgencyAuth."Date Created" := Today;
                            SkyAgencyAuth."Software Activated" := true;
                            SkyAgencyAuth.Insert;
                            Message('Created Succesfully');
                        end;
                    end;
                }
            }
        }
    }

    var
        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,Agency,"Agent Code";
        DocMustbePending: label 'Application must be pending approval';
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
        SkyAgencyAuth: Record "Sky Agency Auth";
}

