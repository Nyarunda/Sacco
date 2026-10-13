
Report 50256 "Dormant Transfer"
{
    // on member accounts data item table view :: WHERE(Product Category=CONST(Ordinary Savings),Blocked=FILTER(' '),Balance=FILTER(>=1,200))

    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Member Status" = const(Dormant));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                TChannel: Enum "Transaction Channel";
            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));


                OrdAccount.Reset;
                OrdAccount.SetRange(OrdAccount."Member No.", Members."No.");
                OrdAccount.SetRange(OrdAccount."Product Category", OrdAccount."product category"::"Ordinary Savings");
                if OrdAccount.Find('-') then begin
                    OrdAccount.Blocked := OrdAccount.Blocked::" ";
                    OrdAccount.Modify;
                    OrdAccount.CalcFields(OrdAccount."Balance (LCY)");
                    BookBal := 500;
                    DepAmt := 50;
                    IncAmt := 0;
                    if OrdAccount."Balance (LCY)" >= 600 then begin
                        if OrdAccount."Balance (LCY)" >= 800 then
                            IncAmt := 250
                        else
                            IncAmt := (OrdAccount."Balance (LCY)" - BookBal - DepAmt);

                        DepAcc := '';
                        DepAccount.Reset;
                        DepAccount.SetRange(DepAccount."Member No.", OrdAccount."Member No.");
                        DepAccount.SetRange(DepAccount."Product Category", DepAccount."product category"::"Deposit Contribution");
                        if DepAccount.FindFirst then begin
                            DepAcc := DepAccount."No.";
                            DepAccount.Blocked := DepAccount.Blocked::" ";
                        end;

                        if DepAmt > 0 then begin
                            SaccoActivities.JournalInsert(
                                  JTemplate,
                                  JBatch,
                                  'ACT/INC',
                                  Today,
                                  Acctype::Savings,
                                  OrdAccount."No.",
                                  'Dormancy Activation',
                                  Acctype::"G/L Account",
                                  '',
                                  DepAmt + IncAmt,
                                  DepAccount."No.",
                                  '',
                                  Transtype::" ",
                                  "Global Dimension 1 Code",
                                  "Global Dimension 2 Code",
                                  true,
                                  TChannel::" ",
                                  UserSetup."Dimension Set ID"
                                  );

                            SaccoActivities.JournalInsert(
                                  JTemplate,
                                  JBatch,
                                  'ACT/INC',
                                  Today,
                                  Acctype::Savings,
                                  DepAcc,
                                  'Share Transfer from Savings',
                                  Acctype::"G/L Account",
                                  '',
                                  -DepAmt,
                                  DepAccount."No.",
                                  '',
                                  Transtype::" ",
                                  "Global Dimension 1 Code",
                                  "Global Dimension 2 Code",
                                  true,
                                    TChannel::" ",
                                    UserSetup."Dimension Set ID"
                                  );

                            SaccoActivities.JournalInsert(
                                  JTemplate,
                                  JBatch,
                                  'ACT/INC',
                                  Today,
                                  Acctype::"G/L Account",
                                  '40017',
                                  'Income Fee',
                                  Acctype::"G/L Account",
                                  '',
                                  -IncAmt,
                                  DepAccount."No.",
                                  '',
                                  Transtype::" ",
                                  "Global Dimension 1 Code",
                                  "Global Dimension 2 Code",
                                  true,
                                  TChannel::" ",
                                  UserSetup."Dimension Set ID"
                                  );
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message('%1\%2', JTemplate, JBatch);
            end;

            trigger OnPreDataItem()
            begin
                dWindow.Open('Dormant Payments:     @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Count;

                UserSetup.Get();
                UserSetup.TestField("Dimension Set ID");

                JTemplate := '';
                JBatch := '';

                SaccoActivities.GetGeneralJournalTemplate(JTemplate, JBatch);


                SaccoActivities.JournalInit(JTemplate, JBatch);

                SaccoSetup.Get;
            end;
        }
        dataitem(Vendor; "Savings Accounts")
        {
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            var
                DepAmt: Decimal;
                Variance: Decimal;
            begin
                // CurrentRecordNo+=1;
                // dWindow.UPDATE(2,CurrentRecordNo);
                // dWindow.UPDATE(3,NoOfRecords);
                // dWindow.UPDATE(1,ROUND(CurrentRecordNo /  NoOfRecords * 10000,1));
                //
                // IF ShareCapitalNos.GET(Vendor."Member No.") THEN BEGIN
                //    ShareCapitalNos."Member Found" := TRUE;
                //
                //    Vendor.CALCFIELDS(Balance);
                //    ActivationFee := 500;
                //    Duty := ROUND(ActivationFee*SaccoSetup."Excise Duty (%)"/100);
                //    DepAmt:=100;
                //
                //
                //    DepAcc:='';
                //    DepAccount.RESET;
                //    DepAccount.SETRANGE("Member No.",Vendor."Member No.");
                //    //DepAccount.SETRANGE(Blocked,DepAccount.Blocked::" ");
                //    DepAccount.SETRANGE("Product Category",DepAccount."Product Category"::"Deposit Contribution");
                //    IF DepAccount.FINDFIRST THEN BEGIN
                //        DepAcc:=DepAccount."No.";
                //    END;
                //
                //    IF DepAmt > 0 THEN BEGIN
                //
                //        ShareCapitalNos."Journal Updated" := TRUE;
                //
                //
                //        SaccoActivities.JournalInsert(
                //            JTemplate,
                //            JBatch,
                //            'TRANSFER',
                //            TODAY,
                //            AccType::Savings,
                //            Vendor."No.",
                //            'Dormancy Activation',
                //            AccType::"G/L Account",
                //            '',
                //            Duty+DepAmt+ActivationFee,
                //            DepAccount."No.",
                //            '',
                //            TransType::" ",
                //            "Global Dimension 1 Code",
                //            "Global Dimension 2 Code",
                //            TRUE
                //            );
                //
                //
                //        SaccoActivities.JournalInsert(
                //            JTemplate,
                //            JBatch,
                //            'TRANSFER',
                //            TODAY,
                //            AccType::Savings,
                //            DepAcc,
                //            'Share Transfer from Savings',
                //            AccType::"G/L Account",
                //            '',
                //            -DepAmt,
                //            DepAccount."No.",
                //            '',
                //            TransType::" ",
                //            "Global Dimension 1 Code",
                //            "Global Dimension 2 Code",
                //            TRUE
                //            );
                //
                //
                //
                //        SaccoActivities.JournalInsert(
                //            JTemplate,
                //            JBatch,
                //            'TRANSFER',
                //            TODAY,
                //            AccType::"G/L Account",
                //            '40017',
                //            'Activation Fee',
                //            AccType::"G/L Account",
                //            '',
                //            -ActivationFee,
                //            DepAccount."No.",
                //            '',
                //            TransType::" ",
                //            "Global Dimension 1 Code",
                //            "Global Dimension 2 Code",
                //            TRUE
                //            );
                //
                //
                //        SaccoActivities.JournalInsert(
                //            JTemplate,
                //            JBatch,
                //            'TRANSFER',
                //            TODAY,
                //            AccType::"G/L Account",
                //            SaccoSetup."Excise Duty GL",
                //            'Excise Duty: Activation Fee',
                //            AccType::"G/L Account",
                //            '',
                //            -Duty,
                //            DepAccount."No.",
                //            '',
                //            TransType::" ",
                //            "Global Dimension 1 Code",
                //            "Global Dimension 2 Code",
                //            TRUE
                //            );
                //
                //
                //
                //    END;
                //    ShareCapitalNos.MODIFY;
                // END;
            end;

            trigger OnPostDataItem()
            begin
                // dWindow.CLOSE;
                // MESSAGE('%1\%2',JTemplate,JBatch);
            end;

            trigger OnPreDataItem()
            begin
                // dWindow.OPEN('Dormant Payments:     @1@@@@@@@@@\'
                //                            +'Counter   #2#########'
                //                            +'Total     #3#########'
                //                            +'Press Esc to abort');
                //
                // NoOfRecords:=COUNT;
                //
                //
                //
                // JTemplate:='';
                // JBatch:= '';
                //
                // SaccoActivities.GetGeneralJournalTemplate(JTemplate,JBatch);
                //
                //
                // SaccoActivities.JournalInit(JTemplate,JBatch);
                //
                // SaccoSetup.GET;
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
        ActivationFee: Decimal;
        Duty: Decimal;
        SaccoSetup: Record "Sacco Setup";
        OrdAccount: Record "Savings Accounts";
        BookBal: Decimal;
        DepAmt: Decimal;
        IncAmt: Decimal;
        UserSetup: Record "User Setup";
}

