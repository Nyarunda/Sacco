Report 50316 "prPaye Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/prPaye Schedule.rdlc';

    dataset
    {
        dataitem("prSalary Card"; "Staff Payroll Details")
        {
            RequestFilterFields = "Employee Code";
            column(ReportForNavId_6207; 6207)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Today; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(PinNumber; PinNumber)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(IDNo; IDNo) { }
            column(HousingLevy; HousingLevy) { }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(TotPayeAmount; TotPayeAmount)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(P_A_Y_E_ScheduleCaption; P_A_Y_E_ScheduleCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(PIN_Number_Caption; PIN_Number_CaptionLbl)
            {
            }
            column(Paye_Amount_Caption; Paye_Amount_CaptionLbl)
            {
            }
            column(Gross_Pay_Caption; Gross_Pay_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                IDNo := objEmp."Personal ID No.";
                PinNumber := objEmp.PIN;

                TaxablePay := 0;
                PayeAmount := 0;

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                if PeriodTrans.Find('-') then
                    repeat
                        //GROSS Pay -  BY BKK
                        if (PeriodTrans."Transaction Code" = 'GPAY') then begin
                            TaxablePay := PeriodTrans.Amount;

                        end;

                        //Housing Levy
                        if (PeriodTrans."Transaction Code" = 'D36') then begin
                            HousingLevy := PeriodTrans.Amount;

                        end;


                        //GrpOrder 7, SubGrpOrder 3 = PAYE
                        if PeriodTrans."Sub Group" = PeriodTrans."Sub Group"::PAYE then begin
                            PayeAmount := PeriodTrans.Amount;
                        end;
                    until PeriodTrans.Next = 0;

                if PayeAmount <= 0 then
                    CurrReport.Skip;

                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Payroll Period"; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Periods"."Date Opened";
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
        /*PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter='' THEN ERROR('You must specify the period filter');
        
        SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");*/

        if SelectedPeriod = 0D then Error('You must specify the period filter');

        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";


        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);

    end;

    var
        PeriodTrans: Record "Payroll Period Transactions";
        PayeAmount: Decimal;
        TotPayeAmount: Decimal;
        HousingLevy: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        EmployeeName: Text[30];
        PinNumber: Text[30];
        objPeriod: Record "Payroll Periods";
        objEmp: Record Employee;
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        IDNo: code[20];
        companyinfo: Record "Company Information";
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        P_A_Y_E_ScheduleCaptionLbl: label 'P.A.Y.E Schedule';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        No_CaptionLbl: label 'No:';
        Employee_NameCaptionLbl: label 'Employee Name';
        PIN_Number_CaptionLbl: label 'PIN Number:';
        Paye_Amount_CaptionLbl: label 'Paye Amount:';
        Gross_Pay_CaptionLbl: label 'Gross Pay:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Totals_CaptionLbl: label 'Totals:';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
        ShowGrossPay: Boolean;



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

