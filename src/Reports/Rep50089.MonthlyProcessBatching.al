namespace UnitedWomen_Production.UnitedWomen_Production;

report 50089 "Monthly Process Batching"
{
    Caption = 'Monthly Process Batching';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Monthly Processes Buffer"; "Monthly Processes Buffer")
        {
            DataItemTableView = sorting("Account No") where(Posted = filter(false));

            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()

            begin
                CurrentRecordNo += 1;
                HandleBatching("Monthly Processes Buffer"."Account No");
                dWindow.Update(1, Round(CurrentRecordNo / NoOfRecords * 10000, 1));
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);

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

                if DocType = DocType::" " then
                    DocType := DocType::"Monthly Processes";

                BatchCount := Round(NoOfRecords / BatchMembers, 1, '>');

                Batches.Reset();
                Batches.SetRange("Document Type", DocType);
                Batches.SetRange("Created By", UserId);
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
        DocType: Option " ",Dividends,"Monthly Processes";
        BatchCount: Integer;
        BatchMembers: Integer;
        NewBatch: Boolean;

        BatchCounter: Integer;
        MemberCounter: Integer;

    procedure HandleBatching(AccountNo: Code[20])
    begin
        if (MemberCounter = 1) or (NewBatch) then begin
            Batches.Init();
            Batches."Batch No." := BatchCounter;
            Batches."Starting No." := AccountNo;
            Batches."Document Type" := DocType::"Monthly Processes";
            Batches."Created By" := UserId;
            Batches.Insert();
            NewBatch := false;
        end;

        if (MemberCounter = BatchMembers) or (CurrentRecordNo = NoOfRecords) then begin
            Batches.Reset();
            Batches.SetRange("Document Type", DocType::"Monthly Processes");
            Batches.SetRange("Created By", UserId);
            Batches.SetRange("Batch No.", BatchCounter);
            if Batches.FindFirst() then begin
                Batches."Ending No." := AccountNo;
                Batches.Modify();
            end;
            BatchCounter += 1;
            MemberCounter := 0;
            NewBatch := true;
        end;

        MemberCounter += 1;
    end;
}


