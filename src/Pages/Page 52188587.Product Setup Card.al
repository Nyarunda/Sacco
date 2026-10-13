
Page 50250 "Product Setup Card"
{
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Product Setup";
    PromotedActionCategories = 'Process,New,Top-Up Products';
    layout
    {
        area(content)
        {
            group(General)
            {
                field(ProductID; Rec."Product ID")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec."USSD Product Name" := Rec.Description;
                    end;
                }
                field(USSDProductName; Rec."USSD Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNoPrefix; Rec."Account No. Prefix")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNoSuffix; Rec."Account No. Suffix")
                {
                    ApplicationArea = Basic;
                }
                field(ProductClass; Rec."Product Class")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                field(SearchCode; Rec."Search Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(MinCustomerAge; Rec."Min. Customer Age")
                {
                    ApplicationArea = Basic;
                }
                field(MaxCustomerAge; Rec."Max.Customer Age")
                {
                    ApplicationArea = Basic;
                }
                field(InterestRateMin; Rec."Interest Rate (Min.)")
                {
                    ApplicationArea = Basic;
                }
                field(InterestRateMax; Rec."Interest Rate (Max.)")
                {
                    ApplicationArea = Basic;
                }
                field(ProductPostingGroup; Rec."Product Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(DontShowonStatement; Rec."Dont Show on Statement")
                {
                    ApplicationArea = Basic;
                }
                field(MbankingKeyWord; Rec."Mbanking Key Word")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(DepositMultiplier; Rec."Deposit Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Special Multiplier"; Rec."Special Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Default Portal Mult. Product"; Rec."Default Portal Mult. Product")
                {
                    ApplicationArea = Basic;
                }
                field(b2bProduct; Rec."B2B Code")
                {
                    ApplicationArea = Basic;
                }


            }
            group("Savings Setup")
            {
                Visible = SavingsBool;
                field(ProductCategory; Rec."Product Category")
                {
                    ApplicationArea = Basic;
                }
                field(SavingsType; Rec."Savings Type")
                {
                    ApplicationArea = Basic;
                }
                field(MandatoryContribution; Rec."Mandatory Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Start Date"; Rec."Registration Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Balance"; Rec."Maximum Balance")
                {
                    ApplicationArea = Basic;
                }
                field(CanOffsetLoan; Rec."Can Offset Loan")
                {
                    ApplicationArea = Basic;
                }

                field(AutoOpenMemberAccount; Rec."Auto Open Member Account")
                {
                    ApplicationArea = Basic;
                }
                field(AutoOpenGroupAccount; Rec."Auto Open Group Account")
                {
                    ApplicationArea = Basic;
                }
                field(AutoOpenChamaAccount; Rec."Auto Open Chamaa Account")
                {
                    ApplicationArea = Basic;
                }
                field(AllowMultipleAccounts; Rec."Allow Multiple Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Frequency"; Rec."Withdrawal Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Frequency Count"; Rec."Withdrawal Frequency Count")
                {
                    ApplicationArea = basic;
                }

                field(DividendCalcMethod; Rec."Dividend Calc. Method")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Capitalization %"; Rec."Dividend Capitalization %")
                {
                    ApplicationArea = Basic;
                }
                field(DormancyPeriod; Rec."Dormancy Period")
                {
                    ApplicationArea = Basic;
                }
                field("Dormancy Period Notification"; Rec."Dormancy Period Notification")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumContribution; Rec."Minimum Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Check Posting Date"; Rec."Check Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.TestField("Check Posting Date", true);
                    end;
                }
                field("Disbursement Product"; Rec."Disbursement Product")
                {
                    ApplicationArea = Basic;
                }
                field("Disbursement Period"; Rec."Disbursement Period")
                {
                    ApplicationArea = Basic;
                }
                field(EarnsInterest; Rec."Earns Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Available on Portal"; Rec."Available on Portal")
                {
                    ApplicationArea = Basic;
                }
                field(InterestExpenseAccount; Rec."Interest Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field(InterestPayableAccount; Rec."Interest Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field(InterestCalcMinBalance; Rec."Interest Calc Min Balance")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawalInterval; Rec."Withdrawal Interval")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Fuuza"; Rec."Allow Fuuza")
                {
                    ApplicationArea = Basic;
                }
                field("Fuuza Daily Interest %"; Rec."Fuuza Daily Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(StatementCharge; Rec."Statement Charge")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumNoofWithdrawal; Rec."Maximum No. of Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumAccountBalance; Rec."Minimum Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(MaxTellerWiithdrawable; Rec."Max Teller Wiithdrawable")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingTaxAccount; Rec."Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field(WithHoldingTax; Rec."WithHolding Tax")
                {
                    ApplicationArea = Basic;
                }
                field(AllowOverdraft; Rec."Allow Overdraft")
                {
                    ApplicationArea = Basic;
                }
                field(OverDraftInterest; Rec."Over Draft Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(OverDraftInterestAccount; Rec."Over Draft Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field(AllowMultipleOverDraft; Rec."Allow Multiple Over Draft")
                {
                    ApplicationArea = Basic;
                }
                field(MobileTransaction; Rec."Mobile Transaction")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyMaintenanceFee; Rec."Monthly Maintenance Fee")
                {
                    ApplicationArea = Basic;
                }
                field(MaintenanceFeeGL; Rec."Maintenance Fee [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Fee [G/L]"; Rec."Penalty Fee [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Ledger Fee"; Rec."Charge Ledger Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Fee"; Rec."Penalty Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing Account"; Rec."Salary Processing Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Processing Account"; Rec."Loan Processing Account")
                {
                    ApplicationArea = Basic;
                }
                field("Import Opening Balance"; Rec."Import Opening Balance")
                {
                    ApplicationArea = Basic;
                }
                field("STO Recovery"; Rec."STO Recovery")
                {
                    ApplicationArea = basic;
                }
            }
            group("Credit Setup")
            {
                Visible = CreditBool;

                field(GracePeriodPrincipal; Rec."Grace Period - Principal")
                {
                    ApplicationArea = Basic;
                }
                field(GracePeriodInterest; Rec."Grace Period - Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Loan Calc. Method"; Rec."Mobile Loan Calc. Method")
                {
                    ApplicationArea = Basic;
                }
                field("Competes Mobile Loan"; Rec."Competes Mobile Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Exclude Own Product Balance"; Rec."Exclude Own Product Balance")
                {
                    ApplicationArea = Basic;
                }
                field(LoanAccountGL; Rec."Loan Account [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestIncomeGL; Rec."Loan Interest Income [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestReceivableGL; Rec."Loan Interest Receivable [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInsuranceIncomeGL; Rec."Insurance Income [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInsuranceReceivableGL; Rec."Insurance Receivable [G/L]")
                {
                    ApplicationArea = Basic;

                }
                field("Insurance Percentage"; Rec."Insurance Percentage")
                {
                    ApplicationArea = Basic;
                }

                field(GuarantorshipType; Rec."Guarantorship Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Min. Guarantors"; Rec."Mobile Min. Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile/Portal Minimum Guarantors';
                }
                field(MaximumGuarantors; Rec."Maximum Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumGuarantors; Rec."Minimum Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field(LoanApplicationPeriod; Rec."Loan Application Period")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumLoanAmount; Rec."Minimum Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumLoanAmount; Rec."Maximum Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum No. of Loans"; Rec."Maximum No. of Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Committee Approval Limit"; Rec."Committee Approval Limit")
                {
                    ApplicationArea = Basic;
                }
                field(InterestCalculationMethod; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Use Tiered Debt Threshold"; Rec."Use Tiered Debt Threshold")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultInstallments; Rec."Default Installments")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Installments Type"; Rec."Mobile Installments Type")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalEFTCharges; Rec."External EFT Charges")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyPercentage; Rec."Penalty Percentage")
                {
                    ApplicationArea = Basic;
                }
                field(LoanPenaltyIncomeGL; Rec."Loan Penalty Income [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanPenaltyReceivableGL; Rec."Loan Penalty Receivable [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(InterestAccountingMethod; Rec."Interest Accounting Method")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyAccountingMethod; Rec."Penalty Accounting Method")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalProduct; Rec."Appraisal Product")
                {
                    ApplicationArea = Basic;
                }
                field(AllowMultipleRunningLoans; Rec."Allow Multiple Running Loans")
                {
                    ApplicationArea = Basic;
                }
                field(LoanSource; Rec."Loan Source")
                {
                    ApplicationArea = Basic;
                }
                field(RecoveryPriority; Rec."Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
                field("AutoRecovery From Savings"; Rec."AutoRecovery From Savings")
                {
                    ApplicationArea = Basic;
                }
                field(RepayMode; Rec."Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(SuspendInterestAccountGL; Rec."Suspend Interest Account [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(RepaymentFrequency; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field(NatureofLoanType; Rec."Nature of Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantorship Option"; Rec."Guarantorship Option")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Upfront Interest"; Rec."Charge Upfront Interest")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(InterestRecoveredUpfront; Rec."Interest Recovered Upfront")
                {
                    ApplicationArea = Basic;
                }
                field(EmailLoanSchedule; Rec."Email Loan Schedule")
                {
                    ApplicationArea = Basic;
                }
                field(RequiresBatching; Rec."Requires Batching")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Min. Deposits"; Rec."Appraisal Min. Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Min. Shares"; Rec."Appraisal Min. Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal % on Amount"; Rec."Appraisal % on Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Business Appraisal % on Amount"; Rec."Business Appraisal % on Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit %"; Rec."Deposit %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualification on Deposits %';
                }
                field("Self Guaranteed Deposit %"; Rec."Self Guaranteed Deposit %")
                {
                    ApplicationArea = Basic;
                }
                field("Rollover Fee %"; Rec."Rollover Fee %")
                {
                    ApplicationArea = Basic;
                }
                field("Share Deposit Capitilization %"; Rec."Share Deposit Capitilization %")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementProduct; Rec."Disbursement Product")
                {
                    ApplicationArea = Basic;
                }
                field(IncomeType; Rec."Income Type")
                {
                    ApplicationArea = Basic;
                }
                field(CutoffDay; Rec."Cutoff Day")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDueonDisbursement; Rec."Interest Due on Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDueCutoffDay; Rec."Interest Due Cutoff Day")
                {
                    ApplicationArea = Basic;
                }
                field(BonusAppraisalStartDate; Rec."Bonus Appraisal Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(CRBProductCode; Rec."CRB Product Code")
                {
                    ApplicationArea = Basic;
                }
                field(PreEarnedReceivableGL; Rec."Pre-Earned Receivable [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(PreEarnedInterest; Rec."Pre-Earned Interest")
                {
                    ApplicationArea = Basic;
                }
                field(RecoverRegistrationFee; Rec."Recover Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Check Arrears"; Rec."Check Arrears")
                {
                    ApplicationArea = basic;
                }
                field(AvailableonMobile; Rec."Available on Mobile")
                {
                    ApplicationArea = Basic;
                }
                field(AvailableonPortal; Rec."Available on Portal")
                {
                    ApplicationArea = Basic;
                }
                field("Exempt Portal Eligibility"; Rec."Exempt Portal Eligibility")
                {
                    ApplicationArea = Basic;
                }
                field("Back Office Available Online"; Rec."Back Office Available Online")
                {
                    ApplicationArea = Basic;
                }
                field(SkipIntDueOnTopUp; Rec."Skip Int Due On Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduleofPropertyMandatory; Rec."Schedule of Property Mandatory")
                {
                    ApplicationArea = Basic;
                }
                field(AutoSendSMSAlerts; Rec."Auto Send SMS Alerts")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Deposits"; Rec."Appraise Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Salary"; Rec."Appraise Salary")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Security"; Rec."Appraise Security")
                {
                    ApplicationArea = Basic;
                }
                field("Exclude Topup Fee"; Rec."Exclude Topup Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Special Offset"; Rec."Allow Special Offset")
                {
                    ApplicationArea = Basic;
                }
                field("Is Mobile"; Rec."Is Mobile")
                {
                    ApplicationArea = Basic;
                }
                field("Mandatory Documents"; Rec."Mandatory Documents")
                {
                    ApplicationArea = Basic;
                }
                field("Restrict to Emp. Code"; Rec."Restrict to Emp. Code")
                {
                    ApplicationArea = Basic;
                }
                field("Restrict to Member Code"; Rec."Restrict to Member Code")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }
                field("Loan Clients"; Rec."Loan Clients")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Sacco Period"; Rec."Minimum Sacco Period")
                {
                    ApplicationArea = Basic;
                }
                field("Skip Salary Cutoff Date"; Rec."Skip Salary Cutoff Date")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Transaction Code"; Rec."Payroll Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Shares"; Rec."Appraisal Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Business"; Rec."Appraisal Business")
                {
                    ApplicationArea = Basic;
                }
                field("Loan to Shares Ration"; Rec."Loan to Shares Ration")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Share Deposits"; Rec."Min. Share Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Comparison Type"; Rec."Charge Comparison Type")
                {
                    ApplicationArea = Basic;
                }

                field("Allow CRB Check"; Rec."Allow CRB Check")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Minimum Loan Amount"; Rec."CRB Minimum Loan Amount")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Agency")
            {
                Visible = SavingsBool;
                field("Maximum Agency Deposit"; Rec."Maximum Agency Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Agency Withdrawable"; Rec."Maximum Agency Withdrawable")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Transaction"; Rec."Allowed Transaction")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Others")
            {

                field("Advice Sorting Order"; Rec."Advice Sorting Order")
                {
                    ApplicationArea = Basic;
                }

                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = Basic;
                }

            }
        }

    }

    actions
    {
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Process';
                action("Product Charges")
                {
                    ApplicationArea = Basic;
                    Image = ChangeBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = field("Product ID");
                }
                action("Product Documents")
                {
                    ApplicationArea = Basic;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product Loan Documents";
                    RunPageLink = "Product" = field("Product ID");
                }
                action("Product Sub. Type")
                {
                    ApplicationArea = Basic;
                    Image = CreateDocuments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Sub. Type";
                    RunPageLink = "Loan Type" = field("Product ID");
                }
            }
        }

        area(navigation)
        {
            group(LoanBand)
            {
                Caption = 'Loan Bands';
                action("Tiered Debt Threshold")
                {
                    ApplicationArea = Basic;
                    Image = InsuranceLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = Rec."Use Tiered Debt Threshold";
                    RunObject = Page "Tiered Debt Threshold";
                    RunPageLink = "Loan Product" = field("Product ID");
                }
                action("Top Up Products")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Products';
                    Image = ChangeBatch;
                    Promoted = true;
                    PromotedCategory = category4;
                    RunObject = Page "Top Up Products";
                    RunPageLink = "Product ID" = field("Product ID");
                }
            }

            group(Deposits)
            {

                action("Loan Reminder Setup")
                {
                    ApplicationArea = Basic;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Loan Reminder Setup";
                    RunPageLink = "Loan Product" = field("Product ID");
                }
                action("Deposit Band")
                {
                    ApplicationArea = Basic;
                    Image = ProductDesign;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Deposit Bands";
                    RunPageLink = "Loan Product" = field("Product ID");
                }
                action("Share Capital Features")
                {
                    ApplicationArea = Basic;
                    Image = Production;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Share Capital Controls";
                    RunPageLink = "Loan Product" = field("Product ID");
                }
                action("Share Capital Bands")
                {
                    ApplicationArea = Basic;
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Loan Share Capital Bands";
                    RunPageLink = "Loan Product" = field("Product ID");
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        CreditBool: Boolean;
        SavingsBool: Boolean;

    local procedure UpdateControls()
    begin

        CreditBool := false;
        SavingsBool := false;

        if Rec."Product Class" = Rec."product class"::Credit then
            CreditBool := true;
        if Rec."Product Class" = Rec."product class"::Savings then
            SavingsBool := true;
    end;



    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Credit Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Credit Setups"');
    end;
}

