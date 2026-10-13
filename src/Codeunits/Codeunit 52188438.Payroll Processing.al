
Codeunit 50082 "Payroll Processing"
{

    trigger OnRun()
    begin
    end;

    var
        PayrollCodes: Record "Payroll Codes";
        PayrollPeriods: Record "Payroll Periods";
        PeriodTrans: Record "Payroll Period Transactions";
        BankRemit: Record "Payroll Bank Remittance";
        RemitAcc: Record "Payroll Remittance Accounts";
        VarGrouping: Option " ","Basic Salary",Allowances,"Gross Salary","Tax Calculations",Statutories,Deductions,"Net Salary","Housing Levy","Housing Levy Levy",Fringe;
        VarSubGroup: Option " ",BasicPay,"BasicPay Arrears","Defined Contribution","Tax Relief","Insurance Relief","Taxable Pay","Tax Charged",NSSF,NHIF,PAYE,"PAYE Arrears","Pension Relief","Owner Occupier","Home Ownership","Non-Taxable","Housing Levy","Housing Levy Relief";
        EntryType: Option " ",Employer,Employee;
        salariesAcc: Code[20];
        TaxAccount: Code[20];
        LoanNo: Code[20];
        SalaryArrears: Record "Payroll Arrears";
        DaysWorked: Integer;
        CountDaysofMonth: Integer;
        curReliefPersonal: Decimal;
        CurReliefNHIF: Decimal;
        "CurReliefHousingLevy%": Decimal;
        curNHIFReliefAmount: Decimal;
        curReliefInsurance: Decimal;
        curMaxPensionContrib: Decimal;
        curMaxInsuranceRelief: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curReliefMorgage: Decimal;
        BenifitAmount: Decimal;
        curMaximumRelief: Decimal;
        currMinRelief: Decimal;
        curGlobalGross: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        intNSSF_BasedOn: Option Gross,Basic;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        Prsalary: Record "Staff Payroll Details";
        RatesCeilings: Record "Payroll Rates";
        curDisabledLimit: Decimal;
        PostingGroup: Record "Payroll Posting Group";
        PayablesAcc: Code[10];
        NitaAccount: Code[10];
        NSSFTier2Account: Code[10];
        FringePayable: Code[10];
        FringeExpense: Code[10];
        TotalGrossPay: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";



    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record PAYE;
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;
        prPAYE.Reset;
        if prPAYE.FindFirst then begin
            if curTaxablePay >= prPAYE."PAYE Tier" then begin

                repeat
                    KeepCount += 1;
                    curTempAmount := curTaxablePay;
                    if curTaxablePay > 0 then begin

                        if KeepCount = prPAYE.Count then   //this is the last record or loop
                            curTaxablePay := curTempAmount
                        else
                            if curTempAmount >= prPAYE."PAYE Tier" then
                                curTempAmount := prPAYE."PAYE Tier"
                            else
                                curTempAmount := curTempAmount;

                        //MESSAGE('curTempAmount %1',curTempAmount);
                        PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                        curTaxablePay := curTaxablePay - curTempAmount;
                    end;

                until prPAYE.Next = 0;
            end;
        end;

        //MESSAGE('curTempAmount %1',PAYE);
    end;


    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record NHIF;
    begin
        prNHIF.Reset;
        prNHIF.SetCurrentkey(prNHIF."Tier Code");
        if prNHIF.FindFirst then begin
            repeat
                if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then begin
                    NHIF := prNHIF.Amount;
                end;
            until prNHIF.Next = 0;
        end;
    end;

    procedure fnGetEmployeeNSSF(curBaseAmount: Decimal; var NSSFEmployeeTier1: Decimal; var NSSFEmployeeTier2: Decimal; var NSSFEmployerTier1: Decimal; var NSSFEmployerTier2: Decimal)
    var
        prNSSF: Record NSSF;
        contributionAmount: Decimal;
        effectiveGross: Decimal;
    begin
        NSSFEmployeeTier1 := 0;
        NSSFEmployeeTier2 := 0;
        NSSFEmployerTier1 := 0;
        NSSFEmployerTier2 := 0;

        effectiveGross := curBaseAmount;



        prNSSF.Reset();
        prNSSF.SetCurrentKey("Tier Code");
        if prNSSF.FindSet() then begin
            repeat
                // Only process if income falls within or above the lower bound
                if effectiveGross >= prNSSF."Lower Limit" then begin

                    // Calculate contribution range for current tier
                    if effectiveGross > prNSSF."Upper Limit" then
                        contributionAmount := prNSSF."Upper Limit" - prNSSF."Lower Limit"
                    else
                        contributionAmount := effectiveGross - prNSSF."Lower Limit";

                    // Skip negative or zero contributions
                    if contributionAmount <= 0 then
                        exit;

                    // Apply either percentage or fixed amounts based on setup
                    if prNSSF."Use Percentage" then begin
                        prNSSF.TestField("% Amount");
                        if prNSSF."Tier Code" = '1' then begin
                            NSSFEmployeeTier1 := Round((prNSSF."% Amount" / 100) * contributionAmount, 0.05, '>');
                            NSSFEmployerTier1 := Round((prNSSF."% Amount" / 100) * contributionAmount, 0.05, '>');
                        end else begin
                            NSSFEmployeeTier2 := Round((prNSSF."% Amount" / 100) * contributionAmount, 0.05, '>');
                            NSSFEmployerTier2 := Round((prNSSF."% Amount" / 100) * contributionAmount, 0.05, '>');
                        end;
                    end else begin
                        if prNSSF."Tier Code" = '1' then begin
                            NSSFEmployeeTier1 := prNSSF."Employee Amount";
                            NSSFEmployerTier1 := prNSSF."Employer Amount";
                        end else begin
                            NSSFEmployeeTier2 := prNSSF."Employee Amount";
                            NSSFEmployerTier2 := prNSSF."Employer Amount";
                        end;
                    end;
                    NSSFEmployeeTier1 := Round(NSSFEmployeeTier1, 0.05, '>');
                    NSSFEmployeeTier2 := Round(NSSFEmployeeTier2, 0.05, '>');
                end;
            until prNSSF.Next() = 0;
        end;
    end;

    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option "None","Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Fringe Benefit",Mortgage,"Salary Arrears","Staff Loan","Education Insurance"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        strExtractedFrml: Text[250];
        MortgageInterest: Decimal;
        MortgageRelief: Decimal;
        EmployeeTrans: Record "Payroll Employee Transactions";
        PayrollCodes: Record "Payroll Codes";
        Loans: Record Loans;
    begin


        SpecialTransAmount := 0;
        PayrollCodes.Reset;
        PayrollCodes.SetRange(PayrollCodes."Special Transactions", intSpecTransID);
        if PayrollCodes.Find('-') then begin
            repeat

                EmployeeTrans.Reset;
                EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
                EmployeeTrans.SetRange(EmployeeTrans."Transaction Code", PayrollCodes."Transaction Code");
                EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
                EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
                EmployeeTrans.SetRange(EmployeeTrans.Stopped, false);
                if EmployeeTrans.Find('-') then begin

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            begin

                                if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                                    SpecialTransAmount := SpecialTransAmount + ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the calculated amount
                                                                                                                                    //error('%1',curTransAmount);
                                end
                                else
                                    if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                                        SpecialTransAmount += PayrollCodes."Standard Amount"
                                    else
                                        SpecialTransAmount += EmployeeTrans.Amount;
                            end;
                        Intspectransid::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * EmployeeTrans.Amount);
                        Intspectransid::"Education Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * EmployeeTrans.Amount);
                        Intspectransid::"Owner Occupier Interest":
                            begin
                                SpecialTransAmount := SpecialTransAmount + EmployeeTrans.Amount;

                                Loans.RESET;
                                Loans.SETRANGE("Member No.", EmployeeTrans."Member No.");
                                Loans.SETRANGE("Loan Product Type", PayrollCodes."Product Type");
                                Loans.SETFILTER("Outstanding Principal", '>0');
                                Loans.SETAUTOCALCFIELDS("Outstanding Interest");
                                IF Loans.FindLast() THEN
                                    SpecialTransAmount := Loans."Outstanding Interest";

                                SpecialTransAmount := SpecialTransAmount;

                            end;
                        Intspectransid::"Home Ownership Savings Plan":
                            SpecialTransAmount := SpecialTransAmount + EmployeeTrans.Amount;

                    end;
                end;
            until PayrollCodes.Next = 0;
        end;
    end;

    procedure fnGetSpecialTransAmountOwner(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option "None","Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Fringe Benefit",Mortgage,"Salary Arrears","Staff Loan","Education Insurance"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        strExtractedFrml: Text[250];
        MortgageInterest: Decimal;
        MortgageRelief: Decimal;
        EmployeeTrans: Record "Payroll Employee Transactions";
        PayrollCodes: Record "Payroll Codes";
        Loans: Record Loans;
    begin


        SpecialTransAmount := 0;
        PayrollCodes.Reset;
        PayrollCodes.SetRange(PayrollCodes."Special Transactions", intSpecTransID);
        if PayrollCodes.Find('-') then begin
            repeat

                /* EmployeeTrans.Reset;
                EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
                EmployeeTrans.SetRange(EmployeeTrans."Transaction Code", PayrollCodes."Transaction Code");
                EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
                EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
                EmployeeTrans.SetRange(EmployeeTrans.Stopped, false);
                if EmployeeTrans.Find('-') then begin */

                //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                EmployeeTrans.Reset();
                EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
                if EmployeeTrans.FindFirst() then;

                case intSpecTransID of
                    Intspectransid::"Defined Contribution":
                        begin

                            if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                                SpecialTransAmount := SpecialTransAmount + ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the calculated amount
                                                                                                                                //error('%1',curTransAmount);
                            end
                            else
                                if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                                    SpecialTransAmount += PayrollCodes."Standard Amount"
                                else
                                    SpecialTransAmount += EmployeeTrans.Amount;
                        end;
                    Intspectransid::"Life Insurance":
                        SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * EmployeeTrans.Amount);
                    Intspectransid::"Education Insurance":
                        SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * EmployeeTrans.Amount);
                    Intspectransid::"Owner Occupier Interest":
                        begin

                            Loans.RESET;
                            Loans.SETRANGE("Member No.", EmployeeTrans."Member No.");
                            Loans.SETRANGE("Loan Product Type", PayrollCodes."Sub-Ledger Product Type");
                            Loans.SETFILTER("Outstanding Principal", '>0');
                            Loans.SETAUTOCALCFIELDS("Outstanding Interest");
                            IF Loans.FINDFIRST THEN
                                SpecialTransAmount := Loans."Outstanding Interest";

                            SpecialTransAmount := SpecialTransAmount;

                        end;
                    Intspectransid::"Home Ownership Savings Plan":
                        SpecialTransAmount := SpecialTransAmount + EmployeeTrans.Amount;

                end;
            //end;
            until PayrollCodes.Next = 0;
        end;
    end;

    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit "Account Schedule Management";
    begin
        Results := AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;


    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        salCard: Record "Staff Payroll Details";
        EmployeeTrans: Record "Payroll Employee Transactions";
    begin


        if strTransCode = 'BPAY' then begin
            salCard.Reset;
            salCard.SetRange(salCard."Employee Code", strEmpCode);
            if salCard.Find('-') then begin
                TransAmount := salCard."Basic Pay";
            end;
        end;

        if strTransCode = 'GPAY' then begin
            salCard.Reset;
            salCard.SetRange(salCard."Employee Code", strEmpCode);
            if salCard.Find('-') then begin
                TransAmount := TotalGrossPay;
            end;
        end;

        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
        EmployeeTrans.SetRange(EmployeeTrans."Transaction Code", strTransCode);
        EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
        EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
        EmployeeTrans.SetRange(EmployeeTrans.Stopped, false); //Added DW to not process Stopped Transactions
        if EmployeeTrans.FindFirst then
            TransAmount := EmployeeTrans.Amount;

    end;



    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then
                StartCopy := true;

            if StartCopy then
                TransCode := TransCode + Char;

            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;

            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);

                //Get TransCodeAmount
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;

    procedure fnPureFormulaIrregularIncome(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]; PayCode: Code[20]; SelectedPeriod: Date) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        IrregularAmt: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
        EmployeeTranss: Record "Payroll Employee Transactions";
        PayrollCodess: Record "Payroll Codes";
    begin
        TransCode := '';


        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then
                StartCopy := true;

            if StartCopy then
                TransCode := TransCode + Char;

            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;

            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);

                //Get TransCodeAmount
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;


    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; VarGrouping: Option " ","Basic Salary",Allowances,"Gross Salary","Tax Calculations",Statutories,Deductions,"Net Salary","Housing Levy","Housing Levy Levy",Fringe; VarSubGroup: Option " ",BasicPay,"BasicPay Arrears","Defined Contribution","Tax Relief","Insurance Relief","Taxable Pay","Tax Charged",NSSF,NHIF,PAYE,"PAYE Arrears","Pension Relief","Owner Occupier","Home Ownership","Non-Taxable"; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; dtOpenPeriod: Date; JournalAC: Code[20]; JournalACType: Enum "Gen. Journal Account Type"; LoanNo: Code[20]; PostAs: Option " ",Debit,Credit; EntryType: Option " ",Employer,Employee; ReferenceNo: Integer)
    var
        NetAmt: Decimal;
        RunBal: Decimal;
        PTrans: Record "Payroll Period Transactions";
        PCodes: Record "Payroll Codes";
        EmpTrans: record "Payroll Employee Transactions";
        SaccoActivitie: Codeunit "Sacco Activities";
    begin

        if curAmount <> 0 then begin


            if VarGrouping = Vargrouping::"Net Salary" then begin
                BankRemit.Reset;
                BankRemit.SetRange("Staff No.", EmpCode);
                BankRemit.SetRange("Payroll Period", dtOpenPeriod);
                if BankRemit.FindFirst then
                    BankRemit.DeleteAll;

                RemitAcc.Reset;
                RemitAcc.SetRange(RemitAcc."Employee Code", EmpCode);
                if RemitAcc.Find('-') then begin
                    RunBal := curAmount;
                    repeat

                        if RemitAcc.Count = 1 then
                            RemitAcc."Percentage to Transfer" := 100;

                        if RemitAcc."Payment to" = RemitAcc."payment to"::Bank then begin
                            RemitAcc.TestField(RemitAcc."Bank  Code");
                            RemitAcc.TestField(RemitAcc."Branch Code");
                            RemitAcc.TestField(RemitAcc."A/C  Number");
                            RemitAcc.TestField(RemitAcc."Percentage to Transfer");
                        end;


                        if RemitAcc."Payment to" = RemitAcc."payment to"::Sacco then begin
                            RemitAcc.TestField(RemitAcc."Sacco Account");
                            RemitAcc.TestField(RemitAcc."Percentage to Transfer");
                        end;

                        RemitAcc.CalcFields("Total % Allocation");
                        if RemitAcc."Total % Allocation" <> 100 then
                            Error('Remittance Allocation for Employee No. %1 Must be 100%', EmpCode);


                        if RunBal > 0 then begin
                            NetAmt := ROUND((curAmount * RemitAcc."Percentage to Transfer" / 100), 0.05, '>');
                            if NetAmt > RunBal then
                                NetAmt := RunBal;
                            RunBal -= NetAmt;

                            BankRemit.Init;
                            BankRemit."Bank Code" := RemitAcc."Bank  Code";
                            BankRemit."Branch Code" := RemitAcc."Branch Code";
                            BankRemit."Payroll Period" := dtOpenPeriod;
                            BankRemit.Amount := NetAmt;
                            BankRemit."Transaction Code" := TCode;
                            BankRemit."Staff No." := EmpCode;
                            BankRemit."Bank Name" := UpperCase(RemitAcc."Bank Name");
                            BankRemit."Branch Name" := UpperCase(RemitAcc."Branch Name");
                            BankRemit."A/C  Number" := RemitAcc."A/C  Number";
                            BankRemit."Sacco Account" := RemitAcc."Sacco Account";
                            BankRemit."Payment to" := RemitAcc."Payment to";
                            BankRemit."% Net PAY" := RemitAcc."Percentage to Transfer";
                            if BankRemit.Amount > 0 then
                                BankRemit.Insert;
                        end;

                    until RemitAcc.Next = 0;
                end
                else begin
                    //     ERROR('No Bank A/C has been specified for [Employee No %1]',EmpCode);
                end;
            end;
            PCodes.Reset;
            if PCodes.Get(TCode) then;

            PTrans.Init;
            PTrans."Payroll Code Type" := PCodes."Transaction Type";
            PTrans."Sacco Transaction Type" := PCodes."Sacco Transaction Type";
            if PCodes."Special Transactions" = PCodes."special transactions"::"Staff Loan" then begin
                if ReferenceNo = 0 then
                    PTrans."Sacco Transaction Type" := PTrans."sacco transaction type"::"Principal Repayment";
                if ReferenceNo = 1 then
                    PTrans."Sacco Transaction Type" := PTrans."sacco transaction type"::"Interest Paid";
                if ReferenceNo = 2 then
                    PTrans."Sacco Transaction Type" := PTrans."Sacco Transaction Type"::"Insurance Paid";
            end;

            PTrans."Employee Code" := EmpCode;
            PTrans."Entry Type" := EntryType;
            PTrans."Transaction Code" := TCode;
            PTrans.Grouping := VarGrouping;
            PTrans."Sub Group" := VarSubGroup;
            PTrans."Transaction Name" := Description;
            PTrans.Amount := Round(curAmount, 0.05, '>');
            PTrans.Balance := curBalance;
            PTrans."Period Month" := Month;
            PTrans."Period Year" := Year;
            PTrans."Payroll Period" := dtOpenPeriod;
            PTrans."Account Type" := JournalACType;
            PTrans."Post As" := PostAs;
            PTrans."Account No." := JournalAC;
            PTrans."Loan No." := LoanNo;

            if PTrans."Sub Group" = PTrans."sub group"::BasicPay then
                PTrans."Payroll Code Type" := PTrans."payroll code type"::Earning;
            if PTrans."Sub Group" = PTrans."sub group"::"BasicPay Arrears" then
                PTrans."Payroll Code Type" := PTrans."payroll code type"::Earning;
            if PTrans."Sub Group" = PTrans."sub group"::PAYE then
                PTrans."Payroll Code Type" := PTrans."payroll code type"::PAYE;
            if PTrans."Sub Group" = PTrans."sub group"::"PAYE Arrears" then
                PTrans."Payroll Code Type" := PTrans."payroll code type"::Deduction;

            PTrans."Reference No" := ReferenceNo;

            PTrans."Payslip Sort Order" := 10;
            if PCodes."Sort Order" > 0 then
                PTrans."Payslip Sort Order" := PCodes."Sort Order";

            if PTrans."Sub Group" = PTrans."sub group"::"Tax Relief" then
                PTrans."Payslip Sort Order" := 100;

            if PTrans."Sub Group" = PTrans."sub group"::PAYE then
                PTrans."Payslip Sort Order" := 1;

            PTrans."Group Order" := PCodes."Group Order";

            if TCode = 'TOT-DED' then
                PTrans."Payslip Sort Order" := 200;

            case TCode of
                'TXBP', 'TXCHRG', 'PSNR', 'PENR', 'OOI':
                    PTrans."Group Order" := 4; //ez
            end;

            if PTrans."Transaction Name" = 'NSSF Tier 1' then
                PTrans."Group Order" := 4;

            PTrans.Insert;


            //Update Housing Levy Amount
            if TCode = 'HLEVY' then begin
                EmpTrans.Reset();
                EmpTrans.SetRange("Employee Code", EmpCode);
                EmpTrans.SetRange("Payroll Period", dtOpenPeriod);
                EmpTrans.SetRange("Transaction Code", TCode);
                if EmpTrans.FindFirst() then begin
                    EmpTrans.Amount := curAmount;
                    EmpTrans."Employer Amount" := curAmount;
                    EmpTrans.Modify();
                end;

            end;




        end;
    end;


    procedure Processpayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; StopEmployerPension: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; blnInsuranceCertificate: Boolean; ManualInsuranceRelief: Decimal)
    var
        EmployeeTrans: Record "Payroll Employee Transactions";
        strTableName: Text[50];
        curTransAmount: Decimal;
        Transcode: record "payroll codes";
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;

        NSSFEmployeeTier1: Decimal;
        NSSFEmployeeTier2: Decimal;
        NSSFEmployerTier1: Decimal;
        NSSFEmployerTier2: Decimal;

        IrregularAmt: Decimal;

        curHousing: Decimal;
        curNSSFEmployer: Decimal;
        curHousingEmployer: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        curHousingLevyRelief: Decimal;
        curSelftDefinedPension: Decimal;
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        SalaryArrears: Record "Payroll Arrears";
        strExtractedFrml: Text[250];
        SpecialTransType: Option "None","Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Fringe Benefit",Mortgage,"Salary Arrears","Staff Loan";
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curSHA: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        salCard: Record "Staff Payroll Details";
        curBPAYBal: Decimal;
        curPensionReliefAmount: Decimal;
        curIncludeinNet: Decimal;
        JournalPostAs: Option " ",Debit,Credit;
        JournalPostingType: Enum "Gen. Journal Account Type";
        JournalAc: Code[20];
        Customer: Record Customer;
        curIncludeGross: Decimal;
        IsCashbenefit: Decimal;
        curNssf_Base_Amount: Decimal;
        Vendor: Record "Savings Accounts";
        HREmployes: Record Employee;
        EmpRec: Record Employee;
        TotalSalaryArrears: Decimal;
        TotalPAYEArrears: Decimal;
        HREmp2: Record Employee;
        Members: Record Members;
        Loans: Record Loans;
        IntAmt: Decimal;
        InsAmt: Decimal;
        MemberAccounts: Record "Savings Accounts";
        MNo: Code[20];
        LSchedule: Record "Loan Repayment Schedule";

        EmployeeTranss: Record "Payroll Employee Transactions";
        PayrollCodess: Record "Payroll Codes";

        LoanType: Record "Product Setup";
    begin
        dtOpenPeriod := 0D;
        DaysWorked := 0;
        CountDaysofMonth := 0;

        PayrollPeriods.Reset;
        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
        if PayrollPeriods.Find('-') then begin
            dtOpenPeriod := PayrollPeriods."Date Opened";
            intMonth := Date2dmy(dtOpenPeriod, 2); //GET THE MONTH
            intYear := Date2dmy(dtOpenPeriod, 3);  //GET THE YEAR
        end
        else begin
            Error('There is no open payroll period');
        end;



        //Initialize
        fnInitialize;

        //Get Payroll Posting Accountss
        ConfirmPostingGroupSetup(strEmpCode);


        //check if the period selected=current period. If not, do NOT run this function
        if SelectedPeriod <> dtOpenPeriod then exit;
        intMonth := Date2dmy(SelectedPeriod, 2);
        intYear := Date2dmy(SelectedPeriod, 3);

        //Delete all Records from the prPeriod Transactions for Reprocessing

        PeriodTrans.Reset;
        PeriodTrans.SetRange(PeriodTrans."Employee Code", strEmpCode);
        PeriodTrans.SetRange(PeriodTrans."Payroll Period", dtOpenPeriod);
        if PeriodTrans.Find('-') then
            PeriodTrans.DeleteAll;



        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
        EmployeeTrans.setrange("Member No.", '');
        if EmployeeTrans.Find('-') then begin
            repeat
                if EmployeeTrans."Member No." = '' then begin
                    EmpRec.Get(strEmpCode);
                    EmpRec.testfield("Member No");
                    EmployeeTrans."Member No." := EmpRec."Member No";
                    EmployeeTrans.Modify();
                    Commit();
                end;
            until EmployeeTrans.Next() = 0;
        end;

        curSelftDefinedPension := 0;
        salCard.Get(strEmpCode);
        curSelftDefinedPension := salCard."Defined Pension";

        //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
        if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
            CountDaysofMonth := Date2dmy(CalcDate('CM', dtOpenPeriod), 1);
            DaysWorked := CountDaysofMonth - Date2dmy(dtDOE, 1) + 1;
            curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
        end;

        //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
        if dtTermination <> 0D then begin
            if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                CountDaysofMonth := Date2dmy(CalcDate('CM', dtOpenPeriod), 1);
                DaysWorked := Date2dmy(dtTermination, 1);
                curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
            end;
        end;



        PayrollCodes.Reset;
        PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::"Basic Pay");
        if PayrollCodes.Find('-') then begin

            curTransAmount := curBasicPay;
            curTransBalance := 0;
            JournalAc := PayrollCodes."GL Account";
            strTransDescription := 'Basic Pay';
            LoanNo := '';
            fnUpdatePeriodTrans(
                strEmpCode, 'BPAY', Vargrouping::"Basic Salary", Varsubgroup::BasicPay, strTransDescription, curTransAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);





            TotalSalaryArrears := 0;
            TotalPAYEArrears := 0;

            //Salary Arrears
            SalaryArrears.Reset;
            SalaryArrears.SetRange(SalaryArrears."Employee Code", strEmpCode);
            SalaryArrears.SetRange(SalaryArrears."Period Month", intMonth);
            SalaryArrears.SetRange(SalaryArrears."Period Year", intYear);
            if SalaryArrears.Find('-') then begin
                repeat

                    curSalaryArrears := SalaryArrears."Salary Arrears";
                    curPayeArrears := SalaryArrears."PAYE Arrears";

                    TotalSalaryArrears += curSalaryArrears;
                    TotalPAYEArrears += curPayeArrears;

                    SalaryArrears.TestField("Transaction Code");


                    curTransAmount := curSalaryArrears;
                    curTransBalance := 0;
                    JournalAc := salariesAcc;
                    strTransDescription := 'Salary Arrears';
                    LoanNo := '';
                    fnUpdatePeriodTrans(
                        strEmpCode, SalaryArrears."Transaction Code", Vargrouping::"Basic Salary", Varsubgroup::"BasicPay Arrears", strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);


                    curTransAmount := curPayeArrears;
                    curTransBalance := 0;
                    JournalAc := TaxAccount;
                    strTransDescription := 'PAYE Arrears';
                    LoanNo := '';
                    fnUpdatePeriodTrans(
                        strEmpCode, SalaryArrears."Transaction Code", Vargrouping::Statutories, Varsubgroup::"PAYE Arrears", strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);

                until SalaryArrears.Next = 0;
            end;



            RatesCeilings.Get;
            if RatesCeilings."NITA Amount" > 0 then begin
                curTransAmount := RatesCeilings."NITA Amount";

                strTransDescription := 'Employer: NITA Levy';

                JournalAc := NitaAccount;

                fnUpdatePeriodTrans(
                    strEmpCode, 'NITA', 0, 0, strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employer, 0);

            end;


        end;


        //Get Earnings

        //Message('%1\%2\%3', strEmpCode, intMonth, intYear);

        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
        EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
        EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
        EmployeeTrans.SetRange(EmployeeTrans.Stopped, false); //Added DW to not process Stopped Transactions
        if EmployeeTrans.Find('-') then begin
            curTotAllowances := 0;
            curNonTaxable := 0;
            repeat
                if EmployeeTrans."Member No." = '' then begin
                    EmpRec.Get(strEmpCode);
                    EmpRec.testfield("Member No");
                    EmployeeTrans."Member No." := EmpRec."Member No";
                    EmployeeTrans.Modify();
                end;
                //Message('t1');
                PayrollCodes.Reset;
                PayrollCodes.SetRange(PayrollCodes."Transaction Code", EmployeeTrans."Transaction Code");
                PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Earning);
                if PayrollCodes.Find('-') then begin
                    //Message('t2');
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strTransDescription := '';
                    strExtractedFrml := '';

                    if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                        curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the calculated amount
                                                                                               //error('%1',curTransAmount);

                    end
                    else
                        if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                            curTransAmount := PayrollCodes."Standard Amount"
                        else
                            curTransAmount := EmployeeTrans.Amount;


                    if PayrollCodes."Balance Type" = PayrollCodes."balance type"::None then
                        curTransBalance := 0;
                    if PayrollCodes."Balance Type" = PayrollCodes."balance type"::Increasing then
                        curTransBalance := EmployeeTrans.Balance + curTransAmount;
                    if PayrollCodes."Balance Type" = PayrollCodes."balance type"::Reducing then
                        curTransBalance := EmployeeTrans.Balance - curTransAmount;


                    //Prorate Allowances Here
                    if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                        curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                    end;

                    //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                    if dtTermination <> 0D then begin
                        if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                            curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                        end;
                    end;
                    // Prorate Allowances Here



                    //Add Non Taxable Here
                    if (not PayrollCodes.Taxable) and (PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::None) then
                        curNonTaxable := curNonTaxable + curTransAmount;

                    //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                    if (not PayrollCodes.Taxable) and (PayrollCodes."Special Transactions" <> PayrollCodes."special transactions"::None) then
                        curTransAmount := 0;

                    curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                    strTransDescription := EmployeeTrans."Transaction Name";

                    //Get the posting Details
                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := '';

                    if PayrollCodes.Subledger <> PayrollCodes.Subledger::"G/L Account" then begin

                        HREmployes.Reset;
                        HREmployes.SetRange(HREmployes."No.", strEmpCode);
                        if HREmployes.Find('-') then begin

                            Transcode.Reset;
                            Transcode.SetRange(Transcode."Transaction Code", EmployeeTrans."Transaction Code");
                            Transcode.SetRange(Transcode.Subledger, Transcode.Subledger::Savings);
                            if Transcode.Find('-') then begin

                                EmployeeTrans."Sub-Ledger" := EmployeeTrans."sub-ledger"::Savings;
                                MemberAccounts.Reset;
                                MemberAccounts.SetRange("Member No.", EmployeeTrans."Member No.");
                                MemberAccounts.SetRange("Product Type", Transcode."Sub-Ledger Product Type");
                                if MemberAccounts.FindFirst then begin
                                    EmployeeTrans."Sub-Ledger Account" := MemberAccounts."No.";
                                end;
                                EmployeeTrans.Modify();

                            end;

                            Transcode.Reset;
                            Transcode.SetRange(Transcode."Transaction Code", EmployeeTrans."Transaction Code");
                            Transcode.SetRange(Transcode.Subledger, Transcode.Subledger::Credit);
                            if Transcode.Find('-') then begin

                                EmployeeTrans."Sub-Ledger" := EmployeeTrans."sub-ledger"::Credit;
                                EmployeeTrans."Sub-Ledger Account" := EmployeeTrans."Member No.";
                                EmployeeTrans.Modify();
                            end;



                            EmployeeTrans.TestField("Sub-Ledger Account");
                            JournalAc := EmployeeTrans."Sub-Ledger Account";
                            JournalPostingType := EmployeeTrans."Sub-Ledger";
                        end;

                        //FOR CUSTOMER
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Customer then begin
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", JournalAc);
                            if not Customer.Find('-') then begin
                                Error('Customer Sub-Ledger Account No. %1 does not Exist for Employer %2', JournalAc, strEmpCode);
                            end;
                        end;

                        //FOR VENDOR
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Vendor then begin
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."No.", JournalAc);
                            if not Vendor.Find('-') then begin
                                Error('Vendor Sub-Ledger Account No. %1 does not Exist for Employer %2', JournalAc, strEmpCode);
                            end;
                        end;

                        //Credit
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::"Bank Account" then begin
                            /*
                           CreditAcc.RESET;
                           CreditAcc.SETRANGE(CreditAcc."No.",JournalAc);
                           CreditAcc.SETRANGE(CreditAcc."Payroll/Staff No.",strEmpCode);
                           CreditAcc.SETRANGE("Product Type",PayrollCodes."Product Type");
                           IF NOT CreditAcc.FIND('-') THEN BEGIN
                              ERROR('Credit Sub-Ledger Account No. %1 does not Exist for Employer %2, Loan Product %3',JournalAc,strEmpCode,PayrollCodes."Product Type");
                           END;
                           */
                        end;

                        //Savings
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::"Fixed Asset" then begin
                            /*
                            SavingAcc.RESET;
                            SavingAcc.SETRANGE(SavingAcc."No.",JournalAc);
                            SavingAcc.SETRANGE(SavingAcc."Payroll/Staff No.",strEmpCode);
                            SavingAcc.SETRANGE("Product Type",PayrollCodes."Product Type");
                            IF SavingAcc.FIND('-') THEN BEGIN
                                ERROR('Savings Sub-Ledger Account No. %1 does not Exist for Employer %2, Loan Product %3',JournalAc,strEmpCode,PayrollCodes."Product Type");
                            END;
                            */
                        end;
                    end
                    else begin
                        JournalPostingType := Journalpostingtype::"G/L Account";
                        JournalAc := PayrollCodes."GL Account";
                    end;

                    LoanNo := '';
                    fnUpdatePeriodTrans(
                        strEmpCode, PayrollCodes."Transaction Code", Vargrouping::Allowances, Varsubgroup::" ", strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);

                end;
            until EmployeeTrans.Next = 0;
        end;

        TotalGrossPay := (curBasicPay + curTotAllowances + TotalSalaryArrears);

        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
        EmployeeTrans.SetRange(EmployeeTrans."Payroll Period", SelectedPeriod);
        EmployeeTrans.SetRange(EmployeeTrans.Stopped, false); //Added DW to not process Stopped Transactions
        if EmployeeTrans.Find('-') then begin
            //MESSAGE('%1',EmployeeTrans.COUNT);

            repeat
                //MESSAGE(EmployeeTrans."Transaction Code");

                PayrollCodes.Reset;
                PayrollCodes.SetRange(PayrollCodes."Transaction Code", EmployeeTrans."Transaction Code");
                PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Deduction);
                if PayrollCodes.Find('-') then begin

                    //MESSAGE(EmployeeTrans."Transaction Name"+' - %1',EmployeeTrans.Amount);
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strExtractedFrml := '';
                    strTransDescription := EmployeeTrans."Transaction Name";
                    JournalAc := PayrollCodes."GL Account";
                    LoanNo := '';
                    JournalPostAs := Journalpostas::Credit;

                    if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin

                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                        curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the calculated amount
                                                                                               //error('%1',curTransAmount);

                    end
                    else
                        if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                            curTransAmount := PayrollCodes."Standard Amount"
                        else
                            curTransAmount := EmployeeTrans.Amount;


                    VarGrouping := Vargrouping::Deductions;
                    VarSubGroup := Varsubgroup::" ";


                    if (PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::"Life Insurance") then
                        if not (PayrollCodes."Deduct Premium") then
                            curTransAmount := 0;

                    if (PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::"Education Insurance") then
                        if not (PayrollCodes."Deduct Premium") then
                            curTransAmount := 0;


                    if (PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::Mortgage) then
                        if (PayrollCodes."Deduct Mortgage" = false) then
                            curTransAmount := 0;

                    if PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::"Defined Contribution" then
                        if curSelftDefinedPension > 0 then
                            curTransAmount := curSelftDefinedPension;


                    //Get the posting Details
                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := '';
                    MNo := '';

                    if PayrollCodes.Subledger <> PayrollCodes.Subledger::"G/L Account" then begin

                        HREmployes.Reset;
                        HREmployes.SetRange(HREmployes."No.", strEmpCode);
                        if HREmployes.Find('-') then begin
                            HREmployes.TestField("Member No");

                            Transcode.Reset;
                            Transcode.SetRange(Transcode."Transaction Code", PayrollCodes."Transaction Code");
                            Transcode.SetRange(Transcode.Subledger, Transcode.Subledger::Savings);
                            if Transcode.Find('-') then begin

                                EmployeeTrans."Sub-Ledger" := EmployeeTrans."sub-ledger"::Savings;

                                MemberAccounts.Reset;
                                if PayrollCodes."Sub-Ledger Account" <> '' then
                                    MemberAccounts.SetRange("No.", PayrollCodes."Sub-Ledger Account")
                                else begin
                                    MemberAccounts.SetRange("Member No.", EmployeeTrans."Member No.");
                                    MemberAccounts.SetRange("Product Type", PayrollCodes."Sub-Ledger Product Type");
                                end;
                                if MemberAccounts.FindFirst then begin
                                    EmployeeTrans."Sub-Ledger Account" := MemberAccounts."No.";
                                end;

                                EmployeeTrans.Modify();

                            end;

                            Transcode.Reset;
                            Transcode.SetRange(Transcode."Transaction Code", PayrollCodes."Transaction Code");
                            Transcode.SetRange(Transcode.Subledger, Transcode.Subledger::Credit);
                            if Transcode.Find('-') then begin

                                EmployeeTrans."Sub-Ledger" := EmployeeTrans."sub-ledger"::Credit;
                                //EmployeeTrans."Sub-Ledger Account" := EmployeeTrans."Member No.";

                                Loans.Reset;
                                Loans.SetRange("Member No.", Members."No.");
                                Loans.SetRange("Loan No.", EmployeeTrans."Loan No.");
                                Loans.SetRange("Loan Product Type", PayrollCodes."Sub-Ledger Product Type");
                                Loans.SetFilter("Total Outstanding Balance", '>0');
                                if Loans.FindFirst then
                                    EmployeeTrans."Sub-Ledger Account" := Loans."Loan Account";

                                EmployeeTrans.Modify();
                            end;


                            EmployeeTrans.TestField("Sub-Ledger Account");
                            JournalAc := EmployeeTrans."Sub-Ledger Account";
                            JournalPostingType := EmployeeTrans."Sub-Ledger";
                            MNo := HREmployes."Member No";
                        end;


                        //FOR CUSTOMER
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Customer then begin
                            JournalAc := PayrollCodes."Sub-Ledger Account";
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", JournalAc);
                            if not Customer.Find('-') then begin
                                Error('Customer Sub-Ledger Account No. %1 does not Exist for Employer %2', JournalAc, strEmpCode);
                            end;
                        end;

                        //FOR VENDOR
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Vendor then begin
                            JournalAc := PayrollCodes."Sub-Ledger Account";
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."No.", JournalAc);
                            if not Vendor.Find('-') then begin
                                Error('Vendor Sub-Ledger Account No. %1 does not Exist for Employer %2', JournalAc, strEmpCode);
                            end;
                        end;

                        //FOR Loans
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Credit then begin
                            Members.Get(MNo);


                            if PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::"Staff Loan" then begin
                                PayrollCodes.TestField("Sub-Ledger Product Type");

                                EmployeeTrans.TestField("Loan No.");
                                LoanNo := EmployeeTrans."Loan No.";

                                Loans.Reset;
                                Loans.SetRange("Member No.", Members."No.");
                                Loans.SetRange("Loan No.", EmployeeTrans."Loan No.");
                                Loans.SetRange("Loan Product Type", PayrollCodes."Sub-Ledger Product Type");
                                Loans.SetFilter("Total Outstanding Balance", '>0');
                                if Loans.FindFirst then begin

                                    LoanType.Get(Loans."Loan Product Type");

                                    JournalAc := Loans."Loan Account";

                                    Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Insurance");
                                    EmployeeTrans.Balance := Loans."Outstanding Principal";
                                    EmployeeTrans.Modify;

                                    if EmployeeTrans."Amortization Total Repayment" = 0 then
                                        EmployeeTrans."Amortization Total Repayment" := Loans.Repayment;
                                    /*
                                    LSchedule.RESET;
                                    LSchedule.SETRANGE("Loan No.",Loans."Loan No.");
                                    LSchedule.SETFILTER("Monthly Principal",'>0');
                                    IF LSchedule.FINDFIRST THEN
                                        IF EmployeeTrans."Payroll Period"
                                        */

                                    if Loans."Outstanding Interest" < 0 then
                                        Loans."Outstanding Interest" := 0;


                                    //EmployeeTrans.Balance := Loans."Outstanding Loan Principal";
                                    IntAmt := Loans."Outstanding Interest";
                                    if IntAmt < 0 then
                                        IntAmt := 0;

                                    //Insurance Amount
                                    InsAmt := Loans."Outstanding Insurance";
                                    if InsAmt < 0 then
                                        InsAmt := 0;

                                    /*
                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::"Flat Rate" then
                                        IntAmt := Loans."Loan Interest Repayment";
                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::Amortised then begin
                                        IntAmt := Loans."Outstanding Interest";
                                        if PayrollCodes."Post Loan Interest Due" then
                                            IntAmt := ROUND(Loans."Outstanding Principal" * Loans."Annual Interest %" / 1200);
                                        EmployeeTrans.TestField("Amortization Total Repayment");
                                    end;
                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::"Reducing Balance" then begin
                                        IntAmt := Loans."Outstanding Interest";

                                        if PayrollCodes."Post Loan Interest Due" then
                                            IntAmt := ROUND(Loans."Outstanding Principal" * Loans."Annual Interest %" / 1200);
                                    end;
                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::"User Defined Amount" then
                                        IntAmt := EmployeeTrans."User Defined Loan Interest";

                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::Amortised then
                                        if IntAmt > EmployeeTrans."Amortization Total Repayment" then
                                            IntAmt := EmployeeTrans."Amortization Total Repayment";
                                    */


                                    if IntAmt < 0 then
                                        IntAmt := 0;

                                    if IntAmt > EmployeeTrans."Amortization Total Repayment" then
                                        IntAmt := EmployeeTrans."Amortization Total Repayment";

                                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                                        if IntAmt > EmployeeTrans."Amortization Total Repayment" then
                                            IntAmt := EmployeeTrans."Amortization Total Repayment";

                                        EmployeeTrans.Amount := EmployeeTrans."Amortization Total Repayment" - IntAmt - InsAmt;
                                        if EmployeeTrans.Amount < 0 then
                                            EmployeeTrans.Amount := 0;

                                    end
                                    else begin
                                        if EmployeeTrans.Amount = 0 then
                                            EmployeeTrans.Amount := Loans."Loan Principle Repayment";
                                    end;

                                    curTransAmount := EmployeeTrans.Amount;
                                    curTransAmount := Round(curTransAmount, 0.05, '>');
                                    curTransBalance := Loans."Outstanding Principal";

                                    if EmployeeTrans."Principal Repayment Preset" = 0 then begin
                                        LSchedule.Reset();
                                        LSchedule.SetRange("Loan No.", Loans."Loan No.");
                                        LSchedule.SetFilter("Monthly Principal", '>0');
                                        LSchedule.SetRange(
                                            "Repayment Date",
                                            CalcDate('-CM', SelectedPeriod),
                                            CalcDate('CM', SelectedPeriod));

                                        if LSchedule.FindFirst() then begin
                                            curTransAmount := Loans."Outstanding Principal" - LSchedule."Loan Balance";
                                            if curTransAmount < 0 then
                                                curTransAmount := 0;
                                        end;
                                    end else
                                        curTransAmount := EmployeeTrans."Principal Repayment Preset";

                                    if curTransAmount > Loans."Outstanding Principal" then
                                        curTransAmount := Loans."Outstanding Principal";


                                    if IntAmt > 0 then begin

                                        strTransDescription := Loantype."USSD Product Name" + ': Interest Repayment';

                                        fnUpdatePeriodTrans(
                                            strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, IntAmt, Loans."Outstanding Interest",
                                            intMonth, intYear, SelectedPeriod, Loans."Loan Account", JournalPostingType, LoanNo, JournalPostAs, Entrytype::Employee, 1);

                                        curTotalDeductions += IntAmt;
                                    end;

                                    if InsAmt > 0 then begin
                                        InsAmt := Round(InsAmt, 0.05, '>');

                                        strTransDescription := Loantype."USSD Product Name" + ': Insurance Repayment';

                                        fnUpdatePeriodTrans(
                                    strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, InsAmt, Loans."Outstanding Insurance",
                                    intMonth, intYear, SelectedPeriod, Loans."Loan Account", JournalPostingType, LoanNo, JournalPostAs, Entrytype::Employee, 2);

                                        curTotalDeductions += InsAmt;
                                    end;
                                end;
                            end;
                        end;

                        //Savings
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Savings then begin

                            curTransAmount := 0;
                            //EmployeeTrans.Balance := 0;
                            Members.Get(MNo);

                            MemberAccounts.Reset;
                            if PayrollCodes."Sub-Ledger Account" <> '' then
                                MemberAccounts.SetRange("No.", PayrollCodes."Sub-Ledger Account")
                            else begin
                                MemberAccounts.SetRange("Member No.", Members."No.");
                                MemberAccounts.SetRange("Product Type", PayrollCodes."Sub-Ledger Product Type");
                            end;
                            if MemberAccounts.FindFirst then begin
                                MemberAccounts.CalcFields("Balance (LCY)");
                                EmployeeTrans.Balance := MemberAccounts."Balance (LCY)";
                                EmployeeTrans.Modify;
                                JournalPostingType := Journalpostingtype::Savings;
                                JournalAc := MemberAccounts."No.";
                            end;

                            if PayrollCodes."Sub-Ledger Account" <> '' then begin

                                JournalAc := PayrollCodes."Sub-Ledger Account";
                            end;

                            curTransAmount := EmployeeTrans.Amount;
                            curTransAmount := Round(curTransAmount, 0.05, '>');

                            /*
                            IF PayrollCodes."Sacco Transaction Type" = PayrollCodes."Sacco Transaction Type"::"Deposit Contribution" THEN BEGIN
                                Members.CALCFIELDS("Current Savings");
                                //EmployeeTrans.Balance := Members."Current Savings";
                            END;
        
                            IF PayrollCodes."Sacco Transaction Type" = PayrollCodes."Sacco Transaction Type"::"Benevolent Fund" THEN BEGIN
                                Members.CALCFIELDS("Benoverent Fund");
                                //EmployeeTrans.Balance := Members."Benoverent Fund";
                            END;
        
                            IF PayrollCodes."Sacco Transaction Type" = PayrollCodes."Sacco Transaction Type"::"Holiday Savings" THEN BEGIN
                                Members.CALCFIELDS("Account Type");
                                //EmployeeTrans.Balance := Members."Holiday Savings";
                            END;
        
                            IF PayrollCodes."Sacco Transaction Type" = PayrollCodes."Sacco Transaction Type"::"Junior Account" THEN BEGIN
                                Members.CALCFIELDS("CRB Employer Industry Type");
                                //EmployeeTrans.Balance := Members."Junior Account";
        
                            END;
        
                            IF PayrollCodes."Special Transactions" = PayrollCodes."Special Transactions"::"Staff Loan" THEN BEGIN
                                PayrollCodes.TESTFIELD("Loan Product Type");
        
                                EmployeeTrans.TESTFIELD("Loan No.");
                                LoanNo := EmployeeTrans."Loan No.";
        
                                Loans.RESET;
                                Loans.SETRANGE("Date Entered",Members."No.");
                                Loans.SETRANGE("SMS ID",EmployeeTrans."Loan No.");
                                Loans.SETRANGE("Mobile Phone No.",PayrollCodes."Loan Product Type");
                                //Loans.SETFILTER("Outstanding Loan Principal",'>0');
                                IF Loans.FINDFIRST THEN BEGIN
                                    Loans.CALCFIELDS("Outstanding Loan Principal","Outstanding Interest");
                                    //EmployeeTrans.Balance := Loans."Outstanding Loan Principal";
                                    IntAmt := 0;
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::"Flat Rate" THEN
                                        IntAmt := Loans."Loan Interest Repayment";
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::Amortised THEN BEGIN
                                        IntAmt := Loans."Outstanding Interest";
                                        EmployeeTrans.TESTFIELD("Amortization Total Repayment");
                                    END;
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::"Reducing Balance" THEN
                                        IntAmt := Loans."Outstanding Interest";
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::"User Defined Amount" THEN
                                        IntAmt := EmployeeTrans."User Defined Loan Interest";
        
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::Amortised THEN
                                        IF IntAmt > EmployeeTrans."Amortization Total Repayment" THEN
                                            IntAmt := EmployeeTrans."Amortization Total Repayment";
        
                                    IF IntAmt < 0 THEN
                                        IntAmt := 0;
        
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::Amortised THEN BEGIN
                                        EmployeeTrans.Amount := EmployeeTrans."Amortization Total Repayment" - IntAmt;
                                        IF EmployeeTrans.Amount < 0 THEN
                                            EmployeeTrans.Amount := 0;
                                        curTransAmount := EmployeeTrans.Amount;
                                    END;
                                    //MESSAGE('%1',IntAmt);
        
                                    IF IntAmt > 0 THEN BEGIN
                                        fnUpdatePeriodTrans(
                                            strEmpCode,PayrollCodes."Transaction Code",VarGrouping,VarSubGroup,strTransDescription+'- Interest',IntAmt,0,
                                            intMonth,intYear,SelectedPeriod,JournalAc,JournalPostingType,LoanNo,JournalPostAs,EntryType::Employee,1);
        
                                        curTotalDeductions +=IntAmt;
                                    END;
                                END;
                            END;
                            */

                        end;

                    end
                    else begin
                        JournalPostingType := Journalpostingtype::"G/L Account";
                        JournalAc := PayrollCodes."GL Account";
                    end;


                    case PayrollCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                        PayrollCodes."balance type"::None:
                            curTransBalance := 0;
                        PayrollCodes."balance type"::Increasing:
                            begin
                                curTransBalance := EmployeeTrans.Balance + curTransAmount;
                            end;
                        PayrollCodes."balance type"::Reducing:
                            begin
                                if EmployeeTrans.Balance < 0 then
                                    EmployeeTrans.Balance := 0;

                                if EmployeeTrans.Balance < EmployeeTrans.Amount then begin
                                    curTransAmount := EmployeeTrans.Balance;
                                    curTransBalance := 0;
                                end
                                else begin
                                    curTransBalance := EmployeeTrans.Balance - curTransAmount;
                                end;

                                if curTransBalance < 0 then begin
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                end;
                            end
                    end;

                    curTotalDeductions += Round(curTransAmount, 0.05, '>');

                    //strTransDescription += ': ' + strEmpCode;

                    if PayrollCodes.Subledger = PayrollCodes.Subledger::Savings then
                        strTransDescription := strTransDescription;

                    if PayrollCodes.Subledger = PayrollCodes.Subledger::Credit then
                        strTransDescription := Loantype."USSD Product Name" + ': ' + 'Loan Repayment';

                    fnUpdatePeriodTrans(
                        strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, LoanNo, JournalPostAs, Entrytype::Employee, 0);

                    //Fringe Benefits and Low interest Benefits
                    if PayrollCodes."Fringe Benefit" = true then begin
                        IF Loans.GET(EmployeeTrans."Loan No.") THEN
                            Loans.CALCFIELDS("Outstanding Principal");
                        fnCalcFringeBenefit := ((curLoanMarketRate - EmployeeTrans."Interest Rate") / 1200) * Loans."Outstanding Principal";

                        fnCalcFringeBenefit := ROUND(fnCalcFringeBenefit * 30 / 100, 0.05, '>');

                    end
                    else begin
                        fnCalcFringeBenefit := 0;
                    end;

                    if fnCalcFringeBenefit > 0 then begin
                        curTransAmount := fnCalcFringeBenefit;
                        strTransDescription := 'Fringe Benefit Tax';
                        curTransBalance := 0;
                        JournalAc := FringeExpense;
                        LoanNo := '';

                        fnUpdatePeriodTrans(
                            strEmpCode, PayrollCodes."Transaction Code" + '-FRG', VarGrouping::Fringe, VarSubGroup, strTransDescription + ': ' + strEmpCode, curTransAmount, curTransBalance,
                            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);

                        /*  
                         strTransDescription := 'Fringe Benefit';
                         TGroup := '';
                         TGroupOrder := 9;
                         TSubGroupOrder := 0;
                         fnUpdatePeriodTrans(
                             strEmpCode, PayrollCodes."Transaction Code" + ' FRG', VarGrouping::Fringe, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                             intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employer, 1);
                         */
                    end;
                    //End Fringe Benefits

                    if PayrollCodes."Special Identifier" = PayrollCodes."special identifier"::NSSF then begin

                        curTransAmount := ROUND(PayrollCodes."Standard Amount", 0.05, '>');


                        curTransBalance := 0;
                        strTransDescription := 'NSSF Relief';
                        JournalAc := '';
                        LoanNo := '';

                        fnUpdatePeriodTrans(
                            strEmpCode, 'SHIFR', Vargrouping::"Tax Calculations", Varsubgroup::"Pension Relief", strTransDescription, curTransAmount, curTransBalance,
                            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);


                    end;

                    //Create Employer Deduction
                    if (PayrollCodes."Employer Deduction") or (PayrollCodes."Include Employer Deduction") then begin

                        if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::Formula then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes."Is Formula for employer");
                            curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
                                                                                                //error('%1',curTransAmount);

                        end
                        else
                            if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::"Standard Amount" then
                                curTransAmount := PayrollCodes."Employer Standard Amount"
                            else
                                curTransAmount := EmployeeTrans.Amount;


                        if curTransAmount > 0 then begin

                            strTransDescription := 'Employer: ' + EmployeeTrans."Transaction Name";

                            JournalAc := PayrollCodes."GL Account";
                            curTransAmount := Round(curTransAmount, 0.05, '>');

                            /*
                            curTransBalance := 0;
                            LoanNo := '';
                            */

                            if PayrollCodes."Special Transactions" = PayrollCodes."Special Transactions"::"Defined Contribution" then
                                if not StopEmployerPension then
                                    fnUpdatePeriodTrans(
                                        strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription + ': ' + strEmpCode, curTransAmount, curTransBalance,
                                        intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

                        end;
                    end;

                end;


            until EmployeeTrans.Next = 0;


            // curHousing := 0;
            // if blnPaysNssf then begin


            //     PayrollCodes.Reset;
            //     PayrollCodes.SetRange(PayrollCodes."Special Identifier", PayrollCodes."special identifier"::"Housing Levy");
            //     PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Deduction);
            //     if PayrollCodes.Find('-') then begin

            //         VarGrouping := Vargrouping::Deductions;
            //         VarSubGroup := Varsubgroup::" ";
            //         VarGrouping := Vargrouping::Statutories;
            //         VarSubGroup := Varsubgroup::"Housing Levy";

            //         JournalPostingType := Journalpostingtype::"G/L Account";
            //         JournalAc := PayrollCodes."GL Account";
            //         JournalPostAs := Journalpostas::Credit;


            //         if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
            //             strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
            //             curHousing := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
            //         end
            //         else
            //             if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
            //                 curHousing := PayrollCodes."Standard Amount"
            //             else
            //                 curHousing := EmployeeTrans.Amount;


            //         curTransAmount := curHousing;
            //         curTotalDeductions += curHousing;
            //         curTransBalance := 0;
            //         fnUpdatePeriodTrans(
            //             strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, PayrollCodes."Transaction Name", curTransAmount, curTransBalance,
            //             intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, '', JournalPostAs, Entrytype::Employee, 0);


            //         //Create Employer Deduction
            //         if (PayrollCodes."Employer Deduction") or (PayrollCodes."Include Employer Deduction") then begin

            //             if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::Formula then begin
            //                 strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes."Is Formula for employer");
            //                 curHousingEmployer := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
            //                                                                                         //error('%1',curTransAmount);

            //             end
            //             else
            //                 if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::"Standard Amount" then
            //                     curHousingEmployer := PayrollCodes."Standard Amount"
            //                 else
            //                     curHousingEmployer := EmployeeTrans.Amount;


            //             curTransAmount := curHousingEmployer;

            //             if curTransAmount > 0 then begin

            //                 strTransDescription := 'Employer: NSSF';

            //                 JournalAc := PayrollCodes."GL Account";
            //                 /*
            //                 curTransBalance := 0;
            //                 LoanNo := '';
            //                 */

            //                 fnUpdatePeriodTrans(
            //                     strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
            //                     intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

            //             end;
            //         end;

            //     end;

            // end;



        end;


        curGrossPay := ROUND((curBasicPay + curTotAllowances + TotalSalaryArrears), 0.05, '>');
        curTransAmount := curGrossPay;
        curTransBalance := 0;
        strTransDescription := 'Gross Pay';
        JournalAc := '';
        JournalPostingType := Journalpostingtype::"G/L Account";

        LoanNo := '';
        fnUpdatePeriodTrans(
            strEmpCode, 'GPAY', Vargrouping::"Gross Salary", Varsubgroup::" ", strTransDescription, curTransAmount, curTransBalance,
            intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

        curGrossTaxable := curGrossPay;
        TotalGrossPay := TotalGrossPay;
        curDefinedContrib := 0;

        /*
        //Added for auto relief calculation
        IF  (curGrossPay-curNSSF)  <= currMinRelief THEN
        BEGIN
            blnGetsPAYERelief:=FALSE;
        END ELSE
        BEGIN
            blnGetsPAYERelief:=TRUE;
            //If employee is marked on salary card as not entitle to personal relief
            PRSalCard_2.RESET;
            IF PRSalCard_2.GET(strEmpCode) THEN
            BEGIN
                IF PRSalCard_2."Disable Personal Relief?" THEN blnGetsPAYERelief:=FALSE;
            END;
        
        END;
        */

        curNSSF := 0;
        if blnPaysNssf then begin

            PayrollCodes.Reset;
            PayrollCodes.SetRange(PayrollCodes."Special Identifier", PayrollCodes."special identifier"::NSSF);
            PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Deduction);
            if PayrollCodes.Find('-') then begin

                VarGrouping := Vargrouping::Deductions;
                VarSubGroup := Varsubgroup::" ";
                VarGrouping := Vargrouping::Statutories;
                VarSubGroup := Varsubgroup::NSSF;

                JournalPostingType := Journalpostingtype::"G/L Account";
                JournalAc := PayrollCodes."GL Account";
                JournalPostAs := Journalpostas::Credit;

                if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                    curNSSF := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the calculated amount
                end
                else
                    if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                        curNSSF := PayrollCodes."Standard Amount"
                    else
                        curNSSF := EmployeeTrans.Amount;


                curNSSF := 0;
                curNSSFEmployer := 0;
                NSSFEmployeeTier1 := 0;
                NSSFEmployeeTier2 := 0;
                NSSFEmployerTier1 := 0;
                NSSFEmployerTier2 := 0;

                PayrollCodess.Reset;
                PayrollCodess.SetRange("Irregular Income", true);
                if PayrollCodess.Find('-') then begin
                    repeat
                        EmployeeTranss.Reset;
                        EmployeeTranss.SetRange("Employee Code", strEmpCode);
                        EmployeeTranss.SetRange("Transaction Code", PayrollCodess."Transaction Code");
                        EmployeeTranss.SetRange("Payroll Period", SelectedPeriod);
                        EmployeeTranss.SetRange(Stopped, false); //Added DW to not process Stopped Transactions
                        if EmployeeTranss.Find('-') then
                            IrregularAmt += EmployeeTranss.Amount;

                    until PayrollCodess.Next() = 0;
                end;


                fnGetEmployeeNSSF(curBasicPay, NSSFEmployeeTier1, NSSFEmployeeTier2, NSSFEmployerTier1, NSSFEmployerTier2);

                curNSSFEmployer := NSSFEmployerTier1 + NSSFEmployerTier2;
                curNSSF := NSSFEmployeeTier1 + NSSFEmployeeTier2;
                curTransAmount := NSSFEmployeeTier1;
                curTotalDeductions += NSSFEmployeeTier1;
                curTransBalance := 0;
                fnUpdatePeriodTrans(
                    strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, PayrollCodes."Transaction Name" + ' Tier 1', curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, '', JournalPostAs, Entrytype::Employee, 0);

                curTransAmount := NSSFEmployeeTier2;
                curTotalDeductions += NSSFEmployeeTier2;
                JournalAc := NSSFTier2Account;
                curTransBalance := 0;
                fnUpdatePeriodTrans(
                    strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, PayrollCodes."Transaction Name" + ' Tier 2', curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, '', JournalPostAs, Entrytype::Employee, 1);



                //Create Employer Deduction
                if (PayrollCodes."Employer Deduction") or (PayrollCodes."Include Employer Deduction") then begin

                    if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::Formula then begin
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes."Is Formula for employer");
                        curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the calculated amount
                                                                                               //error('%1',curTransAmount);

                    end
                    else
                        if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::"Standard Amount" then
                            curTransAmount := PayrollCodes."Standard Amount"
                        else
                            curTransAmount := EmployeeTrans.Amount;


                    curTransAmount := curNSSFEmployer;

                    if curTransAmount > 0 then begin

                        strTransDescription := 'Employer: NSSF';

                        JournalAc := PayrollCodes."GL Account";
                        /*
                        curTransBalance := 0;
                        LoanNo := '';
                        */

                        fnUpdatePeriodTrans(
                            strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

                    end;
                end;

            end;

        end;

        curNHIF := 0;
        if blnPaysNhif then begin

            PayrollCodes.Reset;
            PayrollCodes.SetRange(PayrollCodes."Special Identifier", PayrollCodes."special identifier"::NHIF);
            PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Deduction);
            if PayrollCodes.Find('-') then begin

                VarGrouping := Vargrouping::Deductions;
                VarSubGroup := Varsubgroup::" ";
                VarGrouping := Vargrouping::Statutories;
                VarSubGroup := Varsubgroup::NHIF;

                JournalPostingType := Journalpostingtype::"G/L Account";
                JournalAc := PayrollCodes."GL Account";
                JournalPostAs := Journalpostas::Credit;



                curNhif_Base_Amount := 0;

                if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                    curNhif_Base_Amount := curGrossPay;
                if intNHIF_BasedOn = Intnhif_basedon::Basic then
                    curNhif_Base_Amount := curBasicPay;
                if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                    curNhif_Base_Amount := curTaxablePay;
                //Create Employer Deduction

                if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                    strExtractedFrml := fnPureFormulaIrregularIncome(strEmpCode, intMonth, intYear, PayrollCodes.Formula, PayrollCodes."Transaction Code", SelectedPeriod);
                    curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the 
                    curNHIF := curTransAmount;
                end
                else
                    if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::"Standard Amount" then
                        curTransAmount := PayrollCodes."Standard Amount"
                    else
                        curTransAmount := EmployeeTrans.Amount;

                //curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                //curTransAmount := curNHIF;
                curTotalDeductions += curTransAmount;
                curTransBalance := 0;




                fnUpdatePeriodTrans(
                    strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, PayrollCodes."Transaction Name", curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, '', JournalPostAs, Entrytype::Employee, 0);


                //Create Employer Deduction
                curTransAmount := 0;
                if (PayrollCodes."Employer Deduction") or (PayrollCodes."Include Employer Deduction") then begin

                    if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::Formula then begin
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes."Is Formula for employer");
                        curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the calculated amount
                                                                                               //error('%1',curTransAmount);

                    end
                    else
                        if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::"Standard Amount" then
                            curTransAmount := PayrollCodes."Standard Amount"
                        else
                            curTransAmount := EmployeeTrans.Amount;

                    if curTransAmount > 0 then begin

                        strTransDescription := 'Employer: ' + EmployeeTrans."Transaction Name";

                        JournalAc := PayrollCodes."GL Account";
                        /*
                        curTransBalance := 0;
                        LoanNo := '';
                        */

                        fnUpdatePeriodTrans(
                            strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

                    end;
                end;
                //NHIF RELIEF

                curNHIFReliefAmount := curTransAmount * (CurReliefNHIF / 100);
                if (curNHIFReliefAmount > 0) and (blnGetsPAYERelief) then begin

                    VarGrouping := Vargrouping::"Tax Calculations";
                    VarSubGroup := Varsubgroup::"Tax Relief";
                    VarSubGroup := Varsubgroup::NHIF;
                    curTransBalance := 0;
                    strTransDescription := 'NHIF Relief';
                    JournalAc := '';
                    LoanNo := '';

                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := PayrollCodes."GL Account";
                    JournalPostAs := Journalpostas::Credit;

                    fnUpdatePeriodTrans(
                   strEmpCode, 'NHIF Relief', VarGrouping, VarSubGroup, strTransDescription, curNHIFReliefAmount, curTransBalance,
                   intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType::"G/L Account", '', JournalPostAs::" ", Entrytype::Employee, 0);
                end;

            end;

        end else
            curNHIFReliefAmount := 0;

        curHousing := 0;
        curTransAmount := 0;
        if salCard."Pays Housing Levy" then begin

            PayrollCodes.Reset;
            PayrollCodes.SetRange(PayrollCodes."Special Identifier", PayrollCodes."special identifier"::"Housing Levy");
            PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Deduction);
            if PayrollCodes.Find('-') then begin

                VarGrouping := Vargrouping::Deductions;
                VarSubGroup := Varsubgroup::" ";
                VarGrouping := Vargrouping::Statutories;
                VarSubGroup := Varsubgroup::"Housing Levy";

                JournalPostingType := Journalpostingtype::"G/L Account";
                JournalAc := PayrollCodes."GL Account";
                JournalPostAs := Journalpostas::Credit;

                //Create Employer Deduction
                //if (PayrollCodes."Employer Deduction") or (PayrollCodes."Include Employer Deduction") then begin

                if PayrollCodes."Calculation Type" = PayrollCodes."Calculation Type"::Formula then begin
                    strExtractedFrml := fnPureFormulaIrregularIncome(strEmpCode, intMonth, intYear, PayrollCodes.Formula, PayrollCodes."Transaction Code", SelectedPeriod);
                    curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '>'); //Get the calculated amount
                    //curTransAmount := curGrossPay * 0.015
                    //error('%1',curTransAmount);
                end
                else
                    if PayrollCodes."Calculation Type" = PayrollCodes."Calculation Type"::"Standard Amount" then
                        curTransAmount := PayrollCodes."Standard Amount"
                    else
                        curTransAmount := EmployeeTrans.Amount;

                curHousing := Round(curTransAmount, 0.05, '>');
                curTotalDeductions += Round(curHousing, 0.05, '>');

                fnUpdatePeriodTrans(
                strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, PayrollCodes."Transaction Name", curTransAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, '', JournalPostAs, Entrytype::Employee, 0);

                if (curTransAmount > 0) and (PayrollCodes."Include Employer Deduction") then begin

                    strTransDescription := 'Employer: ' + PayrollCodes."Transaction Name";

                    JournalAc := PayrollCodes."GL Account";
                    /*
                    curTransBalance := 0;
                    LoanNo := '';
                    */

                    fnUpdatePeriodTrans(
                        strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

                end;
                //end;
                //Housing Levy RELIEF

                curHousingLevyRelief := Round(curTransAmount * ("CurReliefHousingLevy%" / 100), 0.01, '=');
                if (curHousingLevyRelief > 0) then begin

                    VarGrouping := Vargrouping::"Tax Calculations";
                    //VarSubGroup := Varsubgroup::"Tax Relief";
                    VarSubGroup := Varsubgroup::"Housing Levy Relief";
                    curTransBalance := 0;
                    strTransDescription := 'Housing Levy Relief';
                    JournalAc := '';
                    LoanNo := '';

                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := PayrollCodes."GL Account";
                    JournalPostAs := Journalpostas::Credit;

                    fnUpdatePeriodTrans(
                   strEmpCode, 'R-' + PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curHousingLevyRelief, curTransBalance,
                   intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType::"G/L Account", '', JournalPostAs::" ", Entrytype::Employee, 0);
                end;

            end;

        end else
            curHousing := 0;

        if blnGetsPAYERelief then begin
            curTransAmount := curReliefPersonal;
            curTransBalance := 0;
            strTransDescription := 'Personal Relief';
            JournalAc := '';
            LoanNo := '';

            fnUpdatePeriodTrans(
                strEmpCode, 'PSNR', Vargrouping::"Tax Calculations", Varsubgroup::"Tax Relief", strTransDescription, curTransAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

        end
        else
            curReliefPersonal := 0;


        //>Pension Contribution [self] relief
        curDefinedContrib := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, Specialtranstype::"Defined Contribution", false) + NSSFEmployeeTier2;//Self contrib Pension is 1 on [Special Transaction]

        if curDefinedContrib > 0 then begin

            if curDefinedContrib > curMaxPensionContrib then
                curTransAmount := ROUND(curMaxPensionContrib, 0.05, '>')
            else
                curTransAmount := ROUND(curDefinedContrib, 0.05, '>');


            curTransBalance := 0;
            strTransDescription := 'Pension Relief';
            JournalAc := '';
            LoanNo := '';
            curPensionReliefAmount := curTransAmount;

            if curPensionReliefAmount + NSSFEmployeeTier1 > curMaxPensionContrib then
                NSSFEmployeeTier1 := 0;

            fnUpdatePeriodTrans(
                strEmpCode, 'PENR', Vargrouping::"Tax Calculations", Varsubgroup::"Pension Relief", strTransDescription, curPensionReliefAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

        end;

        //if he PAYS paye only*******************I
        if blnPaysPaye and blnGetsPAYERelief then begin
            //Get Insurance Relief
            curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, Specialtranstype::"Life Insurance", false); //Insurance is 3 on [Special Transaction]

            if curInsuranceReliefAmount = 0 then
                curInsuranceReliefAmount := ((curReliefInsurance / 100) * ManualInsuranceRelief);

            if curInsuranceReliefAmount > 0 then begin

                /* if ManualInsuranceRelief > 0 then
                    curInsuranceReliefAmount := ManualInsuranceRelief; */


                curTransAmount := ROUND(curInsuranceReliefAmount, 0.05, '>');
                if ManualInsuranceRelief > 0 then
                    curTransAmount := curInsuranceReliefAmount;

                /* if curTransAmount > curMaxInsuranceRelief then
                    curTransAmount := curMaxInsuranceRelief; */


                curTransBalance := 0;
                strTransDescription := 'Insurance Relief';
                JournalAc := '';
                LoanNo := '';

                fnUpdatePeriodTrans(
                    strEmpCode, 'INSR', Vargrouping::"Tax Calculations", Varsubgroup::"Insurance Relief", strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

            end;
            //>OOI
            curOOI := 0;
            curOOI := fnGetSpecialTransAmountOwner(strEmpCode, intMonth, intYear, Specialtranstype::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]

            if curOOI > 0 then begin
                if curOOI <= curOOIMaxMonthlyContrb then
                    curTransAmount := curOOI
                else
                    curTransAmount := curOOIMaxMonthlyContrb;


                curOOI := curTransAmount;
                curTransBalance := 0;
                strTransDescription := 'Owner Occupier Interest';
                JournalAc := '';
                LoanNo := '';

                fnUpdatePeriodTrans(
                    strEmpCode, 'OOI', Vargrouping::"Tax Calculations", Varsubgroup::"Owner Occupier", strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

            end;

            //HOSP
            curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
            if curHOSP > 0 then begin


                if curHOSP > curReliefMorgage then
                    curHOSP := curReliefMorgage;

                curTransAmount := curHOSP;

                curTransBalance := 0;
                strTransDescription := 'Home Ownership Savings Plan';
                JournalAc := '';
                LoanNo := '';

                fnUpdatePeriodTrans(
                    strEmpCode, 'HOSP', Vargrouping::"Tax Calculations", Varsubgroup::"Home Ownership", strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

            end;


            //Enter NonTaxable Amount
            if curNonTaxable > 0 then begin

                curTransAmount := curNonTaxable;
                curTransBalance := 0;
                strTransDescription := 'Other Non-Taxable Benefits';
                JournalAc := '';
                LoanNo := '';

                fnUpdatePeriodTrans(
                    strEmpCode, 'NONTAX', Vargrouping::"Tax Calculations", Varsubgroup::"Non-Taxable", strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

            end;

        end;

        BenifitAmount := 0;

        //Initialize
        curTransAmount := 0;
        curTransBalance := 0;
        strTransDescription := '';
        //curSHA := curGrossPay * 0.025;

        // curTaxablePay := (curGrossTaxable + BenifitAmount) -
        //                 (curSalaryArrears + curOOI + curHOSP + curNonTaxable + curPensionReliefAmount + curNSSF + curHousing + curSHA);
        curTaxablePay := (curGrossTaxable + BenifitAmount) -
        (curSalaryArrears + curOOI + curHOSP + curNonTaxable + curPensionReliefAmount + NSSFEmployeeTier1 + curHousing + curNHIF);
        //curTaxablePay := (curGrossTaxable + BenifitAmount) -
        //              (curSalaryArrears + curDefinedContrib + curOOI + curHOSP + curNonTaxable + curPensionReliefAmount + curNSSF);


        //MESSAGE('curSalaryArrears %1 \curDefinedContrib %2\curMaxPensionContrib %3\curOOI %4\curHOSP %5\curNonTaxable %6\curPensionReliefAmount %7',
        //curSalaryArrears, curDefinedContrib, curMaxPensionContrib, curOOI, curHOSP, curNonTaxable, curPensionReliefAmount);

        curTaxablePay := ROUND(curTaxablePay, 0.05, '>');
        curTransAmount := curTaxablePay;
        curTransBalance := 0;
        strTransDescription := 'Taxable Pay';
        JournalAc := '';
        LoanNo := '';

        fnUpdatePeriodTrans(
            strEmpCode, 'TXBP', Vargrouping::"Tax Calculations", Varsubgroup::"Taxable Pay", strTransDescription, curTransAmount, curTransBalance,
            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);



        if blnPaysPaye then begin
            //Special tax for disabled employee
            HREmp2.Reset;
            if HREmp2.Get(strEmpCode) then begin
                if HREmp2."Physically Challenged" = HREmp2."physically challenged"::Yes then
                    blnPaysPaye := false
                else begin

                    curTaxCharged := ROUND(fnGetEmployeePaye(curTaxablePay), 0.05, '>');
                    curTaxCharged := ROUND(curTaxCharged, 0.05, '>');
                    curTransAmount := ROUND(curTaxCharged, 0.05, '>');
                    curTransBalance := 0;
                    strTransDescription := 'Tax Charged';
                    JournalAc := '';
                    LoanNo := '';

                    fnUpdatePeriodTrans(
                        strEmpCode, 'TXCHRG', Vargrouping::"Tax Calculations", Varsubgroup::"Tax Charged", strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);


                end;
            end;
        end;

        /*
        //Get the Net PAYE amount to post for the month
        IF (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief THEN BEGIN
            curPAYE := curTaxCharged - curMaximumRelief;
        END
        ELSE BEGIN
        
            //******************************************************************************************************************************************
            //Added DW: Only for Employees who have brought their insurance Certificate are entitled to Insurance Relief Otherwise NO
            //Place a check mark on the Salary Card to YES
            IF (blnInsuranceCertificate) THEN BEGIN
                curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curHOSP);
            END
            ELSE BEGIN
                curPAYE := curTaxCharged - (curReliefPersonal + curHOSP);
            END;
            //******************************************************************************************************************************************
        END;
        */

        if (blnInsuranceCertificate) then begin
            curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curHOSP + curNHIFReliefAmount + curHousingLevyRelief);
        end
        else begin
            curPAYE := curTaxCharged - (curReliefPersonal + curHOSP + curNHIFReliefAmount + curHousingLevyRelief);
        end;
        //MESSAGE('curPAYE %1\curReliefPersonal %2',curPAYE,curReliefPersonal);


        //Added for auto PAYE calculation
        if (curGrossPay - curNSSF) <= currMinRelief then begin
            blnPaysPaye := false;
        end
        else begin
            blnPaysPaye := true;
        end;

        curPAYE := ROUND(curPAYE, 0.05, '>');

        if not blnPaysPaye then
            curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0

        if curPAYE < 0 then
            curPAYE := 0;


        curTransAmount := curPAYE;
        strTransDescription := 'P.A.Y.E';
        curTransBalance := 0;
        JournalAc := TaxAccount;
        LoanNo := '';

        fnUpdatePeriodTrans(
            strEmpCode, 'PAYE', Vargrouping::Statutories, Varsubgroup::PAYE, strTransDescription, curTransAmount, curTransBalance,
            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employee, 0);
        curTotalDeductions += curPAYE;





        //GET TOTAL DEDUCTIONS
        strTransDescription := 'Total Deductions';
        curTransAmount := curTotalDeductions;
        curTransBalance := 0;
        JournalAc := '';
        LoanNo := '';

        fnUpdatePeriodTrans(
            strEmpCode, 'TOT-DED', Vargrouping::Deductions, Varsubgroup::" ", strTransDescription, curTransAmount, curTransBalance,
            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

        //END GET TOTAL DEDUCTIONS





        PayrollCodes.Reset;
        PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::"Net Pay");
        if PayrollCodes.Find('-') then begin

            curNetPay := curGrossPay - (curTotalDeductions);//-curIncludeinNet;
            strTransDescription := 'Net Pay';
            curTransAmount := curNetPay;
            curTransBalance := 0;
            JournalAc := PayrollCodes."GL Account";
            LoanNo := '';

            fnUpdatePeriodTrans(
                strEmpCode, 'NPAY', Vargrouping::"Net Salary", Varsubgroup::" ", strTransDescription, curTransAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employee, 0);

        end;

    end;


    procedure fnInitialize()
    begin
        //Initialize Global Setup Items
        RatesCeilings.Get;
        curReliefPersonal := RatesCeilings."Tax Relief";
        curReliefInsurance := RatesCeilings."Insurance Relief";
        curReliefMorgage := RatesCeilings."Mortgage Relief"; //Same as HOSP
        curMaximumRelief := RatesCeilings."Max Relief";
        intNHIF_BasedOn := RatesCeilings."NHIF Based on";
        curMaxPensionContrib := RatesCeilings."Max Pension Contribution";
        curOOIMaxMonthlyContrb := RatesCeilings."OOI Deduction";
        curLoanMarketRate := RatesCeilings."Loan Market Rate";
        curLoanCorpRate := RatesCeilings."Loan Corporate Rate";
        currMinRelief := RatesCeilings."Minimum Relief Amount";
        curDisabledLimit := RatesCeilings."Disbled Tax Limit";
        CurReliefNHIF := RatesCeilings."NHIF Relief";
        "CurReliefHousingLevy%" := RatesCeilings."Housing Levy Relief";
    end;


    procedure ConfirmPostingGroupSetup(strEmpCode: Code[20])
    var
        SalaryCard: Record "Staff Payroll Details";
        HREmp: Record Employee;
    begin

        if HREmp.Get(strEmpCode) then begin
            if PostingGroup.Get('PAYROLL') then begin
                PostingGroup.TestField("Salary Account");
                PostingGroup.TestField("Income Tax Account");
                //PostingGroup.TESTFIELD("Net Salary Payable");

                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                NitaAccount := PostingGroup."NITA Payable Account";
                NSSFTier2Account := PostingGroup."NSSF Tier 2";
                FringeExpense := PostingGroup."Fringe Expense Account";
                FringePayable := PostingGroup."Fringe Payable Account";
            end;
        end;
    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary, 0.05, '>');
    end;


    procedure ClosePayrollPeriod(OpenPeriod: Date) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        intMonth: Integer;
        intYear: Integer;
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        CreateTrans: Boolean;
        NewEmployeeTrans: Record "Payroll Employee Transactions";
        EmployeeTrans: Record "Payroll Employee Transactions";
        Lno: Integer;
    begin

        dtNewPeriod := CalcDate('1M', OpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        intMonth := Date2dmy(OpenPeriod, 2);
        intYear := Date2dmy(OpenPeriod, 3);

        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Payroll Period", OpenPeriod);
        EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
        EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
        EmployeeTrans.SetRange(EmployeeTrans.Stopped, false); //Added DW to not process Stopped Transactions
        if EmployeeTrans.Find('-') then begin
            repeat
                PayrollCodes.Reset;
                PayrollCodes.SetRange(PayrollCodes."Transaction Code", EmployeeTrans."Transaction Code");
                if PayrollCodes.Find('-') then begin


                    curTransAmount := 0;
                    curTransBalance := 0;
                    case PayrollCodes."Balance Type" of
                        PayrollCodes."balance type"::None:
                            begin
                                curTransAmount := EmployeeTrans.Amount;
                                curTransBalance := 0;
                            end;

                        PayrollCodes."balance type"::Increasing:
                            begin
                                curTransAmount := EmployeeTrans.Amount;
                                curTransBalance := EmployeeTrans.Balance + EmployeeTrans.Amount;
                            end;

                        PayrollCodes."balance type"::Reducing:
                            begin
                                curTransAmount := EmployeeTrans.Amount;
                                if EmployeeTrans.Balance < EmployeeTrans.Amount then begin
                                    curTransAmount := EmployeeTrans.Balance;
                                    curTransBalance := 0;
                                end
                                else begin
                                    curTransBalance := EmployeeTrans.Balance - EmployeeTrans.Amount;
                                end;
                                if curTransBalance < 0 then begin
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                end;
                            end;
                    end;


                    //For those transactions with Start and End Date Specified
                    if (EmployeeTrans."Start Date" <> 0D) then begin
                        if EmployeeTrans."Start Date" >= dtNewPeriod then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                        end;
                    end;
                    if (EmployeeTrans."End Date" <> 0D) then begin
                        if EmployeeTrans."End Date" < dtNewPeriod then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                        end;
                    end;
                    //End Transactions with Start and End Date
                    Lno += 1;

                    CreateTrans := (PayrollCodes.Frequency = PayrollCodes.Frequency::Fixed) and
                        ((curTransAmount <> 0) or IsOutstandingStaffLoanTransaction(EmployeeTrans, PayrollCodes));

                    if CreateTrans then begin
                            //Insert record for the next period
                            NewEmployeeTrans.Init;
                            NewEmployeeTrans.EntryNo := Lno;
                            NewEmployeeTrans."Employee Code" := EmployeeTrans."Employee Code";
                            NewEmployeeTrans.Validate("Transaction Code", EmployeeTrans."Transaction Code");
                            NewEmployeeTrans."Transaction Name" := EmployeeTrans."Transaction Name";
                            NewEmployeeTrans.Amount := curTransAmount;
                            NewEmployeeTrans.Balance := curTransBalance;
                            NewEmployeeTrans."Employer Amount" := EmployeeTrans."Employer Amount";
                            NewEmployeeTrans."Employer Balance" := EmployeeTrans."Employer Balance";
                            NewEmployeeTrans."Period Month" := intNewMonth;
                            NewEmployeeTrans."Period Year" := intNewYear;
                            NewEmployeeTrans."Payroll Period" := dtNewPeriod;
                            NewEmployeeTrans."Start Date" := EmployeeTrans."Start Date";
                            NewEmployeeTrans."End Date" := EmployeeTrans."End Date";
                            NewEmployeeTrans."Payroll Code" := EmployeeTrans."Payroll Code";
                            NewEmployeeTrans."Sub-Ledger" := EmployeeTrans."Sub-Ledger";
                            NewEmployeeTrans."Sub-Ledger Account" := EmployeeTrans."Sub-Ledger Account";
                            NewEmployeeTrans."Interest Rate" := EmployeeTrans."Interest Rate";
                            NewEmployeeTrans."Member No." := EmployeeTrans."Member No.";
                            NewEmployeeTrans."User Defined Loan Interest" := EmployeeTrans."User Defined Loan Interest";
                            NewEmployeeTrans."Amortization Total Repayment" := EmployeeTrans."Amortization Total Repayment";
                            NewEmployeeTrans."Loan No." := EmployeeTrans."Loan No.";
                            NewEmployeeTrans."Loan Product Type" := EmployeeTrans."Loan Product Type";
                            NewEmployeeTrans."Reference No" := EmployeeTrans."Reference No";
                            NewEmployeeTrans."User Defined Loan Insurance" := EmployeeTrans."User Defined Loan Insurance";
                            NewEmployeeTrans."Principal Repayment Preset" := EmployeeTrans."Principal Repayment Preset";
                            NewEmployeeTrans.Insert;
                    end;
                end;
            until EmployeeTrans.Next = 0;
        end;

        //Update the Period as Closed
        PayrollPeriods.Reset;
        PayrollPeriods.SetRange(PayrollPeriods."Period Month", intMonth);
        PayrollPeriods.SetRange(PayrollPeriods."Period Year", intYear);
        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
        if PayrollPeriods.Find('-') then begin
            PayrollPeriods.Closed := true;
            PayrollPeriods."Date Closed" := Today;
            PayrollPeriods."Closed By" := UserId;
            PayrollPeriods.Modify;
        end;

        //Enter a New Period
        PayrollPeriods.Init;
        PayrollPeriods."Period Month" := intNewMonth;
        PayrollPeriods."Period Year" := intNewYear;
        PayrollPeriods."Period Name" := CopyStr(Format(dtNewPeriod, 0, '<Month Text>'), 1, 3) + ' ' + Format(intNewYear);
        PayrollPeriods."Date Opened" := dtNewPeriod;
        PayrollPeriods."Opened By" := UserId;
        PayrollPeriods.Closed := false;
        PayrollPeriods.Insert;

        RolloverGymClaims(intMonth, intYear, dtNewPeriod);

        //Effect the transactions for the P9
        UpdatePeriodP9(intMonth, intYear, OpenPeriod);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        AddNegativePay(intMonth, intYear, OpenPeriod);


        /*
        //Reset no. of days worked for casuals
        PRSalCard.RESET;
        PRSalCard.SETRANGE(PRSalCard."Employee Contract Type",'CASUALS');
        IF PRSalCard.FIND('-') THEN BEGIN
            REPEAT
                PRSalCard."No. of Days Worked":=0;
                PRSalCard.MODIFY;
            UNTIL PRSalCard.NEXT = 0;
        END;
        */

    end;

    local procedure IsOutstandingStaffLoanTransaction(EmployeeTrans: Record "Payroll Employee Transactions"; PayrollCode: Record "Payroll Codes"): Boolean
    var
        Loan: Record Loans;
    begin
        if PayrollCode."Special Transactions" <> PayrollCode."Special Transactions"::"Staff Loan" then
            exit(false);

        if EmployeeTrans."Loan No." = '' then
            exit(false);

        if not Loan.Get(EmployeeTrans."Loan No.") then
            exit(false);

        Loan.CalcFields("Total Outstanding Balance");
        exit(Loan."Total Outstanding Balance" > 0);
    end;


    procedure UpdatePeriodP9(intMonth: Integer; intYear: Integer; dtCurPeriod: Date)
    var
        P9EmployeeCode: Code[20];
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        Employee: Record Employee;
    begin
        Employee.Reset;
        if Employee.Find('-') then begin
            repeat
                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", Employee."No.");
                PeriodTrans.SetRange(PeriodTrans."Period Month", intMonth);
                PeriodTrans.SetRange(PeriodTrans."Period Year", intYear);
                if PeriodTrans.Find('-') then begin
                    repeat
                        case PeriodTrans.Grouping of
                            PeriodTrans.Grouping::"Basic Salary": //Basic pay & Arrears
                                begin
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::BasicPay then
                                        P9BasicPay := PeriodTrans.Amount; //Basic Pay
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::"BasicPay Arrears" then
                                        P9BasicPay := P9BasicPay + PeriodTrans.Amount; //Basic Pay Arrears
                                end;
                            PeriodTrans.Grouping::Allowances:  //Allowances
                                begin
                                    P9Allowances := P9Allowances + PeriodTrans.Amount
                                end;
                            PeriodTrans.Grouping::"Gross Salary": //Gross Pay
                                begin
                                    P9GrossPay := PeriodTrans.Amount
                                end;
                            PeriodTrans.Grouping::"Tax Calculations": //Taxation
                                begin
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::"Defined Contribution" then P9DefinedContribution := PeriodTrans.Amount; //Defined Contribution
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::"Tax Relief" then P9TaxRelief := PeriodTrans.Amount; //Tax Relief
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::"Insurance Relief" then P9InsuranceRelief := PeriodTrans.Amount; //Insurance Relief
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::"Taxable Pay" then P9TaxablePay := PeriodTrans.Amount; //Taxable Pay
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::"Tax Charged" then P9TaxCharged := PeriodTrans.Amount; //Tax Charged
                                end;
                            PeriodTrans.Grouping::Statutories: //Statutories
                                begin
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::NSSF then P9NSSF := PeriodTrans.Amount; //Nssf
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::NHIF then P9NHIF := PeriodTrans.Amount; //Nhif
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::PAYE then P9Paye := PeriodTrans.Amount; //paye
                                    if PeriodTrans."Sub Group" = PeriodTrans."sub group"::"PAYE Arrears" then P9Paye := P9Paye + PeriodTrans.Amount; //Paye Arrears
                                end;
                            PeriodTrans.Grouping::Deductions://Deductions
                                begin
                                    P9Deductions := P9Deductions + PeriodTrans.Amount;
                                end;
                            PeriodTrans.Grouping::"Net Salary": //NetPay
                                begin
                                    P9NetPay := PeriodTrans.Amount;
                                end;

                        end;
                    until PeriodTrans.Next = 0;
                end;


                //Update the P9 Details
                if P9NetPay <> 0 then
                    InsertP9Record(Employee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                    P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                    P9NHIF, P9Deductions, P9NetPay, dtCurPeriod);

            until Employee.Next = 0;
        end;
    end;


    procedure AddNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        intNewMonth: Integer;
        intNewYear: Integer;
        dtNewPeriod: Date;
        EmployeeTrans: Record "Payroll Employee Transactions";
    begin
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        PeriodTrans.Reset;
        PeriodTrans.SetRange(PeriodTrans."Period Month", intMonth);
        PeriodTrans.SetRange(PeriodTrans."Period Year", intYear);
        PeriodTrans.SetRange(PeriodTrans.Grouping, PeriodTrans.Grouping::"Net Salary");
        PeriodTrans.SetFilter(PeriodTrans.Amount, '<0');
        if PeriodTrans.Find('-') then begin
            if not PayrollCodes.Get('NEGP') then begin
                PayrollCodes.Init;
                PayrollCodes."Transaction Code" := 'NEGPAY';
                PayrollCodes."Transaction Name" := 'Negative Pay';
                PayrollCodes."Balance Type" := PayrollCodes."balance type"::None;
                PayrollCodes."Transaction Type" := PayrollCodes."transaction type"::Deduction;
                PayrollCodes.Frequency := PayrollCodes.Frequency::Varied;
                PayrollCodes."Calculation Type" := PayrollCodes."calculation type"::"Varied Amount";
                PayrollCodes.Insert;
            end;

            repeat
                EmployeeTrans.Init;
                EmployeeTrans."Employee Code" := PeriodTrans."Employee Code";
                EmployeeTrans."Transaction Code" := 'NEGP';
                EmployeeTrans."Transaction Name" := 'Negative Pay';
                EmployeeTrans.Amount := PeriodTrans.Amount * -1;
                EmployeeTrans.Balance := 0;
                EmployeeTrans."Period Month" := intNewMonth;
                EmployeeTrans."Period Year" := intNewYear;
                EmployeeTrans."Payroll Period" := dtNewPeriod;
                EmployeeTrans.Insert;
            until PeriodTrans.Next = 0;
        end;
    end;

    local procedure RolloverGymClaims(intMonth: Integer; intYear: Integer; dtNewPeriod: Date)
    var
        GymClaims: Record "Employee Gym Claims";
        NewGymClaims: Record "Employee Gym Claims";
        intNewMonth: Integer;
        intNewYear: Integer;
    begin
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        // Get all approved/posted gym claims for the closing period
        GymClaims.Reset();
        GymClaims.SetRange("Period Month", intMonth);
        GymClaims.SetRange("Period Year", intYear);
        GymClaims.SetRange(Status, GymClaims.Status::Posted); // only roll over posted ones
        if GymClaims.FindSet() then
            repeat
                // Don't duplicate if already exists for new period
                NewGymClaims.Reset();
                NewGymClaims.SetRange("Employee Code", GymClaims."Employee Code");
                NewGymClaims.SetRange("Period Month", intNewMonth);
                NewGymClaims.SetRange("Period Year", intNewYear);
                if not NewGymClaims.FindFirst() then begin
                    NewGymClaims.Init();
                    NewGymClaims.Validate("Employee Code", GymClaims."Employee Code");
                    NewGymClaims.Validate("Payroll Period", dtNewPeriod);
                    NewGymClaims."Transaction Code" := GymClaims."Transaction Code";
                    NewGymClaims."Claim Amount" := GymClaims."Claim Amount"; // default from last period
                    NewGymClaims."Gross Amount" := 0;                        // recalculated on posting
                    NewGymClaims."Marginal Tax Rate" := 0;                   // recalculated on posting
                    NewGymClaims.Status := NewGymClaims.Status::Open;        // HR must re-approve
                    NewGymClaims.Posted := false;
                    NewGymClaims.Insert();
                end;
            until GymClaims.Next() = 0;
    end;

    procedure InsertP9Record(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date)
    var
        PayrollP9Buffer: Record "Payroll P9 Buffer";
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := Date2dmy(dtCurrPeriod, 2);
        intYear := Date2dmy(dtCurrPeriod, 3);


        PayrollP9Buffer.Reset;
        PayrollP9Buffer.Init;
        PayrollP9Buffer."Employee Code" := P9EmployeeCode;
        PayrollP9Buffer."Basic Pay" := P9BasicPay;
        PayrollP9Buffer.Allowances := P9Allowances;
        PayrollP9Buffer.Benefits := P9Benefits;
        PayrollP9Buffer."Value Of Quarters" := P9ValueOfQuarters;
        PayrollP9Buffer."Defined Contribution" := P9DefinedContribution;
        PayrollP9Buffer."Owner Occupier Interest" := P9OwnerOccupierInterest;
        PayrollP9Buffer."Gross Pay" := P9GrossPay;
        PayrollP9Buffer."Taxable Pay" := P9TaxablePay;
        PayrollP9Buffer."Tax Charged" := P9TaxCharged;
        PayrollP9Buffer."Insurance Relief" := P9InsuranceRelief;
        PayrollP9Buffer."Tax Relief" := P9TaxRelief;
        PayrollP9Buffer.PAYE := P9Paye;
        PayrollP9Buffer.NSSF := P9NSSF;
        PayrollP9Buffer.NHIF := P9NHIF;
        PayrollP9Buffer.Deductions := P9Deductions;
        PayrollP9Buffer."Net Pay" := P9NetPay;
        PayrollP9Buffer."Period Month" := intMonth;
        PayrollP9Buffer."Period Year" := intYear;
        PayrollP9Buffer."Payroll Period" := dtCurrPeriod;
        PayrollP9Buffer.Insert;
    end;


    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
    end;
}

