
PageExtension 50084 pageextension50084 extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Credit Amount")
        {
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = Basic;
            }
            field("Loan No."; Rec."Loan No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

