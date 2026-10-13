report 50371 "Generate Employee Loans"
{
    ApplicationArea = All;
    Caption = 'Generate Employee Loans';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }

            trigger OnPreDataItem()
            var

            begin
                ObjTempLoan.DeleteAll();
                Commit();

                SelectedPeriod := 0D;

                ObjPayrollPeriods.RESET;
                ObjPayrollPeriods.SETRANGE(Closed, FALSE);
                IF ObjPayrollPeriods.FIND('-') THEN BEGIN
                    SelectedPeriod := ObjPayrollPeriods."Date Opened";
                    ObjPeriodName := ObjPayrollPeriods."Period Name";
                    ObjPeriodMonth := ObjPayrollPeriods."Period Month";
                    ObjPeriodYear := ObjPayrollPeriods."Period Year";
                END;



                ObjEmployeeTransactions.RESET;
                ObjEmployeeTransactions.SETRANGE(Amount, 0);
                //ObjEmployeeTransactions.DELETEALL;


            end;

            trigger OnAfterGetRecord()
            begin
                ObjEmployeeTransactions.RESET;
                ObjEmployeeTransactions.SetRange("Employee Code", Employee."No.");
                ObjEmployeeTransactions.SETRANGE("Payroll Period", SelectedPeriod);
                ObjEmployeeTransactions.SETFILTER("Coop Parameters", '%1', ObjEmployeeTransactions."Coop Parameters"::"Staff Loan");
                IF ObjEmployeeTransactions.FIND('-') THEN BEGIN
                    ObjEmployeeTransactions.CALCFIELDS("Coop Parameters");
                    ObjEmployeeTransactions.DELETEALL;
                    Commit();
                END;

                DefaultCodes(Employee."No.");

                StartDate := CALCDATE('-CM+9D', TODAY);
                EndDate := CALCDATE('CM', TODAY);

                DateFilter := FORMAT(CALCDATE('-CM', TODAY)) + '..' + FORMAT(CALCDATE('CM', TODAY));

                ObjEmployeeLoans.RESET;
                ObjEmployeeLoans.SETFILTER("Total Outstanding Balance", '>0');
                ObjEmployeeLoans.SETRANGE("Staff No", Employee."No.");
                ObjEmployeeLoans.SETRANGE("Repay Mode", ObjEmployeeLoans."Repay Mode"::"Check Off");
                IF ObjEmployeeLoans.FindFirst() THEN BEGIN

                    RecFound := ObjEmployeeLoans.Count;

                    REPEAT
                        ObjEmployeeLoans.CALCFIELDS("Outstanding Principal");

                        //IF ObjEmployeeLoans."Disbursement Date" <= StartDate THEN BEGIN
                        ObjTempLoans.INIT;
                        ObjTempLoans."Rec Found" := FALSE;
                        ObjTempLoans."Member No." := ObjEmployeeLoans."Member No.";
                        ObjTempLoans."Payroll/Staff No." := Employee."No.";
                        ObjTempLoans."Loan No." := ObjEmployeeLoans."Loan No.";
                        ObjTempLoans."Payroll Period" := SelectedPeriod;
                        ObjTempLoans."Payroll Month" := ObjPeriodMonth;
                        ObjTempLoans."Payroll Year" := ObjPeriodYear;
                        ObjTempLoans.Amount := ObjEmployeeLoans."Approved Amount";
                        ObjTempLoans.Repayment := ObjEmployeeLoans.Repayment;
                        ObjTempLoans."Loan Repayment" := ObjEmployeeLoans."Loan Principle Repayment";
                        ObjTempLoans."Product Type" := ObjEmployeeLoans."Loan Product Type";
                        ObjTempLoans."Loan Interest Rate" := ObjEmployeeLoans."Annual Interest %";
                        ObjTempLoans."Outstanding Balance" := ObjEmployeeLoans."Outstanding Principal";
                        ObjTempLoans.INSERT(TRUE);
                        Commit();
                    //END;

                    UNTIL ObjEmployeeLoans.NEXT = 0;

                END;

                ObjEmployeeTransactions.RESET;
                ObjEmployeeTransactions.SETRANGE("Employee Code", Employee."No.");
                ObjEmployeeTransactions.SETRANGE("Payroll Period", SelectedPeriod);
                ObjEmployeeTransactions.SETFILTER("Coop Parameters", '%1', ObjEmployeeTransactions."Coop Parameters"::"Staff Loan");
                IF ObjEmployeeTransactions.FIND('-') THEN BEGIN
                    ObjEmployeeTransactions.CALCFIELDS("Coop Parameters");
                    REPEAT
                        ObjEmployeeTransactions.CALCFIELDS("Coop Parameters");

                        PLoans.RESET;
                        PLoans.SETRANGE("Loan No.", ObjEmployeeTransactions."Loan No.");
                        PLoans.SETRANGE("Payroll/Staff No.", ObjEmployeeTransactions."Employee Code");
                        PLoans.SETRANGE("Payroll Transaction Code", ObjEmployeeTransactions."Transaction Code");
                        IF PLoans.FIND('-') THEN BEGIN
                            PLoans.CALCFIELDS("Payroll Transaction Code");
                            PLoans."Rec Found" := TRUE;
                            PLoans.MODIFY;
                        END;

                    UNTIL ObjEmployeeTransactions.NEXT = 0;
                END;


                ObjTempLoan.RESET;
                ObjTempLoan.SETRANGE("Payroll/Staff No.", Employee."No.");
                IF ObjTempLoan.FindFirst() THEN BEGIN
                    REPEAT
                        IF ObjProductFact.GET(ObjTempLoan."Product Type") THEN BEGIN
                            ObjProductFact.TESTFIELD("Payroll Transaction Code");

                            CASE ObjTempLoan."Rec Found" OF

                                TRUE:
                                    BEGIN

                                        ObjEmployeeTransactions.RESET;
                                        ObjEmployeeTransactions.SETRANGE("Payroll Period", SelectedPeriod);
                                        ObjEmployeeTransactions.SETRANGE("Loan No.", ObjTempLoan."Loan No.");
                                        ObjEmployeeTransactions.SETRANGE("Employee Code", ObjTempLoan."Payroll/Staff No.");
                                        IF ObjEmployeeTransactions.FIND('-') THEN BEGIN
                                            ObjEmployeeTransactions."Employee Code" := ObjTempLoan."Payroll/Staff No.";
                                            ObjEmployeeTransactions."Transaction Type" := ObjEmployeeTransactions."Transaction Type"::Deduction;
                                            ObjEmployeeTransactions."Transaction Name" := ObjProductFact.Description;

                                            ObjEmployeeTransactions."Sub-ledger Account" := ObjEmployeeLoans."Loan Account";
                                            ObjEmployeeTransactions."Payroll Period" := SelectedPeriod;
                                            ObjEmployeeTransactions."Period Month" := ObjPeriodMonth;
                                            ObjEmployeeTransactions."Period Year" := ObjPeriodYear;
                                            ObjEmployeeTransactions."Loan No." := ObjTempLoan."Loan No.";
                                            ObjEmployeeTransactions.VALIDATE("Loan No.");
                                            ObjEmployeeTransactions.Amount := ObjTempLoan."Loan Repayment";
                                            ObjEmployeeTransactions.Balance := ObjTempLoan."Outstanding Balance";
                                            ObjEmployeeTransactions."Interest Rate" := ObjTempLoan."Loan Interest Rate";
                                            ObjEmployeeTransactions."Amortization Total Repayment" := ObjTempLoan.Repayment;
                                            ObjEmployeeTransactions."User Defined Loan Interest" := 0;
                                            ObjEmployeeTransactions."Member No." := ObjTempLoan."Member No.";

                                            ObjEmployeeTransactions.MODIFY(TRUE);
                                            Commit();
                                        END;
                                    END;

                                FALSE:
                                    BEGIN

                                        ObjEmployeeTransactions.INIT;
                                        ObjEmployeeTransactions."Employee Code" := ObjTempLoan."Payroll/Staff No.";
                                        ObjEmployeeTransactions."Transaction Type" := ObjEmployeeTransactions."Transaction Type"::Deduction;
                                        ObjEmployeeTransactions."Transaction Code" := ObjProductFact."Payroll Transaction Code";
                                        ObjEmployeeTransactions."Transaction Name" := ObjProductFact.Description;
                                        ObjEmployeeTransactions."Sub-ledger Account" := ObjEmployeeLoans."Loan Account";
                                        //ObjEmployeeTransactions.VALIDATE("Transaction Code");
                                        ObjEmployeeTransactions."Payroll Period" := SelectedPeriod;
                                        ObjEmployeeTransactions."Period Month" := ObjPeriodMonth;
                                        ObjEmployeeTransactions."Period Year" := ObjPeriodYear;
                                        ObjEmployeeTransactions."Loan No." := ObjTempLoan."Loan No.";
                                        // ObjEmployeeTransactions.VALIDATE("Loan No.");
                                        ObjEmployeeTransactions.Amount := ObjTempLoan."Loan Repayment";
                                        ObjEmployeeTransactions.Balance := ObjTempLoan."Outstanding Balance";
                                        ObjEmployeeTransactions."Interest Rate" := ObjTempLoan."Loan Interest Rate";
                                        ObjEmployeeTransactions."Amortization Total Repayment" := ObjTempLoan.Repayment;
                                        ObjEmployeeTransactions."User Defined Loan Interest" := 0;
                                        ObjEmployeeTransactions."Member No." := ObjTempLoan."Member No.";
                                        ObjEmployeeTransactions.INSERT(TRUE);
                                        Commit();
                                    END;
                            END;
                        END;
                    UNTIL ObjTempLoan.NEXT = 0;
                END;
                UpdateTransactionCode(Employee."No.");

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        ObjTempLoan: Record "Staff Loan Buffer";
        ObjEmployeeTransactions: Record "Payroll Employee Transactions";
        ObjEmployeeLoans: Record Loans;
        ObjPayrollPeriods: Record "Payroll Periods";
        SelectedPeriod: Date;
        DateFilter: Text;
        StartDate: Date;
        EndDate: Date;
        ObjPeriodName: Text;
        ObjPeriodMonth: Integer;
        ObjPeriodYear: Integer;
        ObjCustMember: Record Members;
        ObjProductFact: Record "Product Setup";
        ObjTempLoans: Record "Staff Loan Buffer";
        PLoans: Record "Staff Loan Buffer";
        TempStaffLoan: Record "Staff Loan Buffer";
        ProdFact: Record "Product Setup";
        MultiLoans: Record "Staff Loan Buffer";
        RecFound: Integer;

    Local Procedure UpdateTransactionCode("StaffNo.": Code[10])
    var
        TransactionCodes: Record "Payroll Employee Transactions";
        TransCode: Record "Payroll Codes";
        PayrollProcessing: Codeunit "Payroll Processing";
    begin
        TransactionCodes.RESET;
        TransactionCodes.SETRANGE("Employee Code", "StaffNo.");
        IF TransactionCodes.FINDFIRST THEN BEGIN// TransactionCodes.VALIDATE("Transaction Code");


            Transcode.RESET;
            Transcode.SETRANGE(Transcode."Transaction Code", TransactionCodes."Transaction Code");
            IF Transcode.FINDFIRST THEN BEGIN

                IF Transcode."Calculation Type" = Transcode."Calculation Type"::Formula THEN TransactionCodes.Amount := PayrollProcessing.fnDisplayFrmlValues("StaffNo.", Date2DMY(SelectedPeriod, 2), Date2DMY(SelectedPeriod, 3), Transcode.Formula);

                IF Transcode."Include Employer Deduction" = TRUE THEN BEGIN
                    TransactionCodes."Employer Amount" := PayrollProcessing.fnDisplayFrmlValues("StaffNo.", Date2DMY(SelectedPeriod, 2), Date2DMY(SelectedPeriod, 3), Transcode."Is Formula for employer");
                END;
                TransactionCodes.MODIFY;
            END;

        END;

    end;

    local procedure DefaultCodes("StaffNo.": Code[10])
    var
        Transcode: Record "Payroll Codes";
        EmployeeTrans: Record "Payroll Employee Transactions";


    begin
        Transcode.RESET;
        Transcode.SETRANGE("Is Default", TRUE);
        IF Transcode.FINDFIRST THEN BEGIN
            EmployeeTrans.INIT;
            EmployeeTrans."Employee Code" := "StaffNo.";
            EmployeeTrans."Payroll Period" := SelectedPeriod;
            EmployeeTrans."Transaction Code" := Transcode."Transaction Code";
            EmployeeTrans.VALIDATE("Transaction Code");
            EmployeeTrans."Reference No" := "StaffNo.";
            EmployeeTrans."Transaction Type" := Transcode."Transaction Type";
            EmployeeTrans.INSERT(TRUE);

        END;

    end;




}
