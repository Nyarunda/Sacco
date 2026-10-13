codeunit 51018 "HR Leave Statistics Mgt."
{
    procedure GetLeaveStatistics(EmployeeNo: Code[20]; LeaveType: Code[50]; var AllocatedDays: Decimal; var EarnedDays: Decimal; var ReImbursedDays: Decimal; var TotalLeaveDays: Decimal; var TotalTaken: Decimal; var LeaveBalance: Decimal; var DaysTaken: Decimal)
    var
        Emp: Record Employee;
        HREmp: Record Employee;
        LLE: Record "HR Leave Ledger Entries.";
        HRCalender: Record "HR Leave Calendar.";
        HRLeaveTypes: Record "HR Leave Types.";
        CurrPeriod: Code[20];
        LeaveMonth: Date;
        MonthsEarned: Integer;
        BroughtForward: Decimal;
    begin
        Clear(AllocatedDays);
        Clear(EarnedDays);
        Clear(ReImbursedDays);
        Clear(TotalLeaveDays);
        Clear(TotalTaken);
        Clear(LeaveBalance);
        Clear(DaysTaken);

        if (EmployeeNo = '') or (LeaveType = '') then
            exit;

        if not Emp.Get(EmployeeNo) then
            exit;

        Emp.CalcFields(CurrYearStart, CurrYearEnd);

        HRCalender.Reset();
        HRCalender.SetRange("Current Leave Calendar", true);
        if HRCalender.FindFirst() then
            CurrPeriod := HRCalender."Calendar Code";

        HREmp.Reset();
        HREmp.SetRange("No.", EmployeeNo);
        HREmp.SetFilter("Leave Type Filter", LeaveType);
        HREmp.SetRange("Date Filter", Emp.CurrYearStart, Emp.CurrYearEnd);

        if not HREmp.FindFirst() then
            exit;

        HREmp.CalcFields("Reimbursed Leave Days", "Total Leave Taken", "Allocated Leave Days", "Brought Froward Leave Days");

        TotalTaken := HREmp."Total Leave Taken";
        BroughtForward := HREmp."Brought Froward Leave Days";
        AllocatedDays := HREmp."Allocated Leave Days";
        ReImbursedDays := HREmp."Reimbursed Leave Days" + BroughtForward;
        DaysTaken := TotalTaken;
        TotalLeaveDays := AllocatedDays + ReImbursedDays;

        LLE.Reset();
        LLE.SetRange("Staff No.", EmployeeNo);
        LLE.SetRange("Leave Entry Type", LLE."Leave Entry Type"::Positive);
        LLE.SetRange(Closed, false);
        LLE.SetRange("Leave Type", LeaveType);
        LLE.SetRange("Leave Calendar Code", CurrPeriod);
        if LLE.FindSet() then begin
            LLE.CalcSums("No. of days");
            AllocatedDays := LLE."No. of days";
            TotalLeaveDays := AllocatedDays + ReImbursedDays;
        end;

        LeaveMonth := Today;
        if Date2DMY(Today, 1) < Date2DMY(CalcDate('<CM>', Today), 1) then
            LeaveMonth := CalcDate('-1M', Today);

        MonthsEarned := Date2DMY(LeaveMonth, 2);

        // If employee joined within the current leave calendar/year, earn from employment month.
        // If employee joined before current leave year, earn from January/current leave year start.
        if HREmp."Contract Start Date" <> 0D then begin
            if (HREmp."Contract Start Date" >= CalcDate('<-CY>', Today)) and (HREmp."Contract Start Date" <= CalcDate('<CY>', Today)) then
                MonthsEarned := Date2DMY(LeaveMonth, 2) - Date2DMY(HREmp."Contract Start Date", 2);
        end else
            if (HREmp."Employment Date" >= CalcDate('<-CY>', Today)) and (HREmp."Employment Date" <= CalcDate('<CY>', Today)) then
                MonthsEarned := Date2DMY(LeaveMonth, 2) - Date2DMY(HREmp."Employment Date", 2) + 1;

        if MonthsEarned < 0 then
            MonthsEarned := 0;

        if MonthsEarned > 12 then
            MonthsEarned := 12;

        if HRLeaveTypes.Get(CopyStr(LeaveType, 1, MaxStrLen(HRLeaveTypes.Code))) then
            if not HRLeaveTypes."Is Annual Leave" then
                MonthsEarned := 12;

        if MonthsEarned < 0 then
            MonthsEarned := 0;
        if MonthsEarned > 12 then
            MonthsEarned := 12;

        //EarnedDays := Round((AllocatedDays * MonthsEarned / 12) + ReImbursedDays, 1, '<');
        EarnedDays := Round((2.3 * MonthsEarned) + ReImbursedDays, 1, '>');

        if TotalTaken < 0 then
            LeaveBalance := EarnedDays + TotalTaken
        else
            LeaveBalance := EarnedDays - TotalTaken;
    end;
}
