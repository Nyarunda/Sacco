report 50432 "Loan PV"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan PV.rdlc';

    dataset
    {
        dataitem("Loan Appraisal Buffer"; "Loan Appraisal")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(Margin; Margin)
            {
            }
            column(Margin__Ref_; "Margin (Ref)")
            {
            }
            column(Refinance; Refinance)
            {
            }
            column(GuarDef; GuarDef)
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
            column(ClassCDeposits_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Micro Deposits")
            {
            }
            column(MicroDeposits_LoanAppraisalBuffer; "Loan Appraisal Buffer"."Micro Deposits")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
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
            column(ApprovedAmount_LoanAppraisalBuffer; DisbursedAmount)
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
            /* column(Partially_Disbursed_Amount; "Partially Disbursed Amount")
             {

             } */

            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = where("Outstanding Principal" = filter(> 0));
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
                column(LoansCategorySASRA_Loans; '')
                {
                }

                trigger OnPreDataItem()
                begin

                    //Loans.SETFILTER("Date Filter",'..%1',CALCDATE('-1D',LRec."Disbursement Date"));
                end;


            }
            dataitem("Loan Guarantors and Security"; "Loan Security")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                column(ReportForNavId_60; 60)
                {
                }
                column(SavingsAccountNoMemberNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Account No.")
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
                column(GuarantorType_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Guarantor Type")
                {
                }
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
            begin

                LRec.Get("Loan Appraisal Buffer"."Loan No.");
                LoanApproved := LRec."Approved Amount";
                PCOde := LRec."Loan Product Type";

                DisbursedAmount := 0;
                DisbursedAmount := LRec."Amount To Disburse";

            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
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
        if CompanyInfo.Get then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        CompanyAddress := CompanyInfo.Address + ' -Post Code: ' + CompanyInfo."Post Code" + ' -City:' + CompanyInfo.City + ' Region: ' + CompanyInfo."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInfo."Phone No." + ' -Office Tel: ' + CompanyInfo."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInfo."E-Mail" + '- Website: ' + CompanyInfo."Home Page";
#pragma warning restore AL0432
    end;

    var
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyInfo: Record "Company Information";
        LRec: Record Loans;
        LCharges: Record "Loan Charges";
        LoanApproved: Decimal;
        ProductCharge: Decimal;
        Duty: Decimal;
        GenSetup: Record "General Ledger Setup";
        PCOde: Code[20];
        GuarDef: Code[120];
        DisbursedAmount: Decimal;
}

