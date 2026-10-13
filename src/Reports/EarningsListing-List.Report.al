Report 50322 "Earnings Listing -List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Earnings Listing -List.rdlc';

    dataset
    {
        dataitem(UnknownTable39003990; "Payroll Periods")
        {
            column(ReportForNavId_4946; 4946)
            {
            }
        }
        dataitem("HR Employees"; Employee)
        {
            DataItemTableView = sorting("No.") where(Status = filter(Active));
            column(ReportForNavId_8631; 8631)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
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
            column(nonTaxAmount; nonTaxAmount)
            {
            }
            column(statutoryDed; statutoryDed - Nssf - NHIF)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(OtherAllow; OtherAllow - MealAllow)
            {
            }
            column(TotalDeductions; (statutoryDed - Nssf - NHIF) + Nssf + NHIF + Cic + Pension + MBF + SalAdv + StaffWelfare + UnionContr + LoanRepayment + LoanInt + SharesDed)
            {
            }
            column(nonstatutoryDed; nonstatutoryDed)
            {
            }
            column(Pension; Pension)
            {
            }
            column(Relief; Relief)
            {
            }
            column(TotRelief; TotRelief)
            {
            }
            column(Nssf; Nssf)
            {
            }
            column(subTotNssf; subTotNssf)
            {
            }
            column(NHIF; NHIF)
            {
            }
            column(TotNHIF; TotNHIF)
            {
            }
            column(HseAllow; mealAllow)
            {
            }
            column(HseTotAllow; MealTotAllow)
            {
            }
            column(Cic; Cic)
            {
            }
            column(TotCic; TotCic)
            {
            }
            column(MBF; MBF)
            {
            }
            column(TotMBF; TotMBF)
            {
            }
            column(SharesDed; SharesDed)
            {
            }
            column(TotSharesDed; TotSharesDed)
            {
            }
            column(SalAdv; SalAdv)
            {
            }
            column(TotSalAdv; TotSalAdv)
            {
            }
            column(LoanInt; LoanInt)
            {
            }
            column(TotLoanInt; TotLoanInt)
            {
            }
            column(LoanRepayment; LoanRepayment)
            {
            }
            column(TotLoanRepayment; TotLoanRepayment)
            {
            }
            column(StaffWelfare; StaffWelfare)
            {
            }
            column(TotStaffWelfare; TotStaffWelfare)
            {
            }
            column(UnionContr; UnionContr)
            {
            }
            column(TotUnionContr; TotUnionContr)
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
            column(LeaveAll; LeaveAll)
            {
            }
            column(Oncall; Oncall)
            {
            }
            column(ActingAll; ActingAll)
            {
            }
            column(CommAll; CommAll)
            {
            }
            column(RespAll; RespAll)
            {
            }
            column(TelAll; TelAll)
            {
            }
            column(SalArrs; SalArrs)
            {
            }
            column(Overtime; Overtime)
            {
            }
            column(Gratuity; Gratuity)
            {
            }
            column(Commission; Commission)
            {
            }
            column(TotalComm; TotalComm)
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
            column(PeriodYear; PeriodTrans."Period Year")
            {
            }

            trigger OnAfterGetRecord()
            begin
                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";
                strCodes := "No.";

                BasicPay := 0;
                Allow := 0;
                Grosspay := 0;
                PenGrat := 0;
                Nssf := 0;
                MealAllow := 0;
                statutoryDed := 0;
                nonstatutoryDed := 0;
                TaxablePay := 0;
                Reliefs := 0;
                OtherAllow := 0;
                TotalDeductions := 0;
                NetPay := 0;
                negNet := 0;
                Relief := 0;
                nonTaxAmount := 0;
                Pension := 0;
                NHIF := 0;
                Cic := 0;
                MBF := 0;
                SharesDed := 0;
                SalAdv := 0;
                LoanInt := 0;
                LoanRepayment := 0;
                StaffWelfare := 0;
                UnionContr := 0;
                LeaveAll := 0;
                Oncall := 0;
                ActingAll := 0;
                CommAll := 0;
                RespAll := 0;
                TelAll := 0;
                SalArrs := 0;
                Overtime := 0;
                Gratuity := 0;
                TotalComm := 0;
                Commission := 0;

                //Loop through the Income/Earnings and deductions************************************************************************
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange("Entry Type", PeriodTrans."Entry Type"::Employee);
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                if PeriodTrans.Find('-') then
                    repeat


                        //Basic Pay************************START

                        if PeriodTrans.Grouping = PeriodTrans.Grouping::"Basic Salary" then begin
                            BasicPay := PeriodTrans.Amount;
                            TotBasicPay := TotBasicPay + BasicPay;
                        end;

                        //Other Allowances************************START
                        if PeriodTrans.Grouping = PeriodTrans.Grouping::Allowances then begin
                            OtherAllow := OtherAllow + PeriodTrans.Amount;
                            TotOtherAllow := TotOtherAllow + PeriodTrans.Amount;
                        end;

                        //Gross Pay************************START
                        if PeriodTrans.Grouping = PeriodTrans.Grouping::"Gross Salary" then begin
                            Grosspay := Grosspay + PeriodTrans.Amount;
                            TotGrosspay := TotGrosspay + PeriodTrans.Amount;
                        end;

                        //other non taxable*************START
                        TransCodes.Reset;
                        TransCodes.SetRange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.SetRange(TransCodes.Taxable, false);
                        if TransCodes.FindFirst then begin
                            nonTaxAmount := nonTaxAmount + PeriodTrans.Amount;
                            TotnonTaxAmount := TotnonTaxAmount + PeriodTrans.Amount;
                        end;

                        //Statutory Deductions*************START
                        if PeriodTrans.Grouping = PeriodTrans.Grouping::Statutories then begin
                            statutoryDed := statutoryDed + PeriodTrans.Amount;
                            TotstatutoryDed := TotstatutoryDed + PeriodTrans.Amount;
                        end;

                        //Pension *************************** please redo this ;-) dennis tihihihi
                        if (PeriodTrans."Transaction Code" = 'D0008') or (PeriodTrans."Transaction Code" = 'D00020') then begin
                            Pension := Pension + PeriodTrans.Amount;
                            TotPension := TotPension + PeriodTrans.Amount;
                        end;

                        //Personal relief
                        if (PeriodTrans."Transaction Code" = 'PSNR') then begin
                            Relief := Relief + PeriodTrans.Amount;
                            TotRelief := TotRelief + PeriodTrans.Amount;
                        end;

                        //NSSF Employee
                        if (PeriodTrans."Transaction Code" = 'DEFCON') then begin
                            Nssf := Nssf + PeriodTrans.Amount;
                            subTotNssf := subTotNssf + PeriodTrans.Amount;
                        end;

                        //NSSF Employee
                        if (PeriodTrans."Transaction Code" = 'SHA') then begin
                            NHIF := NHIF + PeriodTrans.Amount;
                            TotNHIF := TotNHIF + PeriodTrans.Amount;
                        end;

                        //CIC Deduction
                        if (PeriodTrans."Transaction Code" = 'D013') then begin
                            Cic := Cic + PeriodTrans.Amount;
                            TotCic := TotCic + PeriodTrans.Amount;
                        end;

                        //MBF Fund
                        if (PeriodTrans."Transaction Code" = 'D003') then begin
                            MBF := MBF + PeriodTrans.Amount;
                            TotMBF := TotMBF + PeriodTrans.Amount;
                        end;

                        //Meal allowance
                        if (PeriodTrans."Transaction Code" = 'E0006') then begin
                            MealAllow := MealAllow + PeriodTrans.Amount;
                            MealTotAllow := MealTotAllow + PeriodTrans.Amount;
                        end;

                        //  Shares Deductions
                        if (PeriodTrans."Transaction Code" = 'D0068') then begin
                            SharesDed := SharesDed + PeriodTrans.Amount;
                            TotSharesDed := TotSharesDed + PeriodTrans.Amount;
                        end;

                        //  Shares Deductions
                        if (PeriodTrans."Transaction Code" = 'D0067') then begin
                            SalAdv := SalAdv + PeriodTrans.Amount;
                            TotSalAdv := TotSalAdv + PeriodTrans.Amount;
                        end;

                        //Loan Interest

                        if (PeriodTrans."Sacco Transaction Type" = PeriodTrans."Sacco Transaction Type"::"Interest Paid") then begin
                            LoanInt := LoanInt + PeriodTrans.Amount;
                            TotLoanInt := TotLoanInt + PeriodTrans.Amount;
                        end;

                        //Loan Repayments

                        if (PeriodTrans."Transaction Code" = 'D006') or (PeriodTrans."Transaction Code" = 'D007') or (PeriodTrans."Transaction Code" = 'D008')
                        or (PeriodTrans."Transaction Code" = 'D009') or (PeriodTrans."Transaction Code" = 'D010') or (PeriodTrans."Transaction Code" = 'D011')
                        or (PeriodTrans."Transaction Code" = 'D012') then begin
                            LoanRepayment := LoanRepayment + PeriodTrans.Amount;
                            TotLoanRepayment := TotLoanRepayment + PeriodTrans.Amount;
                        end;

                        //Staff welfare
                        if (PeriodTrans."Transaction Code" = 'D0021') then begin
                            StaffWelfare := StaffWelfare + PeriodTrans.Amount;
                            TotStaffWelfare := TotStaffWelfare + PeriodTrans.Amount;
                        end;

                        //Union Contributions
                        if (PeriodTrans."Transaction Code" = 'D014') then begin
                            UnionContr := UnionContr + PeriodTrans.Amount;
                            TotUnionContr := TotUnionContr + PeriodTrans.Amount;
                        end;

                        //Leave Allowance
                        if (PeriodTrans."Transaction Code" = 'E0003') then begin
                            LeaveAll := LeaveAll + PeriodTrans.Amount;
                            TotLeaveAll := TotLeaveAll + PeriodTrans.Amount;
                        end;

                        //On Call Allowance
                        if (PeriodTrans."Transaction Code" = 'E') then begin
                            Oncall := Oncall + PeriodTrans.Amount;
                            TotOncall := TotOncall + PeriodTrans.Amount;
                        end;

                        //Acting Allowance
                        if (PeriodTrans."Transaction Code" = 'E0004') then begin
                            ActingAll := ActingAll + PeriodTrans.Amount;
                            TotActingAll := TotActingAll + PeriodTrans.Amount;
                        end;

                        //Commuter Allowance
                        if (PeriodTrans."Transaction Code" = 'E0010') then begin
                            CommAll := CommAll + PeriodTrans.Amount;
                            TotCommAll := TotCommAll + PeriodTrans.Amount;
                        end;


                        //Responsibilty Allowance
                        if (PeriodTrans."Transaction Code" = 'E0017') then begin
                            RespAll := RespAll + PeriodTrans.Amount;
                            TotRespAll := TotRespAll + PeriodTrans.Amount;
                        end;

                        //Telephone Allowance
                        if (PeriodTrans."Transaction Code" = 'E0007') then begin
                            TelAll := TelAll + PeriodTrans.Amount;
                            TotTelAll := TotTelAll + PeriodTrans.Amount;
                        end;

                        //Salary Arrars
                        if (PeriodTrans."Transaction Code" = 'E001') then begin
                            //SalArrs := SalArrs + PeriodTrans.Amount;
                        end;
                        //Commission
                        if (PeriodTrans."Transaction Code" = 'E0008') then begin
                            Commission := Commission + PeriodTrans.Amount;
                            TotalComm += commission;
                        end;

                        if (PeriodTrans."Transaction Code" = 'E0015') then begin
                            SalArrs := SalArrs + PeriodTrans.Amount;
                        end;

                        //Overtime
                        if (PeriodTrans."Transaction Code" = 'E0011') or
                        (PeriodTrans."Transaction Code" = 'E0009') or
                        (PeriodTrans."Transaction Code" = 'E0013')
                         then begin
                            Overtime += Overtime + PeriodTrans.Amount;
                        end;
                        //Gratuity
                        if (PeriodTrans."Transaction Code" = 'E13') then begin
                            Gratuity := Gratuity + PeriodTrans.Amount;
                        end;







                        /*

                  //Total Deductions***********************
                  IF (PeriodTrans."Group Order"=8) AND (PeriodTrans."Sub Group Order"=9)    THEN

                  BEGIN
                     TotalDeductions:=TotalDeductions+PeriodTrans.Amount;
                     totTotalDeductions:=totTotalDeductions+PeriodTrans.Amount;
                  END;
                       */

                        //Net Pay************************START
                        if PeriodTrans.Grouping = PeriodTrans.Grouping::"Net Salary" then begin
                            if PeriodTrans.Amount < 0 then begin
                                NetPay := NetPay + 0;
                                TotNetPay := TotNetPay + 0;
                                negNet := PeriodTrans.Amount;
                                TotnegNet := TotnegNet + PeriodTrans.Amount;
                            end
                            else begin
                                NetPay := NetPay + PeriodTrans.Amount;
                                TotNetPay := TotNetPay + PeriodTrans.Amount
                            end;
                        end;
                    until PeriodTrans.Next = 0
                else
                    CurrReport.Skip;

            end;

            trigger OnPreDataItem()
            begin
                if PayrollMode <> Payrollmode::" " then begin
                    //"HR Employees".SetRange("HR Employees"."Payment Mode", PayrollMode);
                end;
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
                    Caption = 'Payroll Period';
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
        /*
       SelectedPeriod:="prPayroll Periods".GETRANGEMIN("Date Opened");
       //"prPeriod Transactions".GETRANGEMIN("Payroll Period");
         */
        if SelectedPeriod = 0D then Error('You must specify the period filter');
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);

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
        MealAllow: Decimal;
        MealTotAllow: Decimal;
        HREmployee: Record Employee;
        subTotNHIF: Decimal;
        TotNHIF: Decimal;
        NHIF: Decimal;
        TotalSar: Decimal;
        TotalComm: Decimal;
        Commission: Decimal;
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
        strCodes: Code[10];
        CompanyInfo: Record "Company Information";
        PayrollMode: Option " ","Bank Transfer",Cheque,Cash,SACCO;
        Payroll_Summary_ListCaptionLbl: label 'Payroll Summary-List';
        Gross_Taxable_PayCaptionLbl: label 'Gross Taxable Pay';
        Non_Taxable_AmountCaptionLbl: label 'Non-Taxable Amount';
        Statutory_DeductionsCaptionLbl: label 'Statutory Deductions';
        Total_DeductionsCaptionLbl: label 'Total Deductions';
        Pension_Staff_Cont_CaptionLbl: label 'Pension Staff Cont.';
        Negative_Net_PayCaptionLbl: label 'Negative Net Pay';
        Other_AllowancesCaptionLbl: label 'Other Allowances';
        Net_PayCaptionLbl: label 'Net Pay';
        Basic_PayCaptionLbl: label 'Basic Pay';
        Employee_Name_CaptionLbl: label 'Employee Name:';
        Non_Statutory_DeductionsCaptionLbl: label 'Non Statutory Deductions';
        Employee_Code_CaptionLbl: label 'Employee Code:';
        Totals_CaptionLbl: label 'Totals:';
        Checked_byCaptionLbl: label 'Checked by';
        Relief: Decimal;
        TotRelief: Decimal;
        Cic: Decimal;
        TotCic: Decimal;
        MBF: Decimal;
        TotMBF: Decimal;
        SharesDed: Decimal;
        TotSharesDed: Decimal;
        SalAdv: Decimal;
        TotSalAdv: Decimal;
        LoanInt: Decimal;
        TotLoanInt: Decimal;
        LoanRepayment: Decimal;
        TotLoanRepayment: Decimal;
        StaffWelfare: Decimal;
        TotStaffWelfare: Decimal;
        UnionContr: Decimal;
        TotUnionContr: Decimal;
        LeaveAll: Decimal;
        TotLeaveAll: Decimal;
        Oncall: Decimal;
        TotOncall: Decimal;
        ActingAll: Decimal;
        TotActingAll: Decimal;
        CommAll: Decimal;
        TotCommAll: Decimal;
        RespAll: Decimal;
        TotRespAll: Decimal;
        TelAll: Decimal;
        TotTelAll: Decimal;
        SalArrs: Decimal;
        Overtime: Decimal;
        Gratuity: Decimal;


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

