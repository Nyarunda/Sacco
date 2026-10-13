
Report 50212 "HR Leave Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Leave Statement.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", "Leave Type Filter";
            CalcFields = CurrYearStart, CurrYearEnd;
            column(ReportForNavId_6075; 6075)
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
            column(Name; "First Name" + ' ' + "Middle Name")
            {
            }
            column(Balance; RunningLeaveBalance)
            {
            }
            dataitem("HR Leave Ledger Entries."; "HR Leave Ledger Entries.")
            {
                DataItemLink = "Staff No." = field("No."), "Leave Type" = field("Leave Type Filter");
                DataItemTableView = sorting("Posting Date", "Leave Entry Type", "Staff No.") where(Reversed = const(false));

                column(ReportForNavId_4961; 4961)
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Period_; "Leave Calendar Code")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_; "Leave Entry Type")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_; "Leave Type")
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_; "No. of days")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_; "Leave Posting Description")
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_; "Posting Date")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_Caption; FieldCaption("Leave Entry Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_Caption; FieldCaption("Leave Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_Caption; FieldCaption("No. of days"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_Caption; FieldCaption("Leave Posting Description"))
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Period_Caption; FieldCaption("Leave Calendar Code"))
                {
                }
                column(HR_Leave_Ledger_Entries_Entry_No_; "Entry No.")
                {
                }
                column(HR_Leave_Ledger_Entries_Staff_No_; "Staff No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    No := No + 1;
                    case "Leave Entry Type" of
                        "Leave Entry Type"::Negative:
                            RunningLeaveBalance -= Abs("No. of days");
                        else
                            RunningLeaveBalance += Abs("No. of days");
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    "HR Leave Ledger Entries.".SetRange("Posting Date", Employee.CurrYearStart, Employee.CurrYearEnd);
                    //"HR Leave Ledger Entries".SETFILTER("HR Leave Ledger Entries"."Leave Type",
                    //"HR-Employee".GETFILTER("HR-Employee"."Leave Type Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(AllocatedDaysStat);
                Clear(TotalTakenStat);
                Clear(ReImbursedDaysStat);
                Clear(TotalLeaveDaysStat);
                Clear(EarnedDaysStat);
                Clear(LeaveBalanceStat);
                Clear(DaysTakenStat);

                LeaveStatsMgt.GetLeaveStatistics(
                    Employee."No.",
                    CopyStr(Employee.GetFilter("Leave Type Filter"), 1, 50),
                    AllocatedDaysStat,
                    EarnedDaysStat,
                    ReImbursedDaysStat,
                    TotalLeaveDaysStat,
                    TotalTakenStat,
                    LeaveBalanceStat,
                    DaysTakenStat);

                LeaveBalance := LeaveBalanceStat;
                RunningLeaveBalance := 0;
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
        RunningLeaveBalance: Decimal;
        EmployeeCaptionLbl: label 'Employee';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_Leave_StatementCaptionLbl: label 'Employee Leave Statement';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        NameCaptionLbl: label 'Name';
        Leave_BalanceCaptionLbl: label 'Leave Balance';
        Day_s_CaptionLbl: label 'Day(s)';
        No: Decimal;
        AllocatedDaysStat: Decimal;
        TotalTakenStat: Decimal;
        ReImbursedDaysStat: Decimal;
        TotalLeaveDaysStat: Decimal;
        EarnedDaysStat: Decimal;
        LeaveBalanceStat: Decimal;
        DaysTakenStat: Decimal;
        LeaveStatsMgt: Codeunit "HR Leave Statistics Mgt.";
}
