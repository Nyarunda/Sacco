tableextension 50502 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50100; "External Requisition Line No."; Integer)
        {
            Caption = 'External Requisition Line No.';
            DataClassification = CustomerContent;
        }
        field(50101; "RFQ Line No."; Integer)
        {
            Caption = 'RFQ Line No.';
            DataClassification = CustomerContent;
        }
        field(50102; "Vendor Quotation No."; Code[20])
        {
            Caption = 'Vendor Quotation No.';
            DataClassification = CustomerContent;
            TableRelation = "Vendor Quotation Header";
        }
    }
}
