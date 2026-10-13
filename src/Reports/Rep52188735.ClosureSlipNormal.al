report 50398 "ClosureSlip Normal"
{
    ApplicationArea = All;
    Caption = 'ClosureSlip Normal';
    RDLCLayout = './src/Layouts/ClosureSlipNormal.rdlc';

    DefaultLayout = RDLC;

    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(MembershipWithdrawals; "Member Exit")
        {
            /*column(ActualWithdrawalDate; "Actual Withdrawal Date")
            {
            }
            column(AmounttoDisburse; "Amount to Disburse")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(BBFAmount; "BBF Amount")
            {
            }
            column(ChequeNo; "Cheque No.")
            {
            }
            column(ClosingDate; "Closing Date")
            {
            }
            column(ClosureType; "Closure Type")
            {
            }
            column(DisburesmentType; "Disburesment Type")
            {
            }
            column(DividendAccount; "Dividend Account")
            {
            }
            column(DividendAmount; "Dividend Amount")
            {
            }
            column(FOSAAccountNo; "FOSA Account No.")
            {
            }
            column(HolidayDeposits; "Holiday Deposits")
            {
            }
            column(InterestOnDeposit; "Interest On Deposit")
            {
            }
            column(MemberDeposits; "Member Deposits")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(Old_Member_No_; "Old Member No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(ModeOfDisbursement; "Mode Of Disbursement")
            {
            }
            column(NetPay; "Net Pay")
            {
            }
            column(NetPayabletotheMember; "Net Payable to the Member")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PartailDisburesment; "Partail Disburesment")
            {
            }
            column(Payee; Payee)
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
            column(RiskBeneficiary; "Risk Beneficiary")
            {
            }
            column(RiskFund; "Risk Fund")
            {
            }
            column(RiskFundArrears; "Risk Fund Arrears")
            {
            }
            column(RiskRefundable; "Risk Refundable")
            {
            }
            column(SchoolDeposits; "School Deposits")
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
            column(TotalAdds; "Total Adds")
            {
            }
            column(TotalLoanInterest; "Total Interest")
            {

            }
            column(TotalLesses; "Total Lesses")
            {
            }
            column(TotalLoan; "Total Loan")
            {
            }
            column(TotalLoansBOSA; "Total Loans BOSA")
            {
            }
            column(TotalLoansFOSA; "Total Loans FOSA")
            {
            }
            column(TotalOustandingIntFOSA; "Total Oustanding Int FOSA")
            {
            }
            column(TotalOutstandingIntBOSA; "Total Outstanding Int BOSA")
            {
            }
            column(TransferAccount; "Transfer Account")
            {
            }
            column(UnpaidDividends; "Unpaid Dividends")
            {
            }
            column(WithdrawalApplicationDate; "Withdrawal Application Date")
            {
            }
            column(WithdrawalFee; "Withdrawal Fee")
            {
            }
            column(Withdrawn; Withdrawn)
            {
            }
            column(stage; stage)
            {
            }
            trigger OnAfterGetRecord()
            begin
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, MemberWithdrawal."Net Payable to the Member", ' ');
                CheckReport.FormatNoText(NumberText, "Net Payable to the Member", ' ');
            end;
            */
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
    var
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        AmountVendor: Decimal;
        //MemberWithdrawal: record "Membership Withdrawals";
        AmountInWords: text;
}
