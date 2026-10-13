namespace Wanandage.Wanandage;
using System.Automation;
using Microsoft.Finance.Dimension;

page 50670 "Vote Transfer"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Vote Transfer";
    SourceTableView = WHERE(Posted = CONST(false));
    PromotedActionCategories = 'New,Process,Post Loan,Approval Request';

    layout
    {
        area(content)
        {
            group("Budget Transfer")
            {
                Caption = 'Budget Transfer';

                field(No; Rec.No)
                {
                }
                field("USER ID"; Rec."USER ID")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Budget Name"; Rec."Budget Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                group(Source)
                {
                    Caption = 'Source';

                    field("Source Vote"; Rec."Source Vote")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Source Vote Name"; Rec."Source Vote Name")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Source Dimmension 1"; Rec."Source Dimmension 1")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Source Dimension 2"; Rec."Source Dimension 2")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                }
                group(Destination)
                {
                    Caption = 'Destination';

                    field("Destination Vote"; Rec."Destination Vote")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Destination Vote Name"; Rec."Destination Vote Name")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Destination Dimmension 1"; Rec."Destination Dimmension 1")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Destination Dimension 2"; Rec."Destination Dimension 2")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                }

                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF CONFIRM('Do You Really Want To Post The Vote Transfer ?') THEN BEGIN
                        SaccoActivitie.Post_Vote(Rec);
                    END;
                end;
            }
            separator("****************************************************************")
            {
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    //ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    RecRef: RecordRef;
                    DocType: Enum "Approval Document Type";
                    ApprovalTracker: Record "Approval Tracker";
                begin
                    VarVariant := Rec;
                    RecRef.GetTable(VarVariant);
                    DocType := Doctype::"Loan Application";


                    ApprovalTracker.Reset;
                    ApprovalTracker.SetRange("Table ID", RecRef.Number);
                    ApprovalTracker.SetRange("Document No.", Rec.No);
                    ApprovalTracker.SetRange("Custom Document Type", ApprovalTracker."Custom Document Type"::"Vote Transfer");
                    if ApprovalTracker.FindFirst then;
                    //approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                end;
            }
            action("Send A&pproval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DocumentType: Enum "Custom Document Type";
                    CalwideApprovals: Codeunit "Calwide Approvals";
                begin
                    VarVariant := Rec;
                    CalwideApprovals.CreateCustomTracker(VarVariant, Rec.No, 0, Documenttype::"Vote Transfer", Rec."Source Dimmension 1", Rec."Source Dimmension 2", 0);

                end;
            }
            action("Cancel Approval Re&quest")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CalwideApprovals: Codeunit "Calwide Approvals";
                begin
                    Rec.TestField(Status, Rec.Status::Pending);

                    VarVariant := Rec;
                    CalwideApprovals.CancelTracker(VarVariant, Rec.No);
                end;
            }
            separator("************************************************************************************************")
            {
            }
            action(SourceDimensions)
            {
                AccessByPermission = TableData 348 = R;
                ApplicationArea = Suite;
                Caption = 'Source Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                var
                    OldDimSetID: Integer;
                    DimMgt: Codeunit DimensionManagement;
                begin
                    OldDimSetID := Rec."Dimension Set ID";
                    /* "Dimension Set ID" :=
                   DimMgt.EditDimensionSet2(
                       "Dimension Set ID", STRSUBSTNO('%1 %2', 'Vote Tr', No),
                       "Source Dimmension 1", "Source Dimension 2");Rec.*/

                    IF OldDimSetID <> Rec."Dimension Set ID" THEN BEGIN
                        Rec.MODIFY;
                        //  IF PurchLinesExist THEN
                        //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
                    END;

                    CurrPage.SAVERECORD;
                end;
            }
            action(DestDimensions)
            {
                AccessByPermission = TableData 348 = R;
                ApplicationArea = Suite;
                Caption = 'Dest Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                var
                    OldDimSetID: Integer;
                begin
                    OldDimSetID := Rec."Dimension Set ID";
                    /*"Dimmension Set ID1" :=
                      DimMgt.EditDimensionSet2(
                        "Dimmension Set ID1", STRSUBSTNO('%1 %2', 'Vote Tr', No),
                        "Destination Dimmension 1", "Destination Dimension 2");
                    */
                    IF OldDimSetID <> Rec."Dimension Set ID" THEN BEGIN
                        Rec.MODIFY;
                        //  IF PurchLinesExist THEN
                        //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
                    END;

                    CurrPage.SAVERECORD;
                end;
            }
        }
    }

    var
        Text19066037: Label 'Transfer Details';
        Text19004057: Label 'Transfer From Details';
        Text19061585: Label 'Transfer To Details';
        DocumentType: Integer;
        VarVariant: Variant;
        SaccoActivitie: Codeunit "Sacco Activities";

}


