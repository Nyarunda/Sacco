Codeunit 50092 "Coop Processing"
{
    // 4299346900536128
    // 100100040800
    // Abraham


    trigger OnRun()
    var
        Vendor: Record "Savings Accounts";
        TNo: Code[50];
        GLAccount: Record "G/L Account";
        CoopTrans: Record "Coop ATM Transaction";
    begin

        CoopTrans.Reset();
        CoopTrans.SetRange(Posted, false);
        if CoopTrans.FindFirst() then begin
            repeat
                PostATM(CoopTrans."Transaction ID");
            until CoopTrans.Next() = 0;
        end;


        // Vendor.GET('5050123278000');
        // Vendor."ATM No." := '4299331606489806';
        // Vendor.MODIFY;

        //IF GLAccount.GET('105019') THEN GLAccount.Blocked := FALSE; GLAccount.MODIFY;
        //4299348600580976
        //ReverseTransaction('RVS000001','TR0000003','BALANCE_ENQ',
        //MESSAGE('%1',
        ////BalanceEnquiry('TR00r004','BAL_ENQ',CURRENTDATETIME,'TM001','APP','11111','1000002','SIT','YETU SACCO LTD',10,'KES',30,'KES','Balance Enquiry'));

        //MESSAGE(BalanceEnquiry('ServiceName','TRN0002',CURRENTDATETIME,'TM001','POS456789012345',ConnectionMode,'B_A/C_001','4299331917076136','001','Harambee',10,'404',20,'404','','',''));


        //MESSAGE(BalanceEnquiryNew('ServiceName','TR0011',CURRENTDATETIME,'TM001','ATM',ConnectionMode,'B_A/C_001','4299346900536128','001','Harambee',10,'404',20,'404','',''));


        //MESSAGE(MiniStatement('MINISTATEMENT','TRN0029',10,'TM001','ATM',CURRENTDATETIME,'100114573200','0717663099','100114573200',12,'404',22,'404','Mini Statement','001','','',''));

        //MESSAGE(FundsTransfer('ServiceName','TR00051',CURRENTDATETIME,'','OMNISACCO',ConnectionMode,'0001','','001','Harambee',500,'404','100100040800','B_A/C_001',0,'404',0,'404','Cash Withdrawal','','','',''));

        //Reversal
        //MESSAGE(FundsTransfer('FT','106906004119_CS_POSTFUNDS2',CURRENTDATETIME,'POS03170','0002P001',
        //ConnectionMode,'1420','106906004119_CS_POSTFUNDS','001','Harambee',1800,'KES','4299337600286155','B_A/C_001',15,'404',25,'404','Cash Withdrawal','','',''));

        //PostATM('204110162320_CS_MINISTATEMENT');


        //MESSAGE('%1',GetAccountBalance('0502-001-09366',TODAY));
        //ReverseLoans();
        Message('Done');
        //
    end;

    var
        ExciseDutyGL: Code[20];
        ExciseDutyRate: Decimal;
        ExciseDuty: Decimal;
        CoopSetup: Record "Coop ATM  Setup";
        ChargeAmount: Decimal;
        TransAmount: Decimal;
        JTemplate: Code[30];
        JBatch: Code[30];
        GenLedgerSetup: Record "General Ledger Setup";
        GenSetup: Record "Sacco Setup";
        BUser: Record "User Setup";
        SaccoTrans: Codeunit "Sacco Activities";
        CoopTrans: Record "Coop ATM Transaction";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Enum "SMS Source Enum";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[30];
        Dim2: Code[30];
        SystCreated: Boolean;
        SLedger: Record "G/L Entry";
        Sep: label '\::/';
        Null: label 'NULL';
        Success: label '200';
        Account_Does_Not_Exist: label '300';
        Parameters_Not_Valid_Or_Missing: label '400';
        Caller_Not_Authorized_For_This_Request: label '401';
        Insufficient_Funds: label '402';
        Daily_Amount_Limit_Reached: label '403';
        Operation_Does_Not_Exist: label '404';
        Daily_Frequency_Limit_Reached: label '405';
        Severe_problem_Has_Occured: label '500';
        CoopCode: Record "Coop Transaction Codes";
        Continue: Boolean;
        LedgerCount: Integer;
        CurrRecord: Integer;
        EndRec: label '\::::/';
        SavAcc: Record "Savings Accounts";
        GenJournalBatch: Record "Gen. Journal Batch";
        ConnectionMode: Text;

        StringWriter: Text;
        ATM_No: Text;
        BankCharge: Decimal;
        SaccoFee: Decimal;
        TerminalCode: Text;
        CRate: Decimal;
        MobileBanking: Codeunit "Sky Mbanking";
        MActivities: Codeunit "Member Activities";
        ChannelCode: Text;
        DefDesc: Text;
        TChannel: Enum "Transaction Channel";



    procedure BalanceEnquiry(serviceName: Text; requestReference: Text; transactionDate: DateTime; terminalId: Text; channel: Text; connectionMode: Text; creditAccount: Text; debitAccount: Text; institutionCode: Text; institutionName: Text[100]; chargeAmount: Decimal; chargeCurrency: Text; feeAmount: Decimal; feeCurrency: Text; deviceType: Text; location: Text; conversionRate: Text) Response: Text
    var
        i: Decimal;
        Narration: Text;
        MemberNo: Text[30];
        AccBalance: Decimal;
        thisSavAccNo: Text[30];
        foundChargeAccount: Boolean;
        A: Integer;
        MNo: Code[20];
        AcctNo: Code[20];
        TotalCharge: Decimal;
        AccBal: Decimal;
        RespTransactionID: Text;
        RespStatusCode: Text;
        RespStatusDescription: Text;
        RespTransactionDate: DateTime;
        RespTransactionReference: Text;
        RespInstitutionCode: Text;
        RespDebitAccount: Text;
        RespAccountBookBalance: Decimal;
        RespAccountClearedBalance: Decimal;
        RespAccountCurrency: Text;

        StringWriter: Text;
        TransactionType: Code[20];
        JsonResponse: JsonObject;

        Members: Record Members;
    begin

        ChannelCode := Channel;
        TerminalCode := TerminalID;

        IF channel <> '' THEN
            ChannelCode := COPYSTR(channel, 4, 2);

        IF terminalId <> '' THEN
            TerminalCode := COPYSTR(terminalId, 1, 3);

        IF TerminalCode = 'ATM' THEN
            ChannelCode := '';



        Narration := 'Coop Balance Enquiry: ' + TerminalCode + ' : ' + ChannelCode;
        TransactionType := '0016';
        CoopCode.reset;
        CoopCode.setfilter(Code, TransactionType);
        CoopCode.SetFilter(Terminal, TerminalCode);
        CoopCode.SetFilter(Channel, ChannelCode);
        if CoopCode.FindFirst() then begin
            //if CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then begin
            Narration := CoopCode.Description;
        End
        else begin
            TerminalCode := '';
            ChannelCode := '';
        end;

        // Get Excise duty G/L
        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty := 0;

        /*
        TotalCharge:=ChargeAmount+FeeAmount;
        ExciseDuty:=ROUND(FeeAmount*ExciseDutyRate/100);
        */

        ATM_No := '';
        DebitAccount := GetAccountNoFromATMNo(DebitAccount);


        if SavAcc.Get(DebitAccount) then begin
            Members.Get(SavAcc."Member No.");
        end;

        BankCharge := 0;
        SaccoFee := 0;
        if Members."Member Category" <> Members."Member Category"::"Staff Members" then
            GetATMcharges(TransactionType, TerminalCode, ChannelCode, 0, BankCharge, SaccoFee);
        TotalCharge := BankCharge + SaccoFee;
        ExciseDuty := ROUND(SaccoFee * ExciseDutyRate / 100);

        //ERROR('TotalCharge %1',TotalCharge);

        CoopSetup.Get;

        RespTransactionID := RequestReference;
        RespTransactionDate := TransactionDate;
        RespTransactionReference := Null;
        //CoopSetup.TESTFIELD("Institution Code");
        RespInstitutionCode := InstitutionCode;
        RespDebitAccount := DebitAccount;
        RespAccountBookBalance := 0;
        RespAccountClearedBalance := 0;
        RespAccountCurrency := 'KES';


        if SavAcc.Get(DebitAccount) then begin

            AccBal := MobileBanking.GetAccountBalance(SavAcc."No.");
            if AccBal >= TotalCharge + ExciseDuty then begin

                BUser.Get(UserId);

                JTemplate := 'GENERAL';
                JBatch := 'COOPBRIDGE';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'CoopBridge Batch';
                    GenJournalBatch.Insert;
                end;

                CoopTrans.Init;
                CoopTrans."Transaction ID" := RequestReference;
                CoopTrans."Document No." := SetDocumentNo(RequestReference);
                CoopTrans."Service Name" := serviceName;
                CoopTrans."Transaction Date" := Dt2Date(TransactionDate);
                CoopTrans."Transaction Time" := Dt2Time(TransactionDate);
                CoopTrans."Terminal ID" := TerminalID;
                CoopTrans.Channel := Channel;
                CoopTrans."Sacco Account" := CreditAccount;
                CoopTrans."Member Account" := DebitAccount;
                CoopTrans."ATM No." := ATM_No;
                CoopTrans."Institution Code" := InstitutionCode;
                CoopTrans."Institution Name" := InstitutionName;
                CoopTrans.Commission := ChargeAmount;
                CoopTrans."Commission Currency" := ChargeCurrency;
                CoopTrans."Fee Charged" := FeeAmount;
                CoopTrans."Fee Currency" := FeeCurrency;
                CoopTrans."Description 1" := Narration;
                CoopTrans."Description 2" := CoopTrans."Description 1";
                CoopTrans.Activity := CoopTrans.Activity::"Balance Enquiry";
                CoopTrans."Transaction Type" := TransactionType;
                CoopTrans."Terminal Code" := TerminalCode;
                CoopTrans."Channel Code" := ChannelCode;
                CoopTrans."Total Charges" := TotalCharge;
                CoopTrans."Sacco Fee" := SaccoFee;
                CoopTrans."Coop Fee" := BankCharge;
                CoopTrans."Sacco Excise Duty" := ExciseDuty;
                CoopTrans."Total Account Debit" := CoopTrans.Amount + CoopTrans."Total Charges" + CoopTrans."Sacco Excise Duty";
                CoopTrans.Insert;

                RespTransactionReference := CoopTrans."Document No.";
                SavAcc.CalcFields("Balance (LCY)");
                RespAccountBookBalance := SavAcc."Balance (LCY)" - CoopTrans."Total Account Debit";
                RespAccountClearedBalance := MobileBanking.GetAccountBalance(SavAcc."No.") - CoopTrans."Total Account Debit";
                RespStatusCode := Success;
                RespStatusDescription := 'Success';

                CoopTrans.Reset;
                CoopTrans.SetRange("Transaction ID", RequestReference);
                //CoopTrans.SETRANGE(Posted,FALSE);
                if CoopTrans.FindFirst then begin
                    /*
                    DocNo := CoopTrans."Document No.";
                    PDate := CoopTrans."Transaction Date";
                    AcctNo := CoopTrans."Member Account";
                    ExtDoc := '';
                    LoanNo := '';
                    TransType := TransType::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := TRUE;

                    SaccoTrans.InitJournal(JTemplate,JBatch);

                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR(CoopTrans."Description 1",1,50),BalAccType::"G/L Account",
                                  '',TotalCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR('Excise Duty - '+CoopTrans."Description 1",1,50),BalAccType::"G/L Account",
                                  ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);

                    AcctNo := CoopSetup."Coop Commission Account";
                    ExtDoc := CoopTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"Bank Account",CoopSetup."Coop Commission Account",COPYSTR('Balance Enquiry Commission',1,50),BalAccType::"G/L Account",
                                  '',-BankCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);

                    AcctNo := CoopSetup."Coop Fee Account";
                    ExtDoc := CoopTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";

                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",AcctNo,COPYSTR('Balance Enquiry Fee',1,50),BalAccType::"G/L Account",
                                  '',-SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);

                    CoopTrans.Posted:=TRUE;
                    CoopTrans."Posted By":=USERID;
                    CoopTrans."Date Posted":=TODAY;
                    CoopTrans.MODIFY;
                    RespTransactionReference := CoopTrans."Document No.";

                    SaccoTrans.PostJournal(JTemplate,JBatch);

                    {
                    SLedger.RESET;
                    SLedger.SETRANGE("Document No.",CoopTrans."Document No.");
                    SLedger.SETRANGE("Posting Date",CoopTrans."Transaction Date");
                    SLedger.SETRANGE("Account No.",CoopTrans."Member Account");
                    IF SLedger.FINDFIRST THEN BEGIN
                        RespTransactionReference := FORMAT(SLedger."Transaction No.");

                    END;
                    }

                    SavAcc.CALCFIELDS("Balance (LCY)");
                    RespAccountBookBalance := SavAcc."Balance (LCY)";

                    RespAccountClearedBalance := GetAccountBalance(SavAcc."No.",TODAY);

                    RespStatusCode:=Success;
                    RespStatusDescription:='Success';
                    */
                end;
            end
            else begin
                RespStatusCode := Insufficient_Funds;
                RespStatusDescription := 'Insufficient Funds';
                //ERROR('Insufficient Funds');
            end;
        end
        else begin
            RespStatusCode := Account_Does_Not_Exist;
            RespStatusDescription := 'Account Does Not Exist';
            //ERROR('Account Does Not Exist');
        end;
        //Commit();
        PostATM(RespTransactionID);

        // Build JSON Response using JsonObject
        JsonResponse.Add('DebitAccount', RespDebitAccount);
        JsonResponse.Add('AccountNo', DebitAccount);
        JsonResponse.Add('BookBalance', FormatDecimal(RespAccountBookBalance));
        JsonResponse.Add('Currency', chargeCurrency);
        JsonResponse.Add('ClearedBalance', FormatDecimal(RespAccountClearedBalance));
        JsonResponse.Add('messageID', RespTransactionID);
        JsonResponse.Add('statusCode', RespStatusCode);
        JsonResponse.Add('statusDescription', RespStatusDescription);
        JsonResponse.Add('TransactionReference', RespTransactionReference);

        JsonResponse.WriteTo(Response);

    end;

    procedure GetExciseRate() rate: Integer
    begin


        GenSetup.Get;
        GenSetup.TestField(GenSetup."Coop Excise Duty (%)");
        rate := GenSetup."Coop Excise Duty (%)";

    end;


    procedure GetExciseDutyGL() account: Text[20]
    begin

        GenSetup.Reset;
        GenSetup.Get;
        GenSetup.TestField(GenSetup."Excise Duty GL");
        account := GenSetup."Excise Duty GL";

    end;


    procedure ReverseTransaction(ReversalID: Code[50]; TransactionID: Code[50]; ServiceName: Code[50]; Channel: Code[50]; AccountNo: Code[50]; Amount: Decimal) Reversed: Boolean
    var
        Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        Text0005: label 'Your Income of ';
        Text0006: label ' has been credited to your account at ';
        Text0007: label ' on ';
        ReversalEntry: Record "Reversal Entry";
        GLRegister: Record "G/L Register";
        GLentry: Record "G/L Entry";
        CoopTrans: Record "Coop ATM Transaction";
    begin
        Reversed := false;

        //ERROR('TransactionID %1\Channel %2\AccountNo %3\AccountNo %4',TransactionID,Channel,AccountNo,AccountNo);
        CoopTrans.Reset;
        CoopTrans.SetRange("Transaction ID", TransactionID);
        CoopTrans.SetFilter(CoopTrans.Activity, '<>%1', CoopTrans.Activity::Reversal);
        CoopTrans.SetRange(Channel, Channel);
        CoopTrans.SetRange("Member Account", AccountNo);
        CoopTrans.SetRange(Amount, Amount);
        CoopTrans.SetRange(Posted, true);
        CoopTrans.SetRange(Reversed, false);
        if CoopTrans.FindFirst then begin
            Message('1');
            //ERROR('t');
            SLedger.Reset;
            //SLedger.SetRange("Account No.", CoopTrans."Member Account");
            //IF CoopTrans.Activity = CoopTrans.Activity::"Balance Enquiry" THEN
            //SLedger.SETRANGE(Amount,CoopTrans.Commission+CoopTrans."Fee Charged");
            SLedger.SetRange("Document No.", CoopTrans."Document No.");
            SLedger.SetRange("Posting Date", CoopTrans."Transaction Date");
            SLedger.SetRange("Reversed", false);
            if SLedger.FindFirst then begin


                Message('2');
                /*
                GLentry.Reset();
                GLentry.SetRange("Transaction No.", SLedger."Transaction No.");
                GLentry.SetRange("Document No.", CoopTrans."Document No.");
                GLentry.SetRange("Posting Date", CoopTrans."Transaction Date");
                if GLentry.FindFirst() THen begin

                end;
                */
                GLRegister.Reset;
                GLRegister.SetFilter("From Entry No.", '<=%1', SLedger."Entry No.");
                GLRegister.SetFilter("To Entry No.", '>=%1', SLedger."Entry No.");
                if GLRegister.FindFirst then begin
                    ReversalEntry.SetHideWarningDialogs();
                    ReversalEntry.ReverseRegister(GLRegister."No.");
                end;
            end;


            SLedger.Reset;
            //SLedger.SetRange("Account No.", CoopTrans."Member Account");
            if CoopTrans.Activity = CoopTrans.Activity::"Balance Enquiry" then
                SLedger.SetRange(Amount, CoopTrans.Commission + CoopTrans."Fee Charged");
            SLedger.SetRange("Document No.", CoopTrans."Document No.");
            SLedger.SetRange("Posting Date", CoopTrans."Transaction Date");
            SLedger.SetRange("Reversed", true);
            if SLedger.FindFirst then begin

                Message('5');
                CoopTrans.Reversed := true;
                CoopTrans."Date Reversed" := Today;
                CoopTrans."Reversed By" := UserId;
                CoopTrans."Reversal ID" := ReversalID;
                CoopTrans.Modify;

                Reversed := true;
            end;


        end;


    end;



    procedure FundsTransfer(serviceName: Text; requestReference: Text; transactionDate: DateTime; terminalId: Text; channel: Text; connectionMode: Text; transactionType: Text; originalMessageId: Text; institutionCode: Text; institutionName: Text[100]; transactionAmount: Decimal; currency: Text; debitAccount: Text; creditAccount: Text; chargeAmount: Decimal; chargeCurrency: Text; feeAmount: Decimal; feeCurrency: Text; narrative1: Text; narrative2: Text; deviceType: Text; location: Text; conversionRate: Text) Response: Text
    var
        i: Decimal;
        MemberNo: Text[30];
        AccBalance: Decimal;
        thisSavAccNo: Text[30];
        foundChargeAccount: Boolean;
        A: Integer;
        MNo: Code[20];
        AcctNo: Code[50];
        TotalCharge: Decimal;
        AccBal: Decimal;
        RespTransactionID: Text;
        RespStatusCode: Text;
        RespStatusDescription: Text;
        RespTransactionDate: DateTime;
        RespTransactionReference: Text;
        RespInstitutionCode: Text;
        RespDebitAccount: Text;
        RespAccountBookBalance: Decimal;
        RespAccountClearedBalance: Decimal;
        RespAccountCurrency: Text;
        RespTotalAmount: Decimal;
        RespCreditAccount: Text;
        Reversal: Boolean;
        Limit: Decimal;
        LimitReached: Boolean;
        DepRev: Boolean;
        ForeignAmt: Decimal;
        SAct: Codeunit "Sacco Activities";
        JsonResponse: JsonObject;
        ResponseText: Text;
        AccountNo: Code[20];
        CustAccountNo: Code[20];

        Members: Record Members;
    begin

        ForeignAmt := 0;
        if Currency <> '404' then begin
            ForeignAmt := TransactionAmount;
            TransactionAmount := ChargeAmount;
        end;
        if TransactionAmount = 0 then
            TransactionAmount := ForeignAmt;

        // Get Excise duty G/L
        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty := 0;

        ChannelCode := '';
        TerminalCode := '';

        //Error('...TransactionType %1\ terminalId %2 channel %3', TransactionType, terminalId, channel);
        if channel <> '' then
            ChannelCode := CopyStr(channel, 4, 2);

        if terminalId <> '' then
            TerminalCode := CopyStr(terminalId, 1, 3);

        if TerminalCode = 'ATM' then
            ChannelCode := '';

        DefDesc := '';

        //Error('TransactionType %1\ TerminalCode %2 ChannelCode %3', TransactionType, TerminalCode, ChannelCode);
        //MESSAGE(TransactionType+' v '+TerminalCode+' X '+ChannelCode);


        CoopCode.reset;
        CoopCode.setfilter(Code, TransactionType);
        CoopCode.SetFilter(Terminal, TerminalCode);
        CoopCode.SetFilter(Channel, ChannelCode);
        if CoopCode.FindFirst() then begin
            //if CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then begin
            Limit := CoopCode."Daily Limit";
            DefDesc := CoopCode.Description;
        end
        else begin
            TerminalCode := '';
            ChannelCode := '';
        end;

        TotalCharge := ChargeAmount + FeeAmount;
        ExciseDuty := ROUND(FeeAmount * ExciseDutyRate / 100);
        //MESSAGE(TerminalCode+' T '+ChannelCode);
        CustAccountNo := GetAccountNoFromATMNo(DebitAccount);
        if SavAcc.Get(CustAccountNo) then begin
            Members.Get(SavAcc."Member No.");
        end;

        BankCharge := 0;
        SaccoFee := 0;
        if Members."Member Category" <> Members."Member Category"::"Staff Members" then
            GetATMcharges(TransactionType, TerminalCode, ChannelCode, TransactionAmount, BankCharge, SaccoFee);
        TotalCharge := BankCharge + SaccoFee;
        ExciseDuty := ROUND(SaccoFee * ExciseDutyRate / 100);

        CoopSetup.Get;

        //CoopSetup.TESTFIELD("Institution Code");

        RespTransactionID := RequestReference;
        RespTransactionDate := TransactionDate;
        RespTransactionReference := '';

        RespInstitutionCode := InstitutionCode;

        RespDebitAccount := DebitAccount;
        RespAccountBookBalance := 0;
        RespAccountClearedBalance := 0;
        RespAccountCurrency := 'KES';
        RespTotalAmount := TransactionAmount;
        RespCreditAccount := CreditAccount;

        ATM_No := DebitAccount;
        CustAccountNo := GetAccountNoFromATMNo(DebitAccount);

        if (TransactionType = '0010') then
            CustAccountNo := GetAccountNoFromATMNo(creditAccount);

        if CustAccountNo = '' then begin
            Continue := false;
            RespStatusCode := Severe_problem_Has_Occured;
            RespStatusDescription := 'Account Not Found';
        end;

        if SavAcc.Get(CustAccountNo) then begin
            if SavAcc.Status <> SavAcc.Status::Active then begin
                Continue := false;
                RespStatusCode := Severe_problem_Has_Occured;
                RespStatusDescription := 'Account Not Active';
            end;
            if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                Continue := false;
                RespStatusCode := Severe_problem_Has_Occured;
                RespStatusDescription := 'Account Blocked';
            end;
        end;

        CoopTrans.Reset;
        CoopTrans.SetRange("Transaction ID", RequestReference);
        CoopTrans.SetRange(CoopTrans."Transaction Type", TransactionType);
        if CoopTrans.FindFirst then begin
            RespStatusCode := Severe_problem_Has_Occured;
            RespStatusDescription := 'Transaction Already Exists';
        end
        else begin
            Continue := true;
            CRate := 0;
            if conversionRate <> '' then
                if not Evaluate(CRate, conversionRate) then begin
                    Continue := false;
                    RespStatusCode := Severe_problem_Has_Occured;
                    RespStatusDescription := 'Invalid Conversion Rate';
                end;

            if Continue then
                if SavAcc.Get(CustAccountNo) then begin
                    AccBal := MobileBanking.GetAccountBalance(SavAcc."No.");
                    //AccBal -= SAct.GetTotalArrears(SavAcc."Member No.");

                    // Set the cleared balance for response
                    RespAccountClearedBalance := AccBal;

                    LimitReached := false;
                    if Limit > 0 then begin
                        CoopTrans.Reset;
                        CoopTrans.SetRange("Transaction ID", RequestReference);
                        CoopTrans.SetRange(CoopTrans."Transaction Type", TransactionType);
                        CoopTrans.SetRange(CoopTrans."Transaction Date", Dt2Date(TransactionDate));
                        CoopTrans.SetRange(CoopTrans.Activity, CoopTrans.Activity::"Funds Transfer");
                        CoopTrans.SetRange(CoopTrans."Terminal Code", TerminalCode);
                        CoopTrans.SetRange(CoopTrans."Channel Code", ChannelCode);
                        CoopTrans.SetRange(CoopTrans.Reversed, false);
                        if CoopTrans.FindFirst then begin
                            CoopTrans.CalcSums(CoopTrans.Amount);
                            if (TransactionAmount + CoopTrans.Amount) > Limit then
                                LimitReached := true
                        end;
                    end;
                    DepRev := false;

                    if (TransactionType = '1420') then begin
                        if OriginalMessageID = '' then
                            OriginalMessageID := RequestReference;
                    end;

                    if (TransactionType = '1420') or (TransactionType = '0010') then
                        DepRev := true;

                    if (DepRev) or ((AccBal >= TransactionAmount + TotalCharge + ExciseDuty) and (not LimitReached)) then begin

                        JTemplate := 'GENERAL';
                        JBatch := 'COOPBRIDGE';

                        GenJournalBatch.Reset;
                        GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                        GenJournalBatch.SetRange(Name, JBatch);
                        if not GenJournalBatch.FindFirst then begin
                            GenJournalBatch.Init;
                            GenJournalBatch."Journal Template Name" := JTemplate;
                            GenJournalBatch.Name := JBatch;
                            GenJournalBatch.Description := 'CoopBridge Batch';
                            GenJournalBatch.Insert;
                        end;

                        if Narrative1 = '' then
                            Narrative1 := DefDesc;

                        if Narrative2 = '' then
                            Narrative2 := DefDesc;

                        if Narrative1 = '' then
                            Narrative1 := 'Funds transfer';

                        if Narrative2 = '' then
                            Narrative2 := 'Funds transfer';

                        CoopTrans.Init;
                        CoopTrans."Transaction ID" := RequestReference;
                        CoopTrans."Document No." := SetDocumentNo(RequestReference);
                        CoopTrans."Service Name" := ServiceName;
                        CoopTrans."Foreign Amount" := ForeignAmt;
                        CoopTrans."Transaction Date" := Dt2Date(TransactionDate);
                        CoopTrans."Transaction Time" := Dt2Time(TransactionDate);
                        CoopTrans.Channel := Channel;
                        CoopTrans."Transaction Type" := TransactionType;
                        CoopTrans."Terminal Code" := TerminalCode;
                        CoopTrans."Channel Code" := ChannelCode;

                        //ERROR('TotalCharge %1\TransactionType %2\TerminalCode %3\ChannelCode %4', TotalCharge, TransactionType, TerminalCode, ChannelCode);

                        RespTransactionReference := CoopTrans."Document No.";


                        CoopCode.reset;
                        CoopCode.setfilter(Code, TransactionType);
                        CoopCode.SetFilter(Terminal, TerminalCode);
                        CoopCode.SetFilter(Channel, ChannelCode);
                        if CoopCode.FindFirst() then
                            //if CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then
                            CoopTrans."Transaction Name" := CoopCode.Description;

                        CoopTrans."Original Transaction ID" := OriginalMessageID;

                        Continue := true;
                        Reversal := false;
                        if CoopTrans."Transaction Type" = '1420' then begin
                            Reversal := true;
                            if CoopTrans."Original Transaction ID" = '' then begin
                                //CoopTrans.TESTFIELD("Original Transaction ID");;
                                RespStatusCode := Parameters_Not_Valid_Or_Missing;
                                RespStatusDescription := 'Original Message ID missing for this Reversal Request';
                                Continue := false;
                            end;
                        end;

                        if TransactionType = '0010' then
                            TransactionAmount := TransactionAmount * -1;

                        if Continue then begin
                            CoopTrans."Member Account" := CustAccountNo;
                            CoopTrans.Amount := TransactionAmount;
                            CoopTrans."Amount Currency" := Currency;
                            CoopTrans."Sacco Account" := CreditAccount;
                            CoopTrans.Commission := ChargeAmount;
                            CoopTrans."Commission Currency" := ChargeCurrency;
                            CoopTrans."Fee Charged" := FeeAmount;
                            CoopTrans."Fee Currency" := FeeCurrency;
                            CoopTrans."Description 1" := Narrative1;
                            CoopTrans."Description 2" := Narrative2;
                            CoopTrans."ATM No." := ATM_No;
                            CoopTrans."Institution Code" := InstitutionCode;
                            CoopTrans."Institution Name" := InstitutionName;
                            CoopTrans.Activity := CoopTrans.Activity::"Funds Transfer";
                            if Reversal then
                                CoopTrans.Activity := CoopTrans.Activity::Reversal;
                            CoopTrans."Total Charges" := TotalCharge;
                            CoopTrans."Sacco Fee" := SaccoFee;
                            CoopTrans."Coop Fee" := BankCharge;
                            CoopTrans."Sacco Excise Duty" := ExciseDuty;
                            CoopTrans."Total Account Debit" := CoopTrans.Amount + CoopTrans."Total Charges" + CoopTrans."Sacco Excise Duty";
                            CoopTrans."Device Type" := deviceType;
                            CoopTrans.Location := location;
                            CoopTrans."Conversion Rate" := CRate;
                            CoopTrans.Insert;

                            RespTransactionReference := CoopTrans."Document No.";
                            RespStatusCode := Success;
                            RespStatusDescription := 'Success';

                            CoopTrans.Reset;
                            CoopTrans.SetRange("Transaction ID", RequestReference);
                            CoopTrans.SETRANGE("Transaction Type", transactionType);
                            if CoopTrans.FindFirst then begin
                                // Transaction processing logic would go here
                                // (The original commented code for posting/reversal)
                            end
                            else begin
                                RespStatusCode := Severe_problem_Has_Occured;
                                RespStatusDescription := 'Transaction Missing in NAVISION';
                            end;
                        end;
                    end
                    else begin
                        if LimitReached then begin
                            RespStatusCode := Severe_problem_Has_Occured;
                            RespStatusDescription := 'Daily Limit Reached';
                        end
                        else begin
                            RespStatusCode := Insufficient_Funds;
                            RespStatusDescription := 'Insufficient Funds';
                        end;
                    end;
                end
                else begin
                    RespStatusCode := Account_Does_Not_Exist;
                    RespStatusDescription := 'Account Does Not Exist';
                end;

            if TransactionType = '1420' then
                Commit();

            //Error('%1', CoopTrans);
            PostATM(RespTransactionID);
        end;

        // Build JSON Response
        JsonResponse.Add('DebitAccount', RespDebitAccount);
        JsonResponse.Add('CreditAccount', creditAccount);
        JsonResponse.Add('AccountNo', CustAccountNo);
        JsonResponse.Add('Amount', RespTotalAmount);
        JsonResponse.Add('ClearedBalance', RespAccountClearedBalance);
        JsonResponse.Add('messageID', RespTransactionID);
        JsonResponse.Add('statusCode', RespStatusCode);
        JsonResponse.Add('statusDescription', RespStatusDescription);
        JsonResponse.Add('TransactionReference', RespTransactionReference);

        JsonResponse.WriteTo(ResponseText);
        Response := ResponseText;

    end;

    procedure MiniStatement(serviceName: Text; requestReference: Text; maxNumberRows: Integer; terminalId: Text; channel: Text; transactionDate: DateTime; debitAccount: Text; mobileNo: Text; creditAccount: Text; chargeAmount: Decimal; chargeCurrency: Text; feeAmount: Decimal; feeCurrency: Text; narrative: Text[50]; institutionCode: Text; deviceType: Text; location: Text; conversionRate: Text) Response: Text
    var
        TransactionType: Code[20];
        i: Decimal;
        JsonResponse: JsonObject;
        Narration: Text;
        SLedger: Record "Savings Ledger Entry";
        MemberNo: Text[30];
        AccBalance: Decimal;
        thisSavAccNo: Text[30];
        foundChargeAccount: Boolean;
        A: Integer;
        MNo: Code[20];
        AcctNo: Code[20];
        TotalCharge: Decimal;
        AccBal: Decimal;
        RespTransactionID: Text;
        RespStatusCode: Text;
        RespStatusDescription: Text;
        RespTransactionDate: DateTime;
        RespTransactionReference: Text;
        RespInstitutionCode: Text;
        RespDebitAccount: Text;
        RespAccountBookBalance: Decimal;
        RespAccountClearedBalance: Decimal;
        RespAccountCurrency: Text;
        RespTotalAmount: Decimal;
        RespCreditAccount: Text;
        Reversal: Boolean;
        RespDebitCreditFlag: Text;
        RespTransAmount: Decimal;
        RespNarration: Text;
        RespPostingDate: Date;
        SDate: Date;
        RespChannelID: Text;
        RespAccountName: Text;
        RespAccountNumber: Text;
        Found: Boolean;
        RespBookBal: Text;
        RespAvailableBalance: Text;
        RespSummaryAccountBookBalance: Decimal;
        RespSummaryAccountClearedBalance: Decimal;
        JsonArray: JsonArray;
        JsonObject: JsonObject;
        JsonText: Text;

        Members: Record Members;
    begin

        Found := false;

        ChannelCode := '';
        TerminalCode := '';

        if channel <> '' then
            ChannelCode := CopyStr(channel, 4, 2);

        if terminalId <> '' then
            TerminalCode := CopyStr(terminalId, 1, 3);

        if TerminalCode = 'ATM' then
            ChannelCode := '';
        if TerminalCode = 'POS' then
            ChannelCode := '';

        Narration := 'Coop MiniStatememt: ' + TerminalCode + ' : ' + ChannelCode;
        TransactionType := '0014';

        CoopCode.reset;
        CoopCode.setfilter(Code, TransactionType);
        CoopCode.SetFilter(Terminal, TerminalCode);
        CoopCode.SetFilter(Channel, ChannelCode);
        if CoopCode.FindFirst() then begin
            //if CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then begin
            Narration := CoopCode.Description;
        End
        else begin
            TerminalCode := '';
            ChannelCode := '';
        end;

        // Get Excise duty G/L
        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty := 0;

        BankCharge := 0;
        SaccoFee := 0;
        DebitAccount := GetAccountNoFromATMNo(DebitAccount);
        if SavAcc.Get(DebitAccount) then begin
            Members.Get(SavAcc."Member No.");
        end;
        if Members."Member Category" <> Members."Member Category"::"Staff Members" then
            GetATMcharges(TransactionType, TerminalCode, ChannelCode, 0, BankCharge, SaccoFee);
        TotalCharge := BankCharge + SaccoFee;
        ExciseDuty := ROUND(SaccoFee * ExciseDutyRate / 100);

        CoopSetup.Get;

        RespTransactionID := RequestReference;
        RespTransactionDate := TransactionDate;
        RespTransactionReference := Null;
        RespInstitutionCode := InstitutionCode;
        RespDebitAccount := DebitAccount;
        RespAccountBookBalance := 0;
        RespAccountClearedBalance := 0;
        RespSummaryAccountBookBalance := 0;
        RespSummaryAccountClearedBalance := 0;
        RespAccountCurrency := 'KES';
        RespCreditAccount := CreditAccount;

        ATM_No := DebitAccount;
        DebitAccount := GetAccountNoFromATMNo(DebitAccount);

        if SavAcc.Get(DebitAccount) then begin
            RespSummaryAccountBookBalance := SavAcc."Balance (LCY)" - CoopTrans."Total Account Debit";
            RespSummaryAccountClearedBalance := MobileBanking.GetAccountBalance(SavAcc."No.") - CoopTrans."Total Account Debit";

            RespAccountName := SavAcc.Name;
            RespAccountNumber := SavAcc."No.";

            if MaxNumberRows > 0 then begin
                AccBal := MobileBanking.GetAccountBalance(SavAcc."No.");

                if AccBal >= TotalCharge + ExciseDuty then begin
                    BUser.Get(UserId);

                    JTemplate := 'GENERAL';
                    JBatch := 'COOPBRIDGE';

                    GenJournalBatch.Reset;
                    GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                    GenJournalBatch.SetRange(Name, JBatch);
                    if not GenJournalBatch.FindFirst then begin
                        GenJournalBatch.Init;
                        GenJournalBatch."Journal Template Name" := JTemplate;
                        GenJournalBatch.Name := JBatch;
                        GenJournalBatch.Description := 'Mcoop Batch';
                        GenJournalBatch.Insert;
                    end;

                    Narrative := Narration;
                    if Narrative = '' then
                        Narrative := 'Mini-Statement';

                    CoopTrans.Reset;
                    CoopTrans.SetRange("Transaction ID", RequestReference);
                    CoopTrans.SetRange(CoopTrans."Transaction Type", TransactionType);
                    if CoopTrans.FindFirst then begin
                        RespStatusCode := Severe_problem_Has_Occured;
                        RespStatusDescription := 'Transaction Already Exists';
                    end
                    else begin

                        CoopTrans.Init;
                        CoopTrans."Transaction ID" := RequestReference;
                        CoopTrans."Document No." := SetDocumentNo(RequestReference);
                        CoopTrans."Service Name" := ServiceName;
                        CoopTrans."Transaction Date" := Dt2Date(TransactionDate);
                        CoopTrans."Transaction Time" := Dt2Time(TransactionDate);
                        CoopTrans."Member Account" := DebitAccount;
                        CoopTrans."Sacco Account" := CreditAccount;
                        CoopTrans."ATM No." := ATM_No;
                        CoopTrans.Commission := ChargeAmount;
                        CoopTrans."Commission Currency" := ChargeCurrency;
                        CoopTrans."Fee Charged" := FeeAmount;
                        CoopTrans."Fee Currency" := FeeCurrency;
                        CoopTrans."Description 1" := Narrative;
                        CoopTrans."Institution Code" := InstitutionCode;
                        CoopTrans.Activity := CoopTrans.Activity::MiniStatement;
                        CoopTrans."Transaction Type" := TransactionType;
                        CoopTrans."Terminal Code" := TerminalCode;
                        CoopTrans."Channel Code" := ChannelCode;
                        CoopTrans."Total Charges" := TotalCharge;
                        CoopTrans."Sacco Fee" := SaccoFee;
                        CoopTrans."Coop Fee" := BankCharge;
                        CoopTrans."Sacco Excise Duty" := ExciseDuty;
                        CoopTrans."Total Account Debit" := CoopTrans.Amount + CoopTrans."Total Charges" + CoopTrans."Sacco Excise Duty";
                        CoopTrans."Device Type" := deviceType;
                        CoopTrans.Location := location;
                        CoopTrans."Conversion Rate" := CRate;
                        CoopTrans.Insert;

                        RespTransactionReference := CoopTrans."Document No.";
                        RespStatusCode := Success;
                        RespStatusDescription := 'Success';

                        CoopTrans.Reset;
                        CoopTrans.SetRange("Transaction ID", RequestReference);
                        if CoopTrans.FindFirst then begin
                            // Transaction processing logic would go here
                        end
                        else begin
                            RespStatusCode := Severe_problem_Has_Occured;
                            RespStatusDescription := 'Transaction Missing in NAVISION';
                        end;
                    end;
                end
                else begin
                    RespStatusCode := Insufficient_Funds;
                    RespStatusDescription := 'Insufficient Funds';
                end;
            end;

            RespTransAmount := 0;
            RespNarration := '';
            RespPostingDate := 0D;
            RespChannelID := '';

            if RespStatusCode = Success then begin
                CoopTrans.Reset;
                CoopTrans.SetRange("Transaction ID", RequestReference);
                if CoopTrans.FindFirst then begin

                    SLedger.Reset;
                    SLedger.SetRange("Account No.", CoopTrans."Member Account");
                    if SLedger.FindFirst then begin
                        LedgerCount := 0;
                        CurrRecord := SLedger.Count - MaxNumberRows;

                        if CurrRecord < 1 then
                            CurrRecord := 1;
                        if CurrRecord > 0 then begin
                            RespAccountBookBalance := 0;
                            SDate := 0D;
                            repeat
                                LedgerCount += 1;

                                if LedgerCount >= CurrRecord then begin
                                    SDate := SLedger."Posting Date";
                                end
                            until (SLedger.Next = 0) or (SDate <> 0D);

                            // Convert JsonArray to Text

                        end;
                    end;

                    SLedger.Reset;
                    SLedger.SetRange("Account No.", CoopTrans."Member Account");
                    if SLedger.FindFirst then begin
                        // Initialize JSON Array
                        Clear(JsonArray);
                        LedgerCount := 0;
                        CurrRecord := SLedger.Count - MaxNumberRows;

                        if CurrRecord < 1 then
                            CurrRecord := 1;

                        if CurrRecord > 0 then begin


                            RespAccountClearedBalance := MActivities.GetAccountBalanceAsAt(SavAcc."No.", SDate - 1);
                            SavAcc.SetFilter("Date Filter", '..%1', SDate - 1);
                            SavAcc.CalcFields("Balance (LCY)");
                            RespAccountBookBalance := SavAcc."Balance (LCY)";
                            repeat
                                LedgerCount += 1;

                                if LedgerCount >= CurrRecord then begin

                                    RespAccountBookBalance += SLedger."Amount (LCY)" * -1;
                                    RespAccountClearedBalance += SLedger."Amount (LCY)" * -1;

                                    Found := true;
                                    RespStatusCode := Success;
                                    RespStatusDescription := 'Success';

                                    if SLedger.Amount > 0 then
                                        RespDebitCreditFlag := 'DR'
                                    else
                                        RespDebitCreditFlag := 'CR';

                                    RespTransAmount := Abs(SLedger."Amount (LCY)");
                                    RespNarration := SLedger.Description;
                                    RespPostingDate := SLedger."Posting Date";
                                    RespTransactionDate := TransactionDate;
                                    RespChannelID := CoopTrans.Channel;

                                    // Create JSON Object for each transaction
                                    Clear(JsonObject);
                                    JsonObject.Add('TransactionDate', FormatDate(0D, RespTransactionDate));
                                    JsonObject.Add('TransactionReference', RespTransactionReference);
                                    JsonObject.Add('DebitCreditFlag', RespDebitCreditFlag);
                                    JsonObject.Add('Amount', FormatDecimal(RespTransAmount));
                                    JsonObject.Add('Narration', RespNarration);
                                    JsonObject.Add('PostingDate', FormatDate(RespPostingDate, 0DT));
                                    JsonObject.Add('BookBalance', FormatDecimal(RespAccountBookBalance));
                                    JsonObject.Add('ClearedRunningBalance', FormatDecimal(RespAccountClearedBalance));
                                    JsonObject.Add('ChannelID', RespChannelID);
                                    JsonObject.Add('AccountName', RespAccountName);
                                    JsonObject.Add('AccountNumber', RespAccountNumber);

                                    // Add the transaction object to the array
                                    JsonArray.Add(JsonObject);
                                end;
                            until (SLedger.Next = 0);

                            // Convert JsonArray to Text


                        end
                        else begin
                            RespStatusCode := Severe_problem_Has_Occured;
                            RespStatusDescription := 'Invalid Maximum Number of Rows or Record Transaction';
                            Clear(JsonArray);
                            JsonArray.WriteTo(JsonText);
                            Response := JsonText;
                        end;
                    end
                    else begin
                        RespStatusCode := Severe_problem_Has_Occured;
                        RespStatusDescription := 'No transactions Exist for this Member';
                        Clear(JsonArray);
                        JsonArray.WriteTo(JsonText);
                        Response := JsonText;
                    end;
                end
                else begin
                    RespStatusCode := Operation_Does_Not_Exist;
                    RespStatusDescription := 'Operation Does Not Exist';
                    Clear(JsonArray);
                    JsonArray.WriteTo(JsonText);
                    Response := JsonText;
                end;
            end;
        end
        else begin
            RespStatusCode := Account_Does_Not_Exist;
            RespStatusDescription := 'Account Does Not Exist';
            Clear(JsonArray);
            JsonArray.WriteTo(JsonText);
            Response := JsonText;
        end;

        if not Found then begin
            CoopSetup.Get;

            RespTransactionID := RequestReference;
            RespTransactionDate := TransactionDate;
            RespTransactionReference := Null;
            RespInstitutionCode := InstitutionCode;
            RespDebitAccount := DebitAccount;
            RespAccountBookBalance := 0;
            RespAccountClearedBalance := 0;
            RespAccountCurrency := 'KES';
            Commit();
            PostATM(RespTransactionID);
            Clear(JsonArray);
            JsonArray.WriteTo(JsonText);
            Response := JsonText;
        end;



        JsonText := '';
        // Build JSON Response
        JsonResponse.Add('DebitAccount', RespDebitAccount);
        JsonResponse.Add('AccountNo', DebitAccount);
        JsonResponse.Add('MessageID', RespTransactionID);
        JsonResponse.Add('StatusCode', RespStatusCode);
        JsonResponse.Add('StatusDescription', RespStatusDescription);
        JsonResponse.Add('TransactionReference', RespTransactionReference);
        JsonResponse.Add('AccountTransactions', JsonArray);

        JsonResponse.WriteTo(JsonText);
        Response := JsonText;





    end;



    procedure FormatDecimal(Amount: Decimal) TextValue: Text
    begin

        TextValue := DelChr(Format(Amount), '=', ',')
    end;


    procedure FormatDate(Date: Date; DateTime: DateTime) DateFormat: Text
    var
        DatePart: Date;
        TimePart: Time;
        Milliseconds: Integer;
        Hours: Integer;
        Seconds: Integer;
        Minutes: Integer;
        D: Integer;
        M: Integer;
        Y: Integer;
        dd: Text;
        mm: Text;
        yyyy: Text;
        DateString: Text;
        TimeString: Text;
        hh: Text;
        ss: Text;
    begin
        TimePart := 0T;
        DatePart := 0D;


        Milliseconds := 0;
        Seconds := 0;
        Minutes := 0;
        Hours := 0;

        DateString := '';
        TimeString := '';


        DatePart := Date;

        if DatePart = 0D then
            DatePart := Dt2Date(DateTime);

        D := Date2dmy(DatePart, 1);
        M := Date2dmy(DatePart, 2);
        Y := Date2dmy(DatePart, 3);

        dd := Format(D);
        mm := Format(M);
        yyyy := Format(Y);

        if StrLen(dd) = 1 then
            dd := '0' + dd;
        if StrLen(mm) = 1 then
            mm := '0' + mm;

        DateString := yyyy + '-' + mm + '-' + dd;

        if DateTime <> 0DT then begin
            TimePart := Dt2Time(DateTime);


            Milliseconds := TimePart - 000000T;

            Hours := Milliseconds DIV 1000 DIV 60 DIV 60;
            Milliseconds -= Hours * 1000 * 60 * 60;

            Minutes := Milliseconds DIV 1000 DIV 60;
            Milliseconds -= Minutes * 1000 * 60;

            Seconds := Milliseconds DIV 1000;
            Milliseconds -= Seconds * 1000;

            //MESSAGE('%1 \%2 \%3', Hours, Minutes, Milliseconds);

        end;


        hh := Format(Hours);
        mm := Format(Minutes);
        ss := Format(Seconds);


        if StrLen(hh) = 1 then
            hh := '0' + hh;
        if StrLen(mm) = 1 then
            mm := '0' + mm;
        if StrLen(ss) = 1 then
            ss := '0' + ss;

        TimeString := hh + ':' + mm + ':' + ss;


        DateFormat := DateString + 'T' + TimeString;
    end;


    procedure GetAccountNoFromATMNo(ATMNo: Code[20]) AccNo: Text
    var
        Vendor: Record "Savings Accounts";
    begin
        AccNo := '';
        Vendor.Reset;
        Vendor.SetRange(Vendor."ATM No.", ATMNo);
        Vendor.SetRange(Vendor.Blocked, Vendor.Blocked::" ");
        if Vendor.FindFirst then begin

            if Vendor.Count <> 1 then
                Error('ATM No. not linked to one account');

            exit(Vendor."No.");

        end;
    end;

    local procedure SetDocumentNo(TransNo: Code[50]): Code[20]
    var
        TNo: Text;
    begin

        TNo := CreateGuid;
        TNo := DelChr(TNo, '=', '{|}|-');
        TNo := CopyStr(TNo, 1, 15);
        Message('Doc: %1', StrLen(TNo));


        TNo := CopyStr(TransNo, 1, 12);

        exit(TNo);
    end;


    procedure GetATMcharges(TransCode: Code[10]; Terminal: Code[10]; Channel: Code[10]; Amount: Decimal; var BankCharge: Decimal; var SaccoFee: Decimal)
    var
        Charge: Record "Coop ATM Charges";
        Counter: Integer;
    begin

        BankCharge := 0;
        SaccoFee := 0;
        Charge.Reset;
        Charge.SetRange(Charge.Code, TransCode);
        //if (TransCode <> '0016') and (TransCode <> '0014') then begin
        Charge.SetRange(Charge.Terminal, Terminal);
        Charge.SetRange(Charge.Channel, Channel);
        //end;
        Charge.SetFilter(Charge.Minimum, '<=%1', Amount);
        Charge.SetFilter(Charge.Maximum, '>=%1', Amount);
        if Charge.FindFirst then begin
            BankCharge := Charge."Bank Commission";
            SaccoFee := Charge."Sacco Commission";

            if Charge."Sacco Per Every" > 0 then begin
                Counter := ROUND(Amount / Charge."Sacco Per Every", 1, '>');
                SaccoFee := SaccoFee * Counter;
            end;

        end;
    end;


    procedure PostATM(TransID: Code[50]) Response: Text
    var
        i: Decimal;
        MemberNo: Text[30];
        AccBalance: Decimal;
        thisSavAccNo: Text[30];
        foundChargeAccount: Boolean;
        A: Integer;
        MNo: Code[20];
        AcctNo: Code[20];
        TotalCharge: Decimal;
        AccBal: Decimal;
        RespTransactionID: Text;
        RespStatusCode: Text;
        RespStatusDescription: Text;
        RespTransactionDate: DateTime;
        RespTransactionReference: Text;
        RespInstitutionCode: Text;
        RespDebitAccount: Text;
        RespAccountBookBalance: Decimal;
        RespAccountClearedBalance: Decimal;
        RespAccountCurrency: Text;
        TransactionType: Code[10];
        Source: Enum "SMS Source Enum";
        PhoneNo: Code[20];
        Msg: Text;
        Reversal: Boolean;
        Vendor: Record "Savings Accounts";
        Continue: Boolean;
        Desc: Text;
        BankAccount: Code[20];
        DimID: Integer;
        Members: Record Members;
    begin

        //ERROR('test');
        BUser.Get(UserId);

        JTemplate := 'GENERAL';
        JBatch := 'COOPBRIDGE';

        GenJournalBatch.Reset;
        GenJournalBatch.SetRange("Journal Template Name", JTemplate);
        GenJournalBatch.SetRange(Name, JBatch);
        if not GenJournalBatch.FindFirst then begin
            GenJournalBatch.Init;
            GenJournalBatch."Journal Template Name" := JTemplate;
            GenJournalBatch.Name := JBatch;
            GenJournalBatch.Description := 'Coopbridge Batch';
            GenJournalBatch.Insert;
        end;


        // Get Excise duty G/L
        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty := 0;


        CoopSetup.Get;
        CoopTrans.Reset;
        CoopTrans.SetRange(Skipped, false);
        CoopTrans.SetRange(Posted, false);
        IF TransID <> '' THEN
            CoopTrans.SETRANGE("Transaction ID", TransID);
        if CoopTrans.FindFirst then begin
            repeat
                if SavAcc.Get(CoopTrans."Member Account") then begin
                    Members.Get(SavAcc."Member No.");
                    if (SavAcc.Status <> SavAcc.Status::Active) then begin
                        CoopTrans.Posted := true;
                        CoopTrans.Skipped := true;
                        CoopTrans."Posted By" := UserId;
                        CoopTrans."Date Posted" := Today;
                        if Members."Member Status" <> Members."Member Status"::Active then
                            CoopTrans.Remarks := 'You cannot transact on a ' + format(Members."Member Status") + ' account.';
                        if SavAcc.Status <> SavAcc.Status::Active then
                            CoopTrans.Remarks := 'You cannot transact on a ' + format(SavAcc.Status) + ' account.';
                        CoopTrans.Modify;
                        exit;
                    end;
                end;


                CoopTrans.Skipped := true;

                DocNo := CoopTrans."Document No.";
                PDate := CoopTrans."Transaction Date";
                if PDate = 0D then
                    PDate := Today;
                AcctNo := CoopTrans."Member Account";
                ExtDoc := '';
                LoanNo := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";
                DimID := SavAcc."Dimension Set ID";
                SystCreated := true;
                Continue := true;
                if Vendor.Get(AcctNo) then
                    if Vendor.Blocked <> Vendor.Blocked::" " then
                        Continue := false;

                BankAccount := '';
                if Continue then begin

                    TChannel := TChannel::"COOP ATM";

                    if CoopTrans.Activity <> CoopTrans.Activity::Reversal then begin
                        SaccoTrans.JournalInit(JTemplate, JBatch);

                        BankAccount := GetCoopBankAccount(CoopTrans."Transaction Type", CoopTrans."Terminal Code", CoopTrans."Channel Code");

                        Desc := CoopTrans."Transaction Name";
                        if Desc = '' then
                            Desc := CoopTrans."Description 1";
                        if Desc = '' then
                            Desc := CoopTrans."Description 2";


                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AcctNo, CopyStr(Desc + ' ' + SavAcc."No.", 1, 50), Balacctype::"Bank Account",
                                      BankAccount, CoopTrans.Amount, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AcctNo, CopyStr('Fee on ' + Desc, 1, 50), Balacctype::"G/L Account",
                                      '', CoopTrans."Total Charges" + CoopTrans."Sacco Excise Duty", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty - ' + Desc, 1, 50), Balacctype::"G/L Account",
                                      '', -CoopTrans."Sacco Excise Duty", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                        AcctNo := BankAccount;
                        ExtDoc := CoopTrans."Member Account";
                        LoanNo := '';
                        TransType := Transtype::" ";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", BankAccount, CopyStr(Desc + ': ' + CoopTrans."Member Account", 1, 50), Balacctype::"G/L Account",
                                      '', -CoopTrans."Coop Fee", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                        AcctNo := CoopSetup."Coop Fee Account";
                        ExtDoc := CoopTrans."Member Account";
                        LoanNo := '';
                        TransType := Transtype::" ";

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AcctNo, CopyStr(Desc + ': ' + CoopTrans."Member Account", 1, 50), Balacctype::"G/L Account",
                                      '', -CoopTrans."Sacco Fee", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                        CoopTrans.Posted := true;
                        CoopTrans.Skipped := false;
                        CoopTrans."Posted By" := UserId;
                        CoopTrans."Date Posted" := Today;
                        CoopTrans.Modify;

                        if CoopTrans.Activity = CoopTrans.Activity::"Funds Transfer" then begin
                            if SavAcc.Get(CoopTrans."Member Account") then begin
                                PhoneNo := SavAcc."Transactional Mobile No";
                                if PhoneNo = '' then
                                    PhoneNo := SavAcc."Mobile Phone No.";

                                if (CoopTrans."Terminal Code" = 'POS') or (CoopTrans."Terminal Code" = '') then //Dear ODUNGA WALTER OTIENO, you have done a Cash W/d - Coop Bankof ksh 15,000 from ATM terminal DONHOLMBR002>NAIROBIKE on 07/24/25.
                                    Msg := 'Dear ' + SavAcc.Name + ', You have done a Cash W/d - Coop of Ksh.' + Format(CoopTrans.Amount) + ' from ATM terminal ' + CoopTrans.Location + ' on ' + Format(CoopTrans."Transaction Date");

                                if CoopTrans."Terminal Code" = 'ATM' then // Dear CHEGE JOSPHAT MWERI, you have done a Pos Normal Purchaseof ksh 4,900 from ATM terminal BIGSQUARE-MOUNTAINVI>NAIROBIKE on 07/24/25.
                                    Msg := 'Dear ' + SavAcc.Name + ', You have done a POS Normal Purchase of Ksh.' + Format(CoopTrans.Amount) + ' from ATM terminal ' + CoopTrans.Location + ' on ' + Format(CoopTrans."Transaction Date");

                                //Msg := 'Dear ' + SavAcc.Name + ', You have withdrawn KES ' + Format(CoopTrans.Amount) + ' from your FOSA A/C  on ' + Format(CoopTrans."Transaction Date") + ' at ' + CoopTrans.Location;
                                MActivities.SendSms(Source::"Cash Withdrawal Confirm", PhoneNo, Msg, CoopTrans."Transaction ID", CoopTrans."Member Account", false, false);
                            end;
                        end;

                        SaccoTrans.JournalPost(JTemplate, JBatch);
                    end
                    else
                        if CoopTrans.Activity = CoopTrans.Activity::Reversal then begin

                            if CoopTrans."Transaction Type" = '1420' then begin
                                if CoopTrans."Original Transaction ID" <> '' then begin

                                    if ReverseTransaction(CoopTrans."Transaction ID", CoopTrans."Original Transaction ID", CoopTrans."Service Name", CoopTrans.Channel, CoopTrans."Member Account", CoopTrans.Amount) then begin
                                        if SavAcc.Get(CoopTrans."Member Account") then begin
                                            PhoneNo := SavAcc."Transactional Mobile No";
                                            if PhoneNo = '' then
                                                PhoneNo := SavAcc."Mobile Phone No.";


                                            Msg := 'Dear ' + SavAcc.Name + ', your transaction of KES ' + Format(Abs(CoopTrans.Amount)) + ' has been reversed';
                                            MActivities.SendSms(Source::"Cash Withdrawal Confirm", PhoneNo, Msg, CoopTrans."Transaction ID", CoopTrans."Member Account", false, false);
                                        end;

                                        CoopTrans.Posted := true;
                                        CoopTrans."Posted By" := UserId;
                                        CoopTrans."Date Posted" := Today;


                                        CoopTrans.Reversed := true;
                                        CoopTrans."Date Reversed" := Today;
                                        CoopTrans."Reversed By" := UserId;
                                        CoopTrans.Modify;

                                        RespStatusCode := Success;
                                        RespStatusDescription := 'Success';
                                    end
                                    else begin
                                        CoopTrans.Remarks := 'Reversal Failed';
                                    end;

                                end
                                else
                                    CoopTrans.Remarks := 'Original Transaction ID Missing';
                            end
                            else
                                CoopTrans.Remarks := 'Invalid Transaction Code. Expected Code is 1420';

                        end;
                    CoopTrans.Modify;
                end;
            until CoopTrans.Next = 0;
        end;
    end;


    procedure GetCoopBankAccount(TransCode: Code[10]; Terminal: Code[10]; Channel: Code[10]) BankAccount: Code[20]
    var
        Charge: Record "Coop Transaction Codes";
        Counter: Integer;
        CoopSetup: Record "Coop ATM  Setup";
    begin

        BankAccount := '';

        Charge.Reset;
        Charge.SetRange(Charge.Code, TransCode);
        Charge.SetRange(Charge.Terminal, Terminal);
        Charge.SetRange(Charge.Channel, Channel);

        if Charge.FindFirst then begin
            BankAccount := Charge."Coop Bank Account";
        end;

        if BankAccount = '' then begin
            CoopSetup.Get();
            BankAccount := CoopSetup."Coop Bank Account";
        end;
    end;



    procedure PostATMReversal(TransID: Code[50]) Response: Text
    var
        i: Decimal;
        MemberNo: Text[30];
        AccBalance: Decimal;
        thisSavAccNo: Text[30];
        foundChargeAccount: Boolean;
        A: Integer;
        MNo: Code[20];
        AcctNo: Code[20];
        TotalCharge: Decimal;
        AccBal: Decimal;
        RespTransactionID: Text;
        RespStatusCode: Text;
        RespStatusDescription: Text;
        RespTransactionDate: DateTime;
        RespTransactionReference: Text;
        RespInstitutionCode: Text;
        RespDebitAccount: Text;
        RespAccountBookBalance: Decimal;
        RespAccountClearedBalance: Decimal;
        RespAccountCurrency: Text;
        TransactionType: Code[10];
        Source: Enum "SMS Source Enum";
        PhoneNo: Code[20];
        Msg: Text;
        Reversal: Boolean;
        Vendor: Record "Savings Accounts";
        Continue: Boolean;
        Desc: Text;
        BankAccount: Code[20];
    begin

        //ERROR('test');
        BUser.Get(UserId);

        JTemplate := 'GENERAL';
        JBatch := 'COOPBRIDGE';

        GenJournalBatch.Reset;
        GenJournalBatch.SetRange("Journal Template Name", JTemplate);
        GenJournalBatch.SetRange(Name, JBatch);
        if not GenJournalBatch.FindFirst then begin
            GenJournalBatch.Init;
            GenJournalBatch."Journal Template Name" := JTemplate;
            GenJournalBatch.Name := JBatch;
            GenJournalBatch.Description := 'Coopbridge Batch';
            GenJournalBatch.Insert;
        end;


        // Get Excise duty G/L
        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty := 0;


        CoopSetup.Get;
        CoopTrans.Reset;
        CoopTrans.SetRange(Skipped, true);
        CoopTrans.SetRange(Posted, false);
        CoopTrans.SETRANGE("Transaction ID", TransID);
        if CoopTrans.FindFirst then begin
            repeat
                CoopTrans.Skipped := true;

                DocNo := CoopTrans."Document No.";
                PDate := CoopTrans."Transaction Date";
                AcctNo := CoopTrans."Member Account";
                ExtDoc := '';
                LoanNo := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";
                SystCreated := true;
                Continue := true;
                if Vendor.Get(AcctNo) then
                    if Vendor.Blocked <> Vendor.Blocked::" " then
                        Continue := false;

                BankAccount := '';
                Message('a');
                if Continue then begin

                    if CoopTrans.Activity = CoopTrans.Activity::Reversal then begin

                        Message('b');
                        if CoopTrans."Transaction Type" = '1420' then begin

                            Message('c');
                            if CoopTrans."Original Transaction ID" <> '' then begin

                                Message('d');
                                if ReverseTransaction(CoopTrans."Transaction ID", CoopTrans."Original Transaction ID", CoopTrans."Service Name", CoopTrans.Channel, CoopTrans."Member Account", CoopTrans.Amount) then begin
                                    if SavAcc.Get(CoopTrans."Member Account") then begin
                                        PhoneNo := SavAcc."Transactional Mobile No";
                                        if PhoneNo = '' then
                                            PhoneNo := SavAcc."Mobile Phone No.";


                                        Msg := 'Dear ' + SavAcc.Name + ', your transaction of KES ' + Format(Abs(CoopTrans.Amount)) + ' has been reversed';
                                        MActivities.SendSms(Source::"Cash Withdrawal Confirm", PhoneNo, Msg, CoopTrans."Transaction ID", CoopTrans."Member Account", false, false);
                                    end;

                                    CoopTrans.Posted := true;
                                    CoopTrans."Posted By" := UserId;
                                    CoopTrans."Date Posted" := Today;
                                    CoopTrans.skipped := false;


                                    CoopTrans.Reversed := true;
                                    CoopTrans."Date Reversed" := Today;
                                    CoopTrans."Reversed By" := UserId;
                                    CoopTrans.Modify;

                                    RespStatusCode := Success;
                                    RespStatusDescription := 'Success';
                                end
                                else begin
                                    CoopTrans.Remarks := 'Reversal Failed';
                                end;

                            end
                            else
                                CoopTrans.Remarks := 'Original Transaction ID Missing';
                        end
                        else
                            CoopTrans.Remarks := 'Invalid Transaction Code. Expected Code is 1420';

                    end;
                    CoopTrans.Modify;
                end;
            until CoopTrans.Next = 0;
        end;
    end;


    procedure ReverseLoans()
    var
        j: Integer;
        k: Integer;
        ReversalEntry: Record "Auto Reversal Entry";
        GLRegister: Record "G/L Register";
        myInt: Integer;
        GLedger: Record "G/L Entry";
        Loans: Record Loans;
        LRec: Record Loans;
    begin
        GLedger.Reset();
        GLedger.SetRange("Document No.", 'DEF-INST');
        GLedger.SetRange("Posting Date", DMY2Date(23, 05, 2023));
        GLedger.SetFilter(Amount, '>0');
        GLedger.SetRange(Reversed, false);
        if GLedger.FindFirst() then begin
            j := 0;
            k := 0;
            repeat
                if Loans.get(GLedger."External Document No.") then begin
                    if Loans."Loan Product Type" = 'L05' then begin
                        j += 1;
                        LRec.Reset();
                        LRec.SetRange("Disbursement Date", DMY2Date(23, 05, 2023));
                        LRec.SetRange("Member No.", Loans."Member No.");
                        LRec.SetRange("Loan Product Type", 'L05');
                        LRec.SetFilter("Loan No.", '<>%1', Loans."Loan No.");
                        LRec.SetFilter("Outstanding Principal", '>10');
                        if not LRec.FindFirst() then begin

                            GLRegister.Reset;
                            GLRegister.SetFilter("From Entry No.", '<=%1', GLedger."Entry No.");
                            GLRegister.SetFilter("To Entry No.", '>=%1', GLedger."Entry No.");
                            if GLRegister.FindFirst then begin
                                k += 1;
                                ReversalEntry.ReverseRegister(GLRegister."No.");
                            end;
                        end;
                    end;
                end;
            until GLedger.Next() = 0;
        end;
        Message('All: %1\To Reverse: %2', J, K);
    end;
}

