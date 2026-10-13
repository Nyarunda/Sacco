Page 50416 "Sky SMS Messages"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky SMS Messages";
    SourceTableView = sorting(date_created)
                      order(descending)
                      where(msg_category = filter(<> 'MOBILE_PIN'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(transaction_id; Rec.transaction_id)
                {
                    ApplicationArea = Basic;
                }
                field(msg_status_code; Rec.msg_status_code)
                {
                    ApplicationArea = Basic;
                }
                field(msg_result_submit_status; Rec.msg_result_submit_status)
                {
                    ApplicationArea = Basic;
                }
                field(msg_status_description; Rec.msg_status_description)
                {
                    ApplicationArea = Basic;
                }
                field(receiver; Rec.receiver)
                {
                    ApplicationArea = Basic;
                }
                field(msg; Rec.msg)
                {
                    ApplicationArea = Basic;
                }
                field(msgpriority; Rec.msg_priority)
                {
                    ApplicationArea = Basic;
                }
                field(SMSDate; Rec."SMS Date")
                {
                    ApplicationArea = Basic;
                }
                field(datecreated; Rec.date_created)
                {
                    ApplicationArea = Basic;
                }
                field(msg_category; Rec.msg_category)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendSMS)
            {
                trigger OnAction()
                var
                    myInt: Integer;
                    Dispatch: Codeunit SMSDispatcher;
                begin
                    if Confirm('Are you sure you want to send this sms?') then begin
                        Rec.testfield(Sent, false);
                        Dispatch.SendSMS(Rec.transaction_id);
                    end;

                end;

            }
        }
    }
}

