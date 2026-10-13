page 50557 "View Slip"
{
    ApplicationArea = All;
    Caption = 'View Slip';
    PageType = List;
    SourceTable = Employee;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transactions)
            {
                Caption = 'View';
                action(ViewPayslip)
                {
                    ApplicationArea = Basic;
                    Caption = 'View Payslip';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        PayrollPeriods.Reset;
                        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
                        if PayrollPeriods.Find('-') then begin
                            OpenPeriod := PayrollPeriods."Date Opened";
                        end else begin
                            Error('No Payroll period found');
                        end;



                        //Display payslip report
                        Employee.SetRange("No.", Rec."No.");
                        Employee.SetRange("Period Filter", OpenPeriod);
                        Report.Run(50203, true, false, Employee);
                    end;
                }
            }
        }
    }
    var
        PayrollPeriods: Record "Payroll Periods";
        employee: record Employee;
        OpenPeriod: date;
        Staff: Record "User Setup";
}
