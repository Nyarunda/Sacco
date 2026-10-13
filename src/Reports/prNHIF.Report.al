Report 50320 prNHIF
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/prNHIF.rdlc';

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
            column(PeriodTrans_Period_Year; PeriodTrans."Period Year")
            {
            }
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Address; Address)
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(Tel; Tel)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(PeriodName_Control1102756007; PeriodName)
            {
            }
            column(NhifAmount; NhifAmount)
            {
            }
            column(IDNumber; IDNumber)
            {
            }
            column(NhifNo; NhifNo)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(Dob; Dob)
            {
            }
            column(TotNhifAmount; TotNhifAmount)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUNDCaption; NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(PERIOD_Caption_Control1102755032; PERIOD_Caption_Control1102755032Lbl)
            {
            }
            column(ADDRESS_Caption; ADDRESS_CaptionLbl)
            {
            }
            column(EMPLOYER_Caption; EMPLOYER_CaptionLbl)
            {
            }
            column(EMPOLOYER_NO_Caption; EMPOLOYER_NO_CaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NO_Caption; EMPLOYER_PIN_NO_CaptionLbl)
            {
            }
            column(TEL_NO_Caption; TEL_NO_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(NHIF_No_Caption; NHIF_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Date_Of_BirthCaption; Date_Of_BirthCaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Total_NHIF_Caption; Total_NHIF_CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                PCodes: Record "Payroll Codes";
            begin

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then;
                EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                NhifNo := objEmp."NHIF No.";
                IDNumber := objEmp."Personal ID No.";
                Dob := objEmp."Birth Date";

                NhifAmount := 0;
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange("Sub Group", PeriodTrans."Sub Group"::NHIF);
                if PeriodTrans.Find('-') then begin
                    NhifAmount := PeriodTrans.Amount;
                end;

                if NhifAmount <= 0 then
                    CurrReport.Skip;
                TotNhifAmount := TotNhifAmount + NhifAmount;

            end;

            trigger OnPreDataItem()
            begin
                /*
                if CompInfoSetup.Get() then
                    EmployerNHIFNo := CompInfoSetup."N.H.I.F No";
                CompPINNo := CompInfoSetup."Company P.I.N";
                Address := CompInfoSetup.Address;
                Tel := CompInfoSetup."Phone No.";
                */
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
        
        SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");   */

        if SelectedPeriod = 0D then Error('You must specify the period filter');

        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        if Companyinfo.Get() then
            Companyinfo.CalcFields(Companyinfo.Picture);

    end;

    var
        PeriodTrans: Record "Payroll Period Transactions";
        NhifAmount: Decimal;
        TotNhifAmount: Decimal;
        EmployeeName: Text[30];
        NhifNo: Text[30];
        IDNumber: Text[30];
        objPeriod: Record "Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        objEmp: Record Employee;
        CompInfoSetup: Record "Company Information";
        EmployerNHIFNo: Code[20];
        CompPINNo: Code[20];
        Address: Text[90];
        Tel: Text[30];
        Dob: Date;
        Companyinfo: Record "Company Information";
        NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl: label 'SOCIAL HEALTH AUTHORITY';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        PERIOD_Caption_Control1102755032Lbl: label 'PERIOD:';
        ADDRESS_CaptionLbl: label 'ADDRESS:';
        EMPLOYER_CaptionLbl: label 'EMPLOYER:';
        EMPOLOYER_NO_CaptionLbl: label 'EMPOLOYER NO:';
        EMPOLOYER_NO_Caption: Label 'EMPOLOYER NO:';
        EMPLOYER_PIN_NO_CaptionLbl: label 'EMPLOYER PIN NO:';
        TEL_NO_CaptionLbl: label 'TEL NO:';
        AmountCaptionLbl: label 'Amount';
        ID_Number_CaptionLbl: label 'ID Number:';
        NHIF_No_CaptionLbl: label 'SHA No:';
        Employee_NameCaptionLbl: label 'Employee Name';
        No_CaptionLbl: label 'No:';
        Date_Of_BirthCaptionLbl: label 'Date Of Birth';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Total_NHIF_CaptionLbl: label 'Total SHA:';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';



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

