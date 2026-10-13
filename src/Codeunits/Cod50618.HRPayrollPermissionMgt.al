codeunit 50618 "HR Payroll Permission Mgt"
{
    procedure HasHRPayrollAccess(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            exit(false);

        exit(UserSetup."System Admin" or UserSetup."View HR" or UserSetup."View Payroll" or UserSetup.Payroll);
    end;

    procedure RequireHRPayrollAccess()
    begin
        if not HasHRPayrollAccess() then
            Error('You do not have permission to open HR & Payroll.');
    end;

    procedure RequirePayrollAccess()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('You do not have the following permission: "Payroll"');

        if not (UserSetup."System Admin" or UserSetup."View Payroll" or UserSetup.Payroll) then
            Error('You do not have the following permission: "Payroll"');
    end;

    procedure RequireHRAccess()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('You do not have the following permission: "View HR"');

        if not (UserSetup."System Admin" or UserSetup."View HR") then
            Error('You do not have the following permission: "View HR"');
    end;
}
