namespace CentralDB.CentralDB;

report 50489 "Sky SMS"
{
    Caption = 'Sky SMS';
    ProcessingOnly = true;
    dataset
    {
        dataitem(SkySMSMessages; "Sky SMS Messages")
        {
            DataItemTableView = where(Sent = const(false));
            trigger OnAfterGetRecord()

            var
                myInt: Integer;
                Dispatch: Codeunit SMSDispatcher;
            begin
                Dispatch.SendSMS(transaction_id);
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
