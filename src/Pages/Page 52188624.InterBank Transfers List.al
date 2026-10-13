
Page 50287 "InterBank Transfers List"
{
    CardPageID = "Bank & Cash Transfer Request";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Inter-Bank Transfers";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(SourceTransferType; Rec."Source Transfer Type")
                {
                    ApplicationArea = Basic;
                }
                field(PayingBankAccountName; Rec."Paying  Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivingTransferType; Rec."Receiving Transfer Type")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivingBankAccountName; Rec."Receiving Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(CurrencyCodeDestination; Rec."Currency Code Destination")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(CancelledBy; Rec."Cancelled By")
                {
                    ApplicationArea = Basic;
                }
                field(TimeCancelled; Rec."Time Cancelled")
                {
                    ApplicationArea = Basic;
                }
                field(DateCancelled; Rec."Date Cancelled")
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
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    begin

        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Reciept Responsibility Center",UserMgt.GetPurchasesFilter());
        //  setrange("global Dimension 2 Code",UserMgt.GetSetDimensions(userid,2));
          FILTERGROUP(0);
        END;
        */

    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
    end;
}

