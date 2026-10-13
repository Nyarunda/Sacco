
Report 50216 "HR Leave Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Leave Balances.rdlc';
    UsageCategory = ReportsandAnalysis;
    // HR Leave Balances
    // Name; Emp Code; Bal B/f; Annual Days; Total (BF+Annual);Earned; Taken; BAlance;
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", "Leave Type Filter";
            column(ReportForNavId_6075; 6075)
            {
            }
            column(LeaveType; Employee.GetFilter("Leave Type Filter"))
            {
            }
            column(AllocatedDays; AllocatedDaysStat)
            {
            }
            column(TotalTaken; TotalTakenStat)
            {
            }
            column(ReImbursedDays; ReImbursedDaysStat)
            {
            }
            column(TotalLeaveDays; TotalLeaveDaysStat)
            {
            }
            column(EarnedDays; EarnedDaysStat)
            {
            }
            column(LeaveBalance; LeaveBalanceStat)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(UserId; "User ID")
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__FullName; "First Name" + ' ' + "Middle Name")
            {
            }
            column(HR_Employees__HR_Employees___Leave_Balance_mployee; LeaveBalance)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Leave_StatementCaption; Employee_Leave_StatementCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; FieldCaption("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Leave_BalanceCaption; Leave_BalanceCaptionLbl)
            {
            }
            column(Day_s_Caption; Day_s_CaptionLbl)
            {
            }
            column(No; No)
            {
            }
            column(Employee_No; "No.")
            {
            }
            column(Name; FullName)
            {
            }
            column(Balance; LeaveBalance)
            {
            }
            column(BalanceBF; BalanceBF)
            {
            }
            trigger OnAfterGetRecord()
            var
                LeaveTypeCode: Code[20];
            begin
                Clear(AllocatedDaysStat);
                Clear(TotalTakenStat);
                Clear(ReImbursedDaysStat);
                Clear(TotalLeaveDaysStat);
                Clear(EarnedDaysStat);
                Clear(LeaveBalanceStat);
                Clear(DaysTakenStat);
                Clear(BalanceBF);

                LeaveTypeCode := CopyStr(Employee.GetFilter("Leave Type Filter"), 1, MaxStrLen(LeaveTypeCode));

                LeaveStatsMgt.GetLeaveStatistics(
                    Employee."No.",
                    LeaveTypeCode,
                    AllocatedDaysStat,
                    EarnedDaysStat,
                    ReImbursedDaysStat,
                    TotalLeaveDaysStat,
                    TotalTakenStat,
                    LeaveBalanceStat,
                    DaysTakenStat);

                LeaveBalance := LeaveBalanceStat;

                BalanceBF := ReImbursedDaysStat;

                if (AllocatedDaysStat = 0) and (EarnedDaysStat = 0) and (ReImbursedDaysStat = 0) and
                   (TotalLeaveDaysStat = 0) and (TotalTakenStat = 0) and (LeaveBalanceStat = 0) then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin

                if Employee.GetFilter("Leave Type Filter") = '' then
                    Error('Leave Type Filtr MUST be captured');
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

    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();

        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        LeaveBalance: Decimal;
        EmployeeCaptionLbl: label 'Employee';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_Leave_StatementCaptionLbl: label 'Employee Leave Statement';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        NameCaptionLbl: label 'Name';
        Leave_BalanceCaptionLbl: label 'Leave Balance';
        Day_s_CaptionLbl: label 'Day(s)';
        No: Decimal;
        HREmp: Record Employee;
        AllocatedDaysStat: Decimal;
        TotalTakenStat: Decimal;
        ReImbursedDaysStat: Decimal;
        TotalLeaveDaysStat: Decimal;
        m: Integer;
        EarnedDaysStat: Decimal;
        LeaveBalanceStat: Decimal;
        DaysTakenStat: Decimal;
        HRLeaveTypes: Record "HR Leave Types.";
        LeaveStatsMgt: Codeunit "HR Leave Statistics Mgt.";

        BalanceBF: Decimal;

        AnnualDays: Decimal;

        TotalLeaveBal: Decimal;
        Month: Integer;


    procedure GetLeaveStatistics(LeaveType: Text[50])
    begin
        LeaveStatsMgt.GetLeaveStatistics(
            Employee."No.",
            LeaveType,
            AllocatedDaysStat,
            EarnedDaysStat,
            ReImbursedDaysStat,
            TotalLeaveDaysStat,
            TotalTakenStat,
            LeaveBalanceStat,
            DaysTakenStat);
    end;

}
