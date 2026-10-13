
Page 50300 "Banking User Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Banking User Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserName; Rec."User Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(CashierJournalTemplate; Rec."Cashier Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field(CashierJournalBatch; Rec."Cashier Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultBank; Rec."Default  Bank")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultChequeBank; Rec."Default  Cheque Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Default RTGS Bank"; Rec."Default RTGS Bank")
                {
                    ApplicationArea = Basic;
                }
                field(MaxDepositLimit; Rec."Max. Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MaxWithdrawalLimit; Rec."Max. Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MaxCashierWithholding; Rec."Max. Cashier Withholding")
                {
                    ApplicationArea = Basic;
                }
                field(MinBalance; Rec."Min. Balance")
                {
                    ApplicationArea = Basic;
                }
                field(BankersChequeAccount; Rec."Bankers Cheque Account")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeClearanceAccount; Rec."Cheque Clearance Account")
                {
                    ApplicationArea = Basic;
                }
                field(ExcessAccount; Rec."Excess Account")
                {
                    ApplicationArea = Basic;
                }
                field(ShortageAccount; Rec."Shortage Account")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(MPesaBankAccount; Rec."MPesa Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(MPesaCustomerAccount; Rec."MPesa Customer Account")
                {
                    ApplicationArea = Basic;
                }
                field(ShopCustomerAccount; Rec."Shop Customer Account")
                {
                    ApplicationArea = Basic;
                }
                field(MPESATransactionLimit; Rec."MPESA Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MaxMPESAWithholding; Rec."Max. MPESA Withholding")
                {
                    ApplicationArea = Basic;
                }
                field(CustServiceChequeAccount; Rec."Cust. Service Cheque Account")
                {
                    ApplicationArea = Basic;
                }
                field(EquityBankAccount; Rec."Equity Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(EquityCustomerAccount; Rec."Equity Customer Account")
                {
                    ApplicationArea = Basic;
                }
                field(MPESADisbursementAc; Rec."MPESA Disbursement A/c")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeDisbursementAc; Rec."Cheque Disbursement A/c")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorMobileNo; Rec."Supervisor Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorEMail; Rec."Supervisor E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(SuperAgentCustomerAccount; Rec."Super Agent Customer Account")
                {
                    ApplicationArea = Basic;
                }
                field(SuperAgentTransactionLimit; Rec."Super Agent Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field(SuperTreasuryUser; Rec."Super Treasury User")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Treshhold"; Rec."Treasury Treshhold")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Alert %"; Rec."Treasury Alert %")
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
        SaccoPermissions.SetRange("Savings Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Saving Setups"');
    end;

}

