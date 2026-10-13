report 50203 "Staff Payslip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Staff Payslip.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", "Period Filter";

            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyAddressLine; CompanyAddressLine)
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(PayrollPeriodDisplay; PayrollPeriodDisplay)
            {
            }
            column(PIN_Employee; Employee.PIN)
            {
            }
            column(NSSFNo_Employee; Employee."NSSF No.")
            {
            }
            column(NHIFNo_Employee; Employee."NHIF No.")
            {
            }
            column(JobTitle; Employee."Job Title")
            {
            }
            column(LeaveBal; Employee."Leave Balance")
            {
            }
            column(DaysToRetirement; DaysToRetirement)
            {
            }
            column(BasicPayAmount; BasicPayAmount)
            {
            }
            column(OtherEarningsAmount; OtherEarningsAmount)
            {
            }
            column(GrossPayAmount; GrossPayAmount)
            {
            }
            column(DefinedContributionsAmount; DefinedContributionsAmount)
            {
            }
            column(TaxablePayAmount; TaxablePayAmount)
            {
            }
            column(TaxChargedAmount; TaxChargedAmount)
            {
            }
            column(PersonalReliefAmount; PersonalReliefAmount)
            {
            }
            column(NssfAmount; NssfAmount)
            {
            }
            column(ShifAmount; ShifAmount)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(HousingLevyAmount; HousingLevyAmount)
            {
            }
            column(OwnerOccupierAmount; OwnerOccupierAmount)
            {
            }
            column(InsuranceRelief; InsuranceRelief)
            {
            }
            column(PensionContributionAmount; PensionContributionAmount)
            {
            }
            column(PensionContributionBalance; PensionContributionBalance)
            {
            }
            column(SaccoDeductionsAmount; SaccoDeductionsAmount)
            {
            }
            column(SaccoDeductionsBalance; SaccoDeductionsBalance)
            {
            }
            column(SaccoWelfareAmount; SaccoWelfareAmount)
            {
            }
            column(SaccoWelfareBalance; SaccoWelfareBalance)
            {
            }
            column(TotalDeductionsAmount; TotalDeductionsAmount)
            {
            }
            column(NetPayAmount; NetPayAmount)
            {
            }

            dataitem(PeriodEarning; "Payroll Period Transactions")
            {
                DataItemLink = "Employee Code" = field("No.");
                DataItemTableView = sorting("Payslip Sort Order") order(ascending)
                where(
                    "Entry Type" = const(Employee),
                    Grouping = const(Allowances)
                );

                column(EarningDisplayName; EarningDisplayName)
                {
                }

                column(EarningAmount; PeriodEarning.Amount)
                {
                }

                column(EarningBalance; PeriodEarning.Balance)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EarningDisplayName := PeriodEarning."Transaction Name";

                    if PeriodEarning."Loan No." <> '' then
                        EarningDisplayName :=
                            CopyStr(
                                StrSubstNo('%1 (%2)', EarningDisplayName, PeriodEarning."Loan No."),
                                1,
                                MaxStrLen(EarningDisplayName));
                end;

                trigger OnPreDataItem()
                begin
                    PeriodEarning.SetRange("Payroll Period", Period);
                    PeriodEarning.SetFilter("Transaction Code", '<>%1', 'TOT-DED');
                end;
            }
            dataitem(PeriodDeduction; "Payroll Period Transactions")
            {
                DataItemLink = "Employee Code" = field("No.");
                DataItemTableView = sorting("Payslip Sort Order") order(ascending) where("Entry Type" = const(Employee), Grouping = const(Deductions));

                column(DeductionDisplayName; DeductionDisplayName)
                {
                }
                column(DeductionAmount; PeriodDeduction.Amount)
                {
                }
                column(DeductionBalance; PeriodDeduction.Balance)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DeductionDisplayName := PeriodDeduction."Transaction Name";
                    if PeriodDeduction."Loan No." <> '' then
                        DeductionDisplayName := CopyStr(StrSubstNo('%1 (%2)', DeductionDisplayName, PeriodDeduction."Loan No."), 1, MaxStrLen(DeductionDisplayName));
                end;

                trigger OnPreDataItem()
                begin
                    PeriodDeduction.SetRange("Payroll Period", Period);
                    PeriodDeduction.SetFilter("Transaction Code", '<>%1', 'TOT-DED');
                end;
            }

            trigger OnAfterGetRecord()
            var
                LeaveStatsMgt: Codeunit "HR Leave Statistics Mgt.";
                AllocatedDays: Decimal;
                EarnedDays: Decimal;
                ReImbursedDays: Decimal;
                TotalLeaveDays: Decimal;
                LeaveType: Code[20];
                DaysTaken: Decimal;
                TotalTaken: Decimal;
            begin
                LeaveType := GetAnnualLeaveType();

                EmployeeName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                DaysToRetirement := FormatDaysToRetirement(Employee."Birth Date");
                RestrictAccess();
                LoadPayslipSummary(Employee."No.");

                LeaveStatsMgt.GetLeaveStatistics(
                    Employee."No.",
                    LeaveType,
                    AllocatedDays,
                    EarnedDays,
                    ReImbursedDays,
                    TotalLeaveDays,
                    TotalTaken,
                    Employee."Leave Balance",
                    DaysTaken
                );
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                CompanyAddressLine := BuildCompanyAddressLine();

                if not CustomFilter then begin
                    PayrollPeriods.Reset();
                    PayrollPeriods.SetRange(Closed, false);
                    if PayrollPeriods.FindFirst() then
                        Period := PayrollPeriods."Date Opened";
                end else
                    Period := Employee.GetRangeMax("Period Filter");

                PayrollPeriods.Get(Period);
                PayrollPeriodDisplay := Format(PayrollPeriods."Date Opened", 0, '<Month Text>, <Year4>');


            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(CustomFilter; CustomFilter)
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
    end;

    var
        Period: Date;
        CompanyInfo: Record "Company Information";
        PayrollPeriods: Record "Payroll Periods";
        EarningDisplayName: Text[250];
        CustomFilter: Boolean;
        EmployeeName: Text;
        CompanyAddressLine: Text[250];
        PayrollPeriodDisplay: Text[50];
        DaysToRetirement: Text[50];
        BasicPayAmount: Decimal;
        OtherEarningsAmount: Decimal;
        GrossPayAmount: Decimal;
        DefinedContributionsAmount: Decimal;
        TaxablePayAmount: Decimal;
        TaxChargedAmount: Decimal;
        PersonalReliefAmount: Decimal;
        NssfAmount: Decimal;
        ShifAmount: Decimal;
        PayeAmount: Decimal;
        HousingLevyAmount: Decimal;
        OwnerOccupierAmount: Decimal;
        InsuranceRelief: Decimal;
        PensionContributionAmount: Decimal;
        PensionContributionBalance: Decimal;
        SaccoDeductionsAmount: Decimal;
        SaccoDeductionsBalance: Decimal;
        SaccoWelfareAmount: Decimal;
        SaccoWelfareBalance: Decimal;
        TotalDeductionsAmount: Decimal;
        NetPayAmount: Decimal;
        DeductionDisplayName: Text[250];

    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
        PayrollPeriod: Record "Payroll Periods";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst then begin
            SaccoPermissions.Get(UserId);
            if SaccoPermissions."Staff No" <> "Employee"."No." then
                Error('You do not have the following permission: "Payroll"');
        end;

        PayrollPeriod.Reset();
        PayrollPeriod.SetRange(Closed, true);
        if not PayrollPeriod.FindFirst() then
            Error('Cannot view Payslip for an open Payroll period');
    end;

    local procedure GetAnnualLeaveType(): Code[20]
    var
        HRLeaveTypes: Record "HR Leave Types.";
    begin
        hrLeaveTypes.Reset();
        hrLeaveTypes.SetRange("Is Annual Leave", true);
        if hrLeaveTypes.FindFirst() then
            exit(hrLeaveTypes.Code)
        else
            Error('No Annual Leave Type setup for this employee category. Please contact your administrator');
    end;

    local procedure LoadPayslipSummary(EmployeeNo: Code[20])
    var
        PeriodTransaction: Record "Payroll Period Transactions";
    begin
        ResetSummaryValues();

        PeriodTransaction.Reset();
        PeriodTransaction.SetRange("Employee Code", EmployeeNo);
        PeriodTransaction.SetRange("Payroll Period", Period);
        PeriodTransaction.SetRange("Entry Type", PeriodTransaction."Entry Type"::Employee);
        if PeriodTransaction.FindSet() then
            repeat
                case PeriodTransaction.Grouping of
                    PeriodTransaction.Grouping::"Basic Salary":
                        if (PeriodTransaction."Sub Group" = PeriodTransaction."Sub Group"::" ") or
                           (PeriodTransaction."Sub Group" = PeriodTransaction."Sub Group"::BasicPay) then
                            BasicPayAmount += PeriodTransaction.Amount
                        else
                            OtherEarningsAmount += PeriodTransaction.Amount;
                    PeriodTransaction.Grouping::Allowances:
                        OtherEarningsAmount += PeriodTransaction.Amount;
                    PeriodTransaction.Grouping::"Gross Salary":
                        GrossPayAmount += PeriodTransaction.Amount;
                    PeriodTransaction.Grouping::"Net Salary":
                        NetPayAmount += PeriodTransaction.Amount;
                end;

                if PeriodTransaction.Grouping = PeriodTransaction.Grouping::"Tax Calculations" then
                    case PeriodTransaction."Sub Group" of
                        PeriodTransaction."Sub Group"::"Taxable Pay":
                            TaxablePayAmount += PeriodTransaction.Amount;
                        PeriodTransaction."Sub Group"::"Tax Charged":
                            TaxChargedAmount += PeriodTransaction.Amount;
                        PeriodTransaction."Sub Group"::"Owner Occupier":
                            OwnerOccupierAmount += PeriodTransaction.Amount;
                        PeriodTransaction."Sub Group"::"Insurance Relief":
                            InsuranceRelief += PeriodTransaction.Amount;
                    end;

                if PeriodTransaction."Transaction Code" = 'PSNR' then
                    PersonalReliefAmount += PeriodTransaction.Amount;

                if PeriodTransaction.Grouping = PeriodTransaction.Grouping::Statutories then
                    case PeriodTransaction."Sub Group" of
                        PeriodTransaction."Sub Group"::NSSF:
                            NssfAmount += PeriodTransaction.Amount;
                        PeriodTransaction."Sub Group"::NHIF:
                            ShifAmount += PeriodTransaction.Amount;
                        PeriodTransaction."Sub Group"::PAYE:
                            PayeAmount += PeriodTransaction.Amount;
                        PeriodTransaction."Sub Group"::"Housing Levy":
                            HousingLevyAmount += PeriodTransaction.Amount;
                    end;

                if PeriodTransaction."Transaction Code" = 'TOT-DED' then
                    TotalDeductionsAmount += PeriodTransaction.Amount;

                if PeriodTransaction.Grouping = PeriodTransaction.Grouping::Deductions then
                    if PeriodTransaction."Transaction Code" <> 'TOT-DED' then
                        if IsPensionTransaction(PeriodTransaction."Transaction Code") then begin
                            PensionContributionAmount += PeriodTransaction.Amount;
                            PensionContributionBalance += PeriodTransaction.Balance;
                        end
                        else
                            if IsWelfareTransaction(PeriodTransaction."Transaction Code") then begin
                                SaccoWelfareAmount += PeriodTransaction.Amount;
                                SaccoWelfareBalance += PeriodTransaction.Balance;
                            end
                            else begin
                                SaccoDeductionsAmount += PeriodTransaction.Amount;
                                SaccoDeductionsBalance += PeriodTransaction.Balance;
                            end;
            until PeriodTransaction.Next() = 0;

        LoadGymClaimEarnings(EmployeeNo);

        DefinedContributionsAmount := GrossPayAmount - TaxablePayAmount;
    end;

    local procedure LoadGymClaimEarnings(EmployeeNo: Code[20])
    var
        GymClaims: Record "Employee Gym Claims";
        PeriodTransaction: Record "Payroll Period Transactions";
    begin

        GymClaims.Reset();
        GymClaims.SetRange("Employee Code", EmployeeNo);
        GymClaims.SetRange("Payroll Period", Period);
        GymClaims.SetRange(Status, GymClaims.Status::Posted);
        GymClaims.SetRange(Posted, true);
        if not GymClaims.FindSet() then
            exit;

        repeat

            PeriodTransaction.Reset();
            PeriodTransaction.SetRange("Employee Code", EmployeeNo);
            PeriodTransaction.SetRange("Payroll Period", Period);
            PeriodTransaction.SetRange("Entry Type", PeriodTransaction."Entry Type"::Employee);
            PeriodTransaction.SetRange("Transaction Code", GymClaims."Transaction Code");
            if not PeriodTransaction.FindFirst() then
                OtherEarningsAmount += GymClaims."Gross Amount";

        until GymClaims.Next() = 0;
    end;

    local procedure ResetSummaryValues()
    begin
        BasicPayAmount := 0;
        OtherEarningsAmount := 0;
        GrossPayAmount := 0;
        DefinedContributionsAmount := 0;
        TaxablePayAmount := 0;
        TaxChargedAmount := 0;
        PersonalReliefAmount := 0;
        NssfAmount := 0;
        ShifAmount := 0;
        PayeAmount := 0;
        HousingLevyAmount := 0;
        OwnerOccupierAmount := 0;
        InsuranceRelief := 0;
        PensionContributionAmount := 0;
        PensionContributionBalance := 0;
        SaccoDeductionsAmount := 0;
        SaccoDeductionsBalance := 0;
        SaccoWelfareAmount := 0;
        SaccoWelfareBalance := 0;
        TotalDeductionsAmount := 0;
        NetPayAmount := 0;
    end;

    local procedure BuildCompanyAddressLine(): Text[250]
    var
        AddressLine: Text[250];
        PostCodeCity: Text[100];
    begin
        AddressLine := CompanyInfo.Address;
        if AddressLine = '' then
            AddressLine := CompanyInfo."Address 2";

        if (CompanyInfo."Post Code" <> '') and (CompanyInfo.City <> '') then
            PostCodeCity := CompanyInfo."Post Code" + '-' + CompanyInfo.City
        else
            if CompanyInfo."Post Code" <> '' then
                PostCodeCity := CompanyInfo."Post Code"
            else
                PostCodeCity := CompanyInfo.City;
        if PostCodeCity <> '' then begin
            if AddressLine <> '' then
                AddressLine := AddressLine + ', ';
            AddressLine := CopyStr(AddressLine + PostCodeCity, 1, MaxStrLen(AddressLine));
        end;

        exit(AddressLine);
    end;

    local procedure FormatDaysToRetirement(DateOfBirth: Date): Text[50]
    var
        HRSetup: Record "HR Setup.";
        RetirementAgeFormula: DateFormula;
        RetirementDate: Date;
        RemainingMonths: Integer;
        Years: Integer;
        Months: Integer;
        RetirementText: Text[50];
    begin
        if DateOfBirth = 0D then
            exit('');

        HRSetup.Get();
        HRSetup.TestField("Retirement Age");
        Evaluate(RetirementAgeFormula, StrSubstNo('<%1Y>', HRSetup."Retirement Age"));
        RetirementDate := CalcDate(RetirementAgeFormula, DateOfBirth);

        if RetirementDate < Today then
            exit('Retired');

        RemainingMonths :=
            ((Date2DMY(RetirementDate, 3) - Date2DMY(Today, 3)) * 12) +
            Date2DMY(RetirementDate, 2) - Date2DMY(Today, 2);

        if Date2DMY(RetirementDate, 1) < Date2DMY(Today, 1) then
            RemainingMonths -= 1;

        if RemainingMonths < 0 then
            RemainingMonths := 0;

        Years := RemainingMonths div 12;
        Months := RemainingMonths mod 12;

        if Years > 0 then begin
            RetirementText := Format(Years) + ' year';
            if Years <> 1 then
                RetirementText += 's';
        end;

        if Months > 0 then begin
            if RetirementText <> '' then
                RetirementText += ' and ';

            RetirementText += Format(Months) + ' month';
            if Months <> 1 then
                RetirementText += 's';
        end;

        if RetirementText = '' then
            RetirementText := '0 months';

        exit(RetirementText);
    end;

    local procedure IsPensionTransaction(TransactionCode: Code[20]): Boolean
    begin
        exit(
          (TransactionCode = 'D0001') or
          (TransactionCode = 'D0020') or
          (TransactionCode = 'D002') or
          (TransactionCode = 'D017'));
    end;

    local procedure IsWelfareTransaction(TransactionCode: Code[20]): Boolean
    begin
        exit(TransactionCode = 'D001');
    end;
}
