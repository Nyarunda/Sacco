report 50054 "Session Events"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Session Events.rdlc';

    dataset
    {
        dataitem("Session Event"; "Session Event")
        {
            RequestFilterFields = "User SID", "Event Datetime", "Client Type";
            column(UserSID_SessionEvent; "Session Event"."User SID")
            {
            }
            column(ServerInstanceID_SessionEvent; "Session Event"."Server Instance ID")
            {
            }
            column(SessionID_SessionEvent; "Session Event"."Session ID")
            {
            }
            column(EventType_SessionEvent; "Session Event"."Event Type")
            {
            }
            column(EventDatetime_SessionEvent; "Session Event"."Event Datetime")
            {
            }
            column(ClientType_SessionEvent; "Session Event"."Client Type")
            {
            }
            column(DatabaseName_SessionEvent; "Session Event"."Database Name")
            {
            }
            column(ClientComputerName_SessionEvent; "Session Event"."Client Computer Name")
            {
            }
            column(UserID_SessionEvent; "Session Event"."User ID")
            {
            }
            column(Comment_SessionEvent; "Session Event".Comment)
            {
            }
            column(SessionUniqueID_SessionEvent; "Session Event"."Session Unique ID")
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

