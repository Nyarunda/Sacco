Report 50326 "prStaff Pension Contrib"
{
    ApplicationArea = All;
    Caption = 'Staff Pension Contribution';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/prStaff Pension Contrib.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("prSalary Card"; "Staff Payroll Details")
        {
            DataItemTableView = sorting("Employee Code");
            RequestFilterFields = "Period Filter", "Employee Code";
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
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(SelfContrib; SelfContrib)
            {
            }
            column(CompanyContrib; CompanyContrib)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(CummContrib; CummContrib)
            {
            }
            column(TotCompanyContrib; TotCompanyContrib)
            {
            }
            column(TotSelfContrib; TotSelfContrib)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(TotCummContrib; TotCummContrib)
            {
            }
            column(Employee_Employer_Pension_ContributionCaption; Employee_Employer_Pension_ContributionCaptionLbl)
            {
            }
            column(Self_Contribution_Caption; Self_Contribution_CaptionLbl)
            {
            }
            column(Company_Contrib_Caption; Company_Contrib_CaptionLbl)
            {
            }
            column(Cumm_Contribution_Caption; Cumm_Contribution_CaptionLbl)
            {
            }
            column(Basic_Pay_Caption; Basic_Pay_CaptionLbl)
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
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(EmployeeName);
                objEmp.Reset();
                objEmp.SetRange("No.", "Employee Code");
                if objEmp.FindFirst() then
                    EmployeeName := DelChr(StrSubstNo('%1 %2 %3', objEmp."First Name", objEmp."Middle Name", objEmp."Last Name"), '<>', ' ');

                EmpVol := 0;
                SelfContrib := 0;
                CompanyContrib := 0;
                SelfContribARREARS := 0;
                CompanyContribARREARS := 0;

                BasicPay := "Basic Pay";

                PeriodTrans.Reset();
                PeriodTrans.SetRange("Employee Code", "Employee Code");
                PeriodTrans.SetRange("Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange("Entry Type", PeriodTrans."Entry Type"::Employee);
                PeriodTrans.SetFilter("Transaction Code", PensionTransactionCodeFilterTxt);
                if PeriodTrans.FindSet() then
                    repeat
                        SelfContrib += PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;

                prEmployerContrib.Reset();
                prEmployerContrib.SetRange("Employee Code", "Employee Code");
                prEmployerContrib.SetRange("Payroll Period", SelectedPeriod);
                prEmployerContrib.SetFilter("Transaction Code", PensionTransactionCodeFilterTxt);
                prEmployerContrib.SetRange("Entry Type", prEmployerContrib."Entry Type"::Employer);
                if prEmployerContrib.FindSet() then
                    repeat
                        CompanyContrib += prEmployerContrib.Amount;
                    until prEmployerContrib.Next() = 0;


                if (SelfContrib = 0) and (CompanyContrib = 0) and (EmpVol = 0) then
                    CurrReport.Skip
                else
                    EmpCount := EmpCount + 1;


                CummContrib := SelfContrib + CompanyContrib + EmpVol;

                TotVolContrib := TotVolContrib + EmpVol;
                TotBasicPay := TotBasicPay + BasicPay;
                TotSelfContrib := TotSelfContrib + SelfContrib;
                TotCompanyContrib := TotCompanyContrib + CompanyContrib;
                TotCummContrib := TotCummContrib + CummContrib;
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
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then
            Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";

        Clear(TotVolContrib);
        Clear(TotBasicPay);
        Clear(TotSelfContrib);
        Clear(TotCompanyContrib);
        Clear(TotCummContrib);
        Clear(EmpCount);


        if Companyinfo.Get() then
            Companyinfo.CalcFields(Companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "Payroll Period Transactions";
        BasicPay: Decimal;
        SelfContrib: Decimal;
        CompanyContrib: Decimal;
        CummContrib: Decimal;
        TotBasicPay: Decimal;
        TotSelfContrib: Decimal;
        TotCompanyContrib: Decimal;
        TotCummContrib: Decimal;
        EmployeeName: Text[30];
        objEmp: Record Employee;
        objPeriod: Record "Payroll Periods";
        SelectedPeriod: Date;
        PeriodFilter: Text[30];
        PeriodName: Text[30];
        SelfContribARREARS: Decimal;
        CompanyContribARREARS: Decimal;
        prEmployerContrib: Record "Payroll Period Transactions";
        Companyinfo: Record "Company Information";
        EmpVol: Decimal;
        TotVolContrib: Decimal;
        EmpCount: Integer;
        PensionTransactionCodeFilterTxt: Label 'D001', Locked = true;
        Employee_Employer_Pension_ContributionCaptionLbl: label 'Employee/Employer Pension Contribution';
        Self_Contribution_CaptionLbl: label 'Self Contribution:';
        Company_Contrib_CaptionLbl: label 'Company Contrib:';
        Cumm_Contribution_CaptionLbl: label 'Cumm Contribution:';
        Basic_Pay_CaptionLbl: label 'Basic Pay:';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
        Totals_CaptionLbl: label 'Totals:';



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

