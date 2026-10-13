
Report 50245 "Generate Repayment Schedule"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Approved Amount" = filter(> 0), Installments = filter(> 0));
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            Var
                LSchedule: Record "Loan Repayment Schedule";
                L: Record "Product Setup";
            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                //ProductSetup.GET(Loans."Loan Product Type");
                Loans.Validate("Disbursement Date");

                // if "Annual Interest %" = 0 then begin
                //     L.get("Loan Product Type");
                //     "Annual Interest %" := L."Interest Rate (Max.)";
                //     Loans.Modify();
                // end;

                // Commit();

                SaccoActivities.GenerateRepaymentSchedule(Loans);
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


                // SaccoSetup.Get();
                // Loans.SetFilter("Disbursement Date", '%1..%2', SaccoSetup."Go Live Date", CalcDate('+9999M', SaccoSetup."Go Live Date"));
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
        SaccoSetup: Record "Sacco Setup";
}

