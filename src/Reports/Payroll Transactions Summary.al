report 50442 "Payroll Transactions Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Payroll Transactions Summary.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where(Status = const(Active));
            RequestFilterFields = "Period Filter", "No.";

            column(EmployeeNo; Employee."No.")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(PayrollPeriod; SelectedPeriod)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }

            dataitem(PayrollCodes; "Payroll Codes")
            {
                DataItemTableView = sorting("Sort Order") order(ascending);
                RequestFilterFields = "Transaction Code", "Transaction Type";

                column(TransactionCode; PayrollCodes."Transaction Code")
                {
                }
                column(TransactionName; PayrollCodes."Transaction Name")
                {
                }
                column(TransactionType; PayrollCodes."Transaction Type")
                {
                }
                column(GroupText; GroupText)
                {
                }
                column(EarnedAmount; EarnedAmount)
                {
                }
                column(DeductedAmount; DeductedAmount)
                {
                }
                column(TransAmount; TransAmount)
                {
                }
                column(TransName; PayrollCodes."Transaction Name")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CalculateEmployeeTransactionAmount();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                EmployeeName := GetEmployeeName(Employee);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                SelectedPeriod := Employee.GetRangeMin("Period Filter");
                if SelectedPeriod = 0D then
                    Error('You must specify the period filter.');

                if PayrollPeriod.Get(SelectedPeriod) then
                    PeriodName := PayrollPeriod."Period Name"
                else
                    PeriodName := Format(SelectedPeriod);
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

    trigger OnPreReport()
    begin
        RestrictAccess();
    end;

    var
        CompanyInfo: Record "Company Information";
        PayrollPeriod: Record "Payroll Periods";
        PeriodTransaction: Record "Payroll Period Transactions";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        EmployeeName: Text[100];
        EarnedAmount: Decimal;
        DeductedAmount: Decimal;
        TransAmount: Decimal;
        GroupText: Text[50];

    local procedure CalculateEmployeeTransactionAmount()
    begin
        EarnedAmount := 0;
        DeductedAmount := 0;
        TransAmount := 0;
        GroupText := Format(PayrollCodes."Transaction Type");

        PeriodTransaction.Reset();
        PeriodTransaction.SetRange("Employee Code", Employee."No.");
        PeriodTransaction.SetRange("Transaction Code", PayrollCodes."Transaction Code");
        PeriodTransaction.SetRange("Payroll Period", SelectedPeriod);
        PeriodTransaction.SetRange("Entry Type", PeriodTransaction."Entry Type"::Employee);
        if PeriodTransaction.FindSet() then
            repeat
                TransAmount += PeriodTransaction.Amount;
            until PeriodTransaction.Next() = 0;

        case PayrollCodes."Transaction Type" of
            PayrollCodes."Transaction Type"::Earning,
            PayrollCodes."Transaction Type"::"Basic Pay",
            PayrollCodes."Transaction Type"::"Gross Pay":
                EarnedAmount := TransAmount;
            PayrollCodes."Transaction Type"::Deduction,
            PayrollCodes."Transaction Type"::PAYE,
            PayrollCodes."Transaction Type"::Statutory:
                DeductedAmount := TransAmount;
            PayrollCodes."Transaction Type"::"Net Pay":
                EarnedAmount := TransAmount;
        end;
    end;

    local procedure GetEmployeeName(EmployeeRec: Record Employee): Text[100]
    begin
        exit(DelChr(
            StrSubstNo(
                '%1 %2 %3',
                EmployeeRec."Last Name",
                EmployeeRec."First Name",
                EmployeeRec."Middle Name"),
            '<>',
            ' '));
    end;

    procedure RestrictAccess()
    var
        StatusPermission: Record "User Setup";
        ErrorOnRestrictViewTxt: Label 'You do not have permissions to MODIFY or DELETE on this Page. Contact your system administrator for further details';
    begin
        StatusPermission.Reset();
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("Payroll", true);
        if not StatusPermission.Find('-') then
            Error(ErrorOnRestrictViewTxt);
    end;
}