
Report 50149 "Update Deposit Return"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Savings; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = filter("Deposit Contribution"), "Balance (LCY)" = filter(> 0));
            RequestFilterFields = "No.", "Product Type", "Date Filter", "Product Category";
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CurrentRecordNo += 1;
                Savings.CalcFields("Balance (LCY)");

                //IF Savings."Balance (LCY)"<>0 THEN BEGIN
                case Savings."Balance (LCY)" of
                    -999999999999999.0 .. 50000.0:
                        begin

                            if GetType(Savings."Product Type") = 1 then
                                UpdateBuffer(1, Amtrange::"Less 50000", Typeofdep::Non_Withdrawable, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 2 then
                                UpdateBuffer(1, Amtrange::"Less 50000", Typeofdep::Savings, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 3 then
                                UpdateBuffer(1, Amtrange::"Less 50000", Typeofdep::Term, Savings."Balance (LCY)");


                        end;
                    50000.01 .. 100000.0:
                        begin

                            if GetType(Savings."Product Type") = 1 then
                                UpdateBuffer(2, Amtrange::"50001_100000", Typeofdep::Non_Withdrawable, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 2 then
                                UpdateBuffer(2, Amtrange::"50001_100000", Typeofdep::Savings, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 3 then
                                UpdateBuffer(2, Amtrange::"50001_100000", Typeofdep::Term, Savings."Balance (LCY)");

                        end;
                    100000.01 .. 300000.0:
                        begin

                            if GetType(Savings."Product Type") = 1 then
                                UpdateBuffer(3, Amtrange::"100001_300000", Typeofdep::Non_Withdrawable, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 2 then
                                UpdateBuffer(3, Amtrange::"100001_300000", Typeofdep::Savings, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 3 then
                                UpdateBuffer(3, Amtrange::"100001_300000", Typeofdep::Term, Savings."Balance (LCY)");

                        end;
                    300000.01 .. 1000000.0:
                        begin

                            if GetType(Savings."Product Type") = 1 then
                                UpdateBuffer(4, Amtrange::"300001_1000000", Typeofdep::Non_Withdrawable, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 2 then
                                UpdateBuffer(4, Amtrange::"300001_1000000", Typeofdep::Savings, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 3 then
                                UpdateBuffer(4, Amtrange::"300001_1000000", Typeofdep::Term, Savings."Balance (LCY)");

                        end;
                    1000000.01 .. 999999999999999.99:
                        begin

                            if GetType(Savings."Product Type") = 1 then
                                UpdateBuffer(5, Amtrange::"Over 1000000", Typeofdep::Non_Withdrawable, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 2 then
                                UpdateBuffer(5, Amtrange::"Over 1000000", Typeofdep::Savings, Savings."Balance (LCY)");
                            if GetType(Savings."Product Type") = 3 then
                                UpdateBuffer(5, Amtrange::"Over 1000000", Typeofdep::Term, Savings."Balance (LCY)");

                        end;
                end;
                //END;


                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Commit;

                if Confirm('Completed!!! Do you want to Open the Sasra Deposit Return Report?') then begin
                    Report.Run(Report::"Sasra Deposit Return");
                end;
            end;

            trigger OnPreDataItem()
            var
                i: Integer;
                k: Integer;
            begin

                dWindow.Open('Updating Accounts:        @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                SetFilter("Product Type", '<>%1', '');
                NoOfRecords := Savings.Count;

                DepReturn.DeleteAll;
                for i := 1 to 5 do begin

                    for k := 1 to 3 do begin
                        DepReturn.Init;
                        DepReturn."No." := i;

                        if k = 1 then begin
                            DepReturn."Type of Deposit" := DepReturn."type of deposit"::Savings;
                        end;
                        if k = 2 then begin
                            DepReturn."Type of Deposit" := DepReturn."type of deposit"::Non_Withdrawable;
                        end;
                        if k = 3 then begin
                            DepReturn."Type of Deposit" := DepReturn."type of deposit"::Term;
                        end;

                        if i = 1 then begin
                            DepReturn.Range := DepReturn.Range::"Less 50000";
                        end;
                        if i = 2 then begin
                            DepReturn.Range := DepReturn.Range::"50001_100000";
                        end;
                        if i = 3 then begin
                            DepReturn.Range := DepReturn.Range::"100001_300000";
                        end;
                        if i = 4 then begin
                            DepReturn.Range := DepReturn.Range::"300001_1000000";
                        end;
                        if i = 5 then begin
                            DepReturn.Range := DepReturn.Range::"Over 1000000";
                        end;

                        DepReturn.Insert;

                    end;

                end;
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
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        DisbProducts: Record "Savings Accounts";
        Paid: Decimal;
        Expected: Decimal;
        Variance: Decimal;
        Jtemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit,Member;
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal,"Ledger Fee";
        ProductFactory: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        ProdFac: Record "Product Setup";
        Members: Record Members;
        Counter: Integer;
        DepReturn: Record "Deposit Return Buffer";
        AmtRange: Option "Less 50000","50001_100000","100001_300000","300001_1000000","Over 1000000";
        TypeOfDep: Option " ",Non_Withdrawable,Savings,Term;

    local procedure UpdateBuffer(EntryNo: Integer; Range: Option "Less 50000","50001_100000","100001_300000","300001_1000000","Over 1000000"; Type: Option " ",Non_Withdrawable,Savings,Term; Amt: Decimal)
    var
        Buffer: Record "Deposit Return Buffer";
    begin

        Buffer.Reset;
        Buffer.SetRange("No.", EntryNo);
        Buffer.SetRange(Range, Range);
        Buffer.SetRange("Type of Deposit", Type);
        if Buffer.FindFirst then begin
            Buffer."Amount in KES" += Amt;
            Buffer."No. of Accounts" += 1;
            Buffer.Modify;
        end;
    end;

    local procedure GetType(Product: Code[20]): Integer
    begin

        ProductFactory.Get(Product);
        case ProductFactory."Product Category" of
            ProductFactory."product category"::"Deposit Contribution":
                // ProductFactory."product category"::"Micro Group Deposit",
                // ProductFactory."product category"::"Junior Savings",
                // ProductFactory."product category"::Housing,
                // ProductFactory."product category"::"Benevolent Fund",
                // ProductFactory."product category"::"Micro Member Deposit":
                exit(1);
        /*  ProductFactory."product category"::"Fixed Deposit":
             exit(3);

         ProductFactory."product category"::Jipange,
         ProductFactory."product category"::Business:
             //ProductFactory."product category"::"Ordinary Savings":
             exit(2); */
        end;
    end;
}

