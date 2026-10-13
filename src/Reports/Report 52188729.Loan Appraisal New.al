
/// <summary>
/// Report Loan Appraisal New (ID 50392).
/// </summary>
Report 50392 "Loan Appraisal New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Appraisal New.rdlc';

    dataset
    {
        dataitem("Loan Appraisal Buffer"; "Loan Appraisal")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Application_Date; "Application Date")
            { }
            column(Sacco_Deduction; "Sacco Deduction")
            {
            }
            column(Total_Arrears; "Total Arrears")
            {
            }
            column(Current_Deductions; "Current Deductions")
            {
            }
            column(Net___Current_Deductions; "Net + Current Deductions")
            {
            }
            column(New_Deposit; "New Deposit")
            {
            }
            column(New_Loan_Deductions; "New Loan Deductions")
            {
            }
            column(New_Total_Deductions; "New Total Deductions")
            {
            }
            column(New_Net_Take_Home; "New Net Take Home")
            {
            }
            column(V13ofAverageIncome_LoanAppraisalBuffer; "Loan Appraisal Buffer"."1/3 of Gross")
            {
            }
            column(Margin; Margin)
            {
            }
            column(Margin__Ref_; "Margin (Ref)")
            {
            }
            column(Business_Income_Amount; "Loan Appraisal Buffer"."Business Income Amount")
            {

            }
            column(R23_BusinessIncome; "Loan Appraisal Buffer"."Business Income Amount" * 2 / 3)
            {

            }
            column(Staff_No; "Loan Appraisal Buffer"."Staff No")
            { }
            column(Employer_Name; "Loan Appraisal Buffer"."Employer Name")
            { }
            column(Refinance; Refinance)
            {
            }
            column(GuarDef; GuarDef)
            {
            }
            column(Net_Pay; "Net Pay")
            {
            }
            column(Gross_Pay; "Gross Pay")
            {
            }
            column(Uncharged_Interest; "Uncharged Interest")
            {
            }
            column(NewTotalRepayment_LoanAppraisalBuffer; "Loan Appraisal Buffer"."New Total Repayment")
            {
            }
            column(AvailableDeposits_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Available Deposits")
            {
            }
            column(CommittedDeposits_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Committed Deposits")
            {
            }
            column(ExisitingLoanRepayment_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Exisiting Loan Repayment")
            {
            }
            column(ExciseDuty_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Excise Duty")
            {
            }
            column(TopUpAppraisal_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Top Up Appraisal")
            {
            }
            column(TopUpPenalty_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Top Up Penalty")
            {
            }
            column(TotalFinancing_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Total Financing")
            {
            }
            column(RecommendedAmount_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Recommended Amount")
            {
            }

            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(companyPicture; CompanyInfo.Picture)
            {
            }
            column(EntranceFee_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Entrance Fee")
            {
            }
            column(Multiplier_LoanAppraisalBuffer; "Loan Appraisal Buffer".Multiplier)
            {
            }
            column(LoanNo_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Loan No.")
            {
            }
            column(MemberNo_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Member No.")
            {
            }
            column(LoanDisbursementAccount_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Loan Disbursement Account")
            {
            }
            column(Name_LoanAppraisalBuffer; "Loan Appraisal Buffer".Name)
            {
            }
            column(ProductCode_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Product Code")
            {
            }
            column(RequestedAmount_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Approved Amount")
            {
            }
            column(ClassADeposits_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Bosa Deposits")
            {
            }
            column(ClassBDeposits_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Class B Deposits")
            {
            }
            column(TotalDeposits_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Total Deposits")
            {
            }
            column(ExistingLoans_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Current Loan Balance")
            {
            }
            column(Installments_LoanAppraisalBuffer; "Loan Appraisal Buffer".Installments)
            {
            }
            column(AmountGuaranteed_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Amount Guaranteed")
            {
            }
            column(NoofGuarantors_LoanAppraisalBuffer; "Loan Appraisal Buffer"."No. of Guarantors")
            {
            }
            column(SalaryThroughFosa_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Salary Through Fosa")
            {
            }
            column(ShareCapital_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Share Capital")
            {
            }
            column(BranchCode_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Branch Code")
            {
            }
            column(ActivityCode_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Activity Code")
            {
            }
            column(PreviousContribution_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Previous Contribution")
            {
            }
            column(Deposits_LoanAppraisalBuffer; "Loan Appraisal Buffer".Deposits)
            {
            }
            column(DepositFinancing_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Deposit Financing")
            {
            }
            column(DepositMultiplier_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Deposit Multiplier")
            {
            }
            column(LoanOutstanding_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Loan Outstanding")
            {
            }
            column(PrincipleTopUp_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Principle Top Up")
            {
            }
            column(MaximumCredit_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Maximum Credit")
            {
            }
            column(MinimumShareCapital_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Minimum Share Capital")
            {
            }
            column(CurrentShareCapital_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Current Share Capital")
            {
            }
            column(DeficitShareCapital_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Deficit Share Capital")
            {
            }
            column(ShareFinancing_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Share Financing")
            {
            }
            column(AverageIncome_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Average Income")
            {
            }
            column(Earnings_LoanAppraisalBuffer; "Loan Appraisal Buffer".Earnings)
            {
            }
            column(Allowances_LoanAppraisalBuffer; "Loan Appraisal Buffer".Allowances)
            {
            }
            column(Deductions_LoanAppraisalBuffer; "Loan Appraisal Buffer".Deductions)
            {
            }
            column(V23ofAverageIncome_LoanAppraisalBuffer; "Loan Appraisal Buffer"."2/3 of Gross")
            {
            }
            column(NetSalary_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Net Salary")
            {
            }
            column(ExternalEffects_LoanAppraisalBuffer; "Loan Appraisal Buffer"."External Effects")
            {
            }
            column(AdjustedNet_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Adjusted Net")
            {
            }
            column(CurrentLoanRepayment_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Current Loan Repayment")
            {
            }
            column(InterestTopUp_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Interest Top Up")
            {
            }
            column(TopUpCommission_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Top Up Commission")
            {
            }
            column(ExternalLoanCleared_LoanAppraisalBuffer; "Loan Appraisal Buffer"."External Commitment")
            {
            }
            column(ExternalLoanCommission_LoanAppraisalBuffer; "Loan Appraisal Buffer"."External Commitment Commission")
            {
            }
            column(TotalCharges_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Total Charges")
            {
            }
            column(NetTakeHome_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Net Take Home")
            {
            }
            column(QualificationAsPerDeposits_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Qualification As Per Deposits")
            {
            }
            column(QualificationasPerIncome_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Qualification as Per Income")
            {
            }
            column(QualificationasPerGuarantor_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Qualification as Per Guarantor")
            {
            }
            column(Main_Sector_Description; LRec."Main Sector Description")
            {
            }
            column(Sub_Sector_Level_1_Description; LRec."Sub-Sector Level 1 Description")
            {
            }
            column(Sub_Sector_Level_2_Description; LRec."Sub-Sector Level 2 Description")
            {

            }
            column(Main_Sector_Code; LRec."Main Sector Code")
            {

            }
            column(Sub_Sector_Level_1_Code; LRec."Sub-Sector Level 1 Code")
            {

            }
            column(Sub_Sector_Level_2_Code; LRec."Sub-Sector Level 2 Code")
            {

            }

            column(Approvedby; LRec."Approved By")
            {

            }
            column(ApprovedOn; LRec."Approved On")
            {

            }
            column(AppraisedBy; LRec."Appraised By")
            {

            }
            column(AppraisedOn; LRec."Appraised On")
            {

            }
            column(EmployerNameL; EmployerNameL)
            { }
            column(PayrollCodeL; PayrollCode)
            { }
            dataitem(MemberSalaryAppraisal; "Member Salary Appraisal")
            {
                DataItemLink = "Appraisal No." = field("Appraisal Loan No.");

                column(ReportForNavId_90; 90)
                {
                }
                column(Net_Income_Per_Month; "Net Income Per Month")
                { }
                Column(Monthly_Expenditure; "Monthly Expenditure")
                { }
                column(Basic_Pay; MemberSalaryAppraisal."Basic Pay")
                {
                }
                column(HouseAllowance; MemberSalaryAppraisal."House Allowance")
                {
                }
                column(CommuterAllowance; MemberSalaryAppraisal."Commuter Allowance")
                {
                }
                column(OtherAllowances; MemberSalaryAppraisal."Other Allowances")
                {
                }
                column(GrossPay; MemberSalaryAppraisal."Gross Pay")
                {
                }
                column(netUtilizable; MemberSalaryAppraisal."BOSA Loan To Run At")
                {
                }
                column(BOSA_Savings; MemberSalaryAppraisal."BOSA Savings")
                {
                }
                column(NetSalary_MemberSalaryAppraisal; "Net Salary")
                {
                }
                column(Qualification_as_Per_Income; MemberSalaryAppraisal."Qualification as Per Income")
                {
                }


            }


            dataitem(Loans; Loans)
            {
                //DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = where("Outstanding Principal" = filter(> 1));
                CalcFields = "Loans Category-SASRA";
                column(ReportForNavId_50; 50)
                {
                }
                column(LoanNo_Loans; Loans."Loan No.")
                {
                }
                column(LoanProductType_Loans; Loans."Loan Product Type")
                {
                }
                column(MemberNo_Loans; Loans."Member No.")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(DisbursementDate_Loans; Format(Loans."Disbursement Date"))
                {
                }
                column(OutstandingBalance_Loans; Loans."Outstanding Principal")
                {
                }
                column(OutstandingInterest_Loans; Loans."Outstanding Interest")
                {
                }
                column(OutstandingBills_Loans; '')
                {
                }
                column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
                {
                }


                trigger OnPreDataItem()
                begin

                    //Loans.SETFILTER("Date Filter",'..%1',CALCDATE('-1D',LRec."Disbursement Date"));
                    Loans.SetRange("Member No.", LRec."Member No.");
                end;
            }
            dataitem("Loan Guarantors and Security"; "Loan Security")
            {
                DataItemTableView = where("Guarantor Type" = filter(Guarantor));

                DataItemLink = "Loan No." = field("Loan No.");
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
                column(ActualDeposits; "Loan Guarantors and Security"."Guarantor Deposits" / saccoSetup."Guarantors Multiplier")
                {
                }
                column(Member_Deposits; "Loan Guarantors and Security"."Member Deposits")
                {
                }
            }
            dataitem(LoanCollateral; "Loan Security")
            {
                DataItemTableView = where("Guarantor Type" = filter(Collateral));

                DataItemLink = "Loan No." = field("Loan No.");
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

                begin
                    saccoSetup.Get();
                end;
            }
            dataitem("Current Loan Charges"; "Loan Charges")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                column(ReportForNavId_66; 66)
                {
                }
                column(ChargeCode_CurrentLoanCharges; "Current Loan Charges"."Charge Code")
                {
                }
                column(Description_CurrentLoanCharges; "Current Loan Charges".Description)
                {
                }
                column(Amount_CurrentLoanCharges; "Current Loan Charges".Amount)
                {
                }
                column(TotalCharge_CurrentLoanCharges; "Current Loan Charges"."Total Charge")
                {
                }
                column(ExciseDuty_CurrentLoanCharges; "Current Loan Charges"."Excise Duty")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('%1',"Current Loan Charges".Amount);
                end;
            }
            dataitem(PCharges; "Loan Product Charges.")
            {
                DataItemLink = "Product Code" = field("Product Code");
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
            trigger OnAfterGetRecord()
            var
                MembersRec: Record Members;
            begin

                LRec.Get("Loan Appraisal Buffer"."Loan No.");
                LoanApproved := LRec."Approved Amount";
                PCOde := LRec."Loan Product Type";


                MembersRec.Reset();
                MembersRec.SetRange("No.", LRec."Member No.");
                if MembersRec.FindFirst() then begin
                    EmployerNameL := MembersRec."Employer Name";
                    PayrollCode := MembersRec."Payroll/Staff No.";
                end;

            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                saccoSetup.Get();
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

    var
        CompanyInfo: Record "Company Information";
        LRec: Record Loans;
        LCharges: Record "Loan Charges";
        LoanApproved: Decimal;
        ProductCharge: Decimal;
        Duty: Decimal;
        GenSetup: Record "General Ledger Setup";
        PCOde: Code[20];
        GuarDef: Code[120];
        saccoSetup: Record "Sacco Setup";
        DepContribution: Decimal;
        EmployerNameL: Text[100];
        PayrollCode: Code[20];
}

