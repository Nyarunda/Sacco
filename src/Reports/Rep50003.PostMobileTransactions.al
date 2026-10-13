namespace UnitedWomen_Production.UnitedWomen_Production;

using System.Utilities;


report 50003 "Post Mobile Transactions"
{
    ApplicationArea = All;
    Caption = 'Post Mobile Transactions';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = const(1));
            trigger OnAfterGetRecord()
            var
                MTrans: Record "Sky M-Banking Transactions";
            begin

                if TransID = '' then begin

                    if "TransactionType" = "TransactionType"::"Mpesa Deposit" then
                        MpesaActivity.PostMpesaDepositsTransaction('')
                    else if "TransactionType" = "TransactionType"::"Loan Repayment" then
                        MpesaActivity.PostMpesaDepositsTransaction('')
                    else if "TransactionType" = "TransactionType"::"Mpesa Withdrawal" then
                        MpesaActivity.PostMpesaDepositsTransaction('')
                    else begin

                        MpesaActivity.PostMpesaDepositsTransaction('');
                    end;


                end
                else begin

                    MTrans.Reset();
                    MTrans.SetRange("Transaction ID", TransID);
                    if MTrans.FindFirst() then begin
                        if "TransactionType" = "TransactionType"::"Mpesa Deposit" then
                            MpesaActivity.PostMpesaDepositsTransaction(MTrans."Transaction ID");
                    end;
                end;




            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("TransactionType"; "TransactionType")
                    {
                        ApplicationArea = All;
                    }
                    field(TransID; TransID)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        MpesaActivity: Codeunit "Mpesa Activities";
        "TransactionType": enum "Sky M-Banking Trans Types";
        TransID: Code[20];

}
