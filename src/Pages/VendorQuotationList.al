page 50520 "Vendor Quotation List"
{
    PageType = List;
    SourceTable = "Vendor Quotation Header";
    Caption = 'Vendor Quotation List';
    CardPageId = "Vendor Quotation Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Quotations)
            {
                field("Quotation No."; Rec."Quotation No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quotation number.';
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
                }
                field("RFQ No."; Rec."RFQ No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RFQ number.';
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the submission date.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount.';
                }
                field(Ranking; Rec.Ranking)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ranking.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UploadQuotation)
            {
                ApplicationArea = All;
                Caption = 'Upload Quotation';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Upload quotation from vendor (Excel import).';
                trigger OnAction()
                var
                    RFQQuotationMgt: Codeunit "RFQ & Quotation Management";
                begin
                    RFQQuotationMgt.UploadQuotation(Rec);
                end;
            }
        }
    }
}
