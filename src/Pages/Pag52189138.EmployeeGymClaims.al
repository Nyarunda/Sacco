namespace UnitedWomen.UnitedWomen;

page 50840 "Employee Gym Claims"
{
    PageType = List;
    SourceTable = "Employee Gym Claims";
    Caption = 'Employee Gym Claims';
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee Code"; Rec."Employee Code") { ApplicationArea = All; }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payroll Period"; Rec."Payroll Period") { ApplicationArea = All; }
                field("Period Month"; Rec."Period Month") { ApplicationArea = All; }
                field("Period Year"; Rec."Period Year") { ApplicationArea = All; }
                field("Transaction Code"; Rec."Transaction Code") { ApplicationArea = All; }
                field("Claim Amount"; Rec."Claim Amount") { ApplicationArea = All; }
                field("Marginal Tax Rate"; Rec."Marginal Tax Rate") { ApplicationArea = All; }
                field("Gross Amount"; Rec."Gross Amount") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field(Posted; Rec.Posted) { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                Caption = 'Calculate Gross Amount';
                ApplicationArea = All;
                Image = Calculate;
                trigger OnAction()
                begin
                    CalculateGrossAmount();
                end;
            }
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;
                trigger OnAction()
                begin
                    ApproveSelected();
                end;
            }
            action(PostToPayroll)
            {
                Caption = 'Post to Payroll';
                ApplicationArea = All;
                Image = Post;
                trigger OnAction()
                begin
                    PostGymAllowance();
                end;
            }
        }
    }

    var
        PayrollMgt: Codeunit "Payroll Processing";

    local procedure CalculateGrossAmount()
    var
        GymClaims: Record "Employee Gym Claims";
        prPAYE: Record PAYE;
        CurrentTaxableIncome: Decimal;
        MarginalRate: Decimal;
    begin
        CurrPage.SetSelectionFilter(GymClaims);
        if not GymClaims.FindSet(true) then
            Error('No records selected');

        repeat
            if GymClaims.Status <> GymClaims.Status::Open then
                Error('Only open claims can be calculated. Employee: %1', GymClaims."Employee Code");
            EnsureOpenPayrollPeriod(GymClaims."Payroll Period", GymClaims."Employee Code");

            // Get taxable income and marginal rate
            //CurrentTaxableIncome := PayrollMgt.fnGetEmployeeTaxableIncome(GymClaims."Employee Code", GymClaims."Payroll Period");
            // MarginalRate := PayrollMgt.fnGetMarginalRate(CurrentTaxableIncome);

            // Gross up
            if MarginalRate >= 100 then
                Error('Invalid marginal rate %1 for employee %2', MarginalRate, GymClaims."Employee Code");

            GymClaims."Marginal Tax Rate" := MarginalRate;
            GymClaims."Gross Amount" := Round((GymClaims."Claim Amount" * 100) / (100 - MarginalRate), 0.01, '>');
            GymClaims.Modify();
        until GymClaims.Next() = 0;

        Message('Gross amount calculated successfully');
    end;

    local procedure ApproveSelected()
    var
        GymClaims: Record "Employee Gym Claims";
    begin
        CurrPage.SetSelectionFilter(GymClaims);
        if not GymClaims.FindSet(true) then
            Error('No records selected');

        repeat
            if GymClaims."Gross Amount" <= 0 then
                Error('Please calculate gross amount first for employee: %1', GymClaims."Employee Code");
            if GymClaims.Status <> GymClaims.Status::Open then
                Error('Only open claims can be approved. Employee: %1', GymClaims."Employee Code");
            EnsureOpenPayrollPeriod(GymClaims."Payroll Period", GymClaims."Employee Code");

            GymClaims.Status := GymClaims.Status::Approved;
            GymClaims.Modify();
        until GymClaims.Next() = 0;

        Message('Selected claims approved successfully');
    end;

    local procedure PostGymAllowance()
    var
        GymClaims: Record "Employee Gym Claims";
        PayrollEmployeeTransactions: Record "Payroll Employee Transactions";
        PayrollPeriods: Record "Payroll Periods";
        PayrollCodes: Record "Payroll Codes";
    begin
        CurrPage.SetSelectionFilter(GymClaims);
        if not GymClaims.FindSet(true) then
            Error('No records selected');

        repeat
            GymClaims.TestField("Employee Code");
            GymClaims.TestField("Payroll Period");
            GymClaims.TestField("Transaction Code");
            if GymClaims.Status <> GymClaims.Status::Approved then
                Error('Only approved claims can be posted. Employee: %1', GymClaims."Employee Code");
            if GymClaims.Posted then
                Error('Claim already posted for employee: %1', GymClaims."Employee Code");
            EnsureOpenPayrollPeriod(GymClaims."Payroll Period", GymClaims."Employee Code");

            if not PayrollCodes.Get(GymClaims."Transaction Code") then
                Error('Payroll transaction code %1 was not found.', GymClaims."Transaction Code");
            if PayrollCodes."Transaction Type" <> PayrollCodes."Transaction Type"::Earning then
                Error('Gym claim transaction code %1 must be an earning payroll code.', GymClaims."Transaction Code");

            // Get period details
            PayrollPeriods.Reset();
            PayrollPeriods.SetRange("Date Opened", GymClaims."Payroll Period");
            if not PayrollPeriods.FindFirst() then
                Error('Payroll period not found for employee: %1', GymClaims."Employee Code");

            // Find or create transaction
            PayrollEmployeeTransactions.Reset();
            PayrollEmployeeTransactions.SetRange("Employee Code", GymClaims."Employee Code");
            PayrollEmployeeTransactions.SetRange("Transaction Code", GymClaims."Transaction Code");
            PayrollEmployeeTransactions.SetRange("Payroll Period", GymClaims."Payroll Period");

            if PayrollEmployeeTransactions.FindFirst() then begin
                PayrollEmployeeTransactions."Transaction Name" := PayrollCodes."Transaction Name";
                if PayrollEmployeeTransactions."Transaction Name" = '' then
                    PayrollEmployeeTransactions."Transaction Name" := 'Gym Allowance';
                PayrollEmployeeTransactions.Amount := GymClaims."Gross Amount";
                PayrollEmployeeTransactions.Modify();
            end else begin
                PayrollEmployeeTransactions.Init();
                PayrollEmployeeTransactions.EntryNo := 0;
                PayrollEmployeeTransactions."Employee Code" := GymClaims."Employee Code";
                PayrollEmployeeTransactions."Transaction Code" := GymClaims."Transaction Code";
                PayrollEmployeeTransactions."Payroll Period" := GymClaims."Payroll Period";
                PayrollEmployeeTransactions."Period Month" := PayrollPeriods."Period Month";
                PayrollEmployeeTransactions."Period Year" := PayrollPeriods."Period Year";

                PayrollEmployeeTransactions."Transaction Name" := PayrollCodes."Transaction Name";
                if PayrollEmployeeTransactions."Transaction Name" = '' then
                    PayrollEmployeeTransactions."Transaction Name" := 'Gym Allowance';
                PayrollEmployeeTransactions.Amount := GymClaims."Gross Amount";

                PayrollEmployeeTransactions.Insert();
            end;

            // Mark as posted
            GymClaims.Status := GymClaims.Status::Posted;
            GymClaims.Posted := true;
            GymClaims."Last Modified By" := UserId;
            GymClaims."Last Modified DateTime" := CurrentDateTime;
            GymClaims.Modify();

        until GymClaims.Next() = 0;

        Message('Claims posted to payroll successfully');
    end;

    local procedure EnsureOpenPayrollPeriod(PayrollPeriodDate: Date; EmployeeCode: Code[20])
    var
        PayrollPeriods: Record "Payroll Periods";
    begin
        if PayrollPeriodDate = 0D then
            Error('Payroll period must be selected for employee: %1', EmployeeCode);

        PayrollPeriods.Get(PayrollPeriodDate);
        if PayrollPeriods.Closed then
            Error('Gym claims can only be used in an open payroll period. Employee: %1', EmployeeCode);
    end;
}
