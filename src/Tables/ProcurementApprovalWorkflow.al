table 50506 "Procurement Approval Workflow"
{
    Caption = 'Procurement Approval Workflow';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Workflow Type"; Option)
        {
            Caption = 'Workflow Type';
            OptionMembers = "Store Requisition","External Requisition","LPO/LSO";
            OptionCaption = 'Store Requisition,External Requisition,LPO/LSO';
            DataClassification = CustomerContent;
        }
        field(2; "Approval Level"; Integer)
        {
            Caption = 'Approval Level';
            DataClassification = CustomerContent;
        }
        field(3; "Approver Type"; Option)
        {
            Caption = 'Approver Type';
            OptionMembers = "Finance Manager","Procurement Committee","Board","User";
            OptionCaption = 'Finance Manager,Procurement Committee,Board,User';
            DataClassification = CustomerContent;
        }
        field(4; "Approver User ID"; Code[50])
        {
            Caption = 'Approver User ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(5; "Threshold From"; Decimal)
        {
            Caption = 'Threshold From';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(6; "Threshold To"; Decimal)
        {
            Caption = 'Threshold To';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "Workflow Type", "Approval Level")
        {
            Clustered = true;
        }
    }
}
