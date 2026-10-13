tableextension 50100 "Invetory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        field(90000; "Item Jnl Template"; Code[20])
        {
            Caption = 'Item Jnl Template';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template".Name where(Type = const(Item));
        }
        field(50013; "Item Jnl Batch"; Code[20])
        {
            Caption = 'Item Jnl Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Item Jnl Template"));
        }
    }
}
