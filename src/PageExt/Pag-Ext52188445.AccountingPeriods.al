pageextension 50092 AccountingPeriods extends "Accounting Periods"
{

    layout
    {
        addafter("Date Locked")
        {
            field("Close Posting Period"; Rec."Close Posting Period")
            {
                ApplicationArea = Basic;
            }
            field("Posting Period Closed By"; Rec."Posting Period Closed By")
            {
                ApplicationArea = Basic;
            }
            field("Posting Period Date Closed"; Rec."Posting Period Date Closed")
            {
                ApplicationArea = Basic;
            }
            field("Posting Period Opened By"; Rec."Posting Period Opened By")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        addafter("C&lose Year")
        {
            action("Close User Posting Period")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                begin
                    if Confirm('Are you sure you want to Close Posting Period?') then begin

                        Rec."Close Posting Period" := true;
                        Rec."Posting Period Closed By" := UserId;
                        Rec."Posting Period Date Closed" := Today;
                        Rec.Modify();
                        Message('Posting Date Closed');
                    end;
                end;
            }
            action("Open User Posting Period")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    TempAccountingPeriods: Record "Accounting Period" temporary;
                begin
                    if Confirm('Are you sure you want to Open Posting Period?') then begin


                        /*
                         CurrPage.PAGE.GetSelectedRecords(TempAccountingPeriods);

                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);

                        StatementBalance := 0;
                        CashBookBalance := 0;
                        if TempBankAccReconciliationLine.FindSet() then begin
                            repeat
                                StatementBalance += TempBankAccReconciliationLine."Statement Amount";
                            until TempBankAccReconciliationLine.Next() = 0;
                        end;
                        */


                        Rec."Close Posting Period" := false;
                        Rec."Posting Period Opened By" := UserId;
                        Rec.Modify();
                        Message('Posting Date Opened');
                    end;
                end;
            }
        }
    }
}
