Report 50207 "Payroll Summary Report"
{
    ApplicationArea = All;
    Caption = 'Payroll Summary Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Revised Payroll Summary Report.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(CompanyName; CompanyName())
            {
            }
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(SNo; SNo)
            {
            }
            column(PayrollPeriod; PayrollPeriod)
            {
            }
            column(EmployeeNo; "No.")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(No_Employee; "No.")
            {
            }
            column(FullName; EmployeeName)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(PTrans_BasicPay; BasicPay)
            {
            }
            column(PTrans_GymSubscriptionEarning; GymSubscriptionEarning)
            {
            }
            column(PTrans_SalaryArrears; SalaryArrears)
            {
            }
            column(PTrans_StaffBonus; StaffBonus)
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(PTrans_GrossPay; GrossPay)
            {
            }
            column(TotalEarnings; TotalEarnings)
            {
            }
            column(TotalAllowances; TotalEarnings)
            {
            }
            column(PTrans_OtherAllowances; OtherAllowances)
            {
            }
            column(PTrans_LeaveAllowance; LeaveAllowance)
            {
            }
            column(PTrans_ActingAllowance; ActingAllowance)
            {
            }
            column(PTrans_OvertimeAllowance; OvertimeAllowance)
            {
            }
            column(PTrans_HolidayAllowance; HolidayAllowance)
            {
            }
            column(PTrans_Gratuity; Gratuity)
            {
            }
            column(PTrans_TransportAllowance; TransportAllowance)
            {
            }
            column(PTrans_Airtime; Airtime)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(PTrans_TotalDeductions; TotalDeductions)
            {
            }
            column(PTrans_Statutory; StatutoryDeductions)
            {
            }
            column(PTrans_PAYE; PayeAmount)
            {
            }
            column(PTrans_PensionContribution; PensionContribution)
            {
            }
            column(PTrans_PensionRelief; PensionRelief)
            {
            }
            column(PensionContribution; PensionContribution)
            {
            }
            column(PTrans_NHIF; ShifAmount)
            {
            }
            column(PTrans_NSSF; NssfAmount)
            {
            }
            column(HSL; HousingLevyAmount)
            {
            }
            column(PTrans_HELB; HelbAmount)
            {
            }
            column(PTrans_Welfare; WelfareAmount)
            {
            }
            column(PTrans_GymSubscriptionDeduction; GymSubscriptionDeduction)
            {
            }
            column(PTrans_Loans; LoansAmount)
            {
            }
            column(PTrans_Savings; SavingsAmount)
            {
            }
            column(PTrans_JuniorSavings; JuniorSavings)
            {
            }
            column(PTrans_DepositContribution; DepositContribution)
            {
            }
            column(PTrans_LoanProductA; LoanProductA)
            {
            }
            column(LoanProductACaption; LoanProductACaption)
            {
            }
            column(PTrans_LoanProductB; LoanProductB)
            {
            }
            column(LoanProductBCaption; LoanProductBCaption)
            {
            }
            column(PTrans_LoanProductC; LoanProductC)
            {
            }
            column(LoanProductCCaption; LoanProductCCaption)
            {
            }
            column(PTrans_LoanProductD; LoanProductD)
            {
            }
            column(LoanProductDCaption; LoanProductDCaption)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(PTrans_Netpay; NetAmount)
            {
            }
            column(Bank_Code; BankCode)
            {
            }
            column(Branch_Name; BranchName)
            {
            }
            column(PeriodName; PeriodName)
            {
            }

            trigger OnPreDataItem()
            begin
                SNo := 0;

                objPeriod.Reset;
                if objPeriod.Get(PayrollPeriod) then begin
                    PeriodName := objPeriod."Period Name";
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                ClearEmployeeTotals("No.");
                LoadEmployeePayrollTotals("No.");

                if (BasicPay = 0) and (TotalEarnings = 0) and (TotalDeductions = 0) and (NetAmount = 0) then
                    CurrReport.Skip();

                SNo += 1;
            end;
        }
        dataitem(LoanProductTransaction; "Payroll Period Transactions")
        {
            DataItemTableView = sorting("Employee Code", "Transaction Code");

            column(LoanEmployeeCode; "Employee Code") { }
            column(LoanEmployeeName; DynamicLoanEmployeeName) { }
            column(DynamicLoanProductCode; DynamicLoanProductCode) { }
            column(DynamicLoanProductName; DynamicLoanProductName) { }
            column(DynamicLoanAmount; Amount) { }

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Period", PayrollPeriod);
                SetRange("Entry Type", "Entry Type"::Employee);
                SetFilter("Loan No.", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            var
                Loan: Record Loans;
                PayrollEmployee: Record Employee;
                EmployeeNo20: Code[20];
            begin
                Clear(DynamicLoanProductCode);
                Clear(DynamicLoanProductName);
                Clear(DynamicLoanEmployeeName);

                if not Loan.Get("Loan No.") then
                    CurrReport.Skip();

                DynamicLoanProductCode := Loan."Loan Product Type";
                DynamicLoanProductName := Loan."Loan Product Type Name";
                if DynamicLoanProductName = '' then
                    DynamicLoanProductName := DynamicLoanProductCode;

                EmployeeNo20 := CopyStr("Employee Code", 1, MaxStrLen(EmployeeNo20));
                if PayrollEmployee.Get(EmployeeNo20) then
                    DynamicLoanEmployeeName := PayrollEmployee.FullName();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PayrollPeriod; PayrollPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Payroll Period';
                        TableRelation = "Payroll Periods"."Date Opened";
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    begin
        if PayrollPeriod = 0D then
            Error('Please specify payroll period.');

        RestrictAccess();
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        BuildLoanProductColumns();
    end;

    var
        PeriodName: Text[50];
        objPeriod: Record "Payroll Periods";
        CompanyInfo: Record "Company Information";
        EmployeeRec: Record Employee;
        PeriodTrans: Record "Payroll Period Transactions";
        PayrollPeriod: Date;
        SNo: Integer;
        EmployeeName: Text[100];
        BankName: Text[100];
        BankAccountNo: Text[100];
        BankCode: Code[10];
        BranchName: Text[100];
        BasicPay: Decimal;
        GrossPay: Decimal;
        TotalEarnings: Decimal;
        TotalDeductions: Decimal;
        CalculatedDeductions: Decimal;
        NetAmount: Decimal;
        OtherAllowances: Decimal;
        GymSubscriptionEarning: Decimal;
        LeaveAllowance: Decimal;
        ActingAllowance: Decimal;
        OvertimeAllowance: Decimal;
        HolidayAllowance: Decimal;
        SalaryArrears: Decimal;
        StaffBonus: Decimal;
        Gratuity: Decimal;
        TransportAllowance: Decimal;
        Airtime: Decimal;
        StatutoryDeductions: Decimal;
        PayeAmount: Decimal;
        PensionContribution: Decimal;
        PensionRelief: Decimal;
        ShifAmount: Decimal;
        NssfAmount: Decimal;
        HousingLevyAmount: Decimal;
        HelbAmount: Decimal;
        WelfareAmount: Decimal;
        GymSubscriptionDeduction: Decimal;
        LoansAmount: Decimal;
        SavingsAmount: Decimal;
        JuniorSavings: Decimal;
        DepositContribution: Decimal;
        LoanProductA: Decimal;
        LoanProductB: Decimal;
        LoanProductC: Decimal;
        LoanProductD: Decimal;
        LoanProductAKey: Code[20];
        LoanProductBKey: Code[20];
        LoanProductCKey: Code[20];
        LoanProductDKey: Code[20];
        LoanProductACaption: Text[100];
        LoanProductBCaption: Text[100];
        LoanProductCCaption: Text[100];
        LoanProductDCaption: Text[100];
        DynamicLoanProductCode: Code[20];
        DynamicLoanProductName: Text[100];
        DynamicLoanEmployeeName: Text[100];

    local procedure ClearEmployeeTotals(EmployeeNo: Code[50])
    var
        EmployeeNo20: Code[20];
    begin
        Clear(EmployeeName);
        Clear(BankName);
        Clear(BankAccountNo);
        Clear(BankCode);
        Clear(BranchName);
        Clear(BasicPay);
        Clear(GrossPay);
        Clear(TotalEarnings);
        Clear(TotalDeductions);
        Clear(CalculatedDeductions);
        Clear(NetAmount);
        Clear(OtherAllowances);
        Clear(GymSubscriptionEarning);
        Clear(LeaveAllowance);
        Clear(ActingAllowance);
        Clear(OvertimeAllowance);
        Clear(HolidayAllowance);
        Clear(SalaryArrears);
        Clear(StaffBonus);
        Clear(Gratuity);
        Clear(TransportAllowance);
        Clear(Airtime);
        Clear(StatutoryDeductions);
        Clear(PayeAmount);
        Clear(PensionContribution);
        Clear(PensionRelief);
        Clear(ShifAmount);
        Clear(NssfAmount);
        Clear(HousingLevyAmount);
        Clear(HelbAmount);
        Clear(WelfareAmount);
        Clear(GymSubscriptionDeduction);
        Clear(LoansAmount);
        Clear(SavingsAmount);
        Clear(JuniorSavings);
        Clear(DepositContribution);
        Clear(LoanProductA);
        Clear(LoanProductB);
        Clear(LoanProductC);
        Clear(LoanProductD);

        EmployeeName := CopyStr(EmployeeNo, 1, MaxStrLen(EmployeeName));
        EmployeeNo20 := CopyStr(EmployeeNo, 1, MaxStrLen(EmployeeNo20));
        if EmployeeRec.Get(EmployeeNo20) then begin
            EmployeeName := CopyStr(EmployeeRec.FullName(), 1, MaxStrLen(EmployeeName));
            BankName := EmployeeRec."Bank Name";
            BankAccountNo := EmployeeRec."Bank Account No.";
            BankCode := EmployeeRec."Bank Code";
            BranchName := EmployeeRec."Branch Name";
        end;
    end;

    local procedure LoadEmployeePayrollTotals(EmployeeNo: Code[50])
    begin
        PeriodTrans.Reset();
        PeriodTrans.SetRange("Employee Code", EmployeeNo);
        PeriodTrans.SetRange("Payroll Period", PayrollPeriod);
        PeriodTrans.SetRange("Entry Type", PeriodTrans."Entry Type"::Employee);

        if not PeriodTrans.FindSet() then
            exit;

        repeat
            if (BankName = '') and (PeriodTrans."Bank Name" <> '') then
                BankName := PeriodTrans."Bank Name";

            if (BankAccountNo = '') and (PeriodTrans."A/C Number" <> '') then
                BankAccountNo := PeriodTrans."A/C Number";

            if (BankCode = '') and (PeriodTrans."Bank Code" <> '') then
                BankCode := PeriodTrans."Bank Code";

            if (BranchName = '') and (PeriodTrans."Branch Name" <> '') then
                BranchName := PeriodTrans."Branch Name";

            ClassifyTransaction(PeriodTrans);
        until PeriodTrans.Next() = 0;

        if GrossPay = 0 then
            GrossPay := BasicPay + TotalEarnings;

        if TotalDeductions = 0 then
            TotalDeductions := CalculatedDeductions;

        if NetAmount = 0 then
            NetAmount := GrossPay - TotalDeductions;

    end;

    local procedure ClassifyTransaction(var PayrollTrans: Record "Payroll Period Transactions")
    begin
        if PayrollTrans."Transaction Code" = 'TOT-DED' then begin
            TotalDeductions += PayrollTrans.Amount;
            exit;
        end;

        if (PayrollTrans.Grouping = PayrollTrans.Grouping::"Basic Salary") or
           (PayrollTrans."Payroll Code Type" = PayrollTrans."Payroll Code Type"::"Basic Pay")
        then begin
            BasicPay += PayrollTrans.Amount;
            exit;
        end;

        if (PayrollTrans.Grouping = PayrollTrans.Grouping::"Net Salary") or
           (PayrollTrans."Payroll Code Type" = PayrollTrans."Payroll Code Type"::"Net Pay")
        then begin
            NetAmount += PayrollTrans.Amount;
            exit;
        end;

        if (PayrollTrans.Grouping = PayrollTrans.Grouping::"Gross Salary") or
           (PayrollTrans."Payroll Code Type" = PayrollTrans."Payroll Code Type"::"Gross Pay")
        then begin
            GrossPay += PayrollTrans.Amount;
            exit;
        end;

        if (PayrollTrans.Grouping = PayrollTrans.Grouping::Allowances) or
           (PayrollTrans."Payroll Code Type" = PayrollTrans."Payroll Code Type"::Earning)
        then begin
            TotalEarnings += PayrollTrans.Amount;
            AddEarningToColumn(PayrollTrans);
            exit;
        end;

        if (PayrollTrans.Grouping in [PayrollTrans.Grouping::Statutories,
                                      PayrollTrans.Grouping::Deductions,
                                      PayrollTrans.Grouping::"Housing Levy",
                                      PayrollTrans.Grouping::"Housing Levy Levy",
                                      PayrollTrans.Grouping::Fringe]) or
           (PayrollTrans."Payroll Code Type" in [PayrollTrans."Payroll Code Type"::Deduction,
                                                 PayrollTrans."Payroll Code Type"::PAYE])
        then begin
            CalculatedDeductions += PayrollTrans.Amount;
            AddDeductionToColumn(PayrollTrans);
        end;
    end;

    local procedure AddEarningToColumn(var PayrollTrans: Record "Payroll Period Transactions")
    begin
        if TransactionMatches(PayrollTrans, 'GYM') then
            GymSubscriptionEarning += PayrollTrans.Amount
        else
            if TransactionMatches(PayrollTrans, 'OVERTIME') then
                OvertimeAllowance += PayrollTrans.Amount
            else
                if TransactionMatches(PayrollTrans, 'ARREAR') then
                    SalaryArrears += PayrollTrans.Amount
                else
                    if TransactionMatches(PayrollTrans, 'BONUS') then
                        StaffBonus += PayrollTrans.Amount
                    else
                        if TransactionMatches(PayrollTrans, 'LEAVE') then
                            LeaveAllowance += PayrollTrans.Amount
                        else
                            if TransactionMatches(PayrollTrans, 'GRATUITY') then
                                Gratuity += PayrollTrans.Amount
                            else
                                if TransactionMatches(PayrollTrans, 'ACTING') then
                                    ActingAllowance += PayrollTrans.Amount
                                else
                                    if TransactionMatches(PayrollTrans, 'TRANSPORT') then
                                        TransportAllowance += PayrollTrans.Amount
                                    else
                                        if TransactionMatches(PayrollTrans, 'AIRTIME') then
                                            Airtime += PayrollTrans.Amount
                                        else
                                            OtherAllowances += PayrollTrans.Amount;
    end;

    local procedure AddDeductionToColumn(var PayrollTrans: Record "Payroll Period Transactions")
    begin
        if PayrollTrans.Grouping = PayrollTrans.Grouping::Statutories then
            StatutoryDeductions += PayrollTrans.Amount;

        case PayrollTrans."Sub Group" of
            PayrollTrans."Sub Group"::PAYE:
                begin
                    PayeAmount += PayrollTrans.Amount;
                    exit;
                end;
            PayrollTrans."Sub Group"::NSSF:
                begin
                    NssfAmount += PayrollTrans.Amount;
                    exit;
                end;
            PayrollTrans."Sub Group"::NHIF:
                begin
                    ShifAmount += PayrollTrans.Amount;
                    exit;
                end;
            PayrollTrans."Sub Group"::"Housing Levy":
                begin
                    HousingLevyAmount += PayrollTrans.Amount;
                    exit;
                end;
            PayrollTrans."Sub Group"::"Pension Relief":
                begin
                    PensionRelief += PayrollTrans.Amount;
                    exit;
                end;
        end;

        if PayrollTrans."Payroll Code Type" = PayrollTrans."Payroll Code Type"::PAYE then begin
            PayeAmount += PayrollTrans.Amount;
            exit;
        end;

        if TransactionMatches(PayrollTrans, 'PENSION') then
            PensionContribution += PayrollTrans.Amount
        else
            if TransactionMatches(PayrollTrans, 'HOLIDAY') or TransactionMatches(PayrollTrans, 'WEEKEND') then
                HolidayAllowance += PayrollTrans.Amount
            else
                if TransactionMatches(PayrollTrans, 'HELB') then
                    HelbAmount += PayrollTrans.Amount
                else
                    if TransactionMatches(PayrollTrans, 'WELFARE') then
                        WelfareAmount += PayrollTrans.Amount
                    else
                        if TransactionMatches(PayrollTrans, 'GYM') then
                            GymSubscriptionDeduction += PayrollTrans.Amount
                        else
                            if TransactionMatches(PayrollTrans, 'DEPOSIT') then
                                DepositContribution += PayrollTrans.Amount
                            else
                                if TransactionMatches(PayrollTrans, 'JUNIOR') then
                                    JuniorSavings += PayrollTrans.Amount
                                else
                                    if TransactionMatches(PayrollTrans, 'SAVING') then
                                        SavingsAmount += PayrollTrans.Amount
                                    else
                                        if PayrollTrans."Loan No." <> '' then
                                            AddLoanDeductionToColumn(PayrollTrans)
                                        else
                                            if TransactionMatches(PayrollTrans, 'LOAN') then
                                                LoansAmount += PayrollTrans.Amount;
    end;

    local procedure BuildLoanProductColumns()
    var
        PayrollTrans: Record "Payroll Period Transactions";
        Loan: Record Loans;
    begin
        Clear(LoanProductAKey);
        Clear(LoanProductBKey);
        Clear(LoanProductCKey);
        Clear(LoanProductDKey);
        Clear(LoanProductACaption);
        Clear(LoanProductBCaption);
        Clear(LoanProductCCaption);
        Clear(LoanProductDCaption);

        PayrollTrans.SetRange("Payroll Period", PayrollPeriod);
        PayrollTrans.SetRange("Entry Type", PayrollTrans."Entry Type"::Employee);
        PayrollTrans.SetFilter("Loan No.", '<>%1', '');
        if PayrollTrans.FindSet() then
            repeat
                if Loan.Get(PayrollTrans."Loan No.") then
                    AddLoanProductColumn(Loan."Loan Product Type", Loan."Loan Product Type Name");
            until PayrollTrans.Next() = 0;
    end;

    local procedure AddLoanProductColumn(ProductCode: Code[20]; ProductName: Text)
    begin
        if ProductCode = '' then
            exit;
        if ProductCode in [LoanProductAKey, LoanProductBKey, LoanProductCKey, LoanProductDKey] then
            exit;

        if LoanProductAKey = '' then begin
            LoanProductAKey := ProductCode;
            LoanProductACaption := CopyStr(ProductName, 1, MaxStrLen(LoanProductACaption));
        end else
            if LoanProductBKey = '' then begin
                LoanProductBKey := ProductCode;
                LoanProductBCaption := CopyStr(ProductName, 1, MaxStrLen(LoanProductBCaption));
            end else
                if LoanProductCKey = '' then begin
                    LoanProductCKey := ProductCode;
                    LoanProductCCaption := CopyStr(ProductName, 1, MaxStrLen(LoanProductCCaption));
                end else
                    if LoanProductDKey = '' then begin
                        LoanProductDKey := ProductCode;
                        LoanProductDCaption := CopyStr(ProductName, 1, MaxStrLen(LoanProductDCaption));
                    end;
    end;

    local procedure AddLoanDeductionToColumn(var PayrollTrans: Record "Payroll Period Transactions")
    var
        Loan: Record Loans;
    begin
        LoansAmount += PayrollTrans.Amount;

        if not Loan.Get(PayrollTrans."Loan No.") then begin
            exit;
        end;

        case Loan."Loan Product Type" of
            LoanProductAKey:
                LoanProductA += PayrollTrans.Amount;
            LoanProductBKey:
                LoanProductB += PayrollTrans.Amount;
            LoanProductCKey:
                LoanProductC += PayrollTrans.Amount;
            LoanProductDKey:
                LoanProductD += PayrollTrans.Amount;
        end;
    end;

    local procedure ContainsText(SourceText: Text; SearchText: Text): Boolean
    begin
        exit(StrPos(UpperCase(SourceText), UpperCase(SearchText)) > 0);
    end;

    local procedure TransactionMatches(var PayrollTrans: Record "Payroll Period Transactions"; SearchText: Text): Boolean
    begin
        exit(ContainsText(PayrollTrans."Transaction Name", SearchText) or
             ContainsText(PayrollTrans."Transaction Code", SearchText));
    end;

    procedure RestrictAccess()
    var
        StatusPermission: Record "User Setup";
        ErrorOnRestrictViewTxt: Label 'You do not have permissions to MODIFY or DELETE on this Page. Contact your system administrator for further details';
    begin
        StatusPermission.Reset();
        StatusPermission.SetRange("User ID", USERID);
        StatusPermission.SetRange(Payroll, true);
        if not StatusPermission.FindFirst() then
            Error(ErrorOnRestrictViewTxt);
    end;
}
