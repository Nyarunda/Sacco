
Page 50115 "Payroll Employee Transactions."
{
    PageType = List;
    SourceTable = "Payroll Employee Transactions";
    SourceTableView = where("Transaction Type" = const(Earning));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Codes" where("Transaction Type" = const(Earning));

                    trigger OnValidate()
                    begin
                        blnIsLoan := false;

                        PayrollCodes.Reset;
                        PayrollCodes.SetRange(PayrollCodes."Transaction Code", Rec."Transaction Code");
                        if PayrollCodes.Find('-') then begin
                            Rec."Transaction Name" := PayrollCodes."Transaction Name";
                            Rec."Payroll Period" := SelectedPeriod;
                            Rec."Period Month" := PeriodMonth;
                            Rec."Period Year" := PeriodYear;
                            Rec."Loan Product Type" := PayrollCodes."Sub-Ledger Product Type";

                            if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                                empCode := Rec."Employee Code";
                                curTransAmount := objOCX.fnDisplayFrmlValues(empCode, PeriodMonth, PeriodYear, PayrollCodes.Formula);
                                Rec.Amount := curTransAmount;
                            end;

                            if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then begin
                                Rec.Amount := PayrollCodes."Standard Amount";
                            end;


                            if PayrollCodes."Include Employer Deduction" then begin
                                curTransAmount := objOCX.fnDisplayFrmlValues(empCode, PeriodMonth, PeriodYear, PayrollCodes."Is Formula for employer");
                                Rec."Employer Amount" := curTransAmount;
                            end;

                            if PayrollCodes."Special Identifier" = PayrollCodes."special identifier"::NHIF then begin
                                if StaffPayrollDetails.Get(Rec."Employee Code") then
                                    Rec.Amount := objOCX.fnGetEmployeeNHIF(StaffPayrollDetails."Basic Pay");
                            end;


                        end;
                    end;
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field(UserDefinedLoanInterest; Rec."User Defined Loan Interest")
                {
                    ApplicationArea = Basic;
                }
                field(AmortizationTotalRepayment; Rec."Amortization Total Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodMonth; Rec."Period Month")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodYear; Rec."Period Year")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerAmount; Rec."Employer Amount")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerBalance; Rec."Employer Balance")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollCode; Rec."Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess;

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        end;

        //Filter per period  - Dennis
        Rec.SetFilter("Payroll Period", Format(objPeriod."Date Opened"));
        //objPeriod.SETFILTER(objPeriod.Closed,'FALSE');
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Payroll Period", Format(objPeriod."Date Opened"));
    end;

    var
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "Payroll Period Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        transType: Text[30];
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        PREmployeeTrans: Record "Payroll Employee Transactions";
        i: Integer;
        HREmp: Record Employee;
        PayrollCodes: Record "Payroll Codes";
        objOCX: Codeunit "Payroll Processing";
        StaffPayrollDetails: Record "Staff Payroll Details";


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

