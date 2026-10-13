//namespace CentralDB.CentralDB;

page 50713 "Data Importation Card"
{
    ApplicationArea = All;
    Caption = 'Data Importation Card';
    PageType = Card;
    SourceTable = "Sacco Journal Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Type field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Type field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                }
            }

            part(SaccoJnlLine; "Sacco Journal Line")
            {
                Visible = true;
                SubPageLink = "Batch No." = field("Document No.");
            }

        }

    }

    actions
    {
        area(Reporting)
        {


            action("Generate Loan Refunds")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SActivities: Codeunit "Sacco Activities";
                begin

                    if Confirm('Are you sure you want to generate Loan Refunds?') then begin
                        SActivities.RefundLoanOverpayements(Rec);
                    end;
                end;
            }
        }
        area(processing)
        {


            action("Attachment")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DMSint: Record "DMS Endpoints";
                begin

                    DMSint.RESET;
                    DMSint.SETRANGE(DMSint."Link Type", DMSint."Link Type"::jv);
                    IF DMSint.FIND('-') THEN BEGIN
                        HYPERLINK(DMSint."Path" + Rec."Document No.");
                    END;
                end;
            }

            action("Import Journal")
            {
                ApplicationArea = Basic;
                Caption = 'Import Journal';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    Message('Ensure the document is as follows: ' +
                    '\1. Line No.\' +
                    '\2. Posting Date\' +
                    '\3. Document No.\' +
                    '\4. Account Type\' +
                    '\5. Account No.\' +
                    '\6. Description\' +
                    '\7. Debit Amount\' +
                    '\8. Credit Amount\' +
                    '\9. Transaction Type\' +
                    '\10. Loan No.\' +
                    '\11. External Document No.\' +
                    '\12. Activity Code\' +
                    '\13. Branch Code\' +
                    '\14. Batch No.\' +
                    '\\\[Document Format should be Excel and Should include the Headers]');


                    if Confirm('Are you sure you want to Import Journal?') then begin
                        Rec.ImportJournalLinesFromExcel();
                    end;
                end;
            }

            action("Post Entries")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Approved);

                    if Confirm('Are you sure you want to post these entries') then begin
                        SaccoActivities.DataImportation(Rec."Document No.");
                    end;
                end;
            }

            action("JV Report")
            {
                ApplicationArea = Basic;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SaccoLines: Record "Sacco Journal Line";
                begin

                    SaccoLines.Reset();
                    SaccoLines.SetRange("Batch No.", Rec."Document No.");
                    if SaccoLines.FindFirst() then
                        Report.Run(Report::"Sacco Journal Report", true, false, SaccoLines);
                end;
            }
            action("Import Schedule")
            {
                ApplicationArea = Basic;
                Image = ImportLog;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = xmlport "Loan Schedule";

            }
            action("Update GL Entry")
            {
                ApplicationArea = Basic;
                Image = ImportLog;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = report "GL Entries Transfer";
            }
            action("Loan Security Upload")
            {
                ApplicationArea = Basic;
                Image = ImportLog;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = xmlport "Loan Security Upload";
            }

        }


    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Data Migrations" := true;
    end;

    trigger OnNewRecord(BelowRec: Boolean)
    begin
        Rec."Data Migrations" := true;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if (Rec.Posted) or (Rec.Status <> Rec.Status::Open) then CurrPage.Editable := false;

    end;
}