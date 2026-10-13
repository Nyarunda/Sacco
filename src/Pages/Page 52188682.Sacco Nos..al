
Page 50345 "Sacco Nos."
{
    ApplicationArea = Basic, Suite;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Customer Groups,Payments';
    SourceTable = "Sales & Receivables Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Sacco Nos")
            {
                field(TrackerNos; Rec."Tracker Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberApplicationNos; Rec."Member Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountApplicationNos; Rec."Account Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNos; Rec."Member Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(ReceiptsNos; Rec."Receipts Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNos; Rec."Loan Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanRecoveryNos; Rec."Loan Recovery Nos")
                {
                    ApplicationArea = Basic;
                }
                field(LoanReschedulingNos; Rec."Loan Rescheduling Nos")
                {
                    ApplicationArea = Basic;
                }
                field(FixedDepositNos; Rec."Fixed Deposit Nos")
                {
                    ApplicationArea = Basic;
                }
                field(SecuritySubstitutionNos; Rec."Security Substitution Nos")
                {
                    ApplicationArea = Basic;
                }
                field(MemberExitNoticeNos; Rec."Member Exit Notice Nos")
                {
                    ApplicationArea = Basic;
                }
                field(MemberExitNos; Rec."Member Exit Nos")
                {
                    ApplicationArea = Basic;
                }
                field(MemberChangesNos; Rec."Member Changes Nos")
                {
                    ApplicationArea = Basic;
                }
                field(TreasuryTellerNos; Rec."Treasury/Teller Nos")
                {
                    ApplicationArea = Basic;
                }
                field(TellerTransactionNos; Rec."Teller Transaction Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(BankersChequeApplicationNos; Rec."Bankers Cheque Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field(STONos; Rec."STO Nos")
                {
                    ApplicationArea = Basic;
                }
                field(StandingOrderRegNos; Rec."Standing Order Reg. Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(CheqBookNos; Rec."Cheq. Book Nos")
                {
                    ApplicationArea = Basic;
                }
                field(AccountTransferNos; Rec."Account Transfer Nos")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryNos; Rec."Salary Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentVoucherNos; Rec."Payment Voucher Nos")
                {
                    ApplicationArea = Basic;
                }
                field(PettyCashNos; Rec."Petty Cash Nos")
                {
                    ApplicationArea = Basic;
                }
                field(BoardPVsNos; Rec."Board PVs Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(BenevolentClaimNos; Rec."Benevolent Claim Nos")
                {
                    ApplicationArea = Basic;
                }
                field(LoanSecurityNos; Rec."Loan Security Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanSecurityCollectionNos; Rec."Loan Security Collection Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(CheckoffNo; Rec."Checkoff No.")
                {
                    ApplicationArea = Basic;
                }
                field(MicroFinanceTransactions; Rec."Micro Finance Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(OverdraftNos; Rec."Overdraft Nos")
                {
                    ApplicationArea = Basic;
                }
                field(ImprestReqNo; Rec."Imprest Req No")
                {
                    ApplicationArea = Basic;
                }
                field(ImprestSurrenderNo; Rec."Imprest Surrender No")
                {
                    ApplicationArea = Basic;
                }
                field("Portal Loan Nos"; Rec."Portal Loan Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Security Changes"; Rec."Security Changes")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        v: Record "RFQ Header";
    begin

        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
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
        SaccoPermissions.SetRange("General Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "General Setups"');
    end;

}

