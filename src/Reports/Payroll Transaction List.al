report 50039 "Payroll Transaction List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Payroll Transaction List.rdlc';

    dataset
    {
        dataitem("PR Period Transactions"; "Payroll Period Transactions")
        {
            DataItemTableView = SORTING("Group Order", "Transaction Code");
            RequestFilterFields = "Payroll Period";
            column(EmployeeCode_PRPeriodTransactions; "PR Period Transactions"."Employee Code")
            {
            }
            column(TransactionCode_PRPeriodTransactions; "PR Period Transactions"."Transaction Code")
            {
            }
            column(GroupText_PRPeriodTransactions; "PR Period Transactions".Grouping)
            {
            }
            column(TransactionName_PRPeriodTransactions; "PR Period Transactions"."Transaction Name")
            {
            }
            column(Amount_PRPeriodTransactions; "PR Period Transactions".Amount)
            {
            }
            column(Balance_PRPeriodTransactions; "PR Period Transactions".Balance)
            {
            }
            column(OriginalAmount_PRPeriodTransactions; '')
            {
            }
            column(GroupOrder_PRPeriodTransactions; "PR Period Transactions"."Group Order")
            {
            }
            column(SubGroupOrder_PRPeriodTransactions; "PR Period Transactions"."Sub Group Order")
            {
            }
            column(PeriodMonth_PRPeriodTransactions; "PR Period Transactions"."Period Month")
            {
            }
            column(PeriodYear_PRPeriodTransactions; "PR Period Transactions"."Period Year")
            {
            }
            column(PeriodFilter_PRPeriodTransactions; "PR Period Transactions"."Period Filter")
            {
            }
            column(PayrollPeriod_PRPeriodTransactions; "PR Period Transactions"."Payroll Period")
            {
            }
            column(LastFieldNo; LastFieldNo)
            {
            }
            column(FooterPrinted; FooterPrinted)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(SelectedPeriod; SelectedPeriod)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(TotalsAllowances; TotalsAllowances)
            {
            }
            column(TotalFor; TotalFor)
            {
            }
            column(GroupOrder; GroupOrder)
            {
            }
            column(Total; Total)
            {
            }
            column(TotalNet; TotalNet)
            {
            }

            trigger OnAfterGetRecord()
            var
                PayrollCode: Record "Payroll Codes";
            begin

                UserSetup.RESET;
                UserSetup.SETRANGE(UserSetup."User ID", USERID);
                IF UserSetup.FIND('-') THEN BEGIN
                    IF UserSetup."Payroll" = FALSE THEN
                        ERROR('You have no rights')
                END;

                //Get the staff details (header)
                objEmp.SETRANGE(objEmp."No.", "Employee Code");
                IF objEmp.FIND('-') THEN BEGIN
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";

                END;

                "PR Period Transactions".SETRANGE("Payroll Period", SelectedPeriod);

                //"PR Period Transactions".SETFILTER("Group Order",'=7|=8');

                IF (Amount <= 0) OR ("PR Period Transactions"."Transaction Code" = 'TOT-DED') THEN BEGIN
                    GrandTotal := GrandTotal + 0;
                    CurrReport.SKIP;
                END;

                GrandTotal := GrandTotal + Amount;
                GrandBalance := GrandBalance + Balance;

                if PayrollCode.Get("PR Period Transactions"."Transaction Code") then
                    "PR Period Transactions"."Transaction Name" := PayrollCode."Transaction Name";

                //System Should not total tax calculations
                Total := 0;
                IF "PR Period Transactions".Grouping = "PR Period Transactions".Grouping::"Tax Calculations" THEN
                    Total := 0
                ELSE
                    Total := "PR Period Transactions".Amount;

                if "PR Period Transactions"."Transaction Code" = 'NPAY' then begin
                    TotalNet += "PR Period Transactions".Amount;
                    "PR Period Transactions"."Sub Group Order" := 10000;
                end;
            end;


            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Period Year");
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Message('Amt %1', TotalNet);
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

        SelectedPeriod := "PR Period Transactions".GETRANGEMIN("Payroll Period");
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodName := objPeriod."Period Name";
        END;

        CompanyInfo.RESET;
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture)
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PeriodTrans: Record "Payroll Period Transactions";
        objPeriod: Record "Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        CompanyInfo: Record "Company Information";
        TotalsAllowances: Decimal;
        TotalFor: Label 'Total for ';
        GroupOrder: Label '3';
        GrandTotal: Decimal;
        strEmpName: Text[100];
        objEmp: Record Employee;
        GrandBalance: Decimal;
        NSSF: Code[30];
        UserSetup: Record "User Setup";
        Total: Decimal;
        TotalNet: Decimal;
}

