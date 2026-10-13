codeunit 50132 SMTP
{

    procedure SendCustomEmail(from: Text; recipient: Text; cc: Text; bcc: Text; subject: Text; body: Text; attachmentPath: Text; var Msg: Text) Success: boolean;
    var
        SMTPAccount: Record "Custom SMTP Setup";
    //CustomEmailSender: DotNet EmailServiceProject;


    begin
        SMTPAccount.Get;
        //CustomEmailSender := CustomEmailSender.EmailService();


        /* Success := CustomEmailSender.SendEmail(
         SMTPAccount."SMTP Server",
         format(SMTPAccount."SMTP Server Port"),
         SMTPAccount."User ID",
         SMTPAccount."Password Key",
         recipient,
         subject,
         body,
         Msg,
         cc, bcc, attachmentPath, 'true');
         */
        //Ezra

        //IF Success THEN
        //  MESSAGE('Email sent successfully: %1', Msg)
        //ELSE
        //  MESSAGE('Failed to send email: %1', Msg);


    end;

    // Helper function to check if a Text variable is null or empty
    local procedure IsNullOrEmpty(value: Text): Boolean
    begin
        exit(value = '');
    end;

}
