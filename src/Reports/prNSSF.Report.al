Report 50319 prNSSF
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/prNSSF.rdlc';

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
            column(PeriodYear; PeriodYear)
            {
            }
            column(CurrReport_PAGENO; 0)
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
            column(IDNumber; IDNumber)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(NssfAmount_1; NssfAmount_1)
            {
            }
            column(NssfAmount_2; NssfAmount_2)
            {
            }
            column(NssfNo; NssfNo)
            {
            }
            column(NssfAmount_2_Control1102756008; NssfAmount_1)
            {
            }
            column(TotNssfAmount_2; TotNssfAmount)
            {
            }
            column(totTotalAmount; totTotalAmount)
            {
            }
            column(TotVolume_Amount_; "TotVolume Amount")
            {
            }
            column(TotNssfAmount_2_Control1102756015; TotNssfAmount)
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
            column(NSSF_No_Caption; NSSF_No_CaptionLbl)
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
            var
                PCodes: Record "Payroll Codes";
            begin

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then;
                EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                NssfNo := objEmp."NSSF No.";
                IDNumber := objEmp."National Id";
                if IDNumber = '' then
                    IDNumber := objEmp."Personal ID No.";

                "Volume Amount" := 0;
                TotalAmount := 0;
                NssfAmount_1 := 0;
                NssfAmount_2 := 0;
                PCodes.Reset();
                PCodes.SetRange("Special Identifier", PCodes."Special Identifier"::NSSF);
                if PCodes.FindFirst() then begin


                    //Volume Amount****************************************************************************
                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetRange("Entry Type", PeriodTrans."Entry Type"::Employee);
                    PeriodTrans.SetFilter(PeriodTrans."Transaction Code", PCodes."Transaction Code");
                    if PeriodTrans.Find('-') then begin
                        // PeriodTrans.CalcSums(Amount);
                        // "Volume Amount" := PeriodTrans.Amount;
                    end;

                    //"TotVolume Amount" := "TotVolume Amount" + "Volume Amount";


                    //Standard Amount**************************************************************************
                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetRange("Entry Type", PeriodTrans."Entry Type"::Employee);
                    PeriodTrans.SetFilter(PeriodTrans."Transaction Code", PCodes."Transaction Code");
                    PeriodTrans.SetFilter(PeriodTrans."Transaction Name", 'NSSF Tier 1');
                    if PeriodTrans.Find('-') then begin
                        repeat
                            NssfAmount_1 += PeriodTrans.Amount;
                        until PeriodTrans.Next() = 0;
                    end;

                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetRange("Entry Type", PeriodTrans."Entry Type"::Employee);
                    PeriodTrans.SetFilter(PeriodTrans."Transaction Code", PCodes."Transaction Code");
                    PeriodTrans.SetFilter(PeriodTrans."Transaction Name", 'NSSF Tier 2');
                    if PeriodTrans.Find('-') then begin
                        repeat
                            NssfAmount_2 += PeriodTrans.Amount;
                        until PeriodTrans.Next() = 0;
                    end;
                end;

                //Total Amount=NssfAmount+Volume Amount**************************************************
                TotalAmount := NssfAmount_1 + NssfAmount_2;//+ "Volume Amount";


                //Summation Total Amount=****************************************************************
                totTotalAmount := TotalAmount + TotalAmount;

                if NssfAmount_1 + NssfAmount_2 <= 0 then
                    CurrReport.Skip;

                //TotNssfAmount := NssfAmount;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Period; Period)
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
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        //IF PeriodFilter='' THEN ERROR('You must specify the period filter');


        //SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");
        //SelectedPeriod:=PeriodFilter;


        if Period = 0D then Error('You must specify the period filter');

        SelectedPeriod := Period;
        
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then begin
            PeriodName := objPeriod."Period Name";
            PeriodYear := objPeriod."Period Year";
        end;
        PeriodName := objPeriod."Period Name";


        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        PeriodTrans: Record "Payroll Period Transactions";
        NssfAmount_1: Decimal;
        NssfAmount_2: Decimal;
        TotNssfAmount: Decimal;
        objEmp: Record Employee;
        EmployeeName: Text[30];
        NssfNo: Text[30];
        IDNumber: Text[30];
        objPeriod: Record "Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodYear: Integer;
        PeriodFilter: Text[30];
        "Volume Amount": Decimal;
        "TotVolume Amount": Decimal;
        TotalAmount: Decimal;
        totTotalAmount: Decimal;
        CompanyInfo: Record "Company Information";
        NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl: label 'NATIONAL SOCIAL SECURITY FUND';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        PERIOD_Caption_Control1102755031Lbl: label 'PERIOD:';
        EMPLOYER_NO_CaptionLbl: label 'EMPLOYER NO:';
        EMPLOYER_NAME_CaptionLbl: label 'EMPLOYER NAME:';
        Payroll_No_CaptionLbl: label 'Payroll No:';
        Employee_NameCaptionLbl: label 'Employee Name';
        NSSF_No_CaptionLbl: label 'NSSF No:';
        ID_Number_CaptionLbl: label 'ID Number:';
        Vol_AmountCaptionLbl: label 'Vol Amount';
        Total_AmountCaptionLbl: label 'Total Amount';
        Employee_AmountCaptionLbl: label 'Employee Amount';
        Employer_AmountCaptionLbl: label 'Employer Amount';
        Total_Amounts_CaptionLbl: label 'Total Amounts:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
        Period: Date;


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

