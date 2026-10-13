/// <summary>
/// Report Loan Salary Appraisal (ID 50280).
/// </summary>
report 50280 "Loan Salary Appraisal"
{
    ApplicationArea = All;
    Caption = 'Loan Salary Appraisal';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Salary Appraisal.rdlc';
    dataset
    {
        dataitem(MemberSalaryAppraisal; "Member Salary Appraisal")
        {
            column(Picture; CI.picture)
            {
            }
            column(C_Name; CI.Name)
            {
            }
            column(AppraisalNo; "Appraisal No.")
            {
            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Qualification_as_Per_Guarantor; "Qualification as Per Guarantor")
            { }
            column(Qualification_As_Per_Deposits; "Qualification As Per Deposits")
            { }
            column(Requested_Amount; "Requested Amount")
            { }
            column(Recommended_Amount; "Recommended Amount")
            { }
            column(Top_Up_Commission; "Top Up Commission")
            { }
            column(GuarDef; GuarDef)
            { }

            column(Staff_No_; "Staff No.")
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(employer_Name; "Place of Work")
            {
            }
            column(Loan_No; NewLoan)
            {
            }

            column(TotalMonthlyDeduction; "Max. Monthly Deduction")
            {
            }
            column(Share_Deposits; "Share Deposits")
            {
            }
            column(Date; "Date")
            {
            }
            column(LastModifiedBy; "Last Modified By")
            {
            }
            column(BasicPay; "Basic Pay")
            {
            }
            column(HouseAllowance; "House Allowance")
            {
            }
            column(CommuterAllowance; "Commuter Allowance")
            {
            }
            column(OtherAllowances; "Other Allowances")
            {
            }
            column(GrossPay; "Gross Pay")
            {
            }
            column(Tax; Tax)
            {
            }
            column(BOSALoans; "BOSA Loans")
            {
            }
            column(Total_Deductions; "Other Deductions")
            {
            }
            column(Pension; Pension)
            {
            }
            column(NHIF; NHIF)
            {
            }
            column(Arrears_to_Recover; "Arrears to Recover")
            {
            }
            column(NSSF; NSSF)
            {
            }
            column(Branch; Members."Global Dimension 2 Code")
            {
            }
            column(BOSASavings; "BOSA Savings")
            {
            }
            column(OtherDeductions; "Other Deductions")
            {
            }
            column(AthirdofGrossPay; "1/3 of Gross Pay")
            {
            }
            column(ExternalClearance; "External Clearance")
            {
            }
            column(ExternalClearanceCharges; "External Clearance Charges")
            {
            }
            column(TopUpLoan; "Top Up Loan")
            {
            }
            column(TopUpCommission; "Top Up Commission" + "Commission Excise")
            {
            }
            column(UpfrontInterest; "Upfront Interest")
            {
            }
            column(Insurance; Insurance)
            {
            }
            column(FOSALoans; "Fosa Loan Balance")
            {
            }
            column(STO; STO)
            {
            }
            column(NetSalary; "Net Salary")
            {
            }
            column(PercentageofNetSalary; "Percentage of Net Salary")
            {
            }
            column(LoanToRunAt; "BOSA Loan To Run At")
            {
            }
            column(FOSALoanToRunAt; "FOSA Loan To Run At")
            {
            }
            column(MemberCategory; "Member Category")
            {
            }
            column(Qualification; Qualification)
            {
            }
            column(Period; Period)
            {
            }
            column(MonthlyRepayment; "Monthly Repayment")
            {
            }
            column(PrincipalRepayment; "Principal Repayment")
            {
            }
            column(InterestRepayment; "Interest Repayment")
            {
            }
            column(ToDeduct; "To Deduct")
            {
            }
            column(MaxMonthlyDeduction; "Max. Monthly Deduction")
            {
            }
            column(NetSalaryAfterFosaDed; "Net Salary After Fosa Ded")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(RequestedAmount; "Requested Amount")
            {
            }
            column(TotalCharges; "Total Charges" + "Top Up Commission" + "Commission Excise")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(CapturedBy; "Captured By")
            {
            }
            column(Status; Status)
            {
            }
            column(AnnualInterest; "Annual Interest %")
            {
            }
            column(Name; Name)
            {
            }
            column(Sharecap; Sharecap)
            { }
            column(HolidaySav; HolidaySav)
            { }
            column(JuniorSav; JuniorSav)
            { }
            column(FixedDep; FixedDep)
            { }
            column(NetLoanTakeHome; "Net Loan Take Home")
            {
            }
            column(RecommendedAmount; "Recommended Amount")
            {
            }
            column(MemberType; "Member Type")
            {
            }
            column(Multiplier; Multiplier)
            {
            }
            column(ShareDeposits; "Share Deposits")
            {
            }
            column(BOSALoanbalance; "BOSA Loan balance")
            {
            }
            column(MaximumCredit; "Maximum Credit")
            {
            }
            //ADDED FIELDS
            column(DepositMultiplier; "Deposit Multiplier")
            {
            }
            column(Deposit_Boosting; "Deposit Boosting")
            {
            }
            column(Deposit_Boosted_Charge; "Deposit Boosted Charge")
            {
            }
            column(Share_Capital_Boosting; "Share Capital Boosting")
            {
            }
            column(Appraisal_Type; "Appraisal Type")
            {
            }
            column(Net_Salary; "Net Salary")
            {
            }
            column(FOSA_Loan_To_Run_At; "FOSA Loan To Run At")
            {
            }
            column(Product_Description; "Product Description")
            {
            }
            column(Net_Salary_Multiplier__; "Net Salary Multiplier %")
            {
            }
            column(BOSA_Loan_To_Run_At; "BOSA Loan To Run At")
            {
            }
            column(Net_Loan_Take_Home; "Net Loan Take Home")
            { }
            column(Total_Loan_to_Pay; "Total Loan to Pay")
            {
            }
            column(TotalInflow; TotalInflow)
            {
            }
            column(TotalOutflow; TotalOutflow)
            {
            }
            column(Deficit_Surplus; "Deficit/Surplus")
            {
            }
            column(SaccoDeductions; SaccoDeductions)
            {
            }
            column(NetProfits; NetProfits)
            {
            }
            column(PerNetProfits; "%NetProfits")
            {
            }
            column(FreeMoney; FreeMoney)
            {
            }
            column(OtherExpenses; OtherExpenses)
            {
            }
            column(Upfront_Interest; "Upfront Interest")
            {
            }
            column(PrincipleTopup; PrincipleTopup)
            { }
            column(InterestTopup; InterestTopup)
            { }
            column(InsuranceTopup; InsuranceTopup)
            { }
            column(PenaltyTopup; PenaltyTopup)
            { }
            column(ExciseDutyTopup; ExciseDutyTopup)
            { }
            column(TotalTopup; TotalTopup)
            { }
            dataitem("Loan Guarantors and Security"; "Loan Security")
            {
                DataItemTableView = where("Guarantor Type" = filter(Guarantor));

                DataItemLink = "Loan No." = field("Appraisal No.");
                CalcFields = "No of Loans Gua.";
                column(ReportForNavId_60; 60)
                {
                }
                column(SavingsAccountNoMemberNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Member No")
                {
                }
                column(Name_LoanGuarantorsandSecurity; "Loan Guarantors and Security".Name)
                {
                }
                column(AmountGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                }
                column(AvailableGuarantorship_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Available Guarantorship")
                {
                }
                column(GuarDeposits; "Loan Guarantors and Security"."Guarantor Deposits")
                {
                }
                column(GuarantorType_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Guarantor Type")
                {
                }
                column(ActualDeposits; "Loan Guarantors and Security"."Guarantor Deposits")
                {
                }
                column(Member_Deposits; "Loan Guarantors and Security"."Member Deposits")
                {
                }

                column(No__of_Guarantors; "Loan Guarantors and Security"."No of Loans Gua.")
                { }
            }
            dataitem(LoanCollateral; "Loan Security")
            {
                DataItemTableView = where("Guarantor Type" = filter(Collateral));

                DataItemLink = "Loan No." = field("Appraisal No.");
                column(SavingsAccountNoMemberNo_LoanCollateral; "Old Member No.")
                {
                }
                column(Collateral_Reg__No_; "Collateral Reg. No.")
                {
                }
                column(Collateral_Value; "Collateral Value")
                {
                }
                column(Security_Details; "Security Details")
                {
                }
                column(Name_LoanCollateral; Name)
                {
                }
                column(AmountGuaranteed_LoanCollateral; "Amount Guaranteed")
                {
                }
                column(AvailableGuarantorship_LoanCollateral; "Collateral Value" - "Amount Guaranteed")
                {
                }

                trigger OnAfterGetRecord()
                var
                    saccoSetup: Record "Sacco Setup";
                begin
                    saccoSetup.Get();
                end;
            }
            dataitem(LienSecurity; "Loan Security")
            {
                DataItemTableView = where("Guarantor Type" = filter(Lien));

                DataItemLink = "Loan No." = field("Appraisal No.");

                column(SavingsAccountNoMemberNo_LoanLienSecurity; LienSecurity."Member No")
                {
                }
                column(Name_LoanLienSecurity; LienSecurity.Name)
                {
                }
                column(AmountGuaranteed_LienSecurity; LienSecurity."Amount Guaranteed")
                {
                }
                column(AvailableGuarantorship_LienSecurity; LienSecurity."Available Guarantorship")
                {
                }
                column(GuarDeposits_LienSecurity; LienSecurity."Guarantor Deposits")
                {
                }
                column(GuarantorType_LienSecurity; LienSecurity."Guarantor Type")
                {
                }
                column(ActualDeposits_LienSecurity; LienSecurity."Guarantor Deposits")
                {
                }
                column(Member_LienSecurity; LienSecurity."Member Deposits")
                {
                }
            }
            dataitem("Current Loan Charges"; "Loan Charges")
            {
                DataItemLink = "Loan No." = field("Appraisal No.");
                column(ReportForNavId_66; 66)
                {
                }
                column(ChargeCode_CurrentLoanCharges; "Current Loan Charges"."Charge Code")
                {
                }
                column(Description_CurrentLoanCharges; Description)
                {
                }
                column(Amount_CurrentLoanCharges; Amount)
                {
                }
                column(TotalCharge_CurrentLoanCharges; "Total Charge")
                {
                }
                column(ExciseDuty_CurrentLoanCharges; "Excise Duty")
                {
                }
            }
            dataitem(PCharges; "Loan Product Charges.")
            {
                DataItemLink = "Product Code" = field("Loan Product Type");
                column(ReportForNavId_81; 81)
                {
                }
                column(ChargeDescription_PCharges; PCharges.Description)
                {
                }
                column(ProductCharge; ProductCharge)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    ProductCharge := 0;
                    Duty := 0;
                end;
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = where("Total Outstanding Balance" = filter(> 0));
                CalcFields = "Loans Category-SASRA", "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance";
                column(ReportForNavId_67; 66)
                {
                }
                column(Loans_Loan_No_; "Loan No.")
                {
                }
                column(Disbursement_Date; "Disbursement Date")
                { }
                column(Loans_Loan_Product_Type; Loans."Loan Product Type Name")
                {
                }
                column(Loans_Principal_Repayment; "Principal Repayment")
                {
                }
                column(Loans_Approved_Amount; "Approved Amount")
                {
                }
                column(Outstanding_Insurance; "Outstanding Insurance")
                { }
                column(Loans_Outstanding_Interest; "Outstanding Interest")
                {
                }
                column(Loans_Outstanding_Principal; "Outstanding Principal")
                {
                }
                column(Loans_Defaulted; Defaulted)
                {
                }
                column(Rem_P; Loans.Installments)
                {
                }
                column(Total_Arrears; "Total Arrears")
                { }
                column(Loans_Category_SASRA; "Loans Category-SASRA")
                { }


                trigger OnAfterGetRecord()
                begin

                end;
            }

            trigger OnAfterGetRecord()
            var
                Business: Record "Business Monthly Income";
                AppTopup: Record "Appraisal Top Up";
                Legacy: Codeunit Legacy;
                MemberAct: Codeunit "Member Activities";

            begin
                NewLoan := '';
                Members.Get("Member No.");
                Sharecap := MemberAct.GetAccountBookBalance(Legacy.GetShareCapitalAccount(Members."No."));
                HolidaySav := MemberAct.GetAccountBookBalance(Legacy.GetHolidayAccount(Members."No."));
                FixedDep := MemberAct.GetAccountBookBalance(Legacy.GetFixedDepositAccount(Members."No."));
                JuniorSav := MemberAct.GetAccountBookBalance(Legacy.GetJuniorSavAccount(Members."No."));



                if "Appraisal Type" = "Appraisal Type"::Business then begin

                    Business.Reset();
                    Business.SetRange("Appraisal No.", "Appraisal No.");
                    if Business.FindFirst() then begin
                        TotalInflow := Business."Total InFlow";
                        TotalOutflow := Business."Total OutFlow";
                        "Deficit/Surplus" := Business."Deficit/Surplus";
                        SaccoDeductions := Business."Sacco Deductions";
                        NetProfits := Business."Net Profits";
                        "%NetProfits" := Business."Net Profits";
                        OtherExpenses := Business."Other Personal Expenses";
                        FreeMoney := Business."Free Money";
                    end;

                    AppTopup.Reset();
                    AppTopup.SetRange("Loan No.", MemberSalaryAppraisal."Appraisal No.");
                    if AppTopup.FindFirst() then begin
                        repeat
                            PrincipleTopup += AppTopup."Principle Top Up";
                            InterestTopup += AppTopup."Interest Top Up" + AppTopup."Uncharged Interest";
                            InsuranceTopup += AppTopup."Appraisal Top Up" + AppTopup."Uncharged Insurance";
                            PenaltyTopup += AppTopup."Penalty Top Up";
                            ExciseDutyTopup += AppTopup."Commision Excise";
                            TotalTopup += AppTopup."Total Top Up";
                        until AppTopup.Next() = 0;
                    end;
                end;

                LoanApp.Reset();
                LoanApp.SetRange("Salary Appraisal No.", MemberSalaryAppraisal."Appraisal No.");
                if LoanApp.FindFirst() then
                    NewLoan := LoanApp."Loan No.";

                if "FOSA Loan To Run At" < 0 then
                    "FOSA Loan To Run At" := 0;

                if "BOSA Loan To Run At" < 0 then
                    "BOSA Loan To Run At" := 0;

                if "Qualification as Per Income" < 0 then
                    "Qualification as Per Income" := 0;

                if Qualification < 0 then
                    Qualification := 0;

                if "Net Salary" < 0 then
                    "Net Salary" := 0;

                if "Percentage of Net Salary" < 0 then
                    "Percentage of Net Salary" := 0;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }

    }

    trigger OnInitReport()
    begin
        CI.RESET;
        CI.GET;
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        PrincipleTopup: Decimal;
        InterestTopup: Decimal;
        InsuranceTopup: Decimal;
        PenaltyTopup: Decimal;
        ExciseDutyTopup: Decimal;
        TotalTopup: Decimal;

        TotalInflow: Decimal;
        TotalOutflow: Decimal;
        "Deficit/Surplus": Decimal;
        SaccoDeductions: Decimal;
        NetProfits: Decimal;
        "%NetProfits": Decimal;
        FreeMoney: Decimal;
        OtherExpenses: Decimal;
        CredLedEntry: Record "Credit Ledger Entry";
        Rem_P: Decimal;
        LoanApp: Record Loans;
        NewLoan: Text[20];
        Members: Record Members;
        CI: Record "Company Information";
        Sharecap: Decimal;
        JuniorSav: Decimal;
        FixedDep: Decimal;
        HolidaySav: Decimal;
        ProductCharge: Decimal;
        Duty: Decimal;
        ChargeDescription: Text[50];
        ChargeAmount: Decimal;
        ChargeExciseDuty: Decimal;
        ChargeTotalCharge: Decimal;
        GuarDef: Code[120];
}
