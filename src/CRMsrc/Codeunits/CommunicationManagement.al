codeunit 50001 "Communication Management"
{
    procedure SendTicketEmail(TicketHeader: Record "Ticket Header")
    var
        Customer: Record "CRM Customer";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        if Customer.Get(TicketHeader."Customer No.") then begin
            Subject := StrSubstNo('Ticket %1: %2', TicketHeader."No.", TicketHeader.Title);
            Body := BuildEmailBody(TicketHeader);

            EmailMessage.Create(Customer.Email, Subject, Body, true);
            Email.Send(EmailMessage);

            LogCommunication(TicketHeader."No.", 'Email', Customer.Email, Subject);
        end;
    end;

    procedure SendTicketSMS(TicketHeader: Record "Ticket Header")
    var
        Customer: Record "CRM Customer";
        SMSProvider: Codeunit "SMS Provider";
        Message: Text;
    begin
        if Customer.Get(TicketHeader."Customer No.") then begin
            if Customer."Phone No." <> '' then begin
                Message := StrSubstNo('Ticket %1 Status: %2. For details visit our portal.',
                    TicketHeader."No.", Format(TicketHeader.Status));

                SMSProvider.SendSMS(Customer."Phone No.", Message);
                LogCommunication(TicketHeader."No.", 'SMS', Customer."Phone No.", Message);
            end;
        end;
    end;

    procedure SendWelcomeEmail(Customer: Record "CRM Customer")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        Subject := 'Welcome to Our CRM System';
        Body := BuildWelcomeEmailBody(Customer);

        EmailMessage.Create(Customer.Email, Subject, Body, true);
        Email.Send(EmailMessage);
    end;

    local procedure BuildEmailBody(TicketHeader: Record "Ticket Header"): Text
    var
        Customer: Record "CRM Customer";
        Body: Text;
    begin
        Customer.Get(TicketHeader."Customer No.");

        Body := 'Dear ' + Customer.Name + ',<br><br>';
        Body += 'This is an update regarding your ticket:<br><br>';
        Body += '<strong>Ticket Number:</strong> ' + TicketHeader."No." + '<br>';
        Body += '<strong>Title:</strong> ' + TicketHeader.Title + '<br>';
        Body += '<strong>Status:</strong> ' + Format(TicketHeader.Status) + '<br>';
        Body += '<strong>Priority:</strong> ' + Format(TicketHeader.Priority) + '<br>';
        Body += '<strong>Created:</strong> ' + Format(TicketHeader."Created DateTime") + '<br><br>';

        if TicketHeader.Description <> '' then
            Body += '<strong>Description:</strong><br>' + TicketHeader.Description + '<br><br>';

        Body += 'Thank you for your patience.<br><br>';
        Body += 'Best regards,<br>Support Team';

        exit(Body);
    end;

    local procedure BuildWelcomeEmailBody(Customer: Record "CRM Customer"): Text
    var
        Body: Text;
    begin
        Body := 'Dear ' + Customer.Name + ',<br><br>';
        Body += 'Welcome to our Customer Relationship Management system!<br><br>';
        Body += 'Your customer number is: <strong>' + Customer."No." + '</strong><br><br>';
        Body += 'You can now access our support portal to:<br>';
        Body += '• Create and track support tickets<br>';
        Body += '• View your account information<br>';
        Body += '• Access knowledge base articles<br><br>';
        Body += 'If you have any questions, please don''t hesitate to contact us.<br><br>';
        Body += 'Best regards,<br>Customer Support Team';

        exit(Body);
    end;

    local procedure LogCommunication(TicketNo: Code[20]; CommunicationType: Text[20]; Recipient: Text[80]; MessageContent: Text[250])
    var
        CommunicationLog: Record "Communication Log";
    begin
        CommunicationLog.Init();
        CommunicationLog."Ticket No." := TicketNo;
        CommunicationLog."Communication Type" := CommunicationType;
        CommunicationLog.Recipient := Recipient;
        CommunicationLog."Message Content" := MessageContent;
        CommunicationLog."Sent DateTime" := CurrentDateTime();
        CommunicationLog."Sent By" := UserId();
        CommunicationLog.Insert();
    end;
}