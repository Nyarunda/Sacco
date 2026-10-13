
Report 50312 "Payroll Summary - Ded Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Payroll Summary - Ded Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where(Status = const(Active));
            RequestFilterFields = "Period Filter", "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(FullName; FullName)
            {
            }
            dataitem("Payroll Codes"; "Payroll Codes")
            {
                //Earning,Deduction,"Basic Pay","Gross Pay","Net Pay",PAYE;
                DataItemTableView = sorting("Sort Order") order(ascending) where("Transaction Type" = filter(Deduction | PAYE | "Net Pay"));
                column(ReportForNavId_4; 4)
                {
                }
                column(SortOrder_PayrollCodes; "Payroll Codes"."Sort Order")
                {
                }
                column(TransactionCode_PayrollCodes; "Payroll Codes"."Transaction Code")
                {
                }
                column(TransactionName_PayrollCodes; "Payroll Codes"."Transaction Name")
                {
                }
                column(SLoan; SLoan)
                {
                }
                dataitem(PTrans; "Payroll Period Transactions")
                {
                    DataItemLink = "Transaction Code" = field("Transaction Code");
                    DataItemTableView = where("Entry Type" = const(Employee));
                    //                    DataItemTableView = where("Entry Type" = const(Employee), "Sacco Transaction Type" = filter(" " | "Interest Paid"));
                    column(ReportForNavId_8; 8)
                    {
                    }
                    column(Amt; TransAmt)
                    {
                    }
                    column(IntAmt; IntAmt)
                    {
                    }
                    column(TAmt; TAmt)
                    {
                    }
                    column(IntTAmt; IntTAmt)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        TransAmt := 0;
                        IntAmt := 0;

                        PayrollTrans.Reset;
                        //PayrollTrans.SetFilter("Sacco Transaction Type", '%1|%2', PayrollTrans."sacco transaction type"::" ", PayrollTrans."sacco transaction type"::"Principal Repayment");
                        PayrollTrans.SetFilter("Sacco Transaction Type", '<>%1', PayrollTrans."sacco transaction type"::"Interest Paid");
                        PayrollTrans.SetRange("Transaction Code", PTrans."Transaction Code");
                        PayrollTrans.SetRange("Employee Code", PTrans."Employee Code");
                        PayrollTrans.SetRange("Payroll Period", PTrans."Payroll Period");
                        PayrollTrans.SetRange("Entry Type", PTrans."entry type"::Employee);
                        if PayrollTrans.FindFirst then begin
                            PayrollTrans.CalcSums(Amount);
                            TransAmt := PayrollTrans.Amount;
                        end;

                        PayrollTrans.Reset;
                        PayrollTrans.SetFilter("Sacco Transaction Type", '%1', PayrollTrans."sacco transaction type"::"Interest Paid");
                        PayrollTrans.SetRange("Transaction Code", PTrans."Transaction Code");
                        PayrollTrans.SetRange("Employee Code", PTrans."Employee Code");
                        PayrollTrans.SetRange("Payroll Period", PTrans."Payroll Period");
                        PayrollTrans.SetRange("Entry Type", PTrans."entry type"::Employee);
                        if PayrollTrans.FindFirst then begin
                            PayrollTrans.CalcSums(Amount);
                            IntAmt := PayrollTrans.Amount;
                        end;

                        TAmt += TransAmt;
                        IntTAmt += IntAmt;
                    end;

                    trigger OnPreDataItem()
                    begin
                        //Message('SelectedPeriod::: %1', SelectedPeriod);
                        PTrans.SetFilter("Employee Code", EmpNo);
                        PTrans.SetRange("Payroll Period", SelectedPeriod);
                        TAmt := 0;
                        IntTAmt := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE("Payroll Codes"."Transaction Name" );
                    SLoan := false;
                    if "Payroll Codes"."Special Transactions" = "Payroll Codes"."special transactions"::"Staff Loan" then
                        SLoan := true;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                EmpNo := Employee."No.";
                //Message('SelectedPeriod %1', SelectedPeriod);
                //Message('t');
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);


                Evaluate(SelectedPeriod, Employee.GetFilter("Period Filter"));// Employee.GetRangemax("Period Filter");
                if SelectedPeriod = 0D then Error('You must specify the period filter');
                objPeriod.Reset;
                if objPeriod.Get(SelectedPeriod) then begin
                    PeriodName := objPeriod."Period Name";
                    PeriodYear := objPeriod."Period Year";
                end;

            end;
        }
    }


    requestpage
    {

        layout
        {
            area(content)
            {
                /*
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'SelectedPeriod';
                    TableRelation = "Payroll Periods";
                }
                */
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        RestrictAccess
    end;

    var
        FullName: Text;
        Amt: Decimal;
        EmpNo: Code[20];
        CompanyInfo: Record "Company Information";
        PayrollTrans: Record "Payroll Period Transactions";
        TransAmt: Decimal;
        SelectedPeriod: Date;
        PeriodName: Text[30];
        objPeriod: Record "Payroll Periods";
        PeriodYear: Integer;
        IntAmt: Decimal;
        SLoan: Boolean;
        TAmt: Decimal;
        IntTAmt: Decimal;


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

