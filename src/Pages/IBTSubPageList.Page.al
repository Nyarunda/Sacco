Page 50510 "IBT List"
{
    CardPageID = "IBT Page Card";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "IBT Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccount; Rec."Paying Account")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountName; Rec."Paying Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountCurrencyCode; Rec."Paying Account Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountBalance; Rec."Paying Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountBalanceLCY; Rec."Paying Account Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountBankNo; Rec."Paying Account Bank No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoTransfer; Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoTransferLCY; Rec."Amount to Transfer (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(ExchangeRate; Rec."Exchange Rate")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeDocNo; Rec."Cheque / Doc. No")
                {
                    ApplicationArea = Basic;
                }
                field(TransferReleaseDate; Rec."Transfer Release Date")
                {
                    ApplicationArea = Basic;
                }
                field(TotalLinesAmountLCY; Rec."Total Lines Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountMaxCredit; Rec."Paying Account Max. Credit")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

}

