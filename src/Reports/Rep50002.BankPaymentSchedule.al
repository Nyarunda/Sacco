report 50002 "Bank Payment Schedule"
{
    ApplicationArea = All;
    Caption = 'Bank Payment Schedule';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Bank Payment Schedule.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", Status, "Job Title";

            column(CompanyName; CompanyName())
            {
            }
            column(PayrollPeriod; SelectedPeriod)
            {
            }
            column(EmployeeNo; "No.")
            {
            }
            column(EmployeeName; FullName())
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
            column(GrossPay; GrossPay)
            {
            }
            column(TotalEarnings; TotalEarnings)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(Bank_Code;"Bank Code")
            {}
            column(Branch_Name;"Branch Name")
            {}

            trigger OnAfterGetRecord()
            begin
                Clear(BankName);
                Clear(BankAccountNo);
                Clear(BasicPay);
                Clear(GrossPay);
                Clear(TotalEarnings);
                Clear(TotalDeductions);
                Clear(CalculatedDeductions);
                Clear(NetAmount);

                BankName := Employee."Bank Name";
                BankAccountNo := Employee."Bank Account No.";
           

                PeriodTrans.Reset();
                PeriodTrans.SetRange("Employee Code", Employee."No.");
                PeriodTrans.SetRange("Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange("Entry Type", PeriodTrans."Entry Type"::Employee);

                if PeriodTrans.FindSet() then begin
                    repeat
                        if (BankName = '') and (PeriodTrans."Bank Name" <> '') then
                            BankName := PeriodTrans."Bank Name";

                        if (BankAccountNo = '') and (PeriodTrans."A/C Number" <> '') then
                            BankAccountNo := PeriodTrans."A/C Number";

                        ClassifyTransaction(PeriodTrans);
                    until PeriodTrans.Next() = 0;
                end else
                    CurrReport.Skip();

                if GrossPay = 0 then
                    GrossPay := BasicPay + TotalEarnings;

                if TotalDeductions = 0 then
                    TotalDeductions := CalculatedDeductions;

                if NetAmount = 0 then
                    NetAmount := GrossPay - TotalDeductions;

                if (BasicPay = 0) and (GrossPay = 0) and (TotalEarnings = 0) and (TotalDeductions = 0) and (NetAmount = 0) then
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(SelectedPeriod; SelectedPeriod)
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
            area(Processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        if SelectedPeriod = 0D then
            Error('Payroll Period must be selected.');
    end;

    var
        PeriodTrans: Record "Payroll Period Transactions";
        SelectedPeriod: Date;
        BankName: Text[100];
        BankAccountNo: Text[100];
        BasicPay: Decimal;
        GrossPay: Decimal;
        TotalEarnings: Decimal;
        TotalDeductions: Decimal;
        CalculatedDeductions: Decimal;
        NetAmount: Decimal;

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
            exit;
        end;

        if (PayrollTrans.Grouping in [PayrollTrans.Grouping::Statutories,
                                      PayrollTrans.Grouping::Deductions,
                                      PayrollTrans.Grouping::"Housing Levy",
                                      PayrollTrans.Grouping::"Housing Levy Levy",
                                      PayrollTrans.Grouping::Fringe]) or
           (PayrollTrans."Payroll Code Type" in [PayrollTrans."Payroll Code Type"::Deduction,
                                                PayrollTrans."Payroll Code Type"::PAYE])
        then
            CalculatedDeductions += PayrollTrans.Amount;
    end;
}
