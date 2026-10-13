report 50318 "Membership Exit Report"
{
    ApplicationArea = All;
    Caption = 'Membership Withdrawal Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Membership Withdrawal.rdlc';

    dataset
    {
        dataitem(MemberExit; "Member Exit")
        {
            column(ApplicationDate; "Application Date")
            {
            }
            column(BeneficiaryAmount; "Beneficiary Amount")
            {
            }
            column(BenevolentFund; "Benevolent Fund")
            {
            }
            column(ChargeGL; "Charge GL")
            {
            }
            column(ChequeNo; "Cheque No.")
            {
            }
            column(CloseAccount; "Close Account")
            {
            }
            column(ClosingDate; "Closing Date")
            {
            }
            column(ClosureType; "Closure Type")
            {
            }
            column(Contact; Contact)
            {
            }
            column(CustomerFeedback; "Customer Feedback")
            {
            }
            column(Date; "Date")
            {
            }
            column(DatetoRejoin; "Date to Rejoin")
            {
            }
            column(DividendsRebates; "Dividends/Rebates")
            {
            }
            column(DutyonExitCharge; "Duty on Exit Charge")
            {
            }
            column(EarlyExit; "Early Exit")
            {
            }
            column(EmployerCode; EmployerCode)
            {
            }
            column(EnteredBy; "Entered By")
            {
            }
            column(ExitCharge; "Exit Charge")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(InsuranceAmount; "Insurance Amount")
            {
            }
            column(InteresttoRejoin; "Interest to Rejoin")
            {
            }
            column(MDFContribution; "MDF Contribution")
            {
            }
            column(MaturityDate; "Maturity Date")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberSavings; "Member Savings")
            {
            }
            column(MemberExitCharge; MemberExitCharge)
            {
            }
            column(MembershipDate; MembershipDate)
            {
            }
            column(MinuteNos; "Minute Nos.")
            {
            }
            column(NetRefundable; "Net Refundable")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(NonWithdrawableSavings; "Non-Withdrawable Savings")
            {
            }
            column(NoticeNo; "Notice No.")
            {
            }
            column(PartialWithdrawalAmount; "Partial Withdrawal Amount")
            {
            }
            column(PayingBank; "Paying Bank")
            {
            }
            column(Posted; Posted)
            {
            }
            column(ReasonforWithdrawal; "Reason for Withdrawal")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(RetainedSharesDeductable; "Retained Shares Deductable")
            {
            }
            column(ShareCapital; "Share Capital")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TermSavings; "Term Savings")
            {
            }
            column(TotalAppraisal; "Total Appraisal")
            {
            }
            column(TotalCharges; "Total Charges")
            {
            }
            column(TotalGuaranteed; "Total Guaranteed")
            {
            }
            column(TotalInterest; "Total Interest")
            {
            }
            column(TotalLoanOutstanding; "Total Loan Outstanding")
            {
            }
            column(TotalPenalty; "Total Penalty")
            {
            }
            column(TotalPrincipal; "Total Principal")
            {
            }
            column(TotalRefundable; "Total Refundable")
            {
            }
            column(TotalSavings; "Total Savings")
            {
            }
            column(Transaction; Transaction)
            {
            }
            column(TransferAccount; "Transfer Account")
            {
            }
            column(TransferAccountName; "Transfer Account Name")
            {
            }
            column(WithdrawableSavings; "Withdrawable Savings")
            {
            }
            column(WithdrawalType; WithdrawalType)
            {
            }
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
}
