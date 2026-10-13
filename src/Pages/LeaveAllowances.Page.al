Page 50941 "Leave Allowances"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Leave Allowances";
    SourceTableView = where(Paid = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ApplicationNo; Rec."Application No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Paid; Rec.Paid)
                {
                    ApplicationArea = Basic;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Outlook)
            {
            }
            systempart(Control14; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                action(PostLeave)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Leave';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Confirm('Do You want to Post the Leave Allowances?', false) = false then
                            Error('Process Aborted');
                        PRTrans.Reset;
                        //PRTrans.SetRange(PRTrans."IsLeave Allowance", true);
                        if PRTrans.Find('-') then begin
                            PRPeriod.Reset;
                            PRPeriod.SetRange(PRPeriod.Closed, false);
                            if PRPeriod.Find('-') then begin
                                LeaveAllowances.Reset;
                                LeaveAllowances.SetRange(LeaveAllowances.Paid, false);
                                if LeaveAllowances.Find('-') then begin
                                    repeat
                                        PREmpTrans.Reset;
                                        // PREmpTrans.SETRANGE(PREmpTrans."Employee Code",LeaveAllowances."Employee No.");
                                        //  PREmpTrans.SETRANGE(PREmpTrans."Payroll Period",PRPeriod."Date Opened");
                                        // IF PREmpTrans.FIND('-') THEN
                                        begin
                                            PREmpTrans.Init;
                                            PREmpTrans."Employee Code" := LeaveAllowances."Employee No.";
                                            PREmpTrans."Transaction Code" := PRTrans."Transaction Code";
                                            PREmpTrans."Period Month" := PRPeriod."Period Month";
                                            PREmpTrans."Period Year" := PRPeriod."Period Year";
                                            PREmpTrans."Payroll Period" := PRPeriod."Date Opened";
                                            PREmpTrans."Transaction Name" := PRTrans."Transaction Name";
                                            PREmpTrans.Amount := LeaveAllowances.Amount;
                                            PREmpTrans.Insert;
                                            LeaveAllowances.Paid := true;
                                            LeaveAllowances.Modify;
                                        end
                                    until LeaveAllowances.Next = 0;
                                end;
                                Message('Successfully Posted Leave Allowances');
                            end else begin
                                Error('No Payroll Period is open');
                            end;

                        end else begin
                            Error('No Transaction code found')
                        end
                    end;
                }
            }
        }
    }

    var
        PREmpTrans: Record "Payroll Employee Transactions";
        PRPeriod: Record "Payroll Periods";
        PRTrans: Record "Payroll Period Transactions";
        LeaveAllowances: Record "Leave Allowances";
        prVitalSetup: Record "Payroll Rates";

}

