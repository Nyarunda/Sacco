report 50692 "Staff Welfare Schedule"
{
    ApplicationArea = All;
    Caption = 'Staff Welfare Schedule';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Staff Welfare Schedule.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where(Status = const(Active));
            RequestFilterFields = "No.";

            column(ReportForNavId_8631; 8631)
            {
            }
            column(TransName; TransName)
            {
            }
            column(BankBranchCode_Employee; '')
            {
            }
            column(BankCode_Employee; Employee."Bank Code")
            {
            }
            column(BankAccountNo_Employee; Employee."Bank Account No.")
            {
            }
            column(EmployerAmtPresent; '')
            {
            }
            column(UserId; UserId)
            {
            }
            column(Today; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(NHIFNo; '')
            {
            }
            column(Address; CompanyAddressLine)
            {
            }
            column(PeriodName_Control1102760003; PeriodName)
            {
            }
            column(TelNo; CompanyInfo."Phone No.")
            {
            }
            column(HR_Employee__No__; Employee."No.")
            {
            }
            column(HR_Employee__NHIF_No__; WelfareAmount)
            {
            }
            column(PeriodYear; PeriodYear)
            {
            }
            column(EmployeeAmt; WelfareAmount)
            {
            }
            column(EmployerAmt; 0)
            {
            }
            column(HR_Employee__Last_Name_; EmployeeName)
            {
            }
            column(IDs; IdNumber)
            {
            }
            column(PersonalIDNo_Employee; IdNumber)
            {
            }
            column(EmployeeName; '')
            {
            }
            column(TotNhifAmount; WelfareAmount)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUNDCaption; NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(EMPLOYER_NO_Caption; EMPLOYER_NO_CaptionLbl)
            {
            }
            column(ADDRESS_Caption; ADDRESS_CaptionLbl)
            {
            }
            column(PERIOD_Caption_Control1102755031; PERIOD_Caption_Control1102755031Lbl)
            {
            }
            column(TEL_NO_Caption; TEL_NO_CaptionLbl)
            {
            }
            column(HR_Employee__No__Caption; PayrollNoCaptionLbl)
            {
            }
            column(HR_Employee__ID_Number_Caption; IdNumberCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(LAST_NAMECaption; EmployeeNameCaptionLbl)
            {
            }
            column(OTHER_NAMESCaption; '')
            {
            }
            column(HR_Employee__NHIF_No__Caption; AmountCaptionLbl)
            {
            }
            column(prepared; Preparedby)
            {
            }
            column(checked; Checkedby)
            {
            }
            column(authorized; Authorizedby)
            {
            }
            column(approved; Approvedby)
            {
            }
            column(Total_NHIF_Caption; TotalWelfareCaptionLbl)
            {
            }
            column(Counter; Counter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                EmployeeName := CopyStr(Employee.FullName(), 1, MaxStrLen(EmployeeName));
                IdNumber := Employee."National Id";
                if IdNumber = '' then
                    IdNumber := Employee."Personal ID No.";

                WelfareAmount := GetEmployeeWelfareAmount(Employee."No.");
                if WelfareAmount = 0 then
                    CurrReport.Skip();

                Counter += 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
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
    }

    trigger OnPreReport()
    begin
        if PayrollPeriod = 0D then
            Error('Please specify payroll period.');

        RestrictAccess();
        LoadHeaderInfo();
        Counter := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        PayrollPeriods: Record "Payroll Periods";
        PayrollCodes: Record "Payroll Codes";
        PayrollPeriod: Date;
        PeriodName: Text[50];
        PeriodYear: Integer;
        CompanyAddressLine: Text[250];
        EmployeeName: Text[100];
        IdNumber: Text[30];
        WelfareAmount: Decimal;
        Counter: Integer;
        TransName: Text[200];
        NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl: Label 'STAFF WELFARE CONTRIBUTIONS';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        EMPLOYER_NO_CaptionLbl: Label 'EMPLOYER NO:';
        ADDRESS_CaptionLbl: Label 'ADDRESS:';
        PERIOD_Caption_Control1102755031Lbl: Label 'PERIOD:';
        TEL_NO_CaptionLbl: Label 'TEL NO:';
        PayrollNoCaptionLbl: Label 'Payroll No:';
        IdNumberCaptionLbl: Label 'ID Number:';
        EmployeeNameCaptionLbl: Label 'Employee Name';
        AmountCaptionLbl: Label 'Amount';
        TotalWelfareCaptionLbl: Label 'Total Welfare:';
        Preparedby: Label 'Prepared By:.......................................................................................';
        Checkedby: Label 'Checked By:........................................................................................';
        Authorizedby: Label 'Authorised By:....................................................................................';
        Approvedby: Label '';

    local procedure GetEmployeeWelfareAmount(EmployeeNo: Code[20]): Decimal
    var
        WelfareTrans: Record "Payroll Period Transactions";
        WelfareTotal: Decimal;
    begin
        WelfareTrans.Reset();
        WelfareTrans.SetRange("Employee Code", EmployeeNo);
        WelfareTrans.SetRange("Payroll Period", PayrollPeriod);
        WelfareTrans.SetRange("Entry Type", WelfareTrans."Entry Type"::Employee);

        if WelfareTrans.FindSet() then
            repeat
                if IsStaffWelfareTransaction(WelfareTrans) then
                    WelfareTotal += WelfareTrans.Amount;
            until WelfareTrans.Next() = 0;

        exit(WelfareTotal);
    end;

    local procedure IsStaffWelfareTransaction(var WelfareTrans: Record "Payroll Period Transactions"): Boolean
    begin
        exit(
            ContainsText(WelfareTrans."Transaction Name", 'WELFARE') or
            ContainsText(WelfareTrans."Transaction Code", 'WELFARE'));
    end;

    local procedure LoadHeaderInfo()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyAddressLine := BuildCompanyAddressLine();

        PeriodName := Format(PayrollPeriod, 0, '<Month Text>-<Year4>');
        PeriodYear := Date2DMY(PayrollPeriod, 3);
        if PayrollPeriods.Get(PayrollPeriod) then begin
            if PayrollPeriods."Period Name" <> '' then
                PeriodName := PayrollPeriods."Period Name";
            PeriodYear := PayrollPeriods."Period Year";
        end;

        TransName := 'Staff Welfare';
        PayrollCodes.Reset();
        PayrollCodes.SetRange("Special Transactions", PayrollCodes."Special Transactions"::"Staff Welfare");
        if PayrollCodes.FindFirst() then
            TransName := PayrollCodes."Transaction Name";
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

    local procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset();
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst() then
            Error('You do not have the following permission: "Payroll"');
    end;

    local procedure ContainsText(SourceText: Text; SearchText: Text): Boolean
    begin
        exit(StrPos(UpperCase(SourceText), UpperCase(SearchText)) > 0);
    end;
}
