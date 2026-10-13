Page 50497 "Posted IBT Page Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "IBT Header";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            group(General)
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
                field(PayingAccountMaxCredit; Rec."Paying Account Max. Credit")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control24; "IBT Lines")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }


    actions
    {
        area(processing)
        {


            action("Print ")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Category7;
                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"Interbank List Report", true, true, Rec);
                    Rec.Reset;
                end;
            }
        }
    }

}

