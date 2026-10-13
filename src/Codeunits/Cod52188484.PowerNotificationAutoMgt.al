namespace UnitedWomen.UnitedWomen;

using System.Email;
using System.Security.User;

codeunit 50147 "Power Notification Auto Mgt."
{

    procedure NotifyResponsibilityCenterUsers(
        EventCode: Code[50];
        ReferenceNo: Code[20];
        ResponsibilityCenter: Code[10];
        SubjectTxt: Text[250];
        BodyTxt: Text)
    begin
        if ResponsibilityCenter = '' then
            Error('Responsibility Center must not be blank.');

        RaiseAutomationEvent(
            EventCode,
            ReferenceNo,
            '',
            ResponsibilityCenter,
            ResponsibilityCenter,
            0,
            SubjectTxt,
            StripHtml(BodyTxt));

        SendNotificationToUsersByResponsibilityCenter(
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyLoanApplicationSubmitted(
        LoanNo: Code[20];
        MemberNo: Code[20];
        MemberName: Text[100];
        ResponsibilityCenter: Code[10];
        Amount: Decimal)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Loan application submitted - %1', LoanNo);

        BodyTxt :=
            '<b>Loan Application Submitted</b><br><br>' +
            StrSubstNo('Loan No.: %1<br>', LoanNo) +
            StrSubstNo('Member No.: %1<br>', MemberNo) +
            StrSubstNo('Member Name: %1<br>', MemberName) +
            StrSubstNo('Amount: %1<br><br>', Format(Amount)) +
            'Please review and take the necessary action.';

        NotifyResponsibilityCenterUsers(
            'LOAN_APPLICATION_SUBMITTED',
            LoanNo,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyLoanApproved(
        LoanNo: Code[20];
        MemberNo: Code[20];
        MemberName: Text[100];
        ResponsibilityCenter: Code[10];
        Amount: Decimal)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Loan approved - %1', LoanNo);

        BodyTxt :=
            '<b>Loan Approved</b><br><br>' +
            StrSubstNo('Loan No.: %1<br>', LoanNo) +
            StrSubstNo('Member No.: %1<br>', MemberNo) +
            StrSubstNo('Member Name: %1<br>', MemberName) +
            StrSubstNo('Approved Amount: %1<br><br>', Format(Amount)) +
            'The loan application has been approved.';

        NotifyResponsibilityCenterUsers(
            'LOAN_APPROVED',
            LoanNo,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyLoanRejected(
        LoanNo: Code[20];
        MemberNo: Code[20];
        MemberName: Text[100];
        ResponsibilityCenter: Code[10];
        ReasonTxt: Text)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Loan rejected - %1', LoanNo);

        BodyTxt :=
            '<b>Loan Rejected</b><br><br>' +
            StrSubstNo('Loan No.: %1<br>', LoanNo) +
            StrSubstNo('Member No.: %1<br>', MemberNo) +
            StrSubstNo('Member Name: %1<br>', MemberName) +
            StrSubstNo('Reason: %1<br><br>', ReasonTxt);

        NotifyResponsibilityCenterUsers(
            'LOAN_REJECTED',
            LoanNo,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyLeaveRequestSubmitted(
        ApplicationCode: Code[20];
        StaffNo: Code[20];
        StaffName: Text[100];
        ResponsibilityCenter: Code[10];
        LeaveType: Code[20];
        DaysApplied: Decimal)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Leave request submitted - %1', ApplicationCode);

        BodyTxt :=
            '<b>Leave Request Submitted</b><br><br>' +
            StrSubstNo('Application Code: %1<br>', ApplicationCode) +
            StrSubstNo('Staff No.: %1<br>', StaffNo) +
            StrSubstNo('Staff Name: %1<br>', StaffName) +
            StrSubstNo('Leave Type: %1<br>', LeaveType) +
            StrSubstNo('Days Applied: %1<br><br>', Format(DaysApplied)) +
            'Please review the leave request.';

        NotifyResponsibilityCenterUsers(
            'LEAVE_REQUEST_SUBMITTED',
            ApplicationCode,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyLeaveApproved(
        ApplicationCode: Code[20];
        StaffNo: Code[20];
        StaffName: Text[100];
        ResponsibilityCenter: Code[10];
        DaysApproved: Decimal)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Leave approved - %1', ApplicationCode);

        BodyTxt :=
            '<b>Leave Approved</b><br><br>' +
            StrSubstNo('Application Code: %1<br>', ApplicationCode) +
            StrSubstNo('Staff No.: %1<br>', StaffNo) +
            StrSubstNo('Staff Name: %1<br>', StaffName) +
            StrSubstNo('Days Approved: %1<br><br>', Format(DaysApproved));

        NotifyResponsibilityCenterUsers(
            'LEAVE_APPROVED',
            ApplicationCode,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyOvertimeSubmitted(
        ApplicationCode: Code[20];
        StaffNo: Code[20];
        StaffName: Text[100];
        ResponsibilityCenter: Code[10];
        TotalHours: Decimal;
        ConvertToTxt: Text)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Overtime request submitted - %1', ApplicationCode);

        BodyTxt :=
            '<b>Overtime Request Submitted</b><br><br>' +
            StrSubstNo('Application Code: %1<br>', ApplicationCode) +
            StrSubstNo('Staff No.: %1<br>', StaffNo) +
            StrSubstNo('Staff Name: %1<br>', StaffName) +
            StrSubstNo('Total Hours: %1<br>', Format(TotalHours)) +
            StrSubstNo('Convert To: %1<br><br>', ConvertToTxt) +
            'Please review the overtime request.';

        NotifyResponsibilityCenterUsers(
            'OVERTIME_SUBMITTED',
            ApplicationCode,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyOvertimePostedToLeave(
        ApplicationCode: Code[20];
        StaffNo: Code[20];
        StaffName: Text[100];
        ResponsibilityCenter: Code[10];
        LeaveDaysEarned: Decimal)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Overtime posted to leave - %1', ApplicationCode);

        BodyTxt :=
            '<b>Overtime Posted To Leave</b><br><br>' +
            StrSubstNo('Application Code: %1<br>', ApplicationCode) +
            StrSubstNo('Staff No.: %1<br>', StaffNo) +
            StrSubstNo('Staff Name: %1<br>', StaffName) +
            StrSubstNo('Leave Days Earned: %1<br><br>', Format(LeaveDaysEarned));

        NotifyResponsibilityCenterUsers(
            'OVERTIME_POSTED_TO_LEAVE',
            ApplicationCode,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyCollectionReminder(
        LoanNo: Code[20];
        MemberNo: Code[20];
        MemberName: Text[100];
        ResponsibilityCenter: Code[10];
        ArrearsAmount: Decimal;
        DaysInArrears: Integer)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Collection reminder - Loan %1', LoanNo);

        BodyTxt :=
            '<b>Collection Reminder</b><br><br>' +
            StrSubstNo('Loan No.: %1<br>', LoanNo) +
            StrSubstNo('Member No.: %1<br>', MemberNo) +
            StrSubstNo('Member Name: %1<br>', MemberName) +
            StrSubstNo('Arrears Amount: %1<br>', Format(ArrearsAmount)) +
            StrSubstNo('Days in Arrears: %1<br><br>', Format(DaysInArrears)) +
            'Please follow up on this account.';

        NotifyResponsibilityCenterUsers(
            'COLLECTION_REMINDER',
            LoanNo,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyProcessFailed(
        ProcessName: Text[100];
        DocumentNo: Code[20];
        ResponsibilityCenter: Code[10];
        ErrorMessage: Text)
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Process failed - %1', ProcessName);

        BodyTxt :=
            '<b>Process Failed</b><br><br>' +
            StrSubstNo('Process: %1<br>', ProcessName) +
            StrSubstNo('Document No.: %1<br>', DocumentNo) +
            StrSubstNo('Error: %1<br><br>', ErrorMessage) +
            'Please review and resolve the issue.';

        NotifyResponsibilityCenterUsers(
            'PROCESS_FAILED',
            DocumentNo,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyReportReady(
        ReportName: Text[100];
        ResponsibilityCenter: Code[10];
        PeriodTxt: Text[100])
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        SubjectTxt := StrSubstNo('Report ready - %1', ReportName);

        BodyTxt :=
            '<b>Report Ready</b><br><br>' +
            StrSubstNo('Report: %1<br>', ReportName) +
            StrSubstNo('Period: %1<br><br>', PeriodTxt) +
            'The report has been generated successfully.';

        NotifyResponsibilityCenterUsers(
            'REPORT_READY',
            '',
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    procedure NotifyFinanceOfExitNotice(ExitNo: Code[20]; ResponsibilityCenter: Code[10])
    var
        SubjectTxt: Text[250];
        BodyTxt: Text;
    begin
        if ExitNo = '' then
            Error('Exit No. must not be blank.');

        SubjectTxt := StrSubstNo('MEMBER EXIT NOTICE SUBMITTED - %1', ExitNo);

        BodyTxt :=
            'Dear Finance Team,<br/><br/>' +
            StrSubstNo('A member exit notice <b>%1</b> has been submitted and is pending your review and processing.<br/><br/>', ExitNo) +
            'Kindly log into the system to review the details and take the necessary actions.<br/><br/>' +
            'Best Regards,<br/>' +
            CompanyName + ' Customer Service Team';

        NotifyResponsibilityCenterUsers(
            'MEMBER_EXIT_NOTICE_SUBMITTED',
            ExitNo,
            ResponsibilityCenter,
            SubjectTxt,
            BodyTxt);
    end;

    local procedure SendNotificationToUsersByResponsibilityCenter(
        ResponsibilityCenter: Code[10];
        SubjectTxt: Text[250];
        BodyTxt: Text)
    var
        UserSetup: Record "User Setup";
        RecipientEmail: Text;
        SentCount: Integer;
    begin
        if ResponsibilityCenter = '' then
            exit;

        UserSetup.Reset();
        UserSetup.SetRange("Responsibility Center", ResponsibilityCenter);
        UserSetup.SetRange("Receive Notifications", true);
        UserSetup.SetFilter("E-Mail", '<>%1', '');

        if UserSetup.FindSet() then
            repeat
                RecipientEmail := UserSetup."E-Mail";

                if RecipientEmail <> '' then
                    if TrySendEmail(RecipientEmail, SubjectTxt, BodyTxt) then
                        SentCount += 1;
            until UserSetup.Next() = 0;

        if SentCount = 0 then
            Error(
                'No notification recipient was found in User Setup for Responsibility Center %1. Ensure Receive Notifications is ticked and E-Mail is filled.',
                ResponsibilityCenter);
    end;

    [TryFunction]
    local procedure TrySendEmail(RecipientEmail: Text; SubjectTxt: Text[250]; BodyTxt: Text)
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
    begin
        Recipients.Add(RecipientEmail);

        EmailMsg.Create(Recipients, SubjectTxt, BodyTxt, true);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;

    local procedure RaiseAutomationEvent(
        EventCode: Code[50];
        ReferenceNo: Code[20];
        EntityNo: Code[20];
        EntityName: Text[100];
        AssignedUserId: Code[50];
        Amount: Decimal;
        SubjectTxt: Text[250];
        BodyTxt: Text)
    begin
        OnSaccoNotificationAutomationEvent(
            EventCode,
            ReferenceNo,
            EntityNo,
            EntityName,
            AssignedUserId,
            Amount,
            SubjectTxt,
            BodyTxt,
            CurrentDateTime,
            UserId);
    end;

    [BusinessEvent(false)]
    local procedure OnSaccoNotificationAutomationEvent(
        EventCode: Code[50];
        ReferenceNo: Code[20];
        EntityNo: Code[20];
        EntityName: Text[100];
        AssignedUserId: Code[50];
        Amount: Decimal;
        Subject: Text[250];
        Body: Text;
        EventDateTime: DateTime;
        TriggeredBy: Code[50])
    begin
    end;

    local procedure StripHtml(Value: Text): Text
    begin
        Value := Value.Replace('<br>', '\');
        Value := Value.Replace('<br/>', '\');
        Value := Value.Replace('<br />', '\');
        Value := Value.Replace('<br/>', '\');
        Value := Value.Replace('<b>', '');
        Value := Value.Replace('</b>', '');
        Value := Value.Replace('&nbsp;', ' ');

        exit(Value);
    end;
}