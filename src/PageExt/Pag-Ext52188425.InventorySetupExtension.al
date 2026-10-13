/// <summary>
/// PageExtension Inventory Setup Extension (ID 50100) extends Record Inventory Setup.
/// </summary>
pageextension 50100 "Inventory Setup Extension" extends "Inventory Setup"
{
    layout
    {
        addafter("Inbound Whse. Handling Time")
        {
            field("Item Jnl Template"; Rec."Item Jnl Template")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Item Jnl Batch"; Rec."Item Jnl Batch")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
