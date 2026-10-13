
Report 50209 "Payroll Net Pay Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Payroll Net Pay Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where(Status = const(Active));
            RequestFilterFields = "No.";
            column(ReportForNavId_8631; 8631)
            {
            }
            column(TransName; TransName)
            {
            }
            column(BankBranchCode_Employee; Employee."Branch Code")
            {
            }
            column(BankCode_Employee; Employee."Bank Code")
            {
            }
            column(BankAccountNo_Employee; Employee."Bank Account No.")
            {
            }
            column(EmployerAmtPresent; EmployerAmtPresent)
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(NHIFNo; NHIFNo)
            {
            }
            column(Address; Address)
            {
            }
            column(PeriodName_Control1102760003; PeriodName)
            {
            }
            column(TelNo; TelNo)
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(HR_Employee__NHIF_No__; "NHIF No.")
            {
            }
            column(PeriodYear; PeriodYear)
            {
            }
            column(EmployeeAmt; EmployeeAmt)
            {
            }
            column(EmployerAmt; EmployerAmt)
            {
            }
            column(HR_Employee__Last_Name_; "Last Name")
            {
            }
            column(IDs; IdNumber)
            {
            }
            column(PersonalIDNo_Employee; IdNumber)
            {
            }
            column(EmployeeName; EmployeeName)
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
            column(EMPLOYER_NO_Caption; EMPLOYER_NO_CaptionLbl)
            {
            }
            column(ADDRESS_Caption; ADDRESS_CaptionLbl)
            {
            }
            column(PERIOD_Caption_Control1102755031; PERIOD_Caption_Control1102755031Lbl)
            {
            }
            column(TEL_NO_Caption; TEL_NO_CaptionLbl)
            {
            }
            column(HR_Employee__No__Caption; FieldCaption("No."))
            {
            }
            column(HR_Employee__ID_Number_Caption; FieldCaption("No."))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(LAST_NAMECaption; LAST_NAMECaptionLbl)
            {
            }
            column(OTHER_NAMESCaption; OTHER_NAMESCaptionLbl)
            {
            }
            column(HR_Employee__NHIF_No__Caption; FieldCaption("NHIF No."))
            {
            }
            column(prepared; Preparedby)
            {
            }
            column(checked; Checkedby)
            {
            }
            column(authorized; Authorizedby)
            {
            }
            column(approved; Approvedby)
            {
            }
            column(Total_NHIF_Caption; Total_NHIF_CaptionLbl)
            {
            }
            column(Counter; Counter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CoInfo.Get();
                EmployeeName := "First Name" + ' ' + "Middle Name";

                EmployeeAmt := 0;
                EmployerAmt := 0;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", PCode);
                PeriodTrans.SetRange(PeriodTrans."Entry Type", PeriodTrans."entry type"::Employee);
                if PeriodTrans.Find('-') then
                    EmployeeAmt := PeriodTrans.Amount;

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", PCode);
                PeriodTrans.SetRange(PeriodTrans."Entry Type", PeriodTrans."entry type"::Employer);
                if PeriodTrans.Find('-') then
                    EmployerAmt := PeriodTrans.Amount;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(CompanyInfo.Picture);


                PCode := 'NPAY';
                IdNumber := '';

                PayrollCodes.Get(PCode);

                EmployerAmtPresent := '';
                if PayrollCodes."Include Employer Deduction" then
                    EmployerAmtPresent := 'Yes';


                IDNumber := Employee."National Id";
                if IDNumber = '' then
                    IDNumber := Employee."Personal ID No.";


                TransName := PayrollCodes."Transaction Name";
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
                    Caption = 'SelectedPeriod';
                    //TableRelation = Table61004;
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
            PeriodYear := objPeriod."Period Year";
        end;
    end;

    var
        PeriodTrans: Record "Payroll Period Transactions";
        NhifAmount: Decimal;
        IDNumber: Text[20];
        TotNhifAmount: Decimal;
        EmployeeName: Text[100];
        objPeriod: Record "Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        NHIFNo: Text[100];
        NSSFNo: Code[100];
        PINNo: Code[100];
        Address: Text[100];
        TelNo: Text[100];
        ExcelBuf: Record "Excel Buffer" temporary;
        GLFilter: Text[250];
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        CurrFormat: Text[30];
        Text000: label 'Period: %1';
        Text001: label 'NHIF';
        Text002: label 'NHIF';
        Text003: label 'Names';
        Text004: label 'Amount';
        Text005: label 'Company Name';
        Text006: label 'Report No.';
        Text007: label 'Report Name';
        Text008: label 'User ID';
        Text009: label 'Date';
        Text010: label 'G/L Filter';
        Text011: label 'Period Filter';
        Text012: label 'ID Number';
        Text013: label 'NHIF No.';
        Text014: label 'Total Amount';
        CoInfo: Record "Company Information";
        CompanyInfo: Record "Company Information";
        NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl: label 'NATIONAL HOSPITAL INSURANCE FUND';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        EMPLOYER_NO_CaptionLbl: label 'EMPLOYER NO:';
        ADDRESS_CaptionLbl: label 'ADDRESS:';
        PERIOD_Caption_Control1102755031Lbl: label 'PERIOD:';
        TEL_NO_CaptionLbl: label 'TEL NO:';
        AmountCaptionLbl: label 'Amount';
        LAST_NAMECaptionLbl: label 'LAST NAME';
        OTHER_NAMESCaptionLbl: label 'OTHER NAMES';
        Total_NHIF_CaptionLbl: label 'Total NHIF:';
        Preparedby: label 'Prepared By: ...............................................Date:..............................................';
        Checkedby: label 'Checked By :................................................Date:..............................................';
        Authorizedby: label 'Authorized By:..............................................Date:..............................................';
        Approvedby: label 'Approved By:...............................................Date:..............................................';
        Counter: Integer;
        Scheme: Text[30];
        ContractType: Text[30];
        PeriodYear: Integer;
        PayrollCodes: Record "Payroll Codes";
        PCode: Code[20];
        EmployeeAmt: Decimal;
        EmployerAmt: Decimal;
        EmployerAmtPresent: Text;
        TransName: Code[200];


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

