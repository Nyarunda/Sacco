page 50508 "Procurement Setup"
{
    PageType = Card;
    SourceTable = "Procurement Setup";
    Caption = 'Procurement Setup';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the primary key for the setup record.';
                }
                field("Default Store Location"; Rec."Default Store Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default store location.';
                }
            }
            group(Approval)
            {
                Caption = 'Approval Thresholds';
                field("Finance Approval Threshold"; Rec."Finance Approval Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum amount that requires Finance Manager approval (0 to this amount).';
                }
                field("Procurement Committee Threshold"; Rec."Proc Committee Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the threshold for Procurement Committee approval.';
                }
                field("Board Approval Threshold"; Rec."Board Approval Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the threshold for Board approval.';
                }
                field("Enable Approval Workflow"; Rec."Enable Approval Workflow")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if approval workflow is enabled.';
                }
            }
            group(Numbering)
            {
                Caption = 'Number Series';
                field("Store Requisition Nos."; Rec."Store Requisition Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for Store Requisitions.';
                }
                field("External Requisition Nos."; Rec."External Requisition Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for External Requisitions.';
                }
                field("RFQ Nos."; Rec."RFQ Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for RFQs.';
                }
                field("Vendor Quotation Nos."; Rec."VQ Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for Vendor Quotations.';
                }
                field("LPO Nos."; Rec."LPO Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for LPOs.';
                }
                field("GRN Nos."; Rec."GRN Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for Goods Receipt Notes.';
                }
                field("Store Transfer Nos."; Rec."Store Transfer Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for Store Transfers.';
                }
                field("Stock Take Nos."; Rec."Stock Take Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for Stock Take.';
                }
            }
            group(Email)
            {
                Caption = 'Email Templates';
                field("RFQ Email Template"; Rec."RFQ Email Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email template for RFQ distribution.';
                }
                field("Award Letter Template"; Rec."Award Letter Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email template for award letters.';
                }
                field("Regret Letter Template"; Rec."Regret Letter Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email template for regret letters.';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(ScoringCriteriaSetup)
            {
                ApplicationArea = All;
                Caption = 'RFQ Scoring Criteria Setup';
                Image = SetupList;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Maintain dynamic RFQ/RFP scoring criteria, thresholds, and weights.';
                RunObject = page "RFQ Scoring Criteria Setup";
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
