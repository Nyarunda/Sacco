
Report 50160 "Update Bosa Status"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Member Status" = filter(New | Active | Dormant));
            RequestFilterFields = "No.";
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            var
                SavingsAccount: Record "Savings Accounts";
                DF: DateFormula;
            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                MemberActivities.UpdateDormantMembers(Today, Members);

                /*SavingsAccount.Reset();
                SavingsAccount.setfilter("Dormancy Period", '<>%1', DF);
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SetRange(Status, SavingsAccount.Status::Active);
                if SavingsAccount.FindFirst() then begin
                    if "Member Status" <> "Member Status"::Active then begin

                        "Member Status" := "Member Status"::Active;
                        Modify();
                    end;
                end
                else begin

                    SavingsAccount.Reset();
                    SavingsAccount.setfilter("Dormancy Period", '<>%1', DF);
                    SavingsAccount.SetRange("Member No.", Members."No.");
                    SavingsAccount.SetRange(Status, SavingsAccount.Status::Dormant);
                    if SavingsAccount.FindFirst() then begin
                        if "Member Status" <> "Member Status"::Dormant then begin
                            "Member Status" := "Member Status"::Dormant;
                            Modify();
                        end;
                    end;
                end;*/
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
            end;

            trigger OnPreDataItem()
            var
                DF: DateFormula;
            begin

                dWindow.Open('Updating Member Status:    @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');


                //Savings.SetFilter("Dormancy Period", '<>%1', DF);
                NoOfRecords := Members.Count;
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
        MemberActivities: Codeunit "Member Activities";
}

