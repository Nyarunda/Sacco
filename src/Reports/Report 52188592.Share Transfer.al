
Report 50255 "Share Transfer"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = const("Share Capital"), Blocked = filter(" "));
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            var
                DepAmt: Decimal;
                Variance: Decimal;
                TChannel: Enum "Transaction Channel";
            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                if ShareCapitalNos.Get(Vendor."Member No.") then begin
                    ShareCapitalNos."Member Found" := true;

                    Vendor.CalcFields(Balance);

                    DepAmt := 0;
                    DepAcc := '';
                    DepAccount.Reset;
                    DepAccount.SetRange("Member No.", Vendor."Member No.");
                    DepAccount.SetFilter("Balance (LCY)", '>0');
                    DepAccount.SetRange(Blocked, DepAccount.Blocked::" ");
                    DepAccount.SetRange("Product Category", DepAccount."product category"::"Deposit Contribution");
                    if DepAccount.FindFirst then begin
                        DepAccount.CalcFields(Balance);
                        DepAmt := DepAccount.Balance;
                        DepAcc := DepAccount."No.";
                    end;

                    Variance := MinShares - Vendor.Balance;

                    if Variance > DepAmt then
                        Variance := DepAmt;

                    if Variance > 0 then begin

                        ShareCapitalNos."Journal Updated" := true;

                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            'SHARETRANSFER',
                            Today,
                            Acctype::Savings,
                            Vendor."No.",
                            'Share Transfer from Deposits',
                            Acctype::"G/L Account",
                            '',
                            -Variance,
                            DepAccount."No.",
                            '',
                            Transtype::" ",
                            "Global Dimension 1 Code",
                            "Global Dimension 2 Code",
                            true,
                            TChannel::" ",
                            Vendor."Dimension Set ID"
                            );


                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            'SHARETRANSFER',
                            Today,
                            Acctype::Savings,
                            DepAcc,
                            'Share Capital Transfer',
                            Acctype::"G/L Account",
                            '',
                            Variance,
                            DepAccount."No.",
                            '',
                            Transtype::" ",
                            "Global Dimension 1 Code",
                            "Global Dimension 2 Code",
                            true,
                            TChannel::" ",
                            Vendor."Dimension Set ID"
                            );
                    end;
                    ShareCapitalNos.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message('%1\%2', JTemplate, JBatch);
            end;

            trigger OnPreDataItem()
            begin
                ProductSetup.Reset;
                ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Share Capital");
                if ProductSetup.FindFirst then begin
                    MinShares := ProductSetup."Mandatory Contribution";
                end;

                Vendor.SetFilter(Balance, '<%1', MinShares);
                dWindow.Open('Shares Less than' + Format(MinShares) + ':     @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Count;



                JTemplate := '';
                JBatch := '';

                SaccoActivities.GetGeneralJournalTemplate(JTemplate, JBatch);


                SaccoActivities.JournalInit(JTemplate, JBatch);
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
        DepositProduct: Code[10];
        ShareCapProduct: Code[10];
        AsAt: Date;
        ProductFactory: Record "Product Setup";
        MinDeposits: Decimal;
        Found: Boolean;
        Amount: array[5] of Decimal;
        Temp: Record "User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        TransType: Enum "Transaction Type Enum";
        AccType: Enum "Gen. Journal Account Type";
        AccountNo: array[3] of Code[20];
        Description: array[3] of Text;
        membno: Code[50];
        JLine: Record "Gen. Journal Line";
        MinShares: Decimal;
        DepAccount: Record "Savings Accounts";
        ShareCapitalNos: Record "Share Capital Nos";
        DepAcc: Code[20];
}

