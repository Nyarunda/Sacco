
Page 50343 "RFQ Vendors"
{
    PageType = List;
    SourceTable = "RFQ Vendors";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(VendorNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'The vendor no must not have been created in the vendor table';

                }
                field(VendorName; Rec."Vendor Name")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Email"; Rec."Vendor Email")
                {
                    ApplicationArea = Basic;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(Awarded; Rec.Awarded)
                {
                    ApplicationArea = Basic;
                }
                field("Awarded By"; Rec."Awarded By")
                {
                    ApplicationArea = Basic;
                }
                field("Awarded On"; Rec."Awarded On")
                {
                    ApplicationArea = Basic;
                }
                field("Award Notification Sent"; Rec."Award Notification Sent")
                {
                    ApplicationArea = Basic;
                }
                field("Award Notification Sent By"; Rec."Award Notification Sent By")
                {
                    ApplicationArea = Basic;
                }
                field("Award Notification Sent On"; Rec."Award Notification Sent On")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Quotation in Excel")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    confirmImport: Label 'Are you sure and ready to import the excel file? \ Please import the file with headers.';
                    excelFormat: Label 'The header format is :\ 1. Vendor No.\ 2. Document No.\ 3. Type.\ 4. Description. \ 5. Quantitiy. \ 6. Unit Cost.\7. Amount';
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    Message(excelFormat);
                    if Confirm(confirmImport, false) then begin

                        SaccoActivities.ImportToExcelBuffer(Database::"RFQ Vendors Quotations");
                    end;

                end;
                // RunObject = XMLport "Import Vendor Quotations";
            }
            action(Award)
            {
                ApplicationArea = Basic;
                Image = AgreementQuote;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                begin
                    Rec.AwardTender();
                end;
            }
            action("Send Regret Notification")
            {
                ApplicationArea = Basic;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                begin
                    Rec.RejectTender();
                end;
            }

            action("RFQ Vendor Quotations")
            {
                ApplicationArea = Basic;
                Image = VendorBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Vendor Quotation List";
                RunPageLink = "Quotation No." = field("Requisition Document No.");
            }
        }
    }
}

