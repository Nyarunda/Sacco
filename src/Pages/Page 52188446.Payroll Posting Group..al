
Page 50093 "Payroll Posting Group."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Payroll Posting Group";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(SalaryPayingAccount; Rec."Salary Paying Account")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryAccount; Rec."Salary Account")
                {
                    ApplicationArea = Basic;
                }
                field(IncomeTaxAccount; Rec."Income Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field(NITAExpenseAccount; Rec."NITA Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field(NITAPayableAccount; Rec."NITA Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Tier 2"; Rec."NSSF Tier 2")
                {
                    ApplicationArea = Basic;
                }
                field("Fringe Expense Account"; Rec."Fringe Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field("Fringe Payable Account"; Rec."Fringe Payable Account")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}
