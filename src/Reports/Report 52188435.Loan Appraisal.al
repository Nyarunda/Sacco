
Report 50078 "Loan Appraisal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Appraisal.rdlc';

    dataset
    {
        dataitem("Loan Appraisal Buffer"; "Loan Appraisal")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(GuarDef; GuarDef)
            {
            }
            column(Last_Deposit_Amount; "Last Deposit Amount")
            {
            }
            column(Last_Deposit_Date; "Last Deposit Date")
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
            column(V23ofAverageIncome_LoanAppraisalBuffer; "Loan Appraisal Buffer"."2/3 of Average Income")
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
            dataitem(Loans; Loans)
            {
                //DataItemLink = "Member No."=field("Member No.");
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
                column(LoanOwnership; LoanOwnership)
                {
                }

                trigger OnPreDataItem()
                begin

                    //Loans.SETFILTER("Date Filter",'..%1',CALCDATE('-1D',LRec."Disbursement Date"));
                end;

                trigger OnAfterGetRecord()
                var
                    Groups: Record Customer;
                    Members: Record Members;
                    LoanRecord: Record Loans;
                    SkipLoan: Boolean;
                    Signatories: Record "Account Signatories.";
                begin


                    LoanOwnership := '';
                    SkipLoan := true;

                    Members.get(MemberNo);
                    if Members."Group No." <> '' then begin
                        LoanRecord.Reset();
                        LoanRecord.SetRange("Loan No.", Loans."Loan No.");
                        LoanRecord.SetRange("Member No.", Members."Group No.");
                        LoanRecord.SetFilter("Outstanding Principal", '>0');
                        if LoanRecord.FindFirst() then begin
                            SkipLoan := false;
                            LoanOwnership := LoanRecord."Member Name";
                        end;
                    end;

                    Signatories.Reset();
                    Signatories.SetRange("Member No.", MemberNo);
                    if Signatories.FindFirst() then begin
                        repeat


                            LoanRecord.Reset();
                            LoanRecord.SetRange("Loan No.", Loans."Loan No.");
                            LoanRecord.SetRange("Member No.", Signatories.Code);
                            LoanRecord.SetFilter("Outstanding Principal", '>0');
                            if LoanRecord.FindFirst() then begin
                                SkipLoan := false;
                                LoanOwnership := LoanRecord."Member Name";
                            end;
                        until Signatories.Next() = 0;
                    end;


                    if Loans."Member No." = MemberNo then begin
                        LoanOwnership := Loans."Member Name";
                        SkipLoan := false;
                    end;




                    //Loans.SETFILTER("Date Filter",'..%1',CALCDATE('-1D',LRec."Disbursement Date"));

                    if SkipLoan then
                        CurrReport.Skip();
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
                MemberNo := "Loan Appraisal Buffer"."Member No.";
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
        MemberNo: Code[20];
        LoanOwnership: Text[200];
}

