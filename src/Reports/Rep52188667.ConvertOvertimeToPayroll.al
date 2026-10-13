report 50340 "Convert Overtime To Payroll"
{
    ApplicationArea = All;
    Caption = 'Convert Overtime To Payroll';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", Status;
            DataItemTableView = where(Status = const(Active));
            column(No; "No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                HROvertimeLines: Record "HR Overtime Lines";
                OverTimeAmount: Decimal;
                PayrollEmployeeTransactions: Record "Payroll Employee Transactions";
                HROvertimeHdr: Record "HR Overtime Header";
                Found: Boolean;
                SDate: Date;
                EDate: Date;
            begin
                GetstartDates(SDate, EDate);

                PDial.Update(1, Employee.FullName());
                OverTimeAmount := 0;
                HROvertimeLines.Reset();
                HROvertimeLines.SetRange(Date, SDate, EDate);
                HROvertimeLines.SetRange("Staff No.", Employee."No.");
                if HROvertimeLines.FindSet() then
                    repeat
                        HROvertimeHdr.Reset();
                        HROvertimeHdr.SetRange("Application Code", HROvertimeLines."Application Code");
                        HROvertimeHdr.SetRange(Status, HROvertimeHdr.Status::Approved);
                        if HROvertimeHdr.FindFirst() then begin
                            OverTimeAmount += HROvertimeLines."OverTime Amount";
                            HROvertimeHdr.Converted := true;
                            HROvertimeHdr.Modify();
                        end;
                    until HROvertimeLines.next = 0;

                if OverTimeAmount > 0 then begin
                    NoOfSuccessfulStaff += 1;
                    PayrollEmployeeTransactions.Reset();
                    PayrollEmployeeTransactions.SetRange("Employee Code", Employee."No.");
                    PayrollEmployeeTransactions.SetRange("Transaction Code", 'E001');
                    PayrollEmployeeTransactions.SetRange("Payroll Period", OpenPeriod);
                    Found := PayrollEmployeeTransactions.FindFirst();

                    if Found then begin
                        PayrollEmployeeTransactions.Amount := OverTimeAmount;
                        PayrollEmployeeTransactions.Modify();
                    end else begin
                        PayrollEmployeeTransactions.Init();
                        PayrollEmployeeTransactions.EntryNo := 0;
                        PayrollEmployeeTransactions."Employee Code" := Employee."No.";
                        PayrollEmployeeTransactions."Transaction Code" := 'E001';
                        PayrollEmployeeTransactions."Payroll Period" := OpenPeriod;
                        PayrollEmployeeTransactions."Period Month" := PayrollPeriods."Period Month";
                        PayrollEmployeeTransactions."Period Year" := PayrollPeriods."Period Year";
                        PayrollPeriods."Period Name" := PayrollPeriods."Period Name";
                        PayrollEmployeeTransactions."Transaction Name" := 'Overtime';
                        PayrollEmployeeTransactions.Amount := OverTimeAmount;
                        PayrollEmployeeTransactions."Member No." := Employee."Member No";
                        PayrollEmployeeTransactions.Insert();
                    end;

                end;
            end;

            trigger OnPreDataItem()
            begin
                PDial.Open('Processing OverTime:#1#############################');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(DateFilters)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            StartDate := CalcDate('-CM', Today);
            EndDate := CalcDate('CM', Today);
        end;


    }
    trigger OnPreReport()
    var
        USetup: Record "User Setup";

    begin

        USetup.Get(UserId);
        USetup.TestField("Is HR", true);
        PayrollPeriods.Reset;
        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
        if PayrollPeriods.Find('-') then begin
            OpenPeriod := PayrollPeriods."Date Opened";
        end else begin
            Error('No Payroll period found');
        end;




    end;


    trigger OnPostReport()
    begin
        PDial.Close();
        Message('Overtime has been converted to payroll for %1 staff. ', NoOfSuccessfulStaff);
    end;

    procedure GetstartDates(var StartDate: Date; Var EndDate: Date)
    begin
        if (StartDate = 0D) or (EndDate = 0D) then begin
            HROT.Reset();
            HROT.SetRange("Staff No.", Employee."No.");
            HROT.SetRange(Converted, false);
            HROT.SetRange(Status, HROT.Status::Approved);
            if HROT.FindFirst() then begin

                HROTL.Reset();
                HROTL.SetRange("Application Code", HROT."Application Code");
                HROTL.SetCurrentKey(Date);
                HROTL.SetAscending(Date, true);
                if HROTL.FindLast() then begin
                    EndDate := HROTL.Date;
                end;

                HROTL.Reset();
                HROTL.SetRange("Application Code", HROT."Application Code");
                if HROTL.FindFirst() then begin
                    StartDate := HROTL.Date;
                end;
            end;

        end else
            Error('Both the start date and the end date must have a value!');
    end;

    var
        StartDate: Date;
        EndDate: Date;
        PayrollPeriods: Record "Payroll Periods";
        OpenPeriod: Date;
        PDial: Dialog;
        NoOfSuccessfulStaff: Integer;
        HROT: Record "HR Overtime Header";
        HROTL: Record "HR Overtime Lines";

}
