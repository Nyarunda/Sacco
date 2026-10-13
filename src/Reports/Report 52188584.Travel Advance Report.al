
Report 50247 "Travel Advance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Travel Advance Report.rdlc';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");
            column(ReportForNavId_58; 58)
            {
            }
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
            column(Dim1Code; Dim1Code)
            {
            }
            column(Dim2Code; Dim2Code)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Picture);
                GenLedgerSetup.Get;
                Dim1Code := GenLedgerSetup."Global Dimension 1 Code";
                Dim2Code := GenLedgerSetup."Global Dimension 2 Code";
            end;
        }
        dataitem(StaffAdvanceHeader; "Imprest Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(Purpose; StaffAdvanceHeader.Purpose)
            {
            }
            column(DatePosted_StaffAdvanceHeader; StaffAdvanceHeader."Date Posted")
            {
            }
            column(No_StaffAdvanceHeader; StaffAdvanceHeader."No.")
            {
            }
            column(Date_StaffAdvanceHeader; StaffAdvanceHeader.Date)
            {
            }
            column(CurrencyCode_StaffAdvanceHeader; StaffAdvanceHeader."Currency Code")
            {
            }
            column(Cashier_StaffAdvanceHeader; StaffAdvanceHeader.Cashier)
            {
            }
            column(PayingBankAccount_StaffAdvanceHeader; '')
            {
            }
            column(GlobalDimension1Code_StaffAdvanceHeader; StaffAdvanceHeader."Global Dimension 1 Code")
            {
            }
            column(Status_StaffAdvanceHeader; StaffAdvanceHeader.Status)
            {
            }
            column(PaymentType_StaffAdvanceHeader; StaffAdvanceHeader."Payment Type")
            {
            }
            column(ShortcutDimension2Code_StaffAdvanceHeader; StaffAdvanceHeader."Shortcut Dimension 2 Code")
            {
            }
            column(FunctionName_StaffAdvanceHeader; StaffAdvanceHeader."Function Name")
            {
            }
            column(BudgetCenterName_StaffAdvanceHeader; StaffAdvanceHeader."Budget Center Name")
            {
            }
            column(BankName_StaffAdvanceHeader; StaffAdvanceHeader."Bank Name")
            {
            }
            column(TotalVATAmount_StaffAdvanceHeader; 0)
            {
            }
            column(TotalWitholdingTaxAmount_StaffAdvanceHeader; 0)
            {
            }
            column(TotalNetAmount_StaffAdvanceHeader; StaffAdvanceHeader."Total Net Amount")
            {
            }
            column(PayMode_StaffAdvanceHeader; StaffAdvanceHeader."Pay Mode")
            {
            }
            column(PaymentReleaseDate_StaffAdvanceHeader; StaffAdvanceHeader."Payment Release Date")
            {
            }
            column(NoPrinted_StaffAdvanceHeader; StaffAdvanceHeader."No. Printed")
            {
            }
            column(ResponsibilityCenter_StaffAdvanceHeader; StaffAdvanceHeader."Responsibility Center")
            {
            }
            column(Purpose_StaffAdvanceHeader; StaffAdvanceHeader.Purpose)
            {
            }
            column(Payee_StaffAdvanceHeader; StaffAdvanceHeader.Payee)
            {
            }
            column(ReportLabel; ReportLabel)
            {
            }
            column(ChequeNo_StaffAdvanceHeader; StaffAdvanceHeader."Cheque No.")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(StrCopyText; StrCopyText)
            {
            }
            dataitem(StaffAdvanceLines; "Imprest Lines")
            {
                DataItemLink = No = field("No.");
                //DataItemTableView = sorting("Line No.",No);
                column(ReportForNavId_2; 2)
                {
                }
                column(No_StaffAdvanceLines; StaffAdvanceLines.No)
                {
                }
                column(AccountNo_StaffAdvanceLines; StaffAdvanceLines."Account No:")
                {
                }
                column(AccountName_StaffAdvanceLines; StaffAdvanceLines."Account Name")
                {
                }
                column(Amount_StaffAdvanceLines; StaffAdvanceLines.Amount)
                {
                }
                column(DueDate_StaffAdvanceLines; StaffAdvanceLines."Due Date")
                {
                }
                column(ActualSpent_StaffAdvanceLines; StaffAdvanceLines."Actual Spent")
                {
                }
                column(GlobalDimension1Code_StaffAdvanceLines; StaffAdvanceLines."Global Dimension 1 Code")
                {
                }
                column(Applyto_StaffAdvanceLines; StaffAdvanceLines."Apply to")
                {
                }
                column(ApplytoID_StaffAdvanceLines; StaffAdvanceLines."Apply to ID")
                {
                }
                column(SurrenderDate_StaffAdvanceLines; StaffAdvanceLines."Surrender Date")
                {
                }
                column(Surrendered_StaffAdvanceLines; StaffAdvanceLines.Surrendered)
                {
                }
                column(MRNo_StaffAdvanceLines; StaffAdvanceLines."M.R. No")
                {
                }
                column(DateIssued_StaffAdvanceLines; StaffAdvanceLines."Date Issued")
                {
                }
                column(TypeofSurrender_StaffAdvanceLines; StaffAdvanceLines."Type of Surrender")
                {
                }
                column(DeptVchNo_StaffAdvanceLines; StaffAdvanceLines."Dept. Vch. No.")
                {
                }
                column(CashSurrenderAmt_StaffAdvanceLines; StaffAdvanceLines."Cash Surrender Amt")
                {
                }
                column(BankPettyCash_StaffAdvanceLines; StaffAdvanceLines."Bank/Petty Cash")
                {
                }
                column(SurrenderDocNo_StaffAdvanceLines; StaffAdvanceLines."Surrender Doc No.")
                {
                }
                column(DateTaken_StaffAdvanceLines; StaffAdvanceLines."Date Taken")
                {
                }
                column(Purpose_StaffAdvanceLines; StaffAdvanceLines.Purpose)
                {
                }
                column(ShortcutDimension2Code_StaffAdvanceLines; StaffAdvanceLines."Shortcut Dimension 2 Code")
                {
                }
                column(BudgetaryControlAC_StaffAdvanceLines; StaffAdvanceLines."Budgetary Control A/C")
                {
                }
                column(Committed_StaffAdvanceLines; StaffAdvanceLines.Committed)
                {
                }
                column(AdvanceType_StaffAdvanceLines; StaffAdvanceLines."Advance Type")
                {
                }
                column(CurrencyFactor_StaffAdvanceLines; StaffAdvanceLines."Currency Factor")
                {
                }
                column(CurrencyCode_StaffAdvanceLines; StaffAdvanceLines."Currency Code")
                {
                }
                column(AmountLCY_StaffAdvanceLines; StaffAdvanceLines."Amount LCY")
                {
                }
                column(LineNo_StaffAdvanceLines; StaffAdvanceLines."Line No.")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.") where(Status = const(Approved));
                column(ReportForNavId_60; 60)
                {
                }
                column(DocumentNo_ApprovalEntry; "Approval Entry"."Document No.")
                {
                }
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(Status_ApprovalEntry; "Approval Entry".Status)
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                StrCopyText := '';
                if "No. Printed" >= 1 then begin
                    StrCopyText := 'DUPLICATE';
                end
                else begin
                    StrCopyText := 'ORIGINAL';
                end;

                CalcFields("Total Net Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("Total Net Amount"), "Currency Code");
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
    }

    var
        ReportLabel: label 'Advance Request';
        CompanyInfo: Record "Company Information";
        Dim1Code: Code[10];
        Dim2Code: Code[10];
        GenLedgerSetup: Record "General Ledger Setup";
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        StrCopyText: Text;
}

