Page 50499 "IBT Lines"
{
    PageType = ListPart;
    SourceTable = "IBT Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(RecievingAccount; Rec."Recieving Account")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivingAccountName; Rec."Recieving Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivinAccountCurrencyCode; Rec."Recievin Account Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivingAccountBalance; Rec."Recieving Account Balance")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
                field(ReceivinAccountBalanceLCY; Rec."Receivin Account Balance (LCY)")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
                field(ReceivingAccountBankNo; Rec."Recieving Account Bank No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AmounttoReceive; Rec."Amount to Receive")
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoReceiveLCY; Rec."Amount to Receive (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(ExchangeRate; Rec."Exchange Rate")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalDocNo; Rec."External Doc No.")
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

