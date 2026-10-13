codeunit 50148 "Member Notification Management"
{
    Description = 'Handles member notification management';

    procedure CreateNotification(MemberNo: Code[20]; Title: Text[100]; Content: Text[250]; Category: Option "General","Account","Loan","Transaction","System","Important"; LinkText: Text[50]; LinkURL: Text[250]; ExpiryDays: Integer): Integer
    var
        MemberNotification: Record "Member Notifications";
    begin
        // Initialize a new notification record
        MemberNotification.Init();
        MemberNotification."Member No." := MemberNo;
        MemberNotification.Title := Title;
        MemberNotification.Content := Content;
        MemberNotification.Category := Category;
        MemberNotification."Link Text" := LinkText;
        MemberNotification."Link URL" := LinkURL;

        // Set expiry date if specified
        if ExpiryDays > 0 then
            MemberNotification."Expiry Date" := CreateDateTime(CalcDate('<+' + Format(ExpiryDays) + 'D>', Today), Time);

        // Insert will trigger OnInsert which sets Created Date and Created By
        MemberNotification.Insert(true);

        exit(MemberNotification."Entry No.");
    end;

    procedure CreateSystemNotification(MemberNo: Code[20]; Title: Text[100]; Content: Text[250]; LinkText: Text[50]; LinkURL: Text[250]): Integer
    begin
        // Create a system notification with 60-day expiry
        exit(CreateNotification(MemberNo, Title, Content, 4, LinkText, LinkURL, 60));
    end;

    procedure CreateImportantNotification(MemberNo: Code[20]; Title: Text[100]; Content: Text[250]; LinkText: Text[50]; LinkURL: Text[250]): Integer
    begin
        // Create an important notification with 30-day expiry
        exit(CreateNotification(MemberNo, Title, Content, 5, LinkText, LinkURL, 30));
    end;

    procedure MarkAsRead(MemberNo: Code[20]; EntryNo: Integer)
    var
        MemberNotification: Record "Member Notifications";
    begin
        if MemberNotification.Get(EntryNo) then
            if MemberNotification."Member No." = MemberNo then begin
                MemberNotification."Is Read" := true;
                MemberNotification.Modify(true);
            end;
    end;

    procedure DeleteExpiredNotifications()
    var
        MemberNotification: Record "Member Notifications";
    begin
        MemberNotification.SetFilter("Expiry Date", '<%1', CurrentDateTime);
        MemberNotification.DeleteAll(true);
    end;

    procedure GetUnreadCount(MemberNo: Code[20]): Integer
    var
        MemberNotification: Record "Member Notifications";
    begin
        MemberNotification.SetRange("Member No.", MemberNo);
        MemberNotification.SetRange("Is Read", false);
        MemberNotification.SetFilter("Expiry Date", '>=%1', CurrentDateTime);
        exit(MemberNotification.Count);
    end;
}
