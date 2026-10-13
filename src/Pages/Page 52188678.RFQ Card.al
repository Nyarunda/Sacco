
Page 50341 "RFQ Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "RFQ Header";
    PromotedActionCategories = 'New,Process,Report,Request Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = FieldEditable;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(PostingDescription; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field(ExpectedOpeningDate; Rec."Expected Opening Date")
                {
                    ApplicationArea = Basic;
                }
                field("PRF No"; Rec."PRF No")
                {
                    Caption = 'Purchase Requisition No.';
                }
                field(ExpectedClosingDate; Rec."Expected Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field(LocationCode; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Staus; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(InternalRequisitionNo; Rec."Internal Requisition No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Requisition No.';

                }
                field("Evaluation Matrix Type"; Rec."Evaluation Matrix Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this procurement is evaluated using the RFQ or RFP matrix.';
                }
                field("Scoring Document Type"; Rec."Scoring Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the scoring template category used to fetch dynamic criteria lines.';
                }
                field("Budget/Base Amount"; Rec."Budget/Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the benchmark budget used for RFP price scoring.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Email Sent To Vendors"; Rec."Email Sent To Vendors")
                {
                    ApplicationArea = Basic;
                }
                field("Email Sent To Vendors By"; Rec."Email Sent To Vendors By")
                {
                    ApplicationArea = Basic;
                }
                field("Email Sent To Vendors On"; Rec."Email Sent To Vendors On")
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
                 field("Awarded Vendor No."; Rec."Awarded Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the awarded vendor.';
                }
            }
            

            part(Control1; "RFQ Lines")
            {
                Editable = FieldEditable;
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup27)
            {
                action("Get Document Lines")
                {
                    ApplicationArea = Basic;
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        CurrPage.Update(true);
                        InsertRFQLines;
                    end;
                }
                action(SendRFQ)
                {
                    ApplicationArea = All;
                    Caption = 'Send RFQ to Vendors';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Send RFQ to prequalified vendors via email.';
                    trigger OnAction()
                    var
                        RFQQuotationMgt: Codeunit "RFQ & Quotation Management";
                    begin
                        RFQQuotationMgt.SendRFQToVendors(Rec);
                    end;
                }
                action(EvaluateQuotations)
                {
                    ApplicationArea = All;
                    Caption = 'Evaluate Quotations';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Evaluate and rank vendor quotations.';
                    trigger OnAction()
                    var
                        RFQQuotationMgt: Codeunit "RFQ & Quotation Management";
                    begin
                        RFQQuotationMgt.EvaluateQuotations(Rec);
                    end;
                }
                action(BulkImportQuotations)
                {
                    ApplicationArea = All;
                    Caption = 'Bulk Import Quotations';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Import quotations for multiple vendors from one Excel file for this RFQ.';
                    trigger OnAction()
                    var
                        RFQQuotationMgt: Codeunit "RFQ & Quotation Management";
                    begin
                        RFQQuotationMgt.BulkUploadQuotations(Rec);
                    end;
                }
                action(AwardVendor)
                {
                    ApplicationArea = All;
                    Caption = 'Award Vendor';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Award the RFQ to the selected vendor.';
                    trigger OnAction()
                    var
                        RFQQuotationMgt: Codeunit "RFQ & Quotation Management";
                    begin
                        RFQQuotationMgt.AwardVendor(Rec);
                    end;
                }
                action(ScoringCriteriaSetup)
                {
                    ApplicationArea = All;
                    Caption = 'Scoring Criteria Setup';
                    Image = SetupList;
                    ToolTip = 'Open dynamic scoring criteria setup.';
                    RunObject = page "RFQ Scoring Criteria Setup";
                }
                action("Assign Vendor(s)")
                {
                    ApplicationArea = Basic;
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Vends: Record "RFQ Vendors";
                    begin

                        Vends.Reset;
                        Vends.SetRange(Vends."Document Type", Rec."Document Type");
                        Vends.SetRange(Vends."Requisition Document No.", Rec."No.");

                        Page.Run(Page::"RFQ Vendors", Vends);
                    end;
                }
                action("&Email Vendors")
                {
                    ApplicationArea = Basic;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        RFQVend: Record "RFQ Vendors";
                        Vend: Record "Savings Accounts";
                        SaccoActivities: Codeunit "Sacco Activities";
                        EmailsSent: Label 'Email(s) sent successfully!';
                        EmailInvalid: Label 'The email %1 for vendor %2 is invalid, and hence not sent!';
                    begin

                        Rec.TestField("Email Sent To Vendors", false);

                        RFQVend.Reset;
                        RFQVend.SetRange(RFQVend."Document Type", Rec."Document Type");
                        RFQVend.SetRange(RFQVend."Requisition Document No.", Rec."No.");
                        if RFQVend.FindSet() then
                            repeat

                                RFQVend.TestField("Vendor Email");
                                if SaccoActivities.ValidEmailAddress(RFQVend."Vendor Email") then begin

                                    SendEmailToVendor(RFQVend);

                                end else
                                    Message(StrSubstNo(EmailInvalid, RFQVend."Vendor Email", Vend.Name));


                            until RFQVend.Next() = 0;

                        Rec."Email Sent To Vendors" := true;
                        Rec."Email Sent To Vendors By" := UserId;
                        Rec."Email Sent To Vendors On" := CurrentDateTime;
                        Rec.Modify();

                        Message(EmailsSent);

                    end;
                }
                action("Print/Preview")
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        PQH.SetRecfilter;
                        PQH.SetFilter(PQH."Document Type", '%1', Rec."Document Type");
                        PQH.SetFilter("No.", Rec."No.");
                        repvend.SetTableview(PQH);
                        repvend.Run;
                    end;
                }
                action("Create Vendor Quotes")
                {
                    ApplicationArea = Basic;
                    Image = VendorPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        RFQLines: Record "RFQ Line";
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLines: Record "Purchase Line";
                        Vends: Record "RFQ Vendors";
                    begin
                        Vends.SetRange(Vends."Requisition Document No.", Rec."No.");
                        if Vends.FindSet then
                            repeat
                                //create header
                                PurchaseHeader.Init;
                                PurchaseHeader."Document Type" := PurchaseHeader."document type"::Quote;
                                PurchaseHeader.DocApprovalType := PurchaseHeader.Docapprovaltype::Quote;
                                PurchaseHeader."No." := '';
                                PurchaseHeader."Responsibility Center" := Rec."Responsibility Center";
                                PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                PurchaseHeader.Insert(true);
                                PurchaseHeader.Validate("Buy-from Vendor No.", Vends."Account No.");
                                PurchaseHeader."Responsibility Center" := Rec."Responsibility Center";
                                PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                //  PurchaseHeader.validate("RFQ No.","No.");
                                PurchaseHeader.Modify;
                                PurchaseHeader.Insert(true);

                                //create lines

                                RFQLines.SetRange(RFQLines."Document No.", Rec."No.");
                                if RFQLines.FindSet then
                                    repeat
                                        PurchaseLines.Init;
                                        PurchaseLines.TransferFields(RFQLines);
                                        PurchaseLines."Document Type" := PurchaseLines."document type"::Quote;
                                        PurchaseLines."Document No." := Rec."No.";
                                        PurchaseLines.Insert;
                                    /*
                                      ReqLines.VALIDATE(ReqLines."No.");
                                      ReqLines.VALIDATE(ReqLines.Quantity);
                                      ReqLines.VALIDATE(ReqLines."Direct Unit Cost");
                                      ReqLines.MODIFY;
                                    */
                                    until RFQLines.Next = 0;
                            until Vends.Next = 0;

                    end;
                }


            }
            group(Status)
            {
                Caption = 'Status';
                action(Cancel)
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
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

                        RFQVendor: Record "RFQ Vendors";
                        RfqVendReq: Label 'Please specify the RFQ Vendor.';
                    begin

                        if Confirm('Release document?', false) = false then begin exit end;
                        //check if the document has any lines
                        Lines.Reset;
                        Lines.SetRange(Lines."Document Type", Rec."Document Type");
                        Lines.SetRange(Lines."Document No.", Rec."No.");
                        if Lines.FindFirst then begin
                            repeat
                                Lines.TestField(Lines.Quantity);
                            //Lines.TESTFIELD(Lines."Direct Unit Cost");
                            //Lines.TESTFIELD("No.");
                            until Lines.Next = 0;
                        end
                        else begin
                            Error('Document has no lines');
                        end;

                        RFQVendor.Reset();
                        RFQVendor.SetRange("Requisition Document No.", Rec."No.");
                        if not RFQVendor.FindFirst() then
                            Error(RfqVendReq);

                        Rec.Status := Rec.Status::Released;
                        Rec."Released By" := UserId;
                        Rec."Release Date" := Today;
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
                        /*
                        //check if the quotation for request number has already been used
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        //PurchHeader.SETRANGE(purchheader."request for quote no","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Reopen Document?', false) = false then begin exit end;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;

                    end;
                }
            }
        }
    }



    var
        Lines: Record "RFQ Line";
        PQH: Record "RFQ Header";
        FieldEditable: Boolean;
        repvend: Report "RFQ Report";

    trigger OnOpenPage()
    begin
        UpdateControls();
    end;

    procedure InsertRFQLines()
    begin
        /*
        CollectionList.LOOKUPMODE(TRUE);
        IF CollectionList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          CollectionList.SetSelection(Collection);
          Counter := Collection.COUNT;
          IF Counter > 0 THEN BEGIN
            IF Collection.FINDSET THEN
              REPEAT
                Lines.INIT;
                Lines.TRANSFERFIELDS(Collection);
                Lines."Document Type":="Document Type";
                Lines."Document No.":="No.";
                Lines."Line No.":=0;
                Lines."PRF No":=Collection."Document No.";
                Lines."PRF Line No.":=Collection."Line No.";
                Lines.INSERT(TRUE);
                //Collection.Copied:=TRUE;
                //Collection.MODIFY;
             UNTIL Collection.NEXT = 0;
          END;
        END;
        */

    end;

    local procedure UpdateControls()
    begin
        if (Rec.Status = Rec.Status::Released) then begin
            FieldEditable := false;
        end else begin
            FieldEditable := true;
        end;
    end;

    local procedure SendEmailToVendor(RFQVendor: Record "RFQ Vendors")
    var
        Vend: Record "Savings Accounts";
        RFQLn: Record "RFQ Line";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        InStr: InStream;
        OutStr: OutStream;
        RequestForQuotationReport: Report Order;
        FileName: Text;
        Base64: Text;
        BodyMsg: Text;
        AccountStatementTxt: label 'RFQ';
        SalutationTxt: label 'Greetings %1,';
        BodyTxt: label 'Please find attached the quotation to be filled in.';
        RegardsTxt: label 'Kind Regards,';
        DesclaimerTxt: label 'This is a system generated email. please do not respond to this email';
        ProcessTxt: label 'Successfully Processed.';
    begin
        FileName := RFQVendor."Account No." + '-' + 'rfq.xlsx';

        // Find RFQ lines
        RFQLn.Reset();
        RFQLn.SetRange("Document No.", Rec."No.");
        if RFQLn.FindFirst() then begin
            // Generate Excel report in memory
            TempBlob.CreateOutStream(OutStr);
            RequestForQuotationReport.SetTableView(RFQLn);

            if RequestForQuotationReport.SaveAs('', ReportFormat::Pdf, OutStr) then begin
                TempBlob.CreateInStream(InStr);
                Base64 := Base64Convert.ToBase64(InStr);

                // Build email body
                BodyMsg := StrSubstNo(SalutationTxt, RFQVendor."Vendor Name");
                BodyMsg += ('<br><br>');
                BodyMsg += (BodyTxt);
                BodyMsg += ('<br><br>');
                BodyMsg += (RegardsTxt);
                BodyMsg += ('<br>');
                BodyMsg += (CompanyName);
                BodyMsg += ('<br><br>');
                BodyMsg += ('<HR>');
                BodyMsg += (DesclaimerTxt);

                // Send email with attachment
                if RFQVendor."Vendor Email" <> '' then begin
                    EmailMsg.Create(RFQVendor."Vendor Email", AccountStatementTxt, BodyMsg, true);
                    EmailMsg.AddAttachment(FileName, 'xlsx', Base64);
                    Email.Send(EmailMsg);
                    Message(ProcessTxt);
                end else begin
                    Message('Vendor email address is not specified.');
                end;
            end else begin
                Message('Failed to generate Excel report.');
            end;
        end else begin
            Message('No RFQ lines found for document %1.', Rec."No.");
        end;
    end;

}

