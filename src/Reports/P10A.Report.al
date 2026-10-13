Report 50324 P10A
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/P10A.rdlc';

    dataset
    {
        dataitem("HR Employees"; Employee)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(HREmpPR_No; "HR Employees"."No.")
            {
            }
            column(HREmpPR_FName; "HR Employees"."First Name")
            {
            }
            column(HREmpPR_PinNo; "HR Employees".PIN)
            {
            }
            column(HREmpPR_MName; "HR Employees"."Middle Name")
            {
            }
            column(HREmpPR_LName; "HR Employees"."Last Name")
            {
            }
            column(Tot_TaxablePay; Tot_TaxablePay)
            {
            }
            column(Tot_PAYE; Tot_PAYE)
            {
            }
            column(SelectedYear; SelectedYear)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPINNo; CompanyInfo."KRA PIN")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Total Taxable Pay
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentkey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Period Year", SelectedYear);
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'TXBP');
                PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "No.");
                //PRPeriodTrans.SETRANGE(PRPeriodTrans."Period Closed",true);
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    Tot_TaxablePay := PRPeriodTrans.Amount;
                end else begin
                    Tot_TaxablePay := 0;
                end;

                //Total PAYE
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentkey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Period Year", SelectedYear);
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Code Type", PRPeriodTrans."Payroll Code Type"::PAYE);
                PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "No.");
                //PRPeriodTrans.SETRANGE(PRPeriodTrans."Period Closed",true);
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    Tot_PAYE := PRPeriodTrans.Amount;
                end else begin
                    Tot_PAYE := 0;
                end;
                if (Tot_TaxablePay = 0) and (Tot_PAYE = 0) then CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Period)
                {
                    field(Year; SelectedYear)
                    {
                        ApplicationArea = Basic;
                    }
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

        if SelectedYear = 0 then Error(Text001);

        CompanyInfo.Reset;
        if CompanyInfo.Get then begin
            CompanyInfo.TestField(CompanyInfo.Name);
            CompanyInfo.TestField(CompanyInfo."KRA PIN");
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        end;
        //  SORTING(No.) ORDER(Descending) WHERE(Employee Contract Type=FILTER(<>CASUALS))
    end;

    var
        SelectedYear: Integer;
        CompanyInfo: Record "Company Information";
        PRPeriodTrans: Record "Payroll Period Transactions";
        Text001: label 'Please enter Period Year';
        Tot_TaxablePay: Decimal;
        Tot_PAYE: Decimal;
        PRPeriodTrans_1: Record "Payroll Period Transactions";
        PRPeriodTrans_2: Record "Payroll Period Transactions";
        PRPayrollPeriod: Record "Payroll Periods";


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

