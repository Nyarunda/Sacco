
Report 50086 Receipt
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Layouts/Receipt.rdlc';

    dataset
    {
        dataitem("Receipt Header"; "Receipt Header")
        {
            RequestFilterFields = "No.";
            column(payrollandstaffNo; payrollandstaffNo)
            {
            }
            column(No_ReceiptHeader; "Receipt Header"."No.")
            {
            }
            column(Date_ReceiptHeader; "Receipt Header"."Posting Date")
            {
            }
            column(Cashier_ReceiptHeader; "Receipt Header".Cashier)
            {
            }
            column(DatePosted_ReceiptHeader; "Receipt Header"."Date Posted")
            {
            }
            column(TimePosted_ReceiptHeader; "Receipt Header"."Time Posted")
            {
            }
            column(Narration_ReceiptHeader; "Receipt Header".Narration)
            {
            }
            column(OnBehalfOf_ReceiptHeader; "Receipt Header"."On Behalf Of")
            {
            }
            column(AmountRecieved_ReceiptHeader; "Receipt Header"."Amount Recieved")
            {
            }
            column(GlobalDimension1Code_ReceiptHeader; "Receipt Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_ReceiptHeader; "Receipt Header"."Global Dimension 2 Code")
            {
            }
            column(TotalAmount_ReceiptHeader; "Receipt Header"."Total Amount")
            {
            }
            column(PostedBy_ReceiptHeader; "Receipt Header"."Posted By")
            {
            }
            column(MemberNo_ReceiptHeader; "Receipt Header"."Customer No.")
            {
            }
            column(MemberName_ReceiptHeader; "Receipt Header"."Member Name")
            {
            }
            column(PayMode; "Pay Mode")
            {
            }
            column(Cheque_No_; "Cheque No.")
            {
            }
            column(ChequeDepositSlipNo_ReceiptHeader; "Receipt Header"."Cheque/Deposit Slip No")
            {
            }
            column(ChequeDepositSlipDate_ReceiptHeader; "Receipt Header"."Cheque/Deposit Slip Date")
            {
            }
            column(ChequeDepositSlipType_ReceiptHeader; "Receipt Header"."Cheque/Deposit Slip Type")
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(Address_1; CompanyInfo.Address)
            {
            }
            column(Address_2; CompanyInfo."Address 2")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Phone_No2; CompanyInfo."Phone No. 2")
            {
            }
            column(PrintedByText; PrintedByText)
            {
            }
            column(PrintedDateTimeText; PrintedDateTimeText)
            {
            }
            column(Approver1; Approver1)
            {
            }
            column(Approver1DateTimeText; Approver1DateTimeText)
            {
            }
            column(Approver2; Approver2)
            {
            }
            column(Approver2DateTimeText; Approver2DateTimeText)
            {
            }
            dataitem("Document Line"; "Document Line")
            {
                DataItemLink = "Header No." = field("No.");
                column(PrincipleAmt; PrincipleAmt)
                {
                }
                column(InterestAmt; InterestAmt)
                {
                }
                column(ReportForNavId_7160; 7160)
                {
                }
                column(NumberText; NumberText[1])
                {
                }
                column(AccountType_DocumentLine; "Document Line"."Account Type")
                {
                }
                column(AccountNo_DocumentLine; "Document Line"."Account No.")
                {
                }
                column(Description_DocumentLine; "Document Line".Description)
                {
                }
                column(Amount_DocumentLine; "Document Line".Amount)
                {
                }
                column(ShortcutDimension1Code_DocumentLine; "Document Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_DocumentLine; "Document Line"."Shortcut Dimension 2 Code")
                {
                }
                column(TransactionType_DocumentLine; "Document Line"."Transaction Type")
                {
                }
                column(LoanNo_DocumentLine; "Document Line"."Loan No.")
                {
                }
                column(Type_DocumentLine; "Document Line".Type)
                {
                }
                trigger onAfterGetRecord()
                var
                    myInt: Integer;
                begin

                    PrincipleAmt := 0;
                    InterestAmt := 0;
                    CLedger.Reset();
                    CLedger.SetRange("Document No.", "Header No.");
                    CLedger.SetRange("Account No.", "Account No.");
                    CLedger.SetRange("Loan No.", "Loan No.");
                    if CLedger.FindFirst() then begin
                        repeat

                            if CLedger."Transaction Type" = CLedger."Transaction Type"::"Principal Repayment" then
                                PrincipleAmt += CLedger.Amount * -1;
                            if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Paid" then
                                InterestAmt += CLedger.Amount * -1;

                        until CLedger.Next() = 0;
                    end;

                end;

            }

            trigger OnAfterGetRecord()
            begin
                /*
                objLogos.RESET;
                 objLogos.SETRANGE(objLogos.Code,"Receipt Header"."Global Dimension 1 Code");
                IF objLogos.FIND('-') THEN BEGIN
                    objLogos.CALCFIELDS(objLogos.Picture);
                END ELSE BEGIN
                    objLogos.SETRANGE(objLogos.Default,TRUE);
                    objLogos.CALCFIELDS(objLogos.Picture);
                END;
                */
                GenLedgerSetup.Get;

                "Receipt Header".CalcFields("Total Amount");
                PrintedByText := StrSubstNo('Printed By: %1', UserId);
                PrintedDateTimeText := StrSubstNo('Date/Time: %1', Format(CurrentDateTime));
                GetReceiptApprovers("No.");

                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, "Receipt Header"."Total Amount", '');

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        PreparedBy = 'Prepared by :........................................Date :............................. Signature :................................';
        ApprovedBy = 'Approved by :....................................... Date :............................. Signature :.................................';

    }

    local procedure GetReceiptApprovers(DocumentNo: Code[20])
    var
        ApproverCount: Integer;
    begin
        Approver1 := '';
        Approver1DateTimeText := '';
        Approver2 := '';
        Approver2DateTimeText := '';

        ApprovalEntry.Reset();
        ApprovalEntry.SetCurrentKey("Sequence No.");
        ApprovalEntry.SetAscending("Sequence No.", true);
        ApprovalEntry.SetRange("Table ID", Database::"Receipt Header");
        ApprovalEntry.SetRange("Document No.", DocumentNo);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
        if ApprovalEntry.FindSet() then
            repeat
                ApproverCount += 1;
                case ApproverCount of
                    1:
                        begin
                            Approver1 := ApprovalEntry."Approver ID";
                            Approver1DateTimeText := Format(DT2Date(ApprovalEntry."Last Date-Time Modified"));
                        end;
                    2:
                        begin
                            Approver2 := ApprovalEntry."Approver ID";
                            Approver2DateTimeText := Format(DT2Date(ApprovalEntry."Last Date-Time Modified"));
                        end;
                end;

                Approver2 := ApprovalEntry."Approver ID";
                Approver2DateTimeText := Format(DT2Date(ApprovalEntry."Last Date-Time Modified"));
            until ApprovalEntry.Next() = 0;
    end;

    var
        PrincipleAmt: Decimal;
        InterestAmt: Decimal;
        Chq__Slip_No_CaptionLbl: label 'Chq./Slip No.';
        DescriptionCaptionLbl: label 'Description';
        No_CaptionLbl: label 'No.';
        Received_fromCaptionLbl: label 'Received from';
        Currency_CaptionLbl: label 'Currency:';
        VATCaptionLbl: label 'VAT';
        DateCaptionLbl: label 'Date';
        DepartmentCaptionLbl: label 'Department';
        TotalCaptionLbl: label 'Total';
        Signature___________________Lbl: label '..................................';
        Amount_Incl__VATCaptionLbl: label 'Amount Incl. VAT';
        You_were_served_by_CaptionLbl: label 'You were served by:';
        TimeCaptionLbl: label 'Time';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        VAT_Amount_CaptionLbl: label 'VAT Amount:';
        Amount_Excl_VATCaptionLbl: label 'Amount Excl VAT';
        Signature_CaptionLbl: label 'Signature:';
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        NumberText: array[2] of Text;
        TAmount: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        CLedger: Record "Credit Ledger Entry";
        ApprovalEntry: Record "Approval Entry";
        PrintedByText: Text[100];
        PrintedDateTimeText: Text[100];
        Approver1: Text;
        Approver1DateTimeText: Text;
        Approver2: Text;
        Approver2DateTimeText: Text;
}
