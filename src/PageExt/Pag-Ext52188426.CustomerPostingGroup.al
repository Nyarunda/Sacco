/// <summary>
/// PageExtension Customer Posting Group (ID 50018) extends Record Customer Posting Groups.
/// </summary>
pageextension 50018 "Customer Posting Group" extends "Customer Posting Groups"
{
    layout
    {
        addafter("Receivables Account")
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = Basic;
            }
        }

    }

}

