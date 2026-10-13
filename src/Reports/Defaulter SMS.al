report 50525 "Defaulter SMS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Layouts/Defaulter SMS.rdlc';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = WHERE(Posted = FILTER(true));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Employer Code";

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                CompInfo.GET;
            end;

            trigger OnAfterGetRecord()
            var
                Sms: Text;
            begin
                Loans.CALCFIELDS("Loans Category-SASRA", "Outstanding Principal");
                IF (Loans."Loans Category-SASRA" <> Loans."Loans Category-SASRA"::Performing) AND
                  (Loans."Loans Category-SASRA" <> Loans."Loans Category-SASRA"::Watch) THEN BEGIN
                    Members.GET(Loans."Member No.");
                    Sms := 'Dear ' + Loans."Member Name" + ', This is to notify you that the ' + Loans."Loan Product Type Name" + ' that you are currently repaying '
                    + 'has been defaulted in payment. Kindly Contact ' + CompInfo.Name + ' for further details';

                    InsertLoanReminderNotification(Sms);
                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('COMPLETED');
            end;
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

    trigger OnInitReport()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE(StatusPermission."User ID", USERID);
        StatusPermission.SETRANGE(StatusPermission."SASRA Report", TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You Do Not have Permission to perform this action');
        END;
    end;

    var
        LoanGua: Record "Loan Security";
        Members: Record Members;
        Loan: Record Loans;
        CompInfo: Record "Company Information";
        UseDate: Date;
        StatusPermission: Record "User Setup";

    local procedure InsertLoanReminderNotification(Sms: Text)
    var
        LoanReminderNotification: Record "Loan Reminder Notifications";
    begin
        LoanReminderNotification.Reset();
        LoanReminderNotification.SetRange("Loan No.", Loans."Loan No.");
        LoanReminderNotification.SetRange("Member No", Loans."Member No.");
        LoanReminderNotification.SetRange("Date Sent", Today());
        LoanReminderNotification.SetRange(Status, LoanReminderNotification.Status::Open);
        LoanReminderNotification.SetRange("Notification Type", LoanReminderNotification."Notification Type"::SMS);
        if LoanReminderNotification.FindFirst() then
            exit;

        LoanReminderNotification.Init();
        LoanReminderNotification."Loan No." := Loans."Loan No.";
        LoanReminderNotification."Member No" := Loans."Member No.";
        LoanReminderNotification.Name := CopyStr(Loans."Member Name", 1, MaxStrLen(LoanReminderNotification.Name));
        LoanReminderNotification."First Name" := CopyStr(GetFirstName(Loans."Member Name"), 1, MaxStrLen(LoanReminderNotification."First Name"));
        LoanReminderNotification."Date Sent" := Today();
        LoanReminderNotification.Status := LoanReminderNotification.Status::Open;
        LoanReminderNotification.Message := CopyStr(Sms, 1, MaxStrLen(LoanReminderNotification.Message));
        LoanReminderNotification."Notification Type" := LoanReminderNotification."Notification Type"::SMS;
        LoanReminderNotification."Expected Date" := Today();
        LoanReminderNotification."Amount Due" := Loans."Outstanding Principal";
        LoanReminderNotification.Insert(true);
    end;

    local procedure GetFirstName(MemberName: Text): Text
    var
        SpacePosition: Integer;
    begin
        SpacePosition := StrPos(MemberName, ' ');
        if SpacePosition > 1 then
            exit(CopyStr(MemberName, 1, SpacePosition - 1));

        exit(MemberName);
    end;
}
