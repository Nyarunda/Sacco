
Page 50160 "Status Change Permssion."
{
    PageType = List;
    SourceTable = "Status Change Permissions";

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
                field(ResetMpesaPin; Rec."Reset Mpesa Pin")
                {
                    ApplicationArea = Basic;
                }
                field(UpdatePaybillTransaction; Rec."Update Paybill Transaction")
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
                field(ViewBlackListedAccounts; Rec."View BlackListed Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(UpdateMPESAWithdrawal; Rec."Update MPESA Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field(UpdateTransactionalMobileNo; Rec."Update Transactional Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(ClearTransactionalMobile; Rec."Clear Transactional Mobile")
                {
                    ApplicationArea = Basic;
                }

                field("Update Partial Disbursement"; Rec."Update Partial Disbursement")
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
    begin
        Rec.RestrictAccess(UserId);
    end;


    procedure Restrict_Access(UserNo: Code[100])
    var
        StatusPermission: Record "User Setup";
        ErrorOnRestrictViewTxt: label 'You do not have permissions to EDIT this Page. Contact your system administrator for further details';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserNo);
        StatusPermission.SetRange("Approval Administrator", true);
        if not StatusPermission.Find('-') then begin
            CurrPage.Editable := false;
        end;
    end;
}

