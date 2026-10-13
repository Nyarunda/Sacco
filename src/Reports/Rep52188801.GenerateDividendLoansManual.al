report 50483 "Generate Dividend Loans Manual"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Generate Dividend Loans Manual.rdlc';
    Caption = 'Generate Dividend Loans Manual';
    dataset
    {
        dataitem(Members; Members)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }

            trigger OnAfterGetRecord()
            var
                responseCode: Text;
                responseMessage: Text;
                errorMessage: Text;
                LoanCode: Text;
                MemberNo: Code[10];
                Loans: Record Loans;
                ReQID: Text;
                transaction_type: Text;
                amount: Decimal;
                TotalArrears: Decimal;
                InterestArrears: Decimal;
                Vendor: Record "Savings Accounts";
                FName: text;
                LName: Text;
                Location: Text;
                Genders: Text;
                IntroducerPhone: Text;
                phoneNo: Text;
                eLoanCode: Text;
                QualAmt: Decimal;
                MaxQualAmt: Decimal;
                Remark: Text;
                ErrorCode: Text[10];
                installments: integer;
                AsAt: Date;
                ArrearsDate: Date;
                DedAmount: Decimal;
                ExpectedAmt: Decimal;
                AmtPaid: Decimal;
                DefAmount: Decimal;
                DaysInArrear: Integer;
                LoanNo: Code[20];
                JTemplate: Code[10];
                JBatch: Code[10];
                DocNo: Code[20];

                AcctType: Enum "Gen. Journal Account Type";
                BalAccType: Enum "Gen. Journal Account Type";
                TransType: Enum "Transaction Type Enum";
                AccNo: Code[20];
                BalAccNo: Code[20];
                SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
                ExtDoc: Code[20];
                Dim1: Code[10];
                Dim2: Code[10];
                ExciseDuty: Decimal;
                ExciseDutyGL: Code[30];
                TotalTopUp: Decimal;
                IntDue: Decimal;
                ProcessingFee: Decimal;
                InsuranceAmount: Decimal;
                Charges: Record "Charges.";
                TopComm: Decimal;
                SelfPresent: Boolean;
                ChargedValue: Decimal;
                Customer: Record Members;
                PChAmt: Decimal;
                GL: Code[20];
                EDuty: Decimal;
                MemberActivities: Codeunit "Member Activities";
                SaccoActivities: Codeunit "Sacco Activities";
                ActLoans: Record Loans;
                BankAccountComm: Code[20];
                Legacy: COdeunit Legacy;
                ChargeCode: Code[20];
                Value: Decimal;
                ChargeAmt: Decimal;
                ChargeDuty: Decimal;
                ChargeAcctType: Enum "Gen. Journal Account Type";
                ChargeAcct: Code[20];
                ExciseDutyRate: Decimal;
                SystCreated: Boolean;
                TransactionType: Enum "Transaction Type Enum";
                SaccoFee: Decimal;
                VendorCommission: Decimal;
                TotalCharge: Decimal;
                SaccoAccount: Code[20];
                VendorAccount: Code[20];
                UpfrontInterest: Decimal;
                PCharges: Record "Loan Product Charges.";
                Amt: Decimal;
                Custdet: Record "Credit Ledger Entry";
                CustR: Record Customer;
                DepAvg: Decimal;
                Ability: Decimal;
                IncLevel: Decimal;
                VendorBalAcc: Code[20];
                LBalC: Decimal;
                LInt: Decimal;
                ClearOldest: Boolean;
                OldLoans: Record Loans;
                TotalOutstanding: Decimal;
                RunningAmount: Decimal;
                LoanInterest: Decimal;
                SameLoan: Record Loans;
                TotalApplied: Decimal;
                TopUpResponse: Text;
                CanTopAp: Boolean;
                CoopSetup: Record "Sky Mobile Setup.";
                SpotSetup: Record "SpotCash Setup";
                SMSCharge: Decimal;
                SMSAccount: Code[20];
                GenJournalBatch: Record "Gen. Journal Batch";
                LGCount: Integer;
                CheckDate: Date;
                SaccoTrans: Codeunit "Sacco Activities";
                Source: Enum "SMS Source Enum";
                SaccoSetup: Record "Sacco Setup";
                LoanSecurity: Record "Loan Security";
                MobileLoans: Record "Sky Mobile Loans";
                LoanProduct: Record "Product Setup";
                LoanAmount: Decimal;
                RepAmt: Decimal;
                GenSetup: Record "Sacco Setup";
                DivAcc: Code[20];
                Sledger: Record "Savings Ledger Entry";
            begin
                responseCode := '';
                responseMessage := '';
                errorMessage := '';
                phoneNo := '';
                QualAmt := 0;
                TotalArrears := 0;
                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                TotalArrears := 0;
                LoanAmount := 0;
                RepAmt := 0;
                MaxQualAmt := 0;
                InterestArrears := 0;
                eLoanCode := 'L43';
                Remark := '';
                QualAmt := 0;

                GenSetup.Get();

                // Get Excise duty G/L
                ExciseDutyGL := Spotcash.GetExciseDutyGL();
                ExciseDutyRate := Spotcash.GetExciseRate();
                ExciseDuty := 0;

                SaccoAccount := '';
                SaccoFee := 0;
                VendorAccount := '';
                VendorCommission := 0;

                SMSAccount := '';
                SMSCharge := 0;
                DocNo := 'DIV ADVANCE';

                FosaAcc.Reset();
                FosaAcc.SetRange("Member No.", Members."No.");
                FosaAcc.SetRange("Product Category", FOSA."Product Category"::"Dividend Account");
                if FosaAcc.FindFirst() then begin

                    Sledger.Reset();
                    Sledger.SetRange("Account No.", FosaAcc."No.");
                    Sledger.SetRange("Document No.", DocNo);
                    Sledger.SetRange(Reversed, false);
                    if sledger.FindFirst() then
                        CurrReport.skip;

                    DivAcc := FosaAcc."No.";
                end else begin
                    LoanProduct.Reset();
                    LoanProduct.SetRange("Product Category", LoanProduct."Product Category"::"Dividend Account");
                    if LoanProduct.FindFirst() then
                        DivAcc := MemberActivities.CreateSavingsAccount(LoanProduct, Members, LoanProduct."Minimum Contribution", false, LoanProduct."Repay Mode");
                end;


                FOSA.Reset();
                FOSA.SetRange("Member No.", Members."No.");
                //FOSA.SetFilter("Transactional Mobile No", '<>%1', '');
                FOSA.SetRange("Product Category", FOSA."Product Category"::"Ordinary Savings");
                if FOSA.FindFirst() then begin

                    phoneNo := Spotcash.ConvertPhoneNo(phoneNo);
                    sky.GetDividendLoanQualifiedAmount(FOSA."No.", eLoanCode, QualAmt, Remark);

                    LoanProduct.Get(eLoanCode);

                    /*
                    Loans.RESET;
                    Loans.SETRANGE("Member No.", FOSA."Member No.");
                    Loans.SETRANGE("Mobile Loan", false);
                    Loans.SETFILTER("Outstanding Principal", '>0');
                    IF Loans.FindSet() THEN
                        repeat
                            //if LoanType."Maximum No. of Loans" > 0 then begin
                            InterestArrears := 0;
                            DefAmount := 0;
                            AsAt := CALCDATE('-1M+CM', Today);

                            SaccoActivitties.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true);

                            InterestArrears := SaccoActivitties.GetInterestArrears(Loans."Loan No.", CalcDate('-1M+CM', Today));

                            TotalArrears += DefAmount + InterestArrears;

                        until Loans.Next() = 0;
                    

                    if QualAmt > TotalArrears then begin
                        MaxQualAmt := ROUND((QualAmt) * (LoanProduct."Interest Rate (Max.)" / 1200), 1, '>');
                        QualAmt := TotalArrears + MaxQualAmt;
                    end;
                    */


                    if QualAmt > 0 then begin

                        JTemplate := 'GENERAL';
                        JBatch := 'MBANKING';
                        LoanAmount := QualAmt - MaxQualAmt;

                        GenJournalBatch.Reset;
                        GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                        GenJournalBatch.SetRange(Name, JBatch);
                        if not GenJournalBatch.FindFirst then begin
                            GenJournalBatch.Init;
                            GenJournalBatch."Journal Template Name" := JTemplate;
                            GenJournalBatch.Name := JBatch;
                            GenJournalBatch.Description := 'Mbanking Batch';
                            GenJournalBatch.Insert;
                        end;


                        SaccoTrans.JournalInit(JTemplate, JBatch);
                        SaccoFee := 0;
                        SMSCharge := 0;

                        SpotSetup.RESET;
                        SpotSetup.SETRANGE("Transaction Type", SpotSetup."Transaction Type"::"Loan Disbursement");
                        IF SpotSetup.FINDFIRST THEN BEGIN

                            SMSAccount := SpotSetup."SMS Account";
                            SMSCharge := 0;//SpotSetup."SMS Charge";


                            SaccoAccount := SpotSetup."Sacco Fee Account";
                            SaccoFee := 0;//SpotSetup."Sacco Fee";

                            VendorAccount := SpotSetup."Bank Account";
                            VendorCommission := 0;//SpotSetup."Vendor Commission";
                            VendorBalAcc := SpotSetup."Non-Member Debit Account";

                            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
                            ExciseDuty := 0;//ROUND((SaccoFee)*ExciseDutyRate/100);
                        END
                        ELSE BEGIN
                            ERROR('Setup Missing for %1', CoopSetup."Transaction Type"::"Loan Disbursement");
                        END;

                        /*LoanProduct.Get(eLoanCode);

                        Loans.Init;
                        Loans."Mobile Loan" := true;
                        Loans."Loan No." := '';
                        Loans.Source := LoanProduct."Loan Source";
                        Loans."Application Date" := Today;
                        Loans."Loan Product Type" := LoanProduct."Product ID";
                        Loans."Loan Product Type Name" := LoanProduct.Description;
                        Loans.Validate("Member No.", Members."No.");
                        Loans."Disbursement Account No" := FOSA."No.";
                        Loans."Member Name" := Members.Name;
                        Loans."Requested Amount" := LoanAmount;
                        Loans."Approved Amount" := LoanAmount;
                        Loans.Status := Loans."status"::Approved;
                        Loans.Installments := LoanProduct."Default Installments";
                        Loans."Repayment Frequency" := LoanProduct."Repayment Frequency";
                        Loans."Annual Interest %" := LoanProduct."Interest Rate (Max.)";
                        Loans."Sub-Sector Level 2 Code" := '8310';

                        Loans."Interest Calculation Method" := LoanProduct."Interest Calculation Method";

                        Loans."Mode of Disbursement" := Loans."mode of disbursement"::"Transfer to FOSA";
                        Loans."Global Dimension 1 Code" := 'FOSA';

                        if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                            Loans.TestField(Loans.Installments);
                            Loans.Repayment := ROUND((Loans."Annual Interest %" / 12 / 100) / (1 - Power((1 + (Loans."Annual Interest %" / 12 / 100)), -Loans.Installments)) * Loans."Approved Amount");
                            Loans."Loan Interest Repayment" := Loans."Approved Amount" / 100 * Loans."Annual Interest %";
                            Loans."Loan Principle Repayment" := Loans.Repayment - Loans."Loan Interest Repayment";
                        end;

                        if (Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line") then begin
                            //POLICETESTFIELD(Interest);
                            Loans.TestField(Installments);
                            Loans."Loan Principle Repayment" := ROUND(Loans."Approved Amount" / Loans.Installments, 0.05, '>');//LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');

                            Loans."Loan Interest Repayment" := (Loans."Annual Interest %" / 12 / 100) * LoanAmount;
                            Loans.Repayment := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                        end;


                        if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                            Loans.TestField("Annual Interest %");
                            Loans.TestField(Installments);
                            Loans."Loan Principle Repayment" := ROUND(Loans."Approved Amount" / Loans.Installments, 0.05, '>');//LoanAmount/RepayPeriod;
                            Loans."Loan Interest Repayment" := (Loans."Annual Interest %" / 12 / 100) * Loans."Approved Amount";
                            Loans.Repayment := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                            Loans.Repayment := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                            Loans."Adjusted Repayment" := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                        end;

                        Loans."Repay Mode" := LoanProduct."Repay Mode";

                        Loans."Staff No" := Members."Payroll/Staff No.";//FOSA."Staff No" ;
                        Loans."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                        Loans."Booking Branch" := Members."Global Dimension 2 Code";
                        Loans."Employer Code" := Members."Employer Code";
                        Loans."ID NO." := Members."ID No.";

                        Loans.Posted := false;
                        Loans."Disbursement Date" := Today;
                        Loans."Repayment Start Date" := CalcDate('1M', Loans."Disbursement Date");

                        Loans."Completion Date" := CalcDate(Format(Loans.Installments) + 'M', Loans."Disbursement Date");

                        FosaAcc.get(Loans."Disbursement Account No");
                        if FosaAcc."Salary Processing" then
                            Loans."Repay Mode" := Loans."Repay Mode"::Cash;

                            
                        //Loans.GetTSCcodes;
                        // if Loans."Approved Amount" > 0 then begin
                        Loans.Insert(true);

                        LoanNo := Loans."Loan No.";

                        SaccoActivitties.GenerateRepaymentSchedule(Loans);
                        RepAmt := Loans.Repayment;

                        RunningAmount := 0;
                        Loans.Reset;
                        Loans.SetRange("Loan No.", LoanNo);
                        Loans.SetRange("Loan Product Type", LoanProduct."Product ID");
                        if Loans.FindFirst then begin*/

                        //Loans."Loan Account" := SaccoActivities.CreateCreditAccount(Loans);
                        //UpfrontInterest := Loans."Loan Interest Repayment";
                        LoanProduct.Get(eLoanCode);
                        DocNo := 'DIV ADVANCE';

                        Dim1 := FOSA."Global Dimension 1 Code";
                        Dim2 := FOSA."Global Dimension 2 Code";

                        //AccNo := Loans."Disbursement Account No";
                        ExtDoc := Loans."Loan No.";
                        LoanNo := Loans."Loan No.";
                        //TransType := Transtype::"Loan Disbursement";
                        SystCreated := true;

                        //RunningAmount := Loans."Approved Amount";
                        SaccoTrans.JournalInit(JTemplate, JBatch);

                        GenSetup.Get;
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", LoanProduct."Loan Account [G/L]", CopyStr('Dividend Advance Disbursement: ' + Members."No.", 1, 50), Balacctype::"G/L Account",
                                      '', QualAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, DivAcc, CopyStr('Dividend Advance Disbursement: ' + Members."No.", 1, 50), Balacctype::"G/L Account",
                                      '', -QualAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                        /* SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(LoanProduct.Description + ' Disbursement', 1, 50), Balacctype::"G/L Account",
                                       '', Loans."Approved Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(LoanProduct.Description + ' Disbursement', 1, 50), Balacctype::"G/L Account",
                                       '', -Loans."Approved Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                         ExciseDuty := ROUND(((GenSetup."Excise Duty (%)" / 100) * SaccoFee), 1, '>');
                         ExciseDutyGL := GenSetup."Excise Duty GL";

                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(LoanProduct.Description + ' Fee', 1, 50), Balacctype::"G/L Account",
                                       '', VendorCommission + SaccoFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ' + LoanProduct.Description, 1, 50), Balacctype::"G/L Account",
                                       '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());


                         //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",LoanProduct."Loan Interest Account",COPYSTR(LoanProduct.Description+' Commission',1,50),BalAccType::"G/L Account",
                         //            '',-UpfrontInterest,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,Loans."Member Name");
                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(LoanProduct.Description + ' Fee', 1, 50), Balacctype::"G/L Account",
                                       '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());



                         AccNo := VendorAccount;
                         ExtDoc := Loans."Disbursement Account No";
                         LoanNo := '';
                         TransType := Transtype::" ";

                         AcctType := Accttype::"Bank Account";

                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype, VendorAccount, CopyStr(LoanProduct.Description + ' Disbursement Commission', 1, 50), Balacctype::"G/L Account",
                                       '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                         /*RunningAmount -= ROUND((Loans."Approved Amount") * (Loans."Annual Interest %" / 1200), 1, '>');

                         if Loans."Loan Product Type" = 'L43' then
                             ClearOldest := true;

                         SelfPresent := false;
                         IF ClearOldest THEN BEGIN

                             OldLoans.Reset;
                             OldLoans.SetRange("Member No.", Loans."Member No.");
                             OldLoans.SetRange(Posted, true);
                             OldLoans.SetRange("Mobile Loan", false);
                             OldLoans.SetFilter("Outstanding Principal", '>0');
                             if OldLoans.FindFirst then begin //to be uncommented later when needed
                                 repeat

                                     SelfPresent := true;
                                     DefAmount := 0;
                                     AmtPaid := 0;
                                     ExpectedAmt := 0;

                                     AsAt := CALCDATE('-1M+CM', Today);

                                     SaccoActivitties.GetDefaultedAmount(oldLoans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true);

                                     if DefAmount > RunningAmount then
                                         DefAmount := RunningAmount;


                                     LoanNo := OldLoans."Loan No.";

                                     SystCreated := true;
                                     //Principle top up clearance
                                     SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr('Principle Arrear ' + OldLoans."loan no.", 1, 50), Balacctype::"G/L Account",
                                               '', DefAmount, ExtDoc, LoanNo, Transtype::" ", Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                                     SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, OldLoans."Loan Account", CopyStr('Principle Arrear ' + OldLoans."loan no.", 1, 50), Balacctype::"G/L Account",
                                                   '', -DefAmount, ExtDoc, LoanNo, Transtype::"Principal Repayment", Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                                     RunningAmount -= DefAmount;

                                 until OldLoans.Next = 0;

                             end;

                             OldLoans.Reset;
                             OldLoans.SetRange("Member No.", Loans."Member No.");
                             OldLoans.SetRange(Posted, true);
                             OldLoans.SetRange("Mobile Loan", false);
                             OldLoans.SetFilter("Outstanding Interest", '>0');
                             if OldLoans.FindFirst() then begin //to be uncommented later when needed
                                 repeat

                                     if RunningAmount > 0 then begin
                                         InterestArrears := 0;

                                         AsAt := CALCDATE('-1M+CM', Today);

                                         InterestArrears := SaccoActivitties.GetInterestArrears(oldLoans."Loan No.", CalcDate('-1M+CM', Today));

                                         if InterestArrears > RunningAmount then
                                             InterestArrears := RunningAmount;


                                         LoanNo := OldLoans."Loan No.";

                                         SystCreated := true;
                                         //Principle top up clearance
                                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr('Interest Arrear ' + OldLoans."loan no.", 1, 50), Balacctype::"G/L Account",
                                                   '', InterestArrears, ExtDoc, LoanNo, Transtype::" ", Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, OldLoans."Loan Account", CopyStr('Interest Arrear ' + OldLoans."loan no.", 1, 50), Balacctype::"G/L Account",
                                                       '', -InterestArrears, ExtDoc, LoanNo, Transtype::"Interest Paid", Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                                         RunningAmount -= InterestArrears;
                                     end;

                                 until OldLoans.Next = 0;

                             end;

                         end;

                         IntDue := ROUND((Loans."Approved Amount") * (Loans."Annual Interest %" / 1200), 1, '>');

                         ExtDoc := OldLoans."Loan No.";
                         if LoanProduct."Charge Upfront Interest" then
                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(LoanProduct.Description + ' Interest Due', 1, 50), Balacctype::"G/L Account",
                                       LoanProduct."Loan Interest Income [G/L]", IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Due", Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());



                         if LoanProduct."Interest Recovered Upfront" then begin


                             if not LoanProduct."Charge Upfront Interest" then
                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(LoanProduct.Description + ' Interest Due', 1, 50), Balacctype::"G/L Account",
                                       LoanProduct."Loan Interest Income [G/L]", IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Due", Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                             ExtDoc := '';
                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(LoanProduct.Description + ' Interest Paid', 1, 50), Balacctype::"G/L Account",
                                       '', -IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Paid", Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());
                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr(LoanProduct.Description + ' Interest Paid', 1, 50), Balacctype::"G/L Account",
                                       '', IntDue, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, Sky.GetUserDimensionSet());

                         end;


                         Loans.Posted := true;
                         Loans.Modify;


                         if LoanProduct."USSD Product Name" = '' then
                             LoanProduct."USSD Product Name" := LoanProduct.Description;
                             */




                        SaccoTrans.JournalPost(JTemplate, JBatch);

                        /*RepAmt := Loans.Repayment;
                        Loans.CalcFields("Total Outstanding Balance");
                        if Loans.Installments = 1 then
                            RepAmt := Loans."Total Outstanding Balance";
                            */


                        //end;
                        //end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if PDate = 0D then
                    Error('Posting Date is required');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PDate; PDate)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        Sky: Codeunit "Sky MBanking";
        Spotcash: Codeunit "SpotCash Mbanking";
        FOSA: Record "Savings Accounts";
        FosaAcc: Record "Savings Accounts";
        SaccoActivitties: Codeunit "Sacco Activities";
        Channel: Enum "Transaction Channel";
        PDate: Date;
}
