Report 50325 prAllowances_Deductions
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/prAllowances_Deductions.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "Payroll Period Transactions")
        {
            RequestFilterFields = "Transaction Code", "Period Month";
            column(ReportForNavId_1; 1)
            {
            }
            column(EmployeeCode; "prPeriod Transactions"."Employee Code")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(Department; Department)
            {
            }
            column(TransactionCode; "prPeriod Transactions"."Transaction Code")
            {
            }
            column(TransactionName; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(Amount; "prPeriod Transactions".Amount)
            {
            }
            column(Picture; CI.Picture)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(Caption; Txt001)
            {
            }
            column(SelectedPeriod; SelectedPeriod)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Np := Np + 1;


                "Employee Name" := '';
                Department := '';
                //HREmp.RESET;
                if HREmp.Get("Employee Code") then begin
                    if HREmp.Status <> HREmp.Status::Active then
                        CurrReport.skip;

                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    Department := HREmp."Global Dimension 1 Code";
                end;

                //MESSAGE('%1and %2',Np,"prPeriod Transactions"."Employee Code");
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Period", SelectedPeriod);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Periods";
                }
            }
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

        if SelectedPeriod = 0D then Error('You must specify the period filter');
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then begin
            PeriodName := objPeriod."Period Name";
            PeriodMonthflt := objPeriod."Period Month";
        end;



        CI.Reset;
        if CI.Get() then
            CI.CalcFields(Picture);
    end;

    var
        HREmp: Record Employee;
        "Employee Name": Text[250];
        Department: Code[20];
        CI: Record "Company Information";
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Periods";
        PeriodName: Text[50];
        Txt001: label 'Allowance and Deductions Report';
        PeriodMonth: Integer;
        PeriodMonthflt: Integer;
        Np: Integer;


    trigger OnInitReport()
    begin
        RestrictAccess
    end;

    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Payroll"');
    end;
}

