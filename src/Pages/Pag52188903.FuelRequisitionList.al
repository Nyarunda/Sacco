page 50605 "Fuel Requisition List"
{
    ApplicationArea = All;
    Caption = 'Fuel Requisition List';
    PageType = List;
    CardPageID = "Fuel Requisition Card";
    DeleteAllowed = false;
    Editable = false;
    SourceTable = "Purchase Header";
    UsageCategory = Lists;
    SourceTableView = where("Document Type" = const("Fuel Requisition"),
                            DocApprovalType = const(Requisition),
                            Status = filter(Open | Released | "Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Control34)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BuyfromVendorNo; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(OrderAddressCode; Rec."Order Address Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BuyfromVendorName; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PostingDescription; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field(VendorAuthorizationNo; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AssignedUserID; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.DocApprovalType := Rec.Docapprovaltype::Requisition;
        Rec."Document Type" := Rec."Document Type"::"Purchase Requisition";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Assigned User ID" := UserId;
        UserSetup.Get(UserId);
        Rec.DocApprovalType := Rec.Docapprovaltype::Requisition;
        Rec."Document Type" := Rec."Document Type"::"Fuel Requisition";

        Rec."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        Rec."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

        Rec.Validate("Shortcut Dimension 1 Code");
        Rec.Validate("Shortcut Dimension 2 Code");
    end;

    var
        DocPrint: Codeunit "Document-Print";
        BCSetup: Record "Budget Control Setup";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        UserSetup: Record "User Setup";

}
