report 50693 "NSSF Tier 2 Schedule"
{
    ApplicationArea = All;
    Caption = 'NSSF Tier 2 Schedule';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/NSSF Tier 2 Schedule.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("prSalary Card"; "Staff Payroll Details")
        {
            RequestFilterFields = "Employee Code";

            column(ReportForNavId_6207; 6207)
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
            column(PeriodYear; PeriodYear)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(COMPANYNAME; CompanyInfo.Name)
            {
            }
            column(PeriodName_Control1102756011; PeriodName)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Volume_Amount_; 0)
            {
            }
            column(IDNumber; IdNumber)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "Employee Code")
            {
            }
            column(NssfAmount_1; EmployeeTier2Amount)
            {
            }
            column(NssfAmount_2; EmployerTier2Amount)
            {
            }
            column(NssfNo; NssfNo)
            {
            }
            column(NssfAmount_2_Control1102756008; TotalAmount)
            {
            }
            column(TotNssfAmount_2; TotalAmount)
            {
            }
            column(totTotalAmount; 0)
            {
            }
            column(TotVolume_Amount_; 0)
            {
            }
            column(TotNssfAmount_2_Control1102756015; TotalAmount)
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUNDCaption; NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl)
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
            column(PERIOD_Caption_Control1102755031; PERIOD_Caption_Control1102755031Lbl)
            {
            }
            column(EMPLOYER_NO_Caption; EMPLOYER_NO_CaptionLbl)
            {
            }
            column(EMPLOYER_NAME_Caption; EMPLOYER_NAME_CaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(NSSF_No_Caption; NSSF_No_CaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(Vol_AmountCaption; ID_Number_CaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Employee_AmountCaption; Employee_AmountCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(Total_Amounts_Caption; Total_Amounts_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(EmployeeName);
                Clear(NssfNo);
                Clear(IdNumber);
                Clear(EmployeeTier2Amount);
                Clear(EmployerTier2Amount);
                Clear(TotalAmount);

                if Employee.Get("Employee Code") then begin
                    EmployeeName := CopyStr(Employee.FullName(), 1, MaxStrLen(EmployeeName));
                    NssfNo := Employee."NSSF No.";
                    IdNumber := Employee."National Id";
                    if IdNumber = '' then
                        IdNumber := Employee."Personal ID No.";
                end else
                    EmployeeName := "Employee Code";

                EmployeeTier2Amount := GetNssfTier2Amount("Employee Code", PeriodTrans."Entry Type"::Employee);
                EmployerTier2Amount := GetNssfTier2Amount("Employee Code", PeriodTrans."Entry Type"::Employer);
                if EmployerTier2Amount = 0 then
                    EmployerTier2Amount := EmployeeTier2Amount;
                TotalAmount := EmployeeTier2Amount + EmployerTier2Amount;

                if TotalAmount = 0 then
                    CurrReport.Skip();
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
                field(Period; Period)
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Period';
                    TableRelation = "Payroll Periods"."Date Opened";
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if Period = 0D then
            Error('You must specify the period filter');

        RestrictAccess();

        SelectedPeriod := Period;
        if PayrollPeriod.Get(SelectedPeriod) then begin
            PeriodName := PayrollPeriod."Period Name";
            PeriodYear := PayrollPeriod."Period Year";
        end else begin
            PeriodName := Format(SelectedPeriod, 0, '<Month Text>-<Year4>');
            PeriodYear := Date2DMY(SelectedPeriod, 3);
        end;

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(Picture);
    end;

    var
        PeriodTrans: Record "Payroll Period Transactions";
        PayrollCodes: Record "Payroll Codes";
        Employee: Record Employee;
        PayrollPeriod: Record "Payroll Periods";
        CompanyInfo: Record "Company Information";
        Period: Date;
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodYear: Integer;
        EmployeeName: Text[100];
        NssfNo: Text[30];
        IdNumber: Text[30];
        EmployeeTier2Amount: Decimal;
        EmployerTier2Amount: Decimal;
        TotalAmount: Decimal;
        NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl: Label 'United Women Sacco NSSF Tier 2 Report';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        PERIOD_Caption_Control1102755031Lbl: Label 'PERIOD:';
        EMPLOYER_NO_CaptionLbl: Label 'EMPLOYER NO:';
        EMPLOYER_NAME_CaptionLbl: Label 'EMPLOYER NAME:';
        Payroll_No_CaptionLbl: Label 'Payroll No:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        NSSF_No_CaptionLbl: Label 'NSSF No:';
        ID_Number_CaptionLbl: Label 'ID Number:';
        Employee_AmountCaptionLbl: Label 'Employee Tr2 Amount';
        Employer_AmountCaptionLbl: Label 'Employer Tr2 Amount';
        Total_AmountCaptionLbl: Label 'Total Amount';
        Total_Amounts_CaptionLbl: Label 'Total Amounts:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'PREPARED BY:                                      SIGN:                         DATE:';
        Checked_by________________________________________Date_________________CaptionLbl: Label '';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'AUTHORIZED BY:                                    SIGN:                         DATE:';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'APPROVED BY:                                      SIGN:                         DATE:';

    local procedure GetNssfTier2Amount(EmployeeNo: Code[50]; EntryType: Option " ",Employer,Employee): Decimal
    var
        Tier2Amount: Decimal;
    begin
        PeriodTrans.Reset();
        PeriodTrans.SetRange("Employee Code", EmployeeNo);
        PeriodTrans.SetRange("Payroll Period", SelectedPeriod);
        PeriodTrans.SetRange("Entry Type", EntryType);
        PeriodTrans.SetRange("Sub Group", PeriodTrans."Sub Group"::NSSF);
        PeriodTrans.SetFilter("Transaction Name", '@*Tier 2*');

        if PeriodTrans.FindSet() then
            repeat
                if IsNssfTransaction(PeriodTrans) then
                    Tier2Amount += PeriodTrans.Amount;
            until PeriodTrans.Next() = 0;

        exit(Tier2Amount);
    end;

    local procedure IsNssfTransaction(var NssfTrans: Record "Payroll Period Transactions"): Boolean
    begin
        if NssfTrans."Special Identifier" = NssfTrans."Special Identifier"::NSSF then
            exit(true);

        PayrollCodes.Reset();
        PayrollCodes.SetRange("Transaction Code", NssfTrans."Transaction Code");
        PayrollCodes.SetRange("Special Identifier", PayrollCodes."Special Identifier"::NSSF);
        if PayrollCodes.FindFirst() then
            exit(true);

        exit(ContainsText(NssfTrans."Transaction Name", 'NSSF'));
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
