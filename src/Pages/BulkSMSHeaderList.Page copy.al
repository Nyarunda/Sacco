Page 50586 "Posted Bulk SMS Header List"
{
    CardPageID = "Bulk SMS Header";
    Editable = false;
    PageType = List;
    SourceTable = "Bulk SMS Header";
    SourceTableView = where("SMS Status" = filter(Sent));
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Message; Rec.Message_)
                {
                    ApplicationArea = Basic;
                }
                field(SMSType; Rec."SMS Type")
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field(SMSStatus; Rec."SMS Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

