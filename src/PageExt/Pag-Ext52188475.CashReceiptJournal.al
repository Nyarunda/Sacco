namespace UnitedWomen.UnitedWomen;

using Microsoft.Finance.GeneralLedger.Journal;

pageextension 50138 "Cash Receipt Journal" extends "Cash Receipt Journal"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = Basic, Suite;
                Editable = true;
            }
        }
    }
}
