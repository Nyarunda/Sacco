TableExtension 50078 ApprovalEntry extends "Approval Entry"
{
    fields
    {

        field(50000; "Tracker ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval Tracker";
        }
        field(50001; "Document Rec ID to Approve"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Document Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Name; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Custom Document Type"; Enum "Custom Document Type")
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Rejected By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50007; Name2; Text[300])
        {
            DataClassification = ToBeClassified;
        }

    }
}

