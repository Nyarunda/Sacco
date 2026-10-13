
Page 50279 "Sacco Setup"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Setup";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(MembershipAge; Rec."Membership Age")
                {
                    ApplicationArea = Basic;
                }
                field(MemberPictureMandatory; Rec."Member Picture Mandatory")
                {
                    ApplicationArea = Basic;
                }
                field("Group Picture Mandatory"; Rec."Group Picture Mandatory")
                {
                    ApplicationArea = Basic;
                }

                //nich

                field("Next of Kin Mandatory"; Rec."Next of Kin Mandatory")
                {
                    ApplicationArea = Basic;
                }
                field("Kin % Allocation Mandatory"; Rec."Kin % Allocation Mandatory")
                {
                    ApplicationArea = Basic;
                }
                field("Nominee Mandatory"; Rec."Nominee Mandatory")
                {
                    ApplicationArea = Basic;
                }
                //end of nich
                field("BBF Expense Account"; Rec."BBF Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Self Approval"; Rec."Allow Self Approval")
                {
                    ApplicationArea = Basic;
                }
                field(ExciseDuty; Rec."Excise Duty (%)")
                {
                    ApplicationArea = Basic;
                }
                field(ExciseDutyGL; Rec."Excise Duty GL")
                {
                    ApplicationArea = Basic;
                }

                field("Coop Excise Duty (%)"; Rec."Coop Excise Duty (%)")
                {
                    ApplicationArea = Basic;
                }
                field(DormancyPeriod; Rec."Dormancy Period")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Contacts"; Rec."Sacco Contacts")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No,"; Rec."Bank Account No,")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Comm. Expense"; Rec."Registration Comm. Expense")
                {
                    ApplicationArea = Basic;
                }
                field("File Keeping Period"; Rec."File Keeping Period")
                {
                    ApplicationArea = Basic;
                }
                field("Coop B2B Bank Account"; Rec."Coop B2B Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Coop P2F Bank Account"; Rec."Coop P2F Bank Account")
                {
                    ApplicationArea = Basic;
                }

            }
            group(GuarantorshipSettings)
            {
                Caption = 'Guarantorship Configuration';
                field(GuarantorsMultiplier; Rec."Guarantors Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field(StaffCanGuaranteeLoan; Rec."Staff Can Guarantee Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Board Can Self Gua. Loan"; Rec."Staff/Board Can Self Gua. Loan")
                {
                    ApplicationArea = Basic;
                }
                field(SelfGuarantee; Rec."Self Guarantee %")
                {
                    ApplicationArea = Basic;
                }
                field("Self Guarantee Multiplier %"; Rec."Self Guarantee Multiplier %")
                {
                    ApplicationArea = Basic;
                }
                field("Non-Self Guarantee Multiplier %"; Rec."Non-Self Multiplier %")
                {
                    ApplicationArea = Basic;
                }
                field("Third Party Guarantee Multiplier %"; Rec."Third Party Multiplier %")
                {
                    ApplicationArea = Basic;
                }
                field("Max Total Exposure %"; Rec."Max Total Exposure %")
                {
                    ApplicationArea = Basic;
                }
                field("Third Party with Self Loan %"; Rec."Third Party with Self Loan %")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Credit Management")
            {
                field(LoanInterestAutomation; Rec."Loan Interest Automation")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestDate; Rec."Loan Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field(SpecificLoanInterestDay; Rec."Specific Loan Interest Day")
                {
                    ApplicationArea = Basic;
                }
                field(CalcLoanInterestOn; Rec."Calc. Loan Interest On")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Insurance Date"; Rec."Loan Insurance Date")
                {
                    ApplicationArea = Basic;
                }
                field("Specific Loan Insurance Day"; Rec."Specific Loan Insurance Day")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Principal Billing"; Rec."Minimum Principal Billing")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Board Loan Comment Amount"; Rec."Minimum Board Loan Comment Amt")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the minimum loan amount above which Board Comments can be edited on loan application pages.';
                }
                field(CollateralofLimitToUse; Rec."Collateral % of Limit To Use")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumValuationPeriod; Rec."Maximum Valuation Period")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyDaysFromExpPayDay; Rec."Penalty Days From Exp. Pay Day")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumAmttoPenalize; Rec."Minimum Amt to Penalize")
                {
                    ApplicationArea = Basic;
                }
                field(LoanReschedulingFee; Rec."Loan Rescheduling Fee")
                {
                    ApplicationArea = Basic;
                }
                field(LoanRestructureFee; Rec."Loan Restructure Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Min Topup Months"; Rec."Min Topup Months")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Control"; Rec."Checkoff Control")
                {
                    ApplicationArea = Basic;
                }
                field("Duplum Interest Period"; Rec."Duplum Interest Period")
                {
                    ApplicationArea = Basic;
                }

                field("Reminder SMs Date"; Rec."Reminder SMs Date")
                {
                    ApplicationArea = Basic;
                }
                field("Pause Defaulter Offset"; Rec."Pause Defaulter Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Stop Defaulter Recovery';
                }
                field("Loan Cutoff Date"; Rec."Loan Cutoff Date")
                {
                    ApplicationArea = Basic;
                }
                field("Days for Checkoff"; Rec."Days for Checkoff")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Contribution [Deposits]"; Rec."Min. Contribution [Deposits]")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Contribution [Shares]"; Rec."Min. Contribution [Shares]")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Benevolent Contrib"; Rec."Min. Benevolent Contrib")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Loan Deposits Limit %"; Rec."Mobile Loan Deposits Limit %")
                {
                    ApplicationArea = Basic;
                }
                field("Rollover Allowance Period"; Rec."Rollover Allowance Period")
                {
                    ApplicationArea = Basic;
                }
                field("Arrears Grace Period"; Rec."Arrears Grace Period")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Loans Grace Period"; Rec."Mobile Loans Grace Period")
                {
                    ApplicationArea = Basic;
                }
                field("Stop Loan Interest After"; Rec."Stop Loan Interest After")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Day"; Rec."Interest Day")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Billing Grace Period"; Rec."Interest Billing Grace Period")
                {
                    ApplicationArea = Basic;
                }
                field("Exempt Loan Principal Check"; Rec."Exempt Loan Principal Check")
                {
                    ApplicationArea = Basic;
                }
                field("Writeoff GL"; Rec."Writeoff GL")
                {
                    ApplicationArea = Basic;
                }
                field("Writeoff Provision GL"; Rec."Writeoff Provision GL")
                {
                    ApplicationArea = Basic;
                }
                field("Prorate 1st Month Interest"; Rec."Prorate 1st Month Interest")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Savings Management")
            {
                field(TellerCanSelfTransact; Rec."Teller Can Self-Transact")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeRejectPeriod; Rec."Cheque Reject Period")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalSTOAccountNo; Rec."External STO Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(IncomeControlAccount; Rec."Income Control Account")
                {
                    ApplicationArea = Basic;
                }
                field(ByPassChequeClearingDays; Rec."By Pass Cheque Clearing Days")
                {
                    ApplicationArea = Basic;
                }
                field(FDInterestAccrual; Rec."FD Interest Accrual")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum ATM Limit"; Rec."Maximum ATM Limit")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card No Characters"; Rec."ATM Card No Characters")
                {
                    ApplicationArea = Basic;
                }
                field("Internal STO Charge"; Rec."Internal STO Charge")
                {
                    ApplicationArea = Basic;
                }

                field("External STO Charge"; Rec."External STO Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Activation Fee"; Rec."Charge Activation Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Activation Fee Charge"; Rec."Activation Fee Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Petty Cash Amount"; Rec."Max. Petty Cash Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Contrib. Amount"; Rec."Min. Contrib. Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Share Capital"; Rec."Minimum Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Deposit Qualification"; Rec."Minimum Deposit Qualification")
                {
                    ApplicationArea = Basic;
                }

                field("Go Live Date"; Rec."Go Live Date")
                {
                    ApplicationArea = Basic;
                }
                field("Suspense GL Account"; Rec."Suspense GL Account")
                {
                    ApplicationArea = Basic;
                }
                field("GFE Income Acc."; Rec."GFE Income Acc.")
                {
                    ApplicationArea = Basic;
                }
                field("New Member Share Cap"; Rec."New Member Share Cap")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Share Capital Amount"; Rec."Maximum Share Capital Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Lease Increment %"; Rec."Lease Increment %")
                {
                    ApplicationArea = Basic;
                }
                field(WthTax; Rec.WthTax)
                {
                    ApplicationArea = Basic;
                    Caption = 'Withholding Tax (%)';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = Basic;
                }
                field("UFAA GL"; Rec."UFAA GL")
                {
                    ApplicationArea = Basic;
                }
                field("Opening Balances GL"; Rec."OPening Balances GL")
                {
                    ApplicationArea = Basic;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = Basic;
                }

                group(Mobile)
                {
                    field("Sacco Paybill Bank"; Rec."Sacco Paybill Bank")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            group(Dividends)
            {
                field(DividendYearDate; Rec."Dividend Year Date")
                {
                    ApplicationArea = Basic;
                }
                field(DividendProcessingAccount; Rec."Dividend Processing Account")
                {
                    ApplicationArea = Basic;
                }
                field(DividendCharge; Rec."Dividend Charge")
                {
                    ApplicationArea = Basic;
                }
                field(DividendProcessingCharge; Rec."Dividend Processing Charge")
                {
                    ApplicationArea = Basic;
                }
                field(DividendActivityCode; Rec."Dividend Activity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Reverse Date"; Rec."Dividend Reverse Date")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Reverse Document"; Rec."Dividend Reverse Document")
                {
                    ApplicationArea = Basic;
                }
                field("MBanking Application Charge"; Rec."MBanking Application Charge")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Member Exit")
            {
                field(MemberExitNoticePeriod; Rec."Member Exit Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field(MemberExitCharge; Rec."Member Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital Charge"; Rec."Share Capital Charge")
                {
                    ApplicationArea = Basic;
                }
                field(ActivateEarlyExitCharge; Rec."Activate Early Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Early Exit Notice Period"; Rec."Early Exit Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field(EarlyMemberExitCharge; Rec."Early Member Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field(MemberExitTransferAccount; Rec."Member Exit Transfer Account")
                {
                    ApplicationArea = Basic;
                }
                field("Chamaa Exit Charge"; Rec."Chamaa Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Chamaa Early Exit Charge"; Rec."Chamaa Early Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Chamaa Exit Transfer Account"; Rec."Chamaa Exit Transfer Account")
                {
                    ApplicationArea = basic;
                }
                field("Chamaa Consolidation Account"; Rec."Chamaa Consolidation Account")
                {
                    ApplicationArea = basic;
                }
                field("Exit Min. Balance"; Rec."Exit Min. Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Deceased Withdrawal"; Rec."Charge Deceased Withdrawal")
                {
                    ApplicationArea = Basic;
                }

            }
            group(Depreciation)
            {
                field("Depreciation No. Days"; Rec."Depreciation No. Days")
                {
                    ApplicationArea = Basic;
                }
                field("No of Days in Year"; Rec."No of Days in Year")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Notifications)
            {
                field(SendReceiptEmail; Rec."Send Receipt Email")
                {
                    ApplicationArea = Basic;
                }
                field(SendReceiptSMS; Rec."Send Receipt SMS")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Email"; Rec."Credit Email")
                {
                    ApplicationArea = Basic;
                }
                field("Finance Email"; Rec."Finance Email")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Email"; Rec."FOSA Email")
                {
                    ApplicationArea = Basic;
                }
                field("Coseke EDMS Base URL"; Rec."Coseke EDMS Base URL")
                {
                    ApplicationArea = Basic;
                }
                field("Coseke EDMS API Key"; Rec."Coseke EDMS API Key")
                {
                    ApplicationArea = Basic;
                }
                field("Coseke Finance Folder Name"; Rec."Coseke Finance Folder Name")
                {
                    ApplicationArea = Basic;
                }
                field("Metropol Base URL"; Rec."Metropol Base URL")
                {
                    ApplicationArea = Basic;
                }
                field("Metropol API Key"; Rec."Metropol API Key")
                {
                    ApplicationArea = Basic;
                }
                field("PDF Encrypt Function URL"; Rec."PDF Encrypt Function URL")
                {
                    ApplicationArea = Basic;
                }
                field("Statements E-Mail"; Rec."Statements E-Mail")
                {
                    ApplicationArea = Basic;
                }

                field("Email File Path"; Rec."Email File Path")
                {
                    ApplicationArea = Basic;
                }
                field("AGM Msg"; Rec."AGM Msg")
                {
                    ApplicationArea = Basic;
                }
                field("Send Email via Portal"; Rec."Send Email via Portal")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Defaulter Testing")
            {
                field("Is Defaulter Tetsing"; Rec."Is Defaulter Tetsing")
                {
                    ApplicationArea = Basic;
                }
                field("Credit 1 Email"; Rec."Credit 1 Email")
                {
                    ApplicationArea = Basic;
                }
                field("Credit 2 Email"; Rec."Credit 2 Email")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Time")
            {
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = Basic;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Loan Next RunDate"; Rec."Mobile Loan Next RunDate")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Penalty Next RunDate"; Rec."Loan Penalty Next RunDate")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Board)
            {
                field("Board Control Acc."; Rec."Board Control Acc.")
                {
                    ApplicationArea = Basic;
                }
                field("Board Expense Acc."; Rec."Board Expense Acc.")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum No. Board Approvals"; Rec."Minimum No. Board Approvals")
                {
                    ApplicationArea = Basic;
                }
            }
            group(SpotCash)
            {
                field("Spot SMS ClientID"; Rec."Spot SMS ClientID")
                {
                    ApplicationArea = Basic;
                }
                field("Spot SMS PassKey"; Rec."Spot SMS PassKey")
                {
                    ApplicationArea = Basic;
                }
                field("Spot SMS Sender"; Rec."Spot SMS Sender")
                {
                    ApplicationArea = Basic;
                }
                field("Spot SMS ServiceID"; Rec."Spot SMS ServiceID")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Azure)
            {
                field("Azure Path"; Rec."Azure Path")
                {
                    ApplicationArea = Basic;
                }
                field("Azure Storage Path"; Rec."Azure Storage Path")
                {
                    ApplicationArea = Basic;
                }
                field("Azure Storage SASToken"; Rec."Azure Storage SASToken")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }


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
        SaccoPermissions.SetRange("General Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "General Setups"');
    end;
}

