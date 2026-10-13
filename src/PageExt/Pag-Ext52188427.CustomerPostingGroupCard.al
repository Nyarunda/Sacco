/// <summary>
/// PageExtension Customer Posting Group Card (ID 50019) extends Record Customer Posting Group Card.
/// </summary>
pageextension 50019 "Customer Posting Group Card" extends "Customer Posting Group Card"
{
    layout
    {
        addafter("Receivables Account")
        {
            field("Payables Account"; Rec."Payables Account")
            {
                ApplicationArea = Basic;
            }
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = Basic;
            }
        }

    }
}
