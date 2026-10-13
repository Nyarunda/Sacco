page 50502 "Goods Receipt Note Card"
{
    PageType = Card;
    SourceTable = "Goods Receipt Note Header";
    Caption = 'Goods Receipt Note Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("GRN No."; Rec."GRN No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the GRN number.';
                    Editable = false;
                }
                field("LPO No."; Rec."LPO No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the LPO number.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name.';
                    Editable = false;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the receipt date.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                    Editable = false;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who received the goods.';
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who verified the goods.';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the invoice number.';
                }
                field("Delivery Note No."; Rec."Delivery Note No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the delivery note number.';
                }
                field("Purchase Receipt No."; Rec."Purchase Receipt No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase receipt number.';
                    Editable = false;
                }
            }
            part(Lines; "Goods Receipt Note Lines")
            {
                ApplicationArea = All;
                SubPageLink = "GRN No." = field("GRN No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Verify)
            {
                ApplicationArea = All;
                Caption = 'Verify';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Verify the goods receipt.';
                trigger OnAction()
                var
                    GoodsReceiptMgt: Codeunit "Goods Receipt Management";
                begin
                    GoodsReceiptMgt.VerifyGRN(Rec);
                end;
            }
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post the goods receipt note.';
                trigger OnAction()
                var
                    GoodsReceiptMgt: Codeunit "Goods Receipt Management";
                begin
                    GoodsReceiptMgt.PostGRN(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Posted then
            CurrPage.Editable := false;
    end;
}
