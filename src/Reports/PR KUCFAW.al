report 50040 "PR KUCFAW"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/PR KUCFAW.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodName_Control1102756011; PeriodName)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Volume_Amount_; "Volume Amount")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(IDNumber; idNumber)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "No.")
            {
            }
            column(totTotalAmount; totTotalAmount)
            {
            }
            column(TotVolume_Amount_; "TotVolume Amount")
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUNDCaption; NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl)
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
            column(PERIOD_Caption_Control1102755031; PERIOD_Caption_Control1102755031Lbl)
            {
            }
            column(EMPLOYER_NO_Caption; EMPLOYER_NO_CaptionLbl)
            {
            }
            column(EMPLOYER_NAME_Caption; EMPLOYER_NAME_CaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(Vol_AmountCaption; Vol_AmountCaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Employee_AmountCaption; Employee_AmountCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(Total_Amounts_Caption; Total_Amounts_CaptionLbl)
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
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE(UserSetup."User ID", USERID);
                IF UserSetup.FIND('-') THEN BEGIN
                    IF UserSetup."Payroll" = FALSE THEN
                        ERROR('You have no rights')
                END;

                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "No.");
                IF objEmp.FIND('-') THEN;
                EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                IDNumber := objEmp."National Id";
                if IDNumber = '' then
                    IDNumber := objEmp."Personal ID No.";

                //Volume Amount****************************************************************************
                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETFILTER(PeriodTrans."Transaction Code", 'D011');
                PeriodTrans.SETCURRENTKEY(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                "Volume Amount" := 0;
                IF PeriodTrans.FIND('-') THEN BEGIN
                    "Volume Amount" := PeriodTrans.Amount;
                END;

                "TotVolume Amount" := "TotVolume Amount" + "Volume Amount";


                IF "Volume Amount" <= 0 THEN
                    CurrReport.SKIP;
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
                    ApplicationArea = All;
                    Caption = 'SelectedPeriod';
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
        /*
        PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter='' THEN ERROR('You must specify the period filter');
        
        SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");
        objPeriod.RESET;
        IF objPeriod.GET(SelectedPeriod) THEN PeriodName:=objPeriod."Period Name";
        */

        IF SelectedPeriod = 0D THEN ERROR('You must specify the period filter');
        objPeriod.RESET;
        IF objPeriod.GET(SelectedPeriod) THEN BEGIN
            PeriodName := objPeriod."Period Name";
        END;


        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

    end;

    var
        PeriodTrans: Record "Payroll Period Transactions";
        NssfAmount: Decimal;
        TotNssfAmount: Decimal;
        objEmp: Record Employee;
        EmployeeName: Text[150];
        NssfNo: Text[30];
        IDNumber: Text[20];
        objPeriod: Record "Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        "Volume Amount": Decimal;
        "TotVolume Amount": Decimal;
        TotalAmount: Decimal;
        totTotalAmount: Decimal;
        CompanyInfo: Record "Company Information";
        NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl: Label 'NATIONAL SOCIAL SECURITY FUND';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        PERIOD_Caption_Control1102755031Lbl: Label 'PERIOD:';
        EMPLOYER_NO_CaptionLbl: Label 'EMPLOYER NO:';
        EMPLOYER_NAME_CaptionLbl: Label 'EMPLOYER NAME:';
        Payroll_No_CaptionLbl: Label 'Payroll No:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        NSSF_No_CaptionLbl: Label 'NSSF No:';
        ID_Number_CaptionLbl: Label 'ID Number:';
        Vol_AmountCaptionLbl: Label 'Vol Amount';
        Total_AmountCaptionLbl: Label 'Total Amount';
        Employee_AmountCaptionLbl: Label 'Employee Amount';
        Employer_AmountCaptionLbl: Label 'Employer Amount';
        Total_Amounts_CaptionLbl: Label 'Total Amounts:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by……………………………………………………..                Date……………………………………………';
        UserSetup: Record "User Setup";
}

