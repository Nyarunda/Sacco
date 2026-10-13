tableextension 50501 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50100; "LPO No."; Code[20])
        {
            Caption = 'LPO No.';
            DataClassification = CustomerContent;
            TableRelation = "LPO/LSO Header";
        }
        field(50101; "External Requisition No."; Code[20])
        {
            Caption = 'External Requisition No.';
            DataClassification = CustomerContent;
            TableRelation = "External Requisition Header";
        }
        field(50102; "Procurement Status"; Option)
        {
            Caption = 'Procurement Status';
            OptionMembers = " ","Pending Approval","Approved","Rejected";
            OptionCaption = ' ,Pending Approval,Approved,Rejected';
            DataClassification = CustomerContent;
        }
    }
    fieldgroups
    {
       
        addlast(DropDown; "Posting Description") { }
    }
}
