reportextension 50639 "PR Guard A Third Rule" extends "A Third Rule"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50640 "PR Guard Bank Pay Schedule" extends "Bank Payment Schedule"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50641 "PR Guard Ded Listing" extends "Deductions Listing-List"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50642 "PR Guard Earn Listing" extends "Earnings Listing -List"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50643 "PR Guard NITA" extends "NITA Report"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50644 "PR Guard NSSF Tier 1" extends "NSSF Tier 1 Schedule"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50645 "PR Guard NSSF Tier 2" extends "NSSF Tier 2 Schedule"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50646 "PR Guard P9 Board" extends "P9 Report - Board"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50647 "PR Guard P9" extends "P9 Report"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50648 "PR Guard Codes Report" extends "Payroll Codes Report"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50649 "PR Guard Net Pay" extends "Payroll Net Pay Report"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50650 "PR Guard Summary Ded" extends "Payroll Summary - Ded Report"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50651 "PR Guard Summary Detailed" extends "Payroll Summary Detailed"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50652 "PR Guard Summary Report" extends "Payroll Summary Report"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50653 "PR Guard Trans List" extends "Payroll Transaction List"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50654 "PR Guard Trans Summary" extends "Payroll Transactions Summary"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50655 "PR Guard Variance" extends "Payroll Variance Rpt"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50656 "PR Guard Bank Summary" extends "PR Bank Summary"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50657 "PR Guard COTU" extends "PR COTU"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50658 "PR Guard HELB" extends "PR HELB"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50659 "PR Guard KUCFAW" extends "PR KUCFAW"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50660 "PR Guard Provident" extends "PR Provident NSSF"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50661 "PR Guard PAYE Schedule" extends "prPaye Schedule"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50662 "PR Guard Summary List" extends "prPayrollSummary-List"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50663 "PR Guard Pension Contrib" extends "prStaff Pension Contrib"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50664 "PR Guard Staff Welfare" extends "Staff Welfare Schedule"
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50665 "PR Guard P10A" extends P10A
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50666 "PR Guard Allow Ded" extends prAllowances_Deductions
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50667 "PR Guard Housing Levy" extends prHousinglevy
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50668 "PR Guard NHIF" extends prNHIF
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

reportextension 50669 "PR Guard NSSF" extends prNSSF
{
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}
