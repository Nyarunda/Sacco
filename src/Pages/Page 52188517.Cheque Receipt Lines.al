
Page 50180 "Cheque Receipt Lines"
{
    PageType = ListPart;
    SourceTable = "Cheque Issue Lines_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChequeSerialNo; Rec."Cheque Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AvailableBalance; Rec."Available Balance")
                {
                    ApplicationArea = Basic;
                }
                field(UnpayCode; Rec."Un pay Code")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Cheque Setup";
                }
                field(Interpretation; Rec.Interpretation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UnpayDate; Rec."Unpay Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UnPayChargeAmount; Rec."Un Pay Charge Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CoopAccountNo; Rec."Coop Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateRefferenceNo; Rec."Date _Refference No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

