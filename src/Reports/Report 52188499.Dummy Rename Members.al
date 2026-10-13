
Report 50162 "Dummy Rename Members"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Member; "Member Images")
        {
            DataItemTableView = sorting("Member No.") order(ascending);
            RequestFilterFields = "Member No.";
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                MNo := Member."Member No.";

                //IF STRLEN(MNo) = 6 THEN
                //Member.RENAME('0'+MNo);
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

                NoOfRecords := Member.Count;

                //Member.SETRANGE("Member No.",'003487');
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
        MNo: Code[10];
}

