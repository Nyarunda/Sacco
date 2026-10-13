report 50416 "Payroll Variance Rpt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Payroll Variance Rpt.rdlc';

    dataset
    {
        dataitem("PR Period Transactions"; "Payroll Period Transactions")
        {
            RequestFilterFields = "Payroll Period";
            column(EmployeeCod; "PR Period Transactions"."Employee Code")
            {
            }
            column(Amount; "PR Period Transactions".Amount)
            {
            }
            column(Previous; Previous)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(TransactionName; "PR Period Transactions"."Transaction Name")
            {
            }
            column(Differance; Differance)
            {
            }
            column(CurrentMonth; CurrentMonth)
            {
            }
            column(PreviousMonth; PreviousMonth)
            {
            }
            column(Header; StrSubstNo('PAYROLL VARIANCE FOR%1', CurrentMonth))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if EmpRec.Get("Employee Code") then
                    EmployeeName := EmpRec.Initials + ' ' + EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                Differance := 0;
                Previous := 0;
                PreviousRec.Reset;
                PreviousRec.SetRange("Transaction Code", "Transaction Code");
                PreviousRec.SetRange("Employee Code", "Employee Code");
                PreviousRec.SetRange("Payroll Period", PreviousMonth);
                if PreviousRec.Find('-') then
                    Previous := PreviousRec.Amount;


                Differance := Amount - Previous;
                if Differance = 0 then
                    CurrReport.Skip
            end;

            trigger OnPreDataItem()
            begin
                CurrentMonth := "PR Period Transactions".GetRangeMax("Payroll Period");
                PreviousMonth := CalcDate('-1M', "PR Period Transactions".GetRangeMax("Payroll Period"));
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

    var
        Previous: Decimal;
        EmployeeName: Text[150];
        EmpRec: Record Employee;
        PreviousRec: Record "Payroll Period Transactions";
        PreviousMonth: Date;
        Differance: Decimal;
        CurrentMonth: Date;
}

