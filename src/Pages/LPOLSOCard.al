page 50504 "LPO/LSO Card"
{
    PageType = Card;
    SourceTable = "LPO/LSO Header";
    Caption = 'LPO/LSO Card';
    PromotedActionCategories = 'New,Process,Report,Request Approval';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("LPO No."; Rec."LPO No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the LPO number.';
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document type.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name.';
                    Editable = false;
                }
                field("LPO Date"; Rec."LPO Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the LPO date.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                    Editable = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount.';
                    Editable = false;
                }
                field("Vendor Quotation No."; Rec."Vendor Quotation No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor quotation number.';
                    visible = false;
                }
                field("RFQ No."; Rec."RFQ No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RFQ number.';

                }
                field("External Requisition No."; Rec."External Requisition No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the external requisition number.';
                    Editable = false;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related purchase order number.';
                    Editable = false;
                }
            }
            part(Lines; "LPO/LSO Lines")
            {
                ApplicationArea = All;
                SubPageLink = "LPO No." = field("LPO No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {


            action(Cancel)
            {
                ApplicationArea = Basic;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin

                    
                    if Confirm('Cancel Document?', false) = false then begin exit end;
                    Rec.Status := Rec.Status::Cancelled;
                    Rec.Modify;

                end;
            }
            action(Stop)
            {
                ApplicationArea = Basic;
                Image = Stop;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin

                    //check if the quotation for request number has already been used
                    /*
                    PurchHeader.RESET;
                    PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                    PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                    IF PurchHeader.FINDFIRST THEN
                      BEGIN
                        ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                      END;
                    */
                    if Confirm('Close Document?', false) = false then begin exit end;
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify;

                end;
            }
            action(Close)
            {
                ApplicationArea = Basic;
                Image = Close;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin

                    //check if the quotation for request number has already been used
                    /*
                    PurchHeader.RESET;
                    PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                    PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                    IF PurchHeader.FINDFIRST THEN
                      BEGIN
                        ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                      END;
                    */
                    if Confirm('Close Document?', false) = false then begin exit end;
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify;

                end;
            }
            action(Release)
            {
                ApplicationArea = Basic;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Category4;



                trigger OnAction()
                var
                    LPOMgt: Codeunit "LPO Management";
                begin
                   // LPOMgt.ReleaseLPO(Rec);
                    Rec.Status := Rec.Status::Approved;
                        
                        Rec.Modify;

                end;


            }
            action(Reopen)
            {
                ApplicationArea = Basic;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin

                    if Confirm('Reopen Document?', false) = false then begin exit end;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;

                end;
            }
            action(CreatePurchaseOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Purchase Order';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create Business Central Purchase Order from LPO.';
                trigger OnAction()
                var
                    LPOMgt: Codeunit "LPO Management";
                begin
                    LPOMgt.CreatePurchaseOrder(Rec);
                end;
            }
            action(SendLPO)
            {
                ApplicationArea = All;
                Caption = 'Send LPO to Vendor';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Send LPO to vendor via email.';
                trigger OnAction()
                var
                    LPOMgt: Codeunit "LPO Management";
                begin
                    LPOMgt.SendLPOToVendor(Rec);
                end;
            }
        }
    }
}
