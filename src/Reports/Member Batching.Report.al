
Report 50187 "Member Batching"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Members)
        {
            //DataItemTableView = where("Type" = filter(Group|Member));
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()

            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));


                if (MemberCounter = 1) or (NewBatch) then begin
                    Batches.Init();
                    Batches."Batch No." := BatchCounter;
                    Batches."Starting No." := Customer."No.";
                    Batches."Document Type" := DocType;
                    Batches."Created By" := userid;
                    Batches.Insert();
                    NewBatch := false;
                end;
                if (MemberCounter = BatchMembers) or (CurrentRecordNo = NoOfRecords) then begin
                    //Error('%1', BatchCounter);
                    Batches.Reset();
                    Batches.SetRange("Document Type", DocType);
                    Batches.SetRange("Created By", UserId);
                    Batches.SetRange("Batch No.", BatchCounter);
                    if Batches.FindFirst() then begin
                        Batches."Ending No." := Customer."No.";
                        Batches.Modify();
                    end;
                    BatchCounter += 1;
                    MemberCounter := 0;
                    NewBatch := true;

                end;
                MemberCounter += 1;





            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;

                Batches.Reset();
                Batches.SetRange("Document Type", DocType);
                Batches.SetRange("Created By", UserId);
                if Batches.FindFirst() then begin
                    Message('%1 Batches Created', Batches.Count);
                end;
            end;

            trigger OnPreDataItem()
            begin

                dWindow.Open('Generating Batched:     @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Count;
                CurrentRecordNo := 0;

                if BatchMembers = 0 then
                    BatchMembers := 1000;

                BatchCount := Round(NoOfRecords / BatchMembers, 1, '>');

                Batches.Reset();
                Batches.SetRange("Document Type", DocType);
                Batches.SetRange("Created By", userid);
                if Batches.FindFirst() then
                    Batches.DeleteAll();

                NewBatch := true;


                BatchCounter := 1;
                MemberCounter := 1;
            end;
        }
    }


    requestpage
    {

        layout
        {
            area(content)
            {

                field("No. of Entries in a Batch"; BatchMembers)
                {
                    ApplicationArea = Basic;
                }
                field(DocType; DocType)
                {
                    ApplicationArea = Basic;
                }
            }
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
        Batches: Record "Member Batching";
        DocType: Option " ",Dividends;
        BatchCount: Integer;
        BatchMembers: Integer;
        NewBatch: Boolean;

        BatchCounter: Integer;
        MemberCounter: Integer;
}

