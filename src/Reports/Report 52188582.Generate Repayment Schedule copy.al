
Report 50451 "Update Repayment Sch. Balances"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Approved Amount" = filter(> 0), "Disbursement Date" = filter(<> ''), Installments = filter(> 0));
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            Var
                LSchedule: Record "Loan Repayment Schedule";
                L: Record "Product Setup";
                CurrBal: Decimal;
            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                CurrBal := Loans."Approved Amount";

                //ProductSetup.GET(Loans."Loan Product Type");
                LSchedule.Reset;
                LSchedule.SetRange(LSchedule."Loan No.", "Loan No.");
                if LSchedule.findfirst then begin

                    repeat
                        CurrBal -= LSchedule."Monthly Principal";
                        LSchedule."Loan Balance" := CurrBal;
                        LSchedule.Modify();
                    until LSchedule.Next() = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
            end;

            trigger OnPreDataItem()
            begin

                dWindow.Open('Generating Schedules:     @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Loans.Count;
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
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        Text001: label 'Document No. Must be equal to No.';
        GeneratesuccMSG: label 'Interest Posted Successfully';
        AlreadyPostedErr: label 'This transaction Has already been posted';
        NoTemplateErr: label 'Ensure the Bills Template is set up in banking setup';
        NoBatchErr: label 'Ensure the Bills Batch is set up in the banking setup';
        SaccoActivities: Codeunit "Sacco Activities";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Updated: Boolean;
        ProductSetup: Record "Product Setup";
}

