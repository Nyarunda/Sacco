
Report 50204 "Payroll Journal Transfer"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where(Status = const(Active));
            RequestFilterFields = "No.", "Period Filter";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                PeriodTrans: Record "Payroll Period Transactions";
                Amt: Decimal;
                StaffDetails: Record "Staff Payroll Details";
                Savings: Record "Savings Accounts";
                RunBal: Decimal;
                DedAmt: Decimal;
            begin

                TransCode.Reset;
                TransCode.SetCurrentkey("Sort Order");
                //TransCode.SETFILTER(Subledger,'<>%1',TransCode.Subledger::" ");
                if TransCode.Find('-') then begin
                    repeat
                        //Message('test');
                        PeriodTrans.Reset;
                        PeriodTrans.SetRange(PeriodTrans."Transaction Code", TransCode."Transaction Code");
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", Employee."No.");
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", PayrollPeriod);
                        if PeriodTrans.Find('-') then begin
                            repeat
                                Amt := 0;

                                SalAcc := PostingGroup."Salary Account";

                                if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                                    Amt := PeriodTrans.Amount;

                                if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                                    Amt := PeriodTrans.Amount * -1;

                                AccType := PeriodTrans."Account Type";
                                AccNo := PeriodTrans."Account No.";
                                TType := PeriodTrans."Sacco Transaction Type";
                                BalAccNo := '';
                                if PeriodTrans."Entry Type" = PeriodTrans."entry type"::Employer then
                                    BalAccNo := TransCode."Employer GL Account"
                                else begin

                                    //IF AccNo = SalAcc THEN
                                    //  SalAcc := '';

                                    //BalAccNo := SalAcc;
                                end;
                                if PeriodTrans.Grouping = PeriodTrans.Grouping::Fringe then
                                    BalAccNo := PostingGroup."Fringe Payable Account";

                                Savings.Reset();
                                Savings.SetRange("Member No.", Employee."Member No");
                                Savings.SetRange("Product Type", TransCode."Sub-Ledger Product Type");
                                Savings.SetRange(Status, Savings.Status::Active);
                                Savings.SetRange("Product Category", Savings."Product Category"::"Junior Savings");
                                if Savings.FindSet() then begin
                                    RunBal := Abs(Amt);
                                    repeat
                                        Savings.TestField("Monthly Contribution");
                                        AccNo := Savings."No.";
                                        DedAmt := Savings."Monthly Contribution";
                                        if DedAmt > RunBal then DedAmt := RunBal;
                                        JournalInsert(AccType, AccNo, PeriodTrans."Transaction Name", -DedAmt, PeriodTrans."Loan No.", TType, BalAccType, BalAccNo);
                                        RunBal -= DedAmt;
                                    until Savings.Next() = 0;
                                end else begin
                                    if TransCode.Subledger = TransCode.Subledger::"G/L Account" then
                                        JournalInsert(AccType, AccNo, Employee."No." + ' - ' + Employee."First Name" + PeriodTrans."Transaction Name", Amt, PeriodTrans."Loan No.", TType, BalAccType, BalAccNo)
                                    else
                                        JournalInsert(AccType, AccNo, PeriodTrans."Transaction Name", Amt, PeriodTrans."Loan No.", TType, BalAccType, BalAccNo);
                                end;


                                if TransCode."Transaction Type" = TransCode."transaction type"::"Net Pay" then begin
                                    //NetJournalInsert(Acctype::"G/L Account", TransCode."GL Account", PeriodName + ' Salary', Amt, LoanNo, TType, Balacctype::"G/L Account", AccNo)
                                    StaffDetails.Get(Employee."No.");

                                    if StaffDetails."Payment Mode" = StaffDetails."Payment Mode"::"Bank Transfer" then begin
                                        PostingGroup.TestField("Salary Paying Account");
                                        SalAcc := PostingGroup."Salary Paying Account";
                                        //NetJournalInsert(Acctype::"Bank Account", SalAcc, PeriodName + ' Salary', Amt, LoanNo, TType, Balacctype::"G/L Account", AccNo)
                                    end else begin
                                        /* if StaffDetails."Payment Mode" = StaffDetails."Payment Mode"::FOSA then begin
                                            MemberAccounts.Reset;
                                            MemberAccounts.SetRange("Member No.", Employee."Member No");
                                            MemberAccounts.SetRange("Product Category", MemberAccounts."product category"::"Ordinary Savings");
                                            if MemberAccounts.FindFirst then
                                                NetJournalInsert(Acctype::Savings, MemberAccounts."No.", PeriodName + ' Salary', Amt, LoanNo, TType, Balacctype::"G/L Account", AccNo)
                                            else
                                                Error('Fosa Account Missing for %1', Employee."No.");
                                        end else
                                            error('Unsupported Payment Mode for %1', Employee."No."); */
                                    end;

                                end;



                            until PeriodTrans.Next = 0;
                        end;

                    until TransCode.Next = 0;
                end;



                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'NITA');
                PeriodTrans.SetRange(PeriodTrans."Employee Code", Employee."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", PayrollPeriod);
                if PeriodTrans.Find('-') then begin

                    if PeriodTrans.Amount > 0 then begin
                        PostingGroup.TestField("NITA Expense Account");
                        PostingGroup.TestField("NITA Payable Account");
                        PayrollRates.TestField("NITA Amount");
                        PayrollRates.TestField("NITA Number");

                        JournalInsert(Acctype::"G/L Account", PostingGroup."NITA Expense Account", Employee."No." + ' - ' + Employee."First Name" + ': ' + PeriodTrans."Transaction Name",
                        PeriodTrans.Amount, '', Ttype::" ", Balacctype::"G/L Account", PostingGroup."NITA Payable Account");

                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                PeriodFilter := Employee.GetFilter("Period Filter");
                if PeriodFilter = '' then Error('You must specify the period filter');

                PayrollPeriod := Employee.GetRangeMin("Period Filter");

                objPeriod.Reset;
                if objPeriod.Get(PayrollPeriod) then
                    PeriodName := objPeriod."Period Name";


                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);


                GeneraljnlLine.Reset;
                GeneraljnlLine.SetRange("Journal Template Name", 'GENERAL');
                GeneraljnlLine.SetRange("Journal Batch Name", 'SALARIES');
                if GeneraljnlLine.Find('-') then
                    GeneraljnlLine.DeleteAll;


                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARIES');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SALARIES';
                    GenJnlBatch.Insert;
                end;




                GeneraljnlLine.Reset;
                GeneraljnlLine.SetRange("Journal Template Name", 'GENERAL');
                GeneraljnlLine.SetRange("Journal Batch Name", 'SAL-NET');
                if GeneraljnlLine.Find('-') then
                    GeneraljnlLine.DeleteAll;


                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'SAL-NET');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SAL-NET';
                    GenJnlBatch.Insert;
                end;




                DocNo := UpperCase(objPeriod."Period Name");


                SalAcc := '';
                PostingGroup.Get('PAYROLL');
                PayrollRates.Get;
                PostingGroup.TestField("Salary Account");
                PostingGroup.TestField("Income Tax Account");


                //BulkInsert;


                MyDialog.Open('Generating Journal');  //**
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Posting Date"; PostingDate)
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

    trigger OnInitReport()
    begin
        RestrictAccess
    end;

    trigger OnPostReport()
    begin
        Message('Completed');
    end;

    var
        LNo: Integer;
        DocNo: Code[20];
        GeneraljnlLine: Record "Gen. Journal Line";
        PostingDate: Date;
        ActivityCode: Code[10];
        BranchCode: Code[10];
        PayrollPeriod: Date;
        TType: Enum "Transaction Type Enum";
        AccType: Enum "Gen. Journal Account Type";
        LoanNo: Code[20];
        BalAccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        BalAccNo: Code[20];
        TransCode: Record "Payroll Codes";
        Usersetup: Record "User Setup";
        PeriodFilter: Text;
        objPeriod: Record "Payroll Periods";
        PeriodName: Text;
        CompanyInfo: Record "Company Information";
        GenJnlBatch: Record "Gen. Journal Batch";
        MyDialog: Dialog;
        SalAcc: Code[20];
        PostingGroup: Record "Payroll Posting Group";
        PayrollRates: Record "Payroll Rates";
        StaffPayrollDetails: Record "Staff Payroll Details";
        MemberAccounts: Record "Savings Accounts";

    local procedure BulkInsert()
    var
        PeriodTrans: Record "Payroll Period Transactions";
        Amt: Decimal;
    begin

        /*
        PeriodTrans.RESET;
        PeriodTrans.SETRANGE(PeriodTrans."Sub Group",PeriodTrans."Sub Group"::BasicPay);
        PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",PayrollPeriod);
        IF PeriodTrans.FIND('-') THEN BEGIN
            PeriodTrans.CALCSUMS(Amount);
        
            Amt:=0;
            IF PeriodTrans."Post As" = PeriodTrans."Post As"::Debit THEN
                Amt:=PeriodTrans.Amount;
        
            IF PeriodTrans."Post As" =PeriodTrans."Post As"::Credit THEN
                Amt:=PeriodTrans.Amount*-1;
        
        
            TType:=ttype::" ";
            AccNo := PeriodTrans."Account No.";
            AccType := PeriodTrans."Account Type";
        
            JournalInsert(AccType,AccNo,PeriodTrans."Transaction Name",Amt,LoanNo,TType,BalAccType,BalAccNo);
        
        END;
        */

        PeriodTrans.Reset;
        PeriodTrans.SetRange(PeriodTrans."Sub Group", PeriodTrans."sub group"::PAYE);
        PeriodTrans.SetRange(PeriodTrans."Payroll Period", PayrollPeriod);
        if PeriodTrans.Find('-') then begin
            PeriodTrans.CalcSums(Amount);

            Amt := 0;
            if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                Amt := PeriodTrans.Amount;

            if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                Amt := PeriodTrans.Amount * -1;

            TType := Ttype::" ";
            AccNo := PeriodTrans."Account No.";
            AccType := PeriodTrans."Account Type";

            JournalInsert(AccType, AccNo, PeriodTrans."Transaction Name", Amt, LoanNo, TType, BalAccType, BalAccNo);

        end;



        TransCode.Reset;
        TransCode.SetFilter(Subledger, '%1', TransCode.Subledger::"G/L Account");
        TransCode.SetFilter("GL Account", '<>%1', '');
        if TransCode.Find('-') then begin
            repeat
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", TransCode."Transaction Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", PayrollPeriod);
                PeriodTrans.SetRange(PeriodTrans."Entry Type", PeriodTrans."entry type"::Employee);
                if PeriodTrans.Find('-') then begin

                    PeriodTrans.CalcSums(Amount);
                    Amt := 0;

                    if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                        Amt := PeriodTrans.Amount;

                    if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                        Amt := PeriodTrans.Amount * -1;


                    TType := Ttype::" ";
                    AccNo := PeriodTrans."Account No.";
                    AccType := PeriodTrans."Account Type";

                    JournalInsert(AccType, AccNo, PeriodTrans."Transaction Name", Amt, LoanNo, TType, BalAccType, BalAccNo);

                end;


            until TransCode.Next = 0;
        end;

    end;


    procedure JournalInsert(AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20]; Description: Text[150]; Amt: Decimal; LoanNo: Code[20]; TransType: Enum "Transaction Type Enum"; BalAccountType: Enum "Gen. Journal Account Type"; BalAccountNo: Code[20])
    var
        Loans: Record Loans;
        LoanType: Record "Product Setup";
    begin

        Description := CopyStr(Description, 1, 50);
        ActivityCode := '';
        BranchCode := '';

        Usersetup.Reset;
        Usersetup.SetRange(Usersetup."User ID", UserId);
        if Usersetup.Find('-') then begin
            ActivityCode := Usersetup."Global Dimension 1 Code";
            BranchCode := Usersetup."Global Dimension 2 Code";
        end;


        if Amt <> 0 then begin

            LNo := LNo + 100;
            GeneraljnlLine.Init;
            GeneraljnlLine."Journal Template Name" := 'GENERAL';
            GeneraljnlLine."Journal Batch Name" := 'SALARIES';
            GeneraljnlLine."Line No." := LNo;
            GeneraljnlLine."Document No." := DocNo;
            GeneraljnlLine."Loan No." := LoanNo;
            GeneraljnlLine."Transaction Type" := TransType;
            GeneraljnlLine."Posting Date" := PostingDate;
            GeneraljnlLine."Account Type" := AccountType;
            GeneraljnlLine."Account No." := AccountNo;
            GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
            GeneraljnlLine.Description := Description;
            GeneraljnlLine.Validate(Amount, Amt);
            GeneraljnlLine."Bal. Account Type" := BalAccountType;
            GeneraljnlLine."Bal. Account No." := BalAccountNo;
            GeneraljnlLine.Validate(GeneraljnlLine."Bal. Account No.");

            GeneraljnlLine."Shortcut Dimension 1 Code" := ActivityCode;
            GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
            GeneraljnlLine."Shortcut Dimension 2 Code" := BranchCode;
            GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");

            if GeneraljnlLine.Amount <> 0 then
                GeneraljnlLine.Insert;




            if (TransType = Transtype::"Interest Paid") then begin
                if TransCode."Post Loan Interest Due" then begin

                    LNo := LNo + 100;
                    GeneraljnlLine.Init;
                    GeneraljnlLine."Journal Template Name" := 'GENERAL';
                    GeneraljnlLine."Journal Batch Name" := 'SALARIES';
                    GeneraljnlLine."Line No." := LNo;
                    GeneraljnlLine."Document No." := DocNo;
                    GeneraljnlLine."Loan No." := LoanNo;
                    GeneraljnlLine."Transaction Type" := Transtype::"Interest Due";
                    GeneraljnlLine."Posting Date" := PostingDate;
                    GeneraljnlLine."Account Type" := AccountType;

                    Loans.Get(LoanNo);
                    LoanType.Get(Loans."Loan Product Type");
                    BalAccountNo := LoanType."Loan Interest Income [G/L]";

                    GeneraljnlLine."Account No." := AccountNo;
                    GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
                    GeneraljnlLine.Description := Description;
                    GeneraljnlLine.Validate(Amount, Amt * -1);
                    GeneraljnlLine."Bal. Account Type" := Balaccounttype::"G/L Account";
                    GeneraljnlLine."Bal. Account No." := BalAccountNo;
                    GeneraljnlLine.Validate(GeneraljnlLine."Bal. Account No.");

                    GeneraljnlLine."Shortcut Dimension 1 Code" := ActivityCode;
                    GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
                    GeneraljnlLine."Shortcut Dimension 2 Code" := BranchCode;
                    GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");

                    if GeneraljnlLine.Amount <> 0 then
                        GeneraljnlLine.Insert;


                end;
            end;
        end;
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Payroll"');
    end;


    procedure NetJournalInsert(AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20]; Description: Text[150]; Amt: Decimal; LoanNo: Code[20]; TransType: Enum "Transaction Type Enum"; BalAccountType: Enum "Gen. Journal Account Type"; BalAccountNo: Code[20])
    var
        Loans: Record Loans;
        LoanType: Record "Product Setup";
    begin

        Description := CopyStr(Description, 1, 50);
        ActivityCode := '';
        BranchCode := '';

        Usersetup.Reset;
        Usersetup.SetRange(Usersetup."User ID", UserId);
        if Usersetup.Find('-') then begin
            ActivityCode := Usersetup."Global Dimension 1 Code";
            BranchCode := Usersetup."Global Dimension 2 Code";
        end;


        if Amt <> 0 then begin

            LNo := LNo + 100;
            GeneraljnlLine.Init;
            GeneraljnlLine."Journal Template Name" := 'GENERAL';
            GeneraljnlLine."Journal Batch Name" := 'SAL-NET';
            GeneraljnlLine."Line No." := LNo;
            GeneraljnlLine."Document No." := DocNo;
            GeneraljnlLine."Loan No." := LoanNo;
            GeneraljnlLine."Transaction Type" := TransType;
            GeneraljnlLine."Posting Date" := PostingDate;
            GeneraljnlLine."Account Type" := AccountType;
            GeneraljnlLine."Account No." := AccountNo;
            GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
            GeneraljnlLine.Description := Description;
            GeneraljnlLine.Validate(Amount, Amt);
            GeneraljnlLine."Bal. Account Type" := BalAccountType;
            GeneraljnlLine."Bal. Account No." := BalAccountNo;
            GeneraljnlLine.Validate(GeneraljnlLine."Bal. Account No.");
            GeneraljnlLine."Shortcut Dimension 1 Code" := ActivityCode;
            GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
            GeneraljnlLine."Shortcut Dimension 2 Code" := BranchCode;
            GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");
            if GeneraljnlLine.Amount <> 0 then
                GeneraljnlLine.Insert;

            if (TransType = Transtype::"Interest Paid") then begin
                if TransCode."Post Loan Interest Due" then begin

                    LNo := LNo + 100;
                    GeneraljnlLine.Init;
                    GeneraljnlLine."Journal Template Name" := 'GENERAL';
                    GeneraljnlLine."Journal Batch Name" := 'SAL-NET';
                    GeneraljnlLine."Line No." := LNo;
                    GeneraljnlLine."Document No." := DocNo;
                    GeneraljnlLine."Loan No." := LoanNo;
                    GeneraljnlLine."Transaction Type" := Transtype::"Interest Due";
                    GeneraljnlLine."Posting Date" := PostingDate;
                    GeneraljnlLine."Account Type" := AccountType;

                    Loans.Get(LoanNo);
                    LoanType.Get(Loans."Loan Product Type");
                    BalAccountNo := LoanType."Loan Interest Income [G/L]";

                    GeneraljnlLine."Account No." := AccountNo;
                    GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
                    GeneraljnlLine.Description := Description;
                    GeneraljnlLine.Validate(Amount, Amt * -1);
                    GeneraljnlLine."Bal. Account Type" := Balaccounttype::"G/L Account";
                    GeneraljnlLine."Bal. Account No." := BalAccountNo;
                    GeneraljnlLine.Validate(GeneraljnlLine."Bal. Account No.");

                    GeneraljnlLine."Shortcut Dimension 1 Code" := ActivityCode;
                    GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
                    GeneraljnlLine."Shortcut Dimension 2 Code" := BranchCode;
                    GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");

                    if GeneraljnlLine.Amount <> 0 then
                        GeneraljnlLine.Insert;

                end;
            end;
        end;
    end;
}

