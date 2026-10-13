Page 50460 "Approval Templates"
{
    ApplicationArea = All;
    Caption = 'Approval Templates';
    PageType = List;
    SourceTable = "Approval Templates";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ApprovalCode; Rec."Approval Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalType; Rec."Approval Type")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentType; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Custom Document Type"; Rec."Custom Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(LimitType; Rec."Limit Type")
                {
                    ApplicationArea = Basic;
                }
                field(AdditionalApprovers; Rec."Additional Approvers")
                {
                    ApplicationArea = Basic;
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = Basic;
                }
                field(TableID; Rec."Table ID")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the sender user this approval template applies to. Leave blank to use the template for all users.';
                }
                field("Branch Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateTemplates)
            {
                ApplicationArea = Basic;
                Caption = 'Create DefaultTemplates';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    approvalTemp: Record "Approval Templates";
                    DocType: Enum "Approval Document Type";
                begin
                    if Confirm('Are you sure you want to create Default Templates?') then begin

                        InsertApprovalTemplate(DocType::"Purchase Requisition");
                        InsertApprovalTemplate(DocType::"Account Transfer");
                        InsertApprovalTemplate(DocType::"Bankers Cheque Application");
                        InsertApprovalTemplate(DocType::CheckOff);
                        InsertApprovalTemplate(DocType::"Cheque Book App");
                        InsertApprovalTemplate(DocType::"Collateral Register");
                        InsertApprovalTemplate(DocType::"Collateral Return");
                        InsertApprovalTemplate(DocType::"Def. Recovery");
                        InsertApprovalTemplate(DocType::FDR);
                        InsertApprovalTemplate(DocType::"Guarantor Sub.");
                        InsertApprovalTemplate(DocType::"HR Job Requisition");
                        InsertApprovalTemplate(DocType::"HR Jobs");
                        InsertApprovalTemplate(DocType::Imprest);
                        InsertApprovalTemplate(DocType::"Imprest Surrender");
                        InsertApprovalTemplate(DocType::Leave);
                        InsertApprovalTemplate(DocType::"Loan Application");
                        InsertApprovalTemplate(DocType::"Loan Batch");
                        InsertApprovalTemplate(DocType::"Loan Changes");
                        InsertApprovalTemplate(DocType::"Mbanking Application");
                        InsertApprovalTemplate(DocType::"Member Application");
                        InsertApprovalTemplate(DocType::"Member Changes");
                        InsertApprovalTemplate(DocType::"Member Exit");
                        InsertApprovalTemplate(DocType::"Member Exit Notice");
                        InsertApprovalTemplate(DocType::"Micro Transaction");
                        InsertApprovalTemplate(DocType::Overdraft);
                        InsertApprovalTemplate(DocType::"Petty Cash");
                        InsertApprovalTemplate(DocType::PV);
                        InsertApprovalTemplate(DocType::"Savings Application");
                        InsertApprovalTemplate(DocType::STO);
                        InsertApprovalTemplate(DocType::Teller);
                        InsertApprovalTemplate(DocType::"Teller Transaction");


                    end;
                end;
            }
            action(AdditionalAppr)
            {
                ApplicationArea = Basic;
                Caption = '&Additional Appr.';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    AddApprovers.Init;
                    AddApprovers.SetRange("Approval Code", Rec."Approval Code");
                    AddApprovers.SetRange("Approval Type", Rec."Approval Type");
                    AddApprovers.SetRange("Document Type", Rec."Document Type");
                    AddApprovers.SetRange("Custom Document Type", Rec."Custom Document Type");
                    AddApprovers.SetRange("Limit Type", Rec."Limit Type");
                    AddApproverForm.SetTableview(AddApprovers);
                    AddApproverForm.Run;
                end;
            }
        }
    }


    procedure InsertApprovalTemplate(DocType: Enum "Approval Document Type")
    var
        approvalTemp: Record "Approval Templates";

    begin
        approvalTemp.Reset();
        approvalTemp.SetRange("Document Type", DocType);
        if not approvalTemp.FindFirst() then begin

            approvalTemp.Init();
            approvalTemp.validate("Approval Code", CopyStr(Format(DocType), 1, 15));
            approvalTemp.Description := Format(DocType) + ' Approval Workflow';
            approvalTemp."Approval Type" := approvalTemp."Approval Type"::Approver;
            approvalTemp."Document Type" := DocType;
            approvalTemp."Limit Type" := approvalTemp."Limit Type"::"No Limits";
            approvalTemp.Enabled := true;
            approvalTemp.Insert();

        end;
    end;

    var
        AddApprovers: Record "Additional Approvers";
        AddApproverForm: Page "Additional Approvers";

    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Administration Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Administration Setups"');
    end;

}
