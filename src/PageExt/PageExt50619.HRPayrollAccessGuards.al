pageextension 50619 "HR Leave Pending Access Guard" extends "HR Leave App. - Pending"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50620 "HR Leave Approved Access Guard" extends "HR Leave App. - Approved"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50621 "HR Leave Planner Access Guard" extends "HR Leave Planner List"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50622 "Staff Appl Access Guard" extends StaffAppraisalApplication
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50623 "Staff Appr List Access Guard" extends "Staff Appraisal List"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50624 "Completed Appr Access Guard" extends "Completed Salary Appraisal"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50625 "Staff Loan Appr Access Guard" extends "Staff Loans Approved List"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50626 "Staff Loan Pend Access Guard" extends "Staff Loan Pending Approval_"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50627 "Staff Loan Rej Access Guard" extends "Staff Loan Rejected List_"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50628 "Staff Loans Disb Access Guard" extends "Staff Loan Pending Disbur._"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50629 "Emp Gym Claims Access Guard" extends "Employee Gym Claims"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50630 "Human Res Setup Access Guard" extends "Human Resources Setup"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50631 "HR Advanced Setup Access Guard" extends "HR Advanced Setup"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50632 "HR Setup Access Guard" extends "HR Setup"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50633 "HR Leave Types Access Guard" extends "HR Leave Types"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        //HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50634 "HR Leave Jnl Temp Guard" extends "HR Leave Jnl. Template List"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50635 "HR Leave Batches Guard" extends "HR Leave Batches"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50636 "HR Leave Jnl Lines Guard" extends "HR Leave Journal Lines"
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}

pageextension 50637 "HR Leave Calendar Guard" extends "HR Leave Calendsr."
{
    trigger OnOpenPage()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;
}
