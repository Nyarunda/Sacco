
Report 50084 "Process Standing Order"
{
    ProcessingOnly = true;
    UsageCategory = Lists;

    dataset
    {
        dataitem(StandingOrderHeader; "Standing Order Header")
        {
            DataItemTableView = sorting("Source Account No.", Priority) order(ascending) where("Source Account Name" = filter(<> ''), Status = const(Approved), "Income Type" = filter(Business));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecordCounter += 1;
                dWindow.Update(1, StandingOrderHeader.Code);
                dWindow.Update(3, RecordCounter);
                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));


                AvailableBal := 0;
                RunBal := 0;
                AmountDedu := 0;
                if StandingOrderHeader."Next Run Date" = 0D then
                    StandingOrderHeader."Next Run Date" := StandingOrderHeader."Effective/Start Date";


                if (MemberAccounts.Get(StandingOrderHeader."Source Account No.")) and (StandingOrderHeader."Effective/Start Date" <> 0D) then begin

                    GlobalDim1 := MemberAccounts."Global Dimension 1 Code";
                    GlobalDim2 := MemberAccounts."Global Dimension 2 Code";

                    TCharges := 0;
                    MemberActivities.GetGeneralChargeAmount(StandingOrderHeader."Transaction Type", Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct);
                    TCharges := ChargeAmt + ChargeDuty;

                    AvailableBal := MemberActivities.GetAccountBalance(MemberAccounts."No.");
                    AvailableBal -= TCharges;

                    if AvailableBal < 0 then
                        AvailableBal := 0;

                    RunBal := AvailableBal;

                    MemberAccounts."Test Blocked" := MemberAccounts."test blocked"::" ";
                    if MemberAccounts.Blocked <> MemberAccounts.Blocked::" " then begin
                        MemberAccounts."Test Blocked" := MemberAccounts.Blocked;
                        MemberAccounts.Blocked := MemberAccounts.Blocked::" ";
                        MemberAccounts.Modify;
                    end;

                    TChannel := TChannel::STO;

                    STOAmount := StandingOrderHeader.Amount;

                    if StandingOrderHeader.Balance > STOAmount then
                        StandingOrderHeader.Balance := STOAmount;

                    if StandingOrderHeader.Balance > 0 then
                        STOAmount := StandingOrderHeader.Balance;

                    /*
                    IF StandingOrderHeader."Target Amount" > 0 THEN BEGIN
                        STOAmountPosted:=0;
                        SLedger.RESET;
                        SLedger.SETRANGE("Document No.",StandingOrderHeader.Code);
                        SLedger.SETRANGE("Customer No.",StandingOrderHeader."Source Account No.");
                        IF SLedger.FINDFIRST THEN BEGIN
                            SLedger.CALCSUMS("Amount (LCY)");
                            STOAmountPosted:=SLedger."Amount (LCY)";
                        END;
                
                        IF STOAmountPosted+STOAmount >= StandingOrderHeader."Target Amount" THEN BEGIN
                            STOAmount:=StandingOrderHeader."Target Amount"-STOAmountPosted;
                            IF STOAmount < 0 THEN
                                STOAmount:=0;
                
                            StandingOrderHeader.Status:=StandingOrderHeader.Status::Stopped;
                            StandingOrderHeader.MODIFY;
                        END;
                    END;
                    */

                    StandingOrderHeader."Allow Partial Deduction" := false;

                    if STOAmount <= 0 then
                        CurrReport.Skip;

                    if AvailableBal >= STOAmount then begin
                        DeductionStatus := Deductionstatus::Successfull;
                        StandingOrderHeader.Balance := 0;
                        RunBal := STOAmount;
                    end
                    else begin
                        if not StandingOrderHeader."Allow Partial Deduction" then begin
                            DeductionStatus := Deductionstatus::Failed;
                            RunBal := 0;
                            //SendSTOFailedSMS(StandingOrderHeader."Member No.");
                        end
                        else begin
                            if AvailableBal > 0 then begin
                                DeductionStatus := Deductionstatus::"Partial Deduction";
                                StandingOrderHeader.Balance := STOAmount - AvailableBal;
                                RunBal := AvailableBal;
                            end
                            else begin
                                DeductionStatus := Deductionstatus::Failed;
                                StandingOrderHeader.Balance := STOAmount;
                                RunBal := 0;
                                //SendSTOFailedSMS(StandingOrderHeader."Member No.");
                            end;
                        end;
                    end;


                    //MESSAGE('%1',RunBal);
                    StandingOrderLines.Reset;
                    StandingOrderLines.SetCurrentKey(Priority);
                    StandingOrderLines.SetAscending(Priority, true);
                    StandingOrderLines.SetFilter(Amount, '>%1', 0);
                    StandingOrderLines.SetFilter("Destination Account No.", '<>%1', '');
                    StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader.Code);
                    if (StandingOrderLines.Find('-')) and (RunBal > 0) then begin

                        //AZIZSaccoActivities.JournalInit(JTemplate, JBatch);

                        repeat
                            STOlinesname := StandingOrderLines."Destination Account Name";

                            case StandingOrderLines."Destination Account Type" of
                                StandingOrderLines."destination account type"::Internal,
                                StandingOrderLines."destination account type"::"G/L Account",
                                StandingOrderLines."destination account type"::External:
                                    begin


                                        case StandingOrderLines."Destination Account Type" of
                                            StandingOrderLines."destination account type"::"G/L Account":
                                                begin

                                                    AcctType := Accttype::"G/L Account";
                                                    AcctNo := StandingOrderLines."Destination Account No.";
                                                end;
                                            StandingOrderLines."destination account type"::External:
                                                begin
                                                    SaccoSetup.testfield("External STO Account No.");
                                                    AcctType := Accttype::"Bank Account";
                                                    AcctNo := SaccoSetup."External STO Account No.";
                                                end;
                                            StandingOrderLines."destination account type"::Internal:
                                                begin
                                                    AcctType := AcctType::Savings;
                                                    AcctNo := StandingOrderLines."Destination Account No.";
                                                end;
                                        end;

                                        //Desc := CopyStr('STO:-' + Format(StandingOrderHeader.Code) + ' : ' + Format(StandingOrderHeader."Next Run Date") +
                                        //          ' : ' + Format(StandingOrderHeader."Source Account Name"), 1, 50);

                                        Desc := Copystr(Format(StandingOrderHeader."Source Account No.") + ': ' + Format(StandingOrderHeader."Source Account Name" + ' : ' + Format(StandingOrderHeader."Next Run Date")), 1, 50);


                                        if RunBal > StandingOrderLines.Amount then
                                            Amt := -StandingOrderLines.Amount
                                        else
                                            Amt := -RunBal;

                                        LoanNo := StandingOrderLines."Loan No.";
                                        BalAcctType := Balaccttype::"G/L Account";
                                        BalAcctNo := '';
                                        ExtDocNo := StandingOrderHeader.Code;

                                        SaccoActivities.JournalInsert(JTemplate, JBatch, StandingOrderHeader.Code, PDate, AcctType, AcctNo, Desc, BalAcctType,
                                        BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true, TChannel, DimID);

                                        RunBal -= Abs(Amt);
                                        AmountDedu += Abs(Amt);
                                    end;

                                StandingOrderLines."destination account type"::Credit:
                                    begin

                                        LoanInterest := 0;
                                        LoanPrincipal := 0;
                                        LoanRepayment := 0;


                                        Loans.Reset;
                                        Loans.SetRange(Loans."Loan No.", StandingOrderLines."Loan No.");
                                        Loans.SetFilter("Outstanding Principal", '<=0');
                                        if Loans.Find('-') then begin
                                            if StandingOrderLines.Count = 1 then begin
                                                StandingOrderHeader.Status := StandingOrderHeader.Status::Stopped;
                                                StandingOrderHeader.Modify();
                                            end;
                                        end;

                                        Loans.Reset;
                                        Loans.SetRange(Loans."Loan No.", StandingOrderLines."Loan No.");
                                        Loans.SetFilter("Outstanding Principal", '>0');
                                        if Loans.Find('-') then begin
                                            Loans.CalcFields(Loans."Outstanding Interest", Loans."Outstanding Penalty", Loans."Outstanding Principal", "Outstanding Appraisal", "Outstanding Insurance");

                                            LoanPrincipal := StandingOrderLines.Amount;

                                            if StandingOrderLines."Destination Account No." = '' then begin
                                                StandingOrderLines."Destination Account No." := Loans."Member No.";
                                                StandingOrderLines.MODIFY;
                                            end;
                                            //MESSAGE('RUn Bal %1',RunBal);
                                            if Loans."Outstanding Penalty" > 0 then begin


                                                AcctType := AcctType::Credit;
                                                AcctNo := StandingOrderLines."Destination Account No.";
                                                Desc := CopyStr('Destination:-' + Loans."Loan No." + '-' + StandingOrderHeader."Source Account No." + '- Penalty Paid', 1, 50);

                                                LoanNo := StandingOrderLines."Loan No.";
                                                BalAcctType := Balaccttype::"G/L Account";
                                                BalAcctNo := '';
                                                ExtDocNo := StandingOrderHeader.Code;
                                                TransType := Transtype::"Penalty Paid";
                                                LoanPenalty := Loans."Outstanding Penalty";

                                                if LoanPenalty > StandingOrderLines.Amount then begin
                                                    LoanPenalty := StandingOrderLines.Amount;
                                                    LoanAppraisal := 0;
                                                    LoanInterest := 0;
                                                    LoanPrincipal := 0;
                                                end;

                                                if RunBal > LoanPenalty then
                                                    Amt := -LoanPenalty
                                                else
                                                    Amt := -RunBal;

                                                SaccoActivities.JournalInsert(JTemplate, JBatch, StandingOrderHeader.Code, PDate, AcctType, AcctNo, Desc, BalAcctType,
                                                BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true, TChannel::STO, DimID);

                                                RunBal -= Abs(Amt);
                                                AmountDedu += Abs(Amt);
                                                LoanPrincipal -= Abs(Amt);
                                            end;


                                            if Loans."Outstanding Insurance" > 0 then begin

                                                AcctType := AcctType::Credit;
                                                AcctNo := StandingOrderLines."Destination Account No.";
                                                TransType := Transtype::"Insurance Paid";
                                                Desc := CopyStr('Destination:-' + Loans."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                         Format(TransType), 1, 50);

                                                LoanNo := StandingOrderLines."Loan No.";
                                                BalAcctType := Balaccttype::"G/L Account";
                                                BalAcctNo := '';
                                                ExtDocNo := StandingOrderHeader.Code;
                                                LoanAppraisal := Loans."Outstanding Insurance";

                                                if LoanAppraisal > StandingOrderLines.Amount then begin
                                                    LoanAppraisal := StandingOrderLines.Amount;
                                                    LoanInterest := 0;
                                                    LoanPrincipal := 0;
                                                end;

                                                if RunBal > LoanAppraisal then
                                                    Amt := -LoanAppraisal
                                                else
                                                    Amt := -RunBal;

                                                SaccoActivities.JournalInsert(JTemplate, JBatch, StandingOrderHeader.Code, PDate, AcctType, AcctNo, Desc, BalAcctType,
                                                BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true, TChannel, DimID);

                                                RunBal -= Abs(Amt);
                                                AmountDedu += Abs(Amt);
                                                LoanPrincipal -= Abs(Amt);
                                            end;



                                            //MESSAGE('RUn Bal %1\%2',RunBal,Loans."Outstanding Interest");

                                            if Loans."Outstanding Interest" > 0 then begin

                                                AcctType := AcctType::Credit;
                                                AcctNo := StandingOrderLines."Destination Account No.";
                                                TransType := Transtype::"Interest Paid";
                                                Desc := CopyStr('Destination:-' + Loans."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                         Format(TransType), 1, 50);

                                                LoanNo := StandingOrderLines."Loan No.";
                                                BalAcctType := Balaccttype::"G/L Account";
                                                BalAcctNo := '';
                                                ExtDocNo := StandingOrderHeader.Code;
                                                LoanInterest := Loans."Outstanding Interest";

                                                if LoanInterest > StandingOrderLines.Amount then begin
                                                    LoanInterest := StandingOrderLines.Amount;
                                                    LoanPrincipal := 0;

                                                end;

                                                if RunBal > LoanInterest then
                                                    Amt := -LoanInterest
                                                else
                                                    Amt := -RunBal;

                                                //MESSAGE('Amt %1',Amt);
                                                SaccoActivities.JournalInsert(JTemplate, JBatch, StandingOrderHeader.Code, PDate, AcctType, AcctNo, Desc, BalAcctType,
                                                BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true, TChannel, DimID);

                                                RunBal -= Abs(Amt);
                                                AmountDedu += Abs(Amt);
                                                LoanPrincipal -= Abs(Amt);

                                            end;


                                            //MESSAGE('LoanPrincipacl %1\%2',LoanPrincipal,Loans."Outstanding Principal");
                                            if (Loans."Outstanding Principal" > 0) and (LoanPrincipal > 0) then begin

                                                AcctType := AcctType::Credit;
                                                AcctNo := StandingOrderLines."Destination Account No.";
                                                LoanNo := StandingOrderLines."Loan No.";

                                                BalAcctType := Balaccttype::"G/L Account";
                                                ExtDocNo := StandingOrderHeader.Code;
                                                TransType := Transtype::"Principal Repayment";

                                                if Loans."Outstanding Principal" >= LoanPrincipal then
                                                    LoanRepayment := LoanPrincipal
                                                else
                                                    LoanRepayment := Loans."Outstanding Principal";

                                                if RunBal >= LoanRepayment then
                                                    Amt := -LoanRepayment
                                                else
                                                    Amt := -RunBal;

                                                BalAcctType := Balaccttype::"G/L Account";
                                                BalAcctNo := '';

                                                Desc := CopyStr('Destination:-' + Loans."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                     Format(TransType), 1, 50);


                                                SaccoActivities.JournalInsert(JTemplate, JBatch, StandingOrderHeader.Code, PDate, AcctType, AcctNo, Desc, BalAcctType,
                                                BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true, TChannel, DimID);

                                                RunBal -= Abs(Amt);
                                                AmountDedu += Abs(Amt);

                                            end;
                                        end;
                                    end;
                            end;
                        until StandingOrderLines.Next = 0;

                        //ERROR('%1',AmountDedu);

                        AcctType := StandingOrderHeader."Source Account Type";
                        AcctNo := StandingOrderHeader."Source Account No.";
                        Desc := CopyStr('STO:-' + Format(StandingOrderHeader.Code) + ' : ' + Format(StandingOrderHeader."Next Run Date") + '-' + Format(STOlinesname), 1, 50);
                        Amt := AmountDedu;
                        LoanNo := '';
                        BalAcctType := Balaccttype::"G/L Account";
                        BalAcctNo := '';
                        ExtDocNo := StandingOrderHeader.Code;


                        SaccoActivities.JournalInsert(JTemplate, JBatch, StandingOrderHeader.Code, PDate, AcctType, AcctNo, Desc, BalAcctType,
                        BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true, TChannel, DimID);

                        if DeductionStatus <> Deductionstatus::Failed then begin
                            if ChargeAmt > 0 then begin

                                SaccoActivities.JournalInsert(JTemplate, JBatch, StandingOrderHeader.Code, PDate, AcctType, AcctNo, Desc, Balaccttype::"G/L Account",
                                ChargeAcct, ChargeAmt, ExtDocNo, '', Transtype::" ", GlobalDim1, GlobalDim2, true, TChannel, DimID);

                                SaccoActivities.JournalInsert(JTemplate, JBatch, StandingOrderHeader.Code, PDate, AcctType, AcctNo, Desc, Balaccttype::"G/L Account",
                                SaccoSetup."Excise Duty GL", ChargeDuty, ExtDocNo, '', Transtype::" ", GlobalDim1, GlobalDim2, true, TChannel, DimID);

                            end;
                        end;

                        if StandingOrderHeader.Status <> StandingOrderHeader.Status::Stopped then
                            if DeductionStatus = Deductionstatus::Successfull then
                                StandingOrderHeader."Next Run Date" := CalcDate(StandingOrderHeader."Frequency (Months)", StandingOrderHeader."Next Run Date");


                        StandingOrderHeader.Modify;


                        SaccoActivities.JournalPost(JTemplate, JBatch);
                    end;




                    /*
                IF Account.GET(StandingOrderHeader."Source Account No.") THEN BEGIN
                    MobNo:=Account."Mobile Phone No";

                    IF DeductionStatus=DeductionStatus::Successfull THEN BEGIN
                        SendSMS.SendSms(SourceType::"Status Order",MobNo,Text0001 +FORMAT(StandingOrderHeader.Amount)+Text0003
                        +' '+COMPANYNAME,"No.","No.",TRUE,FALSE);
                    END;

                    IF DeductionStatus=DeductionStatus::"Partial Deduction" THEN BEGIN
                        SendSMS.SendSms(SourceType::"Status Order",MobNo,Text0001 +FORMAT(StandingOrderHeader.Amount)+Text0002+FORMAT(StandingOrderHeader.Balance)
                        +' '+COMPANYNAME,StandingOrderHeader.Code,StandingOrderHeader.Code,TRUE,FALSE);
                    END;

                    IF DeductionStatus=DeductionStatus::"Partial Deduction" THEN BEGIN
                        SendSMS.SendSms(SourceType::"Status Order",MobNo,Text0001 +FORMAT(StandingOrderHeader.Amount)+Text0004
                        +' '+COMPANYNAME,"No.","No.",TRUE,FALSE);
                    END;

                END;
                   */




                    if MemberAccounts."Test Blocked" <> MemberAccounts."test blocked"::" " then begin
                        MemberAccounts.Blocked := MemberAccounts."Test Blocked";
                        MemberAccounts."Test Blocked" := MemberAccounts."test blocked"::" ";
                        MemberAccounts.Modify;
                    end;


                    InitializeStandingOrderRegister('', Today, StandingOrderHeader.Code, '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                                StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                                DeductionStatus, StandingOrderHeader.Amount, AmountDedu, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                                StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader.Code);

                end;

            end;

            trigger OnPostDataItem()
            begin
                Message(SuccessfullyPosted);
            end;

            trigger OnPreDataItem()
            begin
                if NextRunDate = 0D then
                    NextRunDate := Today;

                UserSetup.Get(UserId);
                UserSetup.Get(UserId);
                UserSetup.TestField("General Journal Template");
                UserSetup.TestField("General Journal Batch");
                UserSetup.TestField("Dimension Set ID");

                DimID := UserSetup."Dimension Set ID";

                JTemplate := UserSetup."General Journal Template";
                JBatch := UserSetup."General Journal Batch";

                SaccoActivities.JournalInit(JTemplate, JBatch);

                StandingOrderHeader.SetFilter("Next Run Date", '..%1', NextRunDate);
                PDate := Today;


                dWindow.Open('Process Standing Order:            #1#########\'
                                    + 'Total Accounts:             #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                  @4@@@@@@@@@\'
                                    + 'Press Esc to abort');

                TotalRecords := StandingOrderHeader.Count;
                dWindow.Update(2, TotalRecords);
                RecordCounter := 0;

                SaccoSetup.Get;
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
        NextRunDate: Date;
        MemberAccounts: Record "Savings Accounts";
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        ProductSetup: Record "Product Setup";
        AvailableBal: Decimal;
        RunBal: Decimal;
        AmountDedu: Decimal;
        BankingUser: Record "Banking User Setup";
        UserSetup: Record "User Setup";
        JTemplate: Code[20];
        DimID: Integer;
        JBatch: Code[20];
        LineN: Integer;
        StandingOrderLines: Record "Standing Order Lines";
        Loans: Record Loans;
        DeductionStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register.";
        LoanInterest: Decimal;
        LoanPrincipal: Decimal;
        LoanRepayment: Decimal;
        MobNo: Code[20];
        MemberActivities: Codeunit "Member Activities";
        Bal: Decimal;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book";
        STOlinesname: Text[80];
        SaccoSetup: Record "Sacco Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        STOAmount: Decimal;
        PDate: Date;
        Amt: Decimal;
        ExtDocNo: Code[20];
        Desc: Text[50];
        LoanNo: Code[20];
        STOAmountPosted: Decimal;
        LoanAppraisal: Decimal;
        LoanPenalty: Decimal;
        SuccessfullyPosted: label 'Successfully Processed.';
        Text0001: label 'Your standing order of ';
        Text0002: label ' has been effected partially the amount due is ';
        Text0003: label ' has been effected successfully ';
        Text0004: label ' has been unsuccessful ';
        Text0005: label ' is due to expire on ';
        Value: Decimal;
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        SharingAmt: Decimal;
        SharingDuty: Decimal;
        SharingChargeAcctType: Enum "Gen. Journal Account Type";
        SharingChargeAcct: Code[20];
        TCharges: Decimal;
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AcctNo: Code[20];
        BalAcctNo: Code[20];
        TotalRecords: Integer;
        dWindow: Dialog;
        RecordCounter: Integer;
        TChannel: Enum "Transaction Channel";


    procedure InitializeStandingOrderRegister(RNo: Code[10]; RDateProcessed: Date; RDocNo: Code[10]; RNoSeries: Code[10]; RSourceAccountNo: Code[20]; RSourceAccountName: Text; RMemberNo: Code[20]; RStaffNo: Code[20]; RPartialDeduction: Boolean; RDeductionStatus: Option " ",Successfull,"Partial Deduction",Failed; RDeductionAmount: Decimal; RAmountDeducted: Decimal; RStartDate: Date; RDuration: DateFormula; RFrequency: DateFormula; REndDate: Date; Rremarks: Text; Reft: Boolean; RTransferEft: Boolean; STONo: Code[20])
    var
        LineNo: Code[10];
    begin

        StandingOrdSRegister.Reset;
        StandingOrdSRegister.SetRange("Standing Order No.", STONo);
        StandingOrdSRegister.SetRange("Date Processed", RDateProcessed);
        StandingOrdSRegister.SetRange("Deduction Status", RDeductionStatus);
        StandingOrdSRegister.SetRange("Amount Deducted", RAmountDeducted);
        StandingOrdSRegister.SetRange(Amount, RDeductionAmount);
        StandingOrdSRegister.SetRange("Source Account No.", RSourceAccountNo);
        if not StandingOrdSRegister.FindFirst then begin

            StandingOrdSRegister.Init;
            StandingOrdSRegister."No." := RNo;
            StandingOrdSRegister."Date Processed" := RDateProcessed;
            StandingOrdSRegister."Document No." := RDocNo;
            StandingOrdSRegister."No. Series" := RNoSeries;
            StandingOrdSRegister."Source Account No." := RSourceAccountNo;
            StandingOrdSRegister."Source Account Name" := RSourceAccountName;
            StandingOrdSRegister."Member No" := RMemberNo;
            StandingOrdSRegister."Staff/Payroll No." := RStaffNo;
            StandingOrdSRegister."Allow Partial Deduction" := RPartialDeduction;
            StandingOrdSRegister."Deduction Status" := RDeductionStatus;
            StandingOrdSRegister.Amount := RDeductionAmount;
            StandingOrdSRegister."Amount Deducted" := RAmountDeducted;
            StandingOrdSRegister."Effective/Start Date" := RStartDate;
            StandingOrdSRegister.Duration := RDuration;
            StandingOrdSRegister.Frequency := RFrequency;
            StandingOrdSRegister."End Date" := REndDate;
            StandingOrdSRegister.Remarks := Rremarks;
            StandingOrdSRegister.EFT := Reft;
            StandingOrdSRegister."Transfered to EFT" := RTransferEft;
            StandingOrdSRegister."Standing Order No." := STONo;
            StandingOrdSRegister.Insert(true);

        end;
    end;

    local procedure SendSTOFailedSMS(MembNo: Code[20])
    var
        myInt: Integer;
        Msg: Text;
        Sky: Codeunit "Sky MBanking";
        SMSSource: Enum "SMS Source Enum";
        Members: Record Members;
        SkySMS: Record "SMS Messages";
    begin
        Clear(Members);
        Members.Get(Membno);
        Msg := 'Dear ' + Sky.FirstName(Members.Name) + ', Your Standing Order Account is running low in funds. Kindly Top Up.';

        SkySMS.Reset();
        SkySMS.SetRange("SMS Message", Msg);
        SkySMS.SetRange("Date Entered", CalcDate('-CM', Today), CalcDate('CM', Today));
        if not SkySMS.FindFirst() then
            MemberActivities.SendSms(Smssource::"Standing Order", Members."Mobile Phone No.", Msg, Members."No.", Members."No.", false, false);
    end;

}

