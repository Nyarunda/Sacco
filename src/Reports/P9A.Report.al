Report 50361 "P9 AA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/P9 A.rdlc';

    dataset
    {
        dataitem("HR Employees"; Employee)
        {
            RequestFilterFields = "No.", Status;
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(HREmpPR_ContType; "HR Employees"."Employee Type")
            {
            }
            column(HREmpPR_FName; "HR Employees"."First Name")
            {
            }
            column(HREmpPR_MName; "HR Employees"."Middle Name")
            {
            }
            column(HREmpPR_LName; "HR Employees"."Last Name")
            {
            }
            column(HREmpPR_PinNo; "HR Employees".PIN)
            {
            }
            column(CompInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompInfo_PINNo; CompanyInfo."KRA PIN")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(HREmpPR_No; "HR Employees"."No.")
            {
            }
            column(PensionContr; PensionContr)
            {
            }
            column(InsuranceRelief; InsuranceRelief)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(SelectedYear; SelectedYear)
            {
            }
            column(BPAY_LessPension; BPAY_LessPension)
            {
            }
            column(TotPensionContr; TotPensionContr)
            {
            }
            dataitem("prEmployee P9 Info"; "Payroll P9 Buffer")
            {
                DataItemLink = "Employee Code" = field("No.");
                DataItemTableView = sorting("Employee Code", "Payroll Period") order(ascending);
                PrintOnlyIfDetail = false;
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(EmployeeCode_PREmployeeP9Info; "prEmployee P9 Info"."Employee Code")
                {
                }
                column(P9Info_EmployeeCode; "prEmployee P9 Info"."Employee Code")
                {
                }
                column(P9Info_PayrollPeriod; "prEmployee P9 Info"."Payroll Period")
                {
                }
                column(P9Info_BasicPay; "prEmployee P9 Info"."Basic Pay")
                {
                }
                column(P9Info_Benefits; "prEmployee P9 Info".Benefits)
                {
                }
                column(P9Info_ValueQuarters; "prEmployee P9 Info"."Value Of Quarters")
                {
                }
                column(P9Info_GrossPay; "prEmployee P9 Info"."Gross Pay")
                {
                }
                column(P9Info_NSSF; "prEmployee P9 Info".NSSF)
                {
                }
                column(P9Info_OwnerOccupier; "prEmployee P9 Info"."Owner Occupier Interest")
                {
                }
                column(P9Info_TaxablePay; "prEmployee P9 Info"."Taxable Pay")
                {
                }
                column(P9Info_TaxCharged; "prEmployee P9 Info"."Tax Charged")
                {
                }
                column(P9Info_TaxRelief; "prEmployee P9 Info"."Tax Relief")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //Initialize
                    InsuranceRelief := 0;
                    PensionContr := 0;
                    TotTaxableAllow := 0;
                    BasicPay := 0;
                    BPAY_LessPension := 0;
                    NSSFContribution := 0;
                    TotPensionContr := 0;
                    VolNSSFContribution := 0;

                    //Pension Contribution
                    fn_PRPeriodTransactions;
                    PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'D01');  //Transaction Code for Pension Contribution
                    if PRPeriodTrans.Find('-') then begin
                        PensionContr := PRPeriodTrans.Amount;
                    end else begin
                        PensionContr := 0;
                    end;

                    //Insurance Relief
                    // PRSalaryCard.Reset;
                    // if PRSalaryCard.Get("Employee Code") then
                    // begin
                    //     //Only allow Insurance relief is staff has brough insurance certificate
                    //     if PRSalaryCard."Insurance Certificate?" then
                    //     begin
                    //          PRTransCodes.Reset;
                    //          PRTransCodes.SetRange(PRTransCodes."Special Transactions",PRTransCodes."special transactions"::"Life Insurance");
                    //          if PRTransCodes.Find('-') then
                    //          begin
                    //              repeat
                    //                 //Sum up all Insurance Reliefs for current Employee
                    //                 fn_PRPeriodTransactions;
                    //                 PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code",PRTransCodes."Transaction Code");
                    //                 if PRPeriodTrans.Find('-') then
                    //                 begin
                    //                      InsuranceRelief += PRPeriodTrans.Amount;
                    //                      InsuranceRelief :=0.15 * InsuranceRelief;
                    //                 end;
                    //              until PRTransCodes.Next =0;
                    //          end;
                    //      end;
                    // end;


                    //Basic Pay + ALL Taxable Allowances
                    PRTransCodes.Reset;
                    PRTransCodes.SetRange(PRTransCodes."Transaction Type", PRTransCodes."transaction type"::Earning);
                    PRTransCodes.SetRange(PRTransCodes.Taxable, true);
                    if PRTransCodes.Find('-') then begin
                        repeat
                            fn_PRPeriodTransactions;
                            PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", PRTransCodes."Transaction Code");
                            if PRPeriodTrans.Find('-') then begin
                                TotTaxableAllow := TotTaxableAllow + PRPeriodTrans.Amount;  //Total Taxable Allowances
                            end;
                        until PRTransCodes.Next = 0;
                        BasicPay := "Basic Pay" + TotTaxableAllow;
                        //error('Total Taxable Allowances is %1 and Basic Pay is %2',TotTaxableAllow,BasicPay);
                    end;


                    //Volunatary NSSF
                    fn_PRPeriodTransactions;
                    PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'D49');
                    if PRPeriodTrans.Find('-') then begin
                        VolNSSFContribution := PRPeriodTrans.Amount;
                    end else begin
                        VolNSSFContribution := 0;
                    end;

                    //Pension Contribution  + Employer NSSF Contribution + Voluntary NSSF
                    fn_PRPeriodTransactions;
                    PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'D001');
                    if PRPeriodTrans.Find('-') then begin
                        NSSFContribution := PRPeriodTrans.Amount;
                        TotPensionContr := NSSFContribution + PensionContr + VolNSSFContribution;
                    end else begin
                        NSSFContribution := 0;
                    end;


                    //Basic Pay less pension
                    BPAY_LessPension := BasicPay - TotPensionContr;
                end;

                trigger OnPreDataItem()
                begin

                    //Filter by Selected Year
                    SetRange("Period Year", SelectedYearInteger);
                end;
            }
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
                    field("Select Year"; SelectedYear)
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

        if SelectedYear = Selectedyear::" " then Error(Text001);

        SelectedYearText := Format(SelectedYear);
        Evaluate(SelectedYearInteger, SelectedYearText);


        CompanyInfo.Reset;
        if CompanyInfo.Get then begin
            CompanyInfo.CalcFields(CompanyInfo.Picture);
            CompanyInfo.TestField(CompanyInfo.Name);
            CompanyInfo.TestField(CompanyInfo."KRA PIN");
        end;
    end;

    var
        SelectedYear: Option " ","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030";
        SelectedYearText: Text;
        SelectedYearInteger: Integer;
        CompanyInfo: Record "Company Information";
        Text001: label 'Please enter Period Year';
        PRPeriodTrans: Record "Payroll Period Transactions";
        PensionContr: Decimal;
        PRTransCodes: Record "Payroll Codes";
        InsuranceRelief: Decimal;
        PRSalaryCard: Record Employee;
        BasicPay: Decimal;
        TotTaxableAllow: Decimal;
        BPAY_LessPension: Decimal;
        NSSFContribution: Decimal;
        TotPensionContr: Decimal;
        VolNSSFContribution: Decimal;


    procedure fn_PRPeriodTransactions()
    begin
        PRPeriodTrans.Reset;
        PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", "prEmployee P9 Info"."Payroll Period");
        PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "prEmployee P9 Info"."Employee Code");
    end;
}

