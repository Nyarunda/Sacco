
PageExtension 50208 pageextension50092 extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

