Report 50323 "Deductions Listing-List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Deductions Listing-List.rdlc';

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
            column(PeriodName; Month)
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
            column(statutoryDed; PAYE)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(PersonalIns; PersonalIns)
            {
            }
            column(NewMSAportHousing; NewMSAportHousing)
            {
            }


            //PAYE 	NSSF	NHIF	Providend	Union	BIFU	Shares Deduction	Per Ins	Med Bill	Mid Month Adv	Welfare	Other Inst. Loan	KUCFAW	HELB	Training Levy	Others	Loan Repayment	Interest Loan Repayment		

            column(TotalDeductions; TotalDeductions)
            //column(TotalDeductions; (statutoryDed - Nssf - NHIF) + Nssf + NHIF + Medbill + Pension + MidMonthAll + LoanRepayment + LoanInt + SharesDed + othersDeductions + PersonalIns + HELB + COTU + INTS + Welfare + KUCFAW)
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
            column(Union; Union)
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
            column(BIFU; BIFU)
            {
            }
            column(TotNHIF; TotNHIF)
            {
            }
            column(HseTotAllow; HseTotAllow)
            {
            }
            column(Medbill; Medbill)
            {
            }
            column(TotCic; TotCic)
            {
            }
            column(othersDeductions; othersDeductions)
            {
            }
            column(MidMonthAll; MidMonthAll)
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
            column(OtherDeduction; OtherDeduction)
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
            column(Welfare; Welfare)
            {
            }
            column(INTS; INTS)
            {
            }
            column(KUCFAW; KUCFAW)
            {
            }
            column(HELB; HELB)
            {
            }
            column(COtu; COTU)
            {
            }
            column(AHL; AHL) { }
            column(TotAHL; TotAHL) { }

            trigger OnAfterGetRecord()
            begin
                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";
                strCodes := "No.";

                BasicPay := 0;
                Union := 0;
                Allow := 0;
                Grosspay := 0;
                PenGrat := 0;
                Nssf := 0;
                PersonalIns := 0;
                statutoryDed := 0;
                nonstatutoryDed := 0;
                TaxablePay := 0;
                NewMSAportHousing := 0;
                PAYE := 0;
                Reliefs := 0;
                OtherAllow := 0;
                TotalDeductions := 0;
                NetPay := 0;
                negNet := 0;
                Relief := 0;
                nonTaxAmount := 0;
                Pension := 0;
                NHIF := 0;
                BIFU := 0;
                Medbill := 0;
                MidMonthAll := 0;
                SharesDed := 0;
                SalAdv := 0;
                LoanInt := 0;
                LoanRepayment := 0;
                othersDeductions := 0;
                UnionContr := 0;
                LeaveAll := 0;
                Oncall := 0;
                ActingAll := 0;
                CommAll := 0;
                RespAll := 0;
                TelAll := 0;
                SalArrs := 0;
                Overtime := 0;
                Welfare := 0;
                INTS := 0;
                KUCFAW := 0;
                HELB := 0;
                COTU := 0;
                AHL := 0;

                //Loop through the Income/Earnings and deductions************************************************************************
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                if PeriodTrans.Find('-') then
                    repeat

                        if PeriodTrans."Sub Group" = PeriodTrans."Sub Group"::PAYE then begin
                            PAYE := PeriodTrans.Amount;
                        end;
                        //Basic Pay************************START
                        if PeriodTrans.Grouping = PeriodTrans.Grouping::"Basic Salary" then begin
                            BasicPay := PeriodTrans.Amount;
                            TotBasicPay := TotBasicPay + BasicPay;
                            Month := Format(PeriodTrans."Payroll Period");
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
                        if (PeriodTrans."Transaction Code" = 'D0001') or (PeriodTrans."Transaction Code" = 'D0020') then begin
                            if PeriodTrans."Entry Type" = PeriodTrans."Entry Type"::Employee then begin

                                Pension += PeriodTrans.Amount;
                                TotPension := TotPension + PeriodTrans.Amount;

                            end;
                        end;

                        //Personal relief
                        if (PeriodTrans."Transaction Code" = 'PSNR') then begin
                            Relief := Relief + PeriodTrans.Amount;
                            TotRelief := TotRelief + PeriodTrans.Amount;
                        end;

                        //NSSF Employee
                        /* if (PeriodTrans."Transaction Code" = 'DEFCON') then begin
                             Nssf := Nssf + PeriodTrans.Amount;
                             subTotNssf := subTotNssf + PeriodTrans.Amount;
                         end;*/
                        if (PeriodTrans."Transaction Code" = 'NSSF') then begin
                            Nssf := Nssf + PeriodTrans.Amount;
                            subTotNssf := subTotNssf + PeriodTrans.Amount;
                        end;

                        //NSSF Employee
                        if (PeriodTrans."Transaction Code" = 'SHA') then begin
                            NHIF := NHIF + PeriodTrans.Amount;
                            TotNHIF := TotNHIF + PeriodTrans.Amount;
                        end;

                        //Medical Bill Deduction
                        if (PeriodTrans."Transaction Code" = 'D14') then begin
                            Medbill := Medbill + PeriodTrans.Amount;
                        end;

                        //MBF Fund
                        if (PeriodTrans."Transaction Code" = 'D003') then begin
                            MidMonthAll := MidMonthAll + PeriodTrans.Amount;
                        end;

                        //Personal Insurance
                        if (PeriodTrans."Transaction Code" = 'D022') then begin
                            PersonalIns := PersonalIns + PeriodTrans.Amount;
                        end;

                        //  Shares Deductions
                        if (PeriodTrans."Transaction Code" = 'D0068') or (PeriodTrans."Transaction Code" = 'D0067')
                        or (PeriodTrans."Transaction Code" = 'D0076') or (PeriodTrans."Transaction Code" = 'D0069')
                        or (PeriodTrans."Transaction Code" = 'D0070') then begin
                            SharesDed := SharesDed + PeriodTrans.Amount;
                            TotSharesDed := TotSharesDed + PeriodTrans.Amount;
                        end;

                        //  Shares Deductions
                        if (PeriodTrans."Transaction Code" = 'D004') then begin
                            SalAdv := SalAdv + PeriodTrans.Amount;
                            TotSalAdv := TotSalAdv + PeriodTrans.Amount;
                        end;

                        //Union
                        if (PeriodTrans."Transaction Code" = 'D009') then begin
                            Union := Union + PeriodTrans.Amount;
                        end;


                        //Loan Interest

                        if PeriodTrans."Sacco Transaction Type" = PeriodTrans."Sacco Transaction Type"::"Interest Paid" then begin


                            LoanInt := LoanInt + PeriodTrans.Amount;
                            TotLoanInt := TotLoanInt + PeriodTrans.Amount;
                        end
                        else        //Loan Repayments
                            if PeriodTrans."Sacco Transaction Type" = PeriodTrans."Sacco Transaction Type"::"Principal Repayment" then begin
                                /*if (PeriodTrans."Transaction Code" = 'D008') or (PeriodTrans."Transaction Code" = 'D11') or (PeriodTrans."Transaction Code" = 'D12')
                                or then (PeriodTrans."Transaction Code" = 'D16') or (PeriodTrans."Transaction Code" = 'D17') or (PeriodTrans."Transaction Code" = 'D18')
                                or (PeriodTrans."Transaction Code" = 'D15') or (PeriodTrans."Transaction Code" = 'D29') or (PeriodTrans."Transaction Code" = 'D30') then begin
                                end*/


                                LoanRepayment := LoanRepayment + PeriodTrans.amount;
                                toalloanRepayment := toalloanRepayment + PeriodTrans.amount;

                            end;

                        //Other Deductions
                        if (PeriodTrans."Transaction Code" = 'D007')
                        or (PeriodTrans."Transaction Code" = 'D19') then begin
                            othersDeductions := othersDeductions + PeriodTrans.Amount;

                        end;
                        //NewMSAportHousing
                        if (PeriodTrans."Transaction Code" = 'D33') then begin
                            NewMSAportHousing := NewMSAportHousing + PeriodTrans.Amount;
                        end;

                        //BIFU
                        if (PeriodTrans."Transaction Code" = 'D31') then begin
                            BIFU := BIFU + PeriodTrans.Amount;
                            TotalBIFU := TotalBIFU + PeriodTrans.amount;
                        END;

                        //Union Contributions
                        if (PeriodTrans."Transaction Code" = 'D014') then begin
                            UnionContr := UnionContr + PeriodTrans.Amount;
                            TotUnionContr := TotUnionContr + PeriodTrans.Amount;
                        end;
                        //Welfare
                        if (PeriodTrans."Transaction Code" = 'D0021') then begin
                            Welfare := Welfare + PeriodTrans.Amount;
                            TotUnionContr := TotUnionContr + PeriodTrans.Amount;
                        end;
                        //INTS
                        if (PeriodTrans."Transaction Code" = 'D21') then begin
                            INTS := INTS + PeriodTrans.Amount;
                            TotUnionContr := TotUnionContr + PeriodTrans.Amount;
                        end;
                        //KUCFAW
                        if (PeriodTrans."Transaction Code" = 'D') then begin
                            KUCFAW := KUCFAW + PeriodTrans.Amount;
                            TotUnionContr := TotUnionContr + PeriodTrans.Amount;
                        end;
                        //HELB
                        if (PeriodTrans."Transaction Code" = 'D0007') then begin
                            HELB := HELB + PeriodTrans.Amount;
                            TotUnionContr := TotUnionContr + PeriodTrans.Amount;
                        end;
                        //COTU
                        if (PeriodTrans."Transaction Code" = 'D0016') then begin
                            COTU := COTU + PeriodTrans.Amount;
                            TotUnionContr := TotUnionContr + PeriodTrans.Amount;
                        end;

                        //Housing Levy
                        if (PeriodTrans."Transaction Code" = 'HLEVY') then begin
                            AHL := PeriodTrans.Amount;
                            TotAHL := TotAHL + PeriodTrans.Amount;

                        end;

                        //Leave Allowance
                        if (PeriodTrans."Transaction Code" = 'E006') then begin
                            LeaveAll := LeaveAll + PeriodTrans.Amount;
                            TotLeaveAll := TotLeaveAll + PeriodTrans.Amount;
                        end;

                        //On Call Allowance
                        if (PeriodTrans."Transaction Code" = 'E10') then begin
                            Oncall := Oncall + PeriodTrans.Amount;
                            TotOncall := TotOncall + PeriodTrans.Amount;
                        end;

                        //Acting Allowance
                        if (PeriodTrans."Transaction Code" = 'E009') then begin
                            ActingAll := ActingAll + PeriodTrans.Amount;
                            TotActingAll := TotActingAll + PeriodTrans.Amount;
                        end;

                        //Commuter Allowance
                        if (PeriodTrans."Transaction Code" = 'E005') then begin
                            CommAll := CommAll + PeriodTrans.Amount;
                            TotCommAll := TotCommAll + PeriodTrans.Amount;
                        end;


                        //Responsibilty Allowance
                        if (PeriodTrans."Transaction Code" = 'E002') then begin
                            RespAll := RespAll + PeriodTrans.Amount;
                            TotRespAll := TotRespAll + PeriodTrans.Amount;
                        end;

                        //Telephone Allowance
                        if (PeriodTrans."Transaction Code" = 'E008') then begin
                            TelAll := TelAll + PeriodTrans.Amount;
                            TotTelAll := TotTelAll + PeriodTrans.Amount;
                        end;

                        //Salary Arrars
                        if (PeriodTrans."Transaction Code" = 'E001') then begin
                            SalArrs := SalArrs + PeriodTrans.Amount;
                        end;

                        //Overtime
                        if (PeriodTrans."Transaction Code" = 'E001') then begin
                            Overtime := Overtime + PeriodTrans.Amount;
                        end;




                        if (PeriodTrans."Transaction Code" = 'TOT-DED') then
                            TotalDeductions := PeriodTrans.Amount;





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
                                NetPay := Round(NetPay, 0.01, '<') + 0;
                                TotNetPay := TotNetPay + 0;
                                negNet := PeriodTrans.Amount;
                                TotnegNet := TotnegNet + PeriodTrans.Amount;
                            end
                            else begin
                                NetPay := NetPay + PeriodTrans.Amount;
                                Netpay := Round(NetPay, 0.01, '<');
                                TotNetPay := TotNetPay + PeriodTrans.Amount
                            end;
                        end;
                    until PeriodTrans.Next = 0
                else
                    CurrReport.Skip;




                //TotalDeductions :=NewMSAportHousing+ PAYE + Nssf + NHIF + Pension + Union + bifu + SharesDed + PersonalIns + Medbill + MidMonthAll + Welfare + INTS + KUCFAW + HELB + cotu + othersDeductions + LoanRepayment + LoanInt

            end;

            trigger OnPreDataItem()
            begin
                if PayrollMode <> Payrollmode::" " then begin
                    //"HR Employees".SetRange("HR Employees"."Payment Mode",PayrollMode);
                    if SelectedPeriod = 0D then Error('You must specify the period filter');
                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
                    if objPeriod.Find('-') then begin
                        PeriodName := objPeriod."Period Name";
                    end;
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



        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;

    var
        PAYE: decimal;
        //TotalDeductions: Decimal;
        TotalBIFU: decimal;
        toalloanRepayment: decimal;
        PensEmp: record "Payroll Employee Transactions";
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
        PersonalIns: Decimal;
        HseTotAllow: Decimal;
        HREmployee: Record Employee;
        subTotNHIF: Decimal;
        AHL: Decimal;
        TotAHL: Decimal;
        TotNHIF: Decimal;
        NHIF: Decimal;
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
        Medbill: Decimal;
        TotCic: Decimal;
        MidMonthAll: Decimal;
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
        othersDeductions: Decimal;
        Union: Decimal;
        BIFU: Decimal;
        Welfare: Decimal;
        INTS: Decimal;
        KUCFAW: Decimal;
        HELB: Decimal;
        COTU: Decimal;
        NewMSAportHousing: Decimal;
        Month: Text;


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

