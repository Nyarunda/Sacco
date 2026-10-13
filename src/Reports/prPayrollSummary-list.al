report 50027 "prPayrollSummary-List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/prPayrollSummary-List.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(PayrollMode; PayrollMode)
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(Grosspay; Grosspay)
            {
            }
            column(PAYE; PAYE)
            {
            }
            column(ProjLoan; ProjLoan)
            {
            }
            column(Helb; Helb)
            {
            }
            column(prPayrollPeriodsDateOpened; objPeriod."Date Opened")
            {
            }
            column(Periodyear; objPeriod."Period Year")
            {
            }
            column(TestH; TestH)
            {
            }
            column(NHIF; NHIF)
            {
            }
            column(SaccContr; SaccContr)
            {
            }
            column(PenVoContr; PenVoContr)
            {
            }
            column(SIContr; SIContr)
            {
            }
            column(SaccLoan; SaccLoan)
            {
            }
            column(Nssf; Nssf)
            {
            }
            column(nonTaxAmount; nonTaxAmount)
            {
            }
            column(statutoryDed; statutoryDed)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(OtherAllow; OtherAllow)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(nonstatutoryDed; nonstatutoryDed)
            {
            }
            column(Pension; Pension)
            {
            }
            column(negNet; negNet)
            {
            }
            column(strCodes; strCodes)
            {
            }
            column(TotnegNet; TotnegNet)
            {
            }
            column(TotNetPay; TotNetPay)
            {
            }
            column(totTotalDeductions; totTotalDeductions)
            {
            }
            column(TotPension; TotPension)
            {
            }
            column(TotnonstatutoryDed; TotnonstatutoryDed)
            {
            }
            column(TotstatutoryDed; TotstatutoryDed)
            {
            }
            column(TotnonTaxAmount; TotnonTaxAmount)
            {
            }
            column(TotGrosspay; TotGrosspay)
            {
            }
            column(TotOtherAllow; TotOtherAllow)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(DATE____________________________________________________________; 'DATE...........................................................')
            {
            }
            column(NAME_________________________________________________________________________________________; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION_____________________________________________________; 'DESIGNATION....................................................')
            {
            }
            column(SIGNATURE____________________________________________________; 'SIGNATURE...................................................')
            {
            }
            column(SIGNATURE_____________________________________________________Control1102756035; 'SIGNATURE...................................................')
            {
            }
            column(DATE_____________________________________________________________Control1102756042; 'DATE...........................................................')
            {
            }
            column(NAME__________________________________________________________________________________________Control1102756031; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION______________________________________________________Control1102756034; 'DESIGNATION....................................................')
            {
            }
            column(Payroll_Summary_ListCaption; Payroll_Summary_ListCaptionLbl)
            {
            }
            column(Gross_Taxable_PayCaption; Gross_Taxable_PayCaptionLbl)
            {
            }
            column(Non_Taxable_AmountCaption; Non_Taxable_AmountCaptionLbl)
            {
            }
            column(Statutory_DeductionsCaption; Statutory_DeductionsCaptionLbl)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(Pension_Staff_Cont_Caption; Pension_Staff_Cont_CaptionLbl)
            {
            }
            column(Negative_Net_PayCaption; Negative_Net_PayCaptionLbl)
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Basic_PayCaption; Basic_PayCaptionLbl)
            {
            }
            column(Employee_Name_Caption; Employee_Name_CaptionLbl)
            {
            }
            column(Non_Statutory_DeductionsCaption; Non_Statutory_DeductionsCaptionLbl)
            {
            }
            column(Employee_Code_Caption; Employee_Code_CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Checked_byCaption; Checked_byCaptionLbl)
            {
            }
            column(HR_Employee_No_; "No.")
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

                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";
                strCodes := "No.";

                BasicPay := 0;
                Allow := 0;
                Grosspay := 0;
                PenGrat := 0;
                Nssf := 0;
                HseAllow := 0;
                statutoryDed := 0;
                nonstatutoryDed := 0;
                TaxablePay := 0;
                Reliefs := 0;
                OtherAllow := 0;
                TotalDeductions := 0;
                NetPay := 0;
                negNet := 0;
                nonTaxAmount := 0;
                Pension := 0;
                NHIF := 0;
                PAYE := 0;
                Helb := 0;
                SaccLoan := 0;
                SIContr := 0;
                PenVoContr := 0;
                SaccContr := 0;
                StaffAdv := 0;
                ProjLoan := 0;
                totTotalDeductions := 0;


                //Loop through the Income/Earnings and deductions************************************************************************
                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETCURRENTKEY(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                IF PeriodTrans.FIND('-') THEN
                    REPEAT
                        //Basic Pay************************START
                        IF PeriodTrans.Grouping = PeriodTrans.Grouping::"Basic Salary" THEN BEGIN
                            BasicPay := PeriodTrans.Amount;
                            TotBasicPay := TotBasicPay + BasicPay;
                        END;

                        //Other Allowances************************START
                        IF PeriodTrans.Grouping = PeriodTrans.Grouping::Allowances THEN BEGIN
                            OtherAllow := OtherAllow + PeriodTrans.Amount;
                            TotOtherAllow := TotOtherAllow + PeriodTrans.Amount;
                        END;

                        //Gross Pay************************START
                        IF PeriodTrans.Grouping = PeriodTrans.Grouping::"Gross Salary" THEN BEGIN
                            Grosspay := Grosspay + PeriodTrans.Amount;
                            TotGrosspay := TotGrosspay + PeriodTrans.Amount;
                        END;

                        //other non taxable*************START
                        TransCodes.RESET;
                        TransCodes.SETRANGE(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.SETRANGE(TransCodes.Taxable, FALSE);
                        IF TransCodes.FINDFIRST THEN BEGIN
                            nonTaxAmount := nonTaxAmount + PeriodTrans.Amount;
                            TotnonTaxAmount := TotnonTaxAmount + PeriodTrans.Amount;
                        END;
                        /*
                         //Deductions Totals*************START
                           PeriodTrans.RESET;
                           PeriodTrans.SETRANGE(TransCodes."Transaction Code",PeriodTrans."Transaction Code");
                           PeriodTrans.SETRANGE(TransCodes.Taxable,FALSE) ;
                           IF PeriodTrans.FINDFIRST  THEN
                            BEGIN
                              nonTaxAmount:=nonTaxAmount+PeriodTrans.Amount;
                              TotnonTaxAmount:=TotnonTaxAmount+PeriodTrans.Amount;
                             END;
                       */








                        //Statutory Deductions*************START
                        IF PeriodTrans.Grouping = PeriodTrans.Grouping::Statutories THEN BEGIN
                            statutoryDed := statutoryDed + PeriodTrans.Amount;
                            TotstatutoryDed := TotstatutoryDed + PeriodTrans.Amount;
                        END;


                        //Pension ***************************START
                        IF PeriodTrans."Transaction Code" = 'D017' THEN BEGIN
                            Pension := PeriodTrans.Amount;
                        END;

                        /*
                        //Sacco Contribution***************************START
                        IF (PeriodTrans."Group Order"=8) AND (PeriodTrans."Sub Group Order"=0) THEN
                        BEGIN
                        IF PeriodTrans."Transaction Code"='D002' THEN BEGIN
                        SaccContr:=PeriodTrans.Amount;
                        END;
                        END;
                        */
                        /*
                        //SIC Contribution***************************START
                        IF (PeriodTrans."Group Order"=8) AND (PeriodTrans."Sub Group Order"=0) THEN
                        BEGIN
                        IF PeriodTrans."Transaction Code"='D003' THEN BEGIN
                        SIContr:=PeriodTrans.Amount;
                        END;
                        END;
                        */
                        /*
                        //Pension Voluntary Contribution***************************START
                        IF (PeriodTrans."Group Order"=8) AND (PeriodTrans."Sub Group Order"=0) THEN
                        BEGIN
                        IF PeriodTrans."Transaction Code"='D004' THEN BEGIN
                        PenVoContr:=PeriodTrans.Amount;
                        END;
                        END;
                        */
                        //Staff Advances***************************START
                        /*IF (PeriodTrans."Group Order"=8) AND (PeriodTrans."Sub Group Order"=0) THEN
                        BEGIN
                        IF PeriodTrans."Transaction Code"='D005' THEN BEGIN
                        StaffAdv:=PeriodTrans.Amount;
                        END;
                        END;
                        */
                        //Sacco Loan Contribution***************************START
                        /*IF (PeriodTrans."Group Order"=8) AND (PeriodTrans."Sub Group Order"=0) THEN
                        BEGIN
                        IF PeriodTrans."Transaction Code"='D006' THEN BEGIN
                        SaccLoan:=SaccLoan+PeriodTrans.Amount;
                        END;
                        END;
                        */
                        //HELB Contribution***************************START
                        IF (PeriodTrans."Group Order" = 8) AND (PeriodTrans."Sub Group Order" = 0) THEN BEGIN
                            IF PeriodTrans."Transaction Code" = 'D009' THEN BEGIN
                                Helb := Helb + PeriodTrans.Amount;
                            END;
                        END;
                        /*

                        //HELB Contribution***************************START
                        IF (PeriodTrans."Group Order"=8) AND (PeriodTrans."Sub Group Order"=0) THEN
                        BEGIN
                        IF PeriodTrans."Transaction Code"='D009' THEN BEGIN
                        ProjLoan:=ProjLoan+PeriodTrans.Amount;
                        END;
                        END;
                        */


                        //NSSF ***************************START
                        IF (PeriodTrans."Group Order" = 7) AND (PeriodTrans."Sub Group Order" = 1) THEN BEGIN
                            Nssf := Nssf + PeriodTrans.Amount;
                        END;


                        //PAYE ***************************START
                        IF (PeriodTrans."Group Order" = 7) AND (PeriodTrans."Sub Group Order" = 3) THEN BEGIN
                            PAYE := PAYE + PeriodTrans.Amount;
                        END;


                        //NHIF ***************************START
                        IF PeriodTrans."Transaction Code" = 'SHA' THEN BEGIN
                            NHIF := NHIF + PeriodTrans.Amount;
                        END;

                        //TOT-DED


                        IF PeriodTrans."Transaction Code" = 'TOT-DED' THEN BEGIN
                            totTotalDeductions := PeriodTrans.Amount + Nssf + PAYE + NHIF;
                        END;

                        /*
                        //Total Deductions***********************
                            IF (PeriodTrans."Group Order"=8) AND (PeriodTrans."Sub Group Order"=0)    THEN

                            BEGIN
                               TotalDeductions:=TotalDeductions+PeriodTrans.Amount+Nssf+PAYE+NHIF;

                            END;

                        totTotalDeductions:=Pension+SaccContr+SIContr+SaccLoan+PenVoContr+StaffAdv+ProjLoan+Helb+Nssf+PAYE+NHIF;
                        */

                        //Net Pay************************START
                        IF PeriodTrans.Grouping = PeriodTrans.Grouping::"Net Salary" THEN BEGIN
                            IF PeriodTrans.Amount < 0 THEN BEGIN
                                NetPay := NetPay + 0;
                                TotNetPay := TotNetPay + 0;
                                negNet := PeriodTrans.Amount;
                                TotnegNet := TotnegNet + PeriodTrans.Amount;
                            END
                            ELSE BEGIN
                                NetPay := NetPay + PeriodTrans.Amount;
                                TotNetPay := TotNetPay + PeriodTrans.Amount
                            END;
                        END;
                    UNTIL PeriodTrans.NEXT = 0
                ELSE
                    CurrReport.SKIP;

            end;

            trigger OnPreDataItem()
            begin
                /*
                IF PayrollMode<>PayrollMode::" " THEN BEGIN
                    Table39003917.SETRANGE(Table39003917."Payment Mode",PayrollMode);
                END;
                */

            end;
        }
        dataitem("Payroll Period Transactions"; "Payroll Period Transactions")
        {
            RequestFilterFields = "Payroll Period";
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                SelectedPeriod := "Payroll Period Transactions"."Payroll Period";
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

        //SelectedPeriod:=objPeriod.GETFILTER("Date Opened");
        SelectedPeriod := "Payroll Period Transactions".GETRANGEMIN("Payroll Period");

        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodName := objPeriod."Period Name";
        END;


        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        RestrictAccess();
    end;

    var
        strEmpName: Text[100];
        BasicPay: Decimal;
        Allow: Decimal;
        Grosspay: Decimal;
        PenGrat: Decimal;
        Nssf: Decimal;
        subTotNssf: Decimal;
        TotBasicPay: Decimal;
        TotAllow: Decimal;
        TotGrosspay: Decimal;
        TotPenGrat: Decimal;
        TotNssf: Decimal;
        PeriodTrans: Record "Payroll Period Transactions";
        TransCodes: Record "Payroll Codes";
        objPeriod: Record "Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[50];
        HseAllow: Decimal;
        HseTotAllow: Decimal;
        HREmployee: Record Employee;
        subTotNHIF: Decimal;
        TotNHIF: Decimal;
        statutoryDed: Decimal;
        TotstatutoryDed: Decimal;
        subTotstatutoryDed: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        SubTotTaxablePay: Decimal;
        Reliefs: Decimal;
        TotReliefs: Decimal;
        TaxCharged: Decimal;
        TotTaxCharged: Decimal;
        UnusedRelief: Decimal;
        SubTotUnusedRelief: Decimal;
        TotUnusedRelief: Decimal;
        PersonalRelief: Decimal;
        SubTotPersonalRelief: Decimal;
        TotPersonalRelief: Decimal;
        PAYETaxDeduction: Decimal;
        TotPAYETaxDeduction: Decimal;
        OtherDeduction: Decimal;
        TotOtherDeduction: Decimal;
        NetPay: Decimal;
        subTotNetPay: Decimal;
        TotNetPay: Decimal;
        subTotBasicPay: Decimal;
        subTotHseAllow: Decimal;
        SubTotGrosspay: Decimal;
        OtherAllow: Decimal;
        TotOtherAllow: Decimal;
        SubTotOtherAllow: Decimal;
        subtotTotalDeductions: Decimal;
        totTotalDeductions: Decimal;
        TotalDeductions: Decimal;
        companyHousing: Decimal;
        TotcompanyHousing: Decimal;
        SubTotcompanyHousing: Decimal;
        subTotReliefs: Decimal;
        SubTotTaxCharged: Decimal;
        subtotPAYETaxDeduction: Decimal;
        subTotOtherDeductions: Decimal;
        nonTaxAmount: Decimal;
        TotnonTaxAmount: Decimal;
        subTotnonTaxAmount: Decimal;
        nonstatutoryDed: Decimal;
        TotnonstatutoryDed: Decimal;
        subTotnonstatutoryDed: Decimal;
        Pension: Decimal;
        TotPension: Decimal;
        subTotPension: Decimal;
        negNet: Decimal;
        TotnegNet: Decimal;
        subTotnegNet: Decimal;
        strCodes: Code[20];
        CompanyInfo: Record "Company Information";
        PayrollMode: Option " ","Bank Transfer",Cheque,Cash,SACCO;
        Payroll_Summary_ListCaptionLbl: Label 'Payroll Summary-List';
        Gross_Taxable_PayCaptionLbl: Label 'Gross Taxable Pay';
        Non_Taxable_AmountCaptionLbl: Label 'Non-Taxable Amount';
        Statutory_DeductionsCaptionLbl: Label 'Statutory Deductions';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        Pension_Staff_Cont_CaptionLbl: Label 'Pension Staff Cont.';
        Negative_Net_PayCaptionLbl: Label 'Negative Net Pay';
        Other_AllowancesCaptionLbl: Label 'Other Allowances';
        Net_PayCaptionLbl: Label 'Net Pay';
        Basic_PayCaptionLbl: Label 'Basic Pay';
        Employee_Name_CaptionLbl: Label 'Employee Name:';
        Non_Statutory_DeductionsCaptionLbl: Label 'Non Statutory Deductions';
        Employee_Code_CaptionLbl: Label 'Employee Code:';
        Totals_CaptionLbl: Label 'Totals:';
        Checked_byCaptionLbl: Label 'Checked by';
        NHIF: Decimal;
        PAYE: Decimal;
        Helb: Decimal;
        SaccLoan: Decimal;
        SIContr: Decimal;
        PenVoContr: Decimal;
        SaccContr: Decimal;
        StaffAdv: Decimal;
        TestH: Decimal;
        ProjLoan: Decimal;
        TrCodes: Record "Payroll Codes";
        UserSetup: Record "User Setup";

    procedure RestrictAccess()
    var
        StatusPermission: Record "User Setup";
        ErrorOnRestrictViewTxt: Label 'You do not have permissions to MODIFY or DELETE on this Page. Contact your system administrator for further details';
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE("User ID", DATABASE.USERID);
        //StatusPermission.SETFILTER("Function Extended",'%1|%2',StatusPermission."Function Extended"::"Operation User",StatusPermission."Function Extended"::Administrator);
        StatusPermission.SETRANGE("Payroll", TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR(ErrorOnRestrictViewTxt);
        END;

    end;
}

