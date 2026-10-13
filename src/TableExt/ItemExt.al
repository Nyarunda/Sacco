tableextension 50500 "Item Ext" extends Item
{
    fields
    {
        field(50100; "Store Location"; Code[10])
        {
            Caption = 'Store Location';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(50101; "Stock Tracking Enabled"; Boolean)
        {
            Caption = 'Stock Tracking Enabled';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(50102; "Procurement Category"; Code[20])
        {
            Caption = 'Procurement Category';
            DataClassification = CustomerContent;
        }
    }
}
