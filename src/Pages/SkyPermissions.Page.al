Page 50166 "Sky Permissions"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Sky Permissions";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(ViewSetup; Rec."View Setup")
                {
                    ApplicationArea = Basic;
                }
                field(EditSetup; Rec."Edit Setup")
                {
                    ApplicationArea = Basic;
                }
                field(ResetMpesaPin; Rec."Reset Mpesa Pin")
                {
                    ApplicationArea = Basic;
                }
                field(UpdatePaybillTransaction; Rec."Update Paybill Transaction")
                {
                    ApplicationArea = Basic;
                }
                field(UpdateTransactionalMobileNo; Rec."Update Transactional Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(SkyMobileSetups; Rec."Sky Mobile Setups")
                {
                    ApplicationArea = Basic;
                }
                field(ReverseSkyTransactions; Rec."Reverse Sky Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(BlackListAccounts; Rec."Black-List Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(UpdateMPESAWithdrawal; Rec."Update MPESA Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field(ViewBlackListedAccounts; Rec."View BlackListed Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(ClearTransactionalMobile; Rec."Clear Transactional Mobile")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

