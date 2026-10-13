page 50058 "Loan Reminder Notifications"
{
    ApplicationArea = All;
    Caption = 'Loan Arrears Reminder Notifications';
    PageType = List;
    SourceTable = "Loan Reminder Notifications";
    SourceTableView = where(Status = const(Open));
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    Permissions = tabledata "Loan Reminder Notifications" = rimd;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';

                field(AsAtDate; AsAtDate)
                {
                    ApplicationArea = All;
                    Caption = 'As At Date';
                    Editable = true;
                    ToolTip = 'Specifies the date to use when calculating loan arrears for generated reminders.';
                }
            }

            repeater(General)
            {
                Editable = false;

                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Expected Date"; Rec."Expected Date")
                {
                    ApplicationArea = All;
                }
                field("Amount Due"; Rec."Amount Due")
                {
                    ApplicationArea = All;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Notification Type"; Rec."Notification Type")
                {
                    ApplicationArea = All;
                }
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(GenerateArrearsMessages)
            {
                ApplicationArea = All;
                Caption = 'Generate Messages';
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generates open loan reminder notification messages from defaulter loans.';

                trigger OnAction()
                var
                    GeneratedCount: Integer;
                begin
                    if AsAtDate = 0D then
                        AsAtDate := WorkDate();

                    if not Confirm('Generate open loan reminder notification messages now?', false) then
                        exit;

                    GeneratedCount := GenerateLoanReminderMessages(AsAtDate);
                    Message('%1 loan reminder message(s) generated as at %2.', GeneratedCount, AsAtDate);
                    CurrPage.Update(false);
                end;
            }

            action(DeleteGeneratedMessages)
            {
                ApplicationArea = All;
                Caption = 'Delete Generated Messages';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Deletes the currently filtered open loan reminder notification messages.';

                trigger OnAction()
                var
                    LoanReminderNotification: Record "Loan Reminder Notifications";
                    DeletedCount: Integer;
                begin
                    LoanReminderNotification.Copy(Rec);
                    LoanReminderNotification.SetRange(Status, LoanReminderNotification.Status::Open);

                    DeletedCount := LoanReminderNotification.Count();
                    if DeletedCount = 0 then begin
                        Message('There are no open generated loan reminder messages to delete.');
                        exit;
                    end;

                    if not Confirm('%1 open generated loan reminder message(s) will be deleted. Continue?', false, DeletedCount) then
                        exit;

                    LoanReminderNotification.DeleteAll();
                    Message('%1 generated loan reminder message(s) deleted.', DeletedCount);
                    CurrPage.Update(false);
                end;
            }

            action(SendReminders)
            {
                ApplicationArea = All;
                Caption = 'Send Notifications';
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Sends open loan reminder notifications by SMS, email, or both and marks them as sent or failed.';

                trigger OnAction()
                var
                    SMSLogs: Record "Loan Reminder Notifications";
                    Window: Dialog;
                    TotalCount: Integer;
                    ProcessedCount: Integer;
                    SentCount: Integer;
                    FailedCount: Integer;
                    DeliveryOption: Integer;
                    DeliveryCaption: Text;
                begin
                    DeliveryOption := StrMenu('Send SMS,Send Email,Send SMS & Email', 1, 'Select the delivery method to process.');
                    if DeliveryOption = 0 then
                        exit;

                    SMSLogs.Reset();
                    SMSLogs.SetCurrentKey("Entry No");
                    SMSLogs.SetRange(Status, SMSLogs.Status::Open);
                    case DeliveryOption of
                        1:
                            begin
                                //SMSLogs.SetRange("Notification Type", SMSLogs."Notification Type"::SMS);
                                DeliveryCaption := 'SMS';
                            end;
                        2:
                            begin
                                //SMSLogs.SetRange("Notification Type", SMSLogs."Notification Type"::Email);
                                DeliveryCaption := 'email';
                            end;
                        3:
                            begin
                                //SMSLogs.SetRange("Notification Type", SMSLogs."Notification Type"::"SMS & Email");
                                DeliveryCaption := 'SMS & email';
                            end;
                    end;

                    TotalCount := SMSLogs.Count();
                    if TotalCount = 0 then begin
                        Message('There are no open %1 loan reminder notifications to send.', DeliveryCaption);
                        exit;
                    end;

                    if not Confirm('%1 open %2 reminder notification(s) will be sent. Continue?', false, TotalCount, DeliveryCaption) then
                        exit;

                    ProcessedCount := 0;
                    SentCount := 0;
                    FailedCount := 0;

                    Window.Open(
                        'Processing notifications...\' +
                        'Processed: #1#######\' +
                        'Total:     #2#######\' +
                        'Sent:      #3#######\' +
                        'Failed:    #4#######');

                    if SMSLogs.FindSet(true) then
                        repeat
                            ProcessedCount += 1;

                            if ProcessLoanReminderNotification(SMSLogs, DeliveryOption) then begin
                                SMSLogs.Status := SMSLogs.Status::Sent;
                                SMSLogs."Date Sent" := Today();
                                SMSLogs.Modify();
                                SentCount += 1;
                            end else begin
                                SMSLogs.Status := SMSLogs.Status::Failed;
                                SMSLogs.Modify();
                                FailedCount += 1;
                            end;

                            Window.Update(1, ProcessedCount);
                            Window.Update(2, TotalCount);
                            Window.Update(3, SentCount);
                            Window.Update(4, FailedCount);
                        until SMSLogs.Next() = 0;

                    Window.Close();
                    Message('Notification processing completed. Total: %1, Sent: %2, Failed: %3.', TotalCount, SentCount, FailedCount);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    local procedure ProcessLoanReminderNotification(SMSLogs: Record "Loan Reminder Notifications"; DeliveryOption: Integer): Boolean
    begin
        case DeliveryOption of
            1:
                exit(TrySendLoanReminderSms(SMSLogs.Message, SMSLogs."Member No", SMSLogs."Loan No."));
            2:
                exit(TrySendLoanReminderEmail(SMSLogs));
            3:
                begin
                    if not TrySendLoanReminderSms(SMSLogs.Message, SMSLogs."Member No", SMSLogs."Loan No.") then
                        exit(false);
                    exit(TrySendLoanReminderEmail(SMSLogs));
                end;
        end;

        exit(false);
    end;

    trigger OnOpenPage()
    begin
        if AsAtDate = 0D then
            AsAtDate := WorkDate();
    end;

    local procedure GenerateLoanReminderMessages(SelectedAsAtDate: Date): Integer
    var
        Loans: Record Loans;
        Member: Record Members;
        Window: Dialog;
        ArrearsAmount: Decimal;
        MonthlyRepayment: Decimal;
        TotalCount: Integer;
        ProcessedCount: Integer;
        GeneratedCount: Integer;
    begin
        Loans.Reset();
        Loans.SetRange(Posted, true);
        Loans.SetRange("Date Filter", 0D, SelectedAsAtDate);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        //Loans.SetRange("Member No.", '006128');
        TotalCount := Loans.Count();
        if TotalCount = 0 then
            exit(0);

        Window.Open(
            'Generating loan reminders...\' +
            'Processed: #1#######\' +
            'Total:     #2#######\' +
            'Generated: #3#######');

        if Loans.FindSet() then
            repeat
                ProcessedCount += 1;
                Loans.CalcFields("Loans Category-SASRA", "Total Outstanding Balance");

                ArrearsAmount := GetLoanArrearsAsAt(Loans, SelectedAsAtDate);
                MonthlyRepayment := GetMonthlyRepaymentAsAt(Loans, SelectedAsAtDate);
                if (ArrearsAmount >= MonthlyRepayment / 2) then
                    if Member.Get(Loans."Member No.") then begin
                        ArrearsAmount += 5000; // Add deposit contribution to arrears amount if arrears is more than 50% of monthly repayment
                        if InsertLoanReminderNotification(Loans, Member, ArrearsAmount, SelectedAsAtDate) then
                            GeneratedCount += 1;
                    end;

                Window.Update(1, ProcessedCount);
                Window.Update(2, TotalCount);
                Window.Update(3, GeneratedCount);
            until Loans.Next() = 0;

        Window.Close();
        exit(GeneratedCount);
    end;

    local procedure InsertLoanReminderNotification(Loan: Record Loans; Member: Record Members; ArrearsAmount: Decimal; AsAt: Date): Boolean
    var
        LoanReminderNotification: Record "Loan Reminder Notifications";
        ReminderMessage: Text;
    begin
        LoanReminderNotification.Reset();
        LoanReminderNotification.SetRange("Loan No.", Loan."Loan No.");
        LoanReminderNotification.SetRange("Member No", Loan."Member No.");
        LoanReminderNotification.SetRange("Date Sent", Today());
        LoanReminderNotification.SetRange(Status, LoanReminderNotification.Status::Open);
        LoanReminderNotification.SetRange("Notification Type", LoanReminderNotification."Notification Type"::SMS);
        if LoanReminderNotification.FindFirst() then
            exit(false);

        ReminderMessage := BuildLoanReminderSms(Loan, Member, ArrearsAmount, AsAt);

        LoanReminderNotification.Init();
        LoanReminderNotification."Loan No." := Loan."Loan No.";
        LoanReminderNotification."Member No" := Loan."Member No.";
        LoanReminderNotification.Name := CopyStr(Loan."Member Name", 1, MaxStrLen(LoanReminderNotification.Name));
        LoanReminderNotification."First Name" := CopyStr(GetFirstName(Loan."Member Name"), 1, MaxStrLen(LoanReminderNotification."First Name"));
        LoanReminderNotification."Date Sent" := Today();
        LoanReminderNotification.Status := LoanReminderNotification.Status::Open;
        LoanReminderNotification.Message := ReminderMessage;
        LoanReminderNotification."Notification Type" := LoanReminderNotification."Notification Type"::SMS;
        LoanReminderNotification."Expected Date" := AsAt;
        LoanReminderNotification."Amount Due" := ArrearsAmount;
        LoanReminderNotification.Insert(true);
        exit(true);
    end;

    local procedure BuildLoanReminderSms(Loan: Record Loans; Member: Record Members; ArrearsAmount: Decimal; AsAt: Date): Text
    var
        FirstName: Text;
        ProductName: Text;
        PenaltyDate: Date;
        NextInstallmentTxt: Text;
        NextInstallmentAmount: Decimal;
        NextInstallmentDueDate: Date;
    begin
        FirstName := GetFirstName(Member.Name);
        if FirstName = '' then
            FirstName := Member.Name;

        ProductName := Loan."Loan Product Type Name";
        if ProductName = '' then
            ProductName := Loan."Loan Product Type";

        PenaltyDate := CalcDate('14D', CalcDate('-CM', Today()));
        GetNextInstallmentInfo(Loan, AsAt, NextInstallmentTxt, NextInstallmentAmount, NextInstallmentDueDate);

        exit(
            StrSubstNo(
                'Dear %1,Your %2 is overdue by Ksh.%3 as of %4. If payment is not received by %5,a penalty of 5% of your principle loan installment will be incurred.Your %6 installment of Ksh. %7 is due by %8.',
                FirstName,
                ProductName,
                Format(ArrearsAmount),
                Format(AsAt, 0, '<Day> <Month Text> <Year4>'),
                Format(PenaltyDate),
                NextInstallmentTxt,
                Format(Round(NextInstallmentAmount, 0.01, '>')),
                Format(NextInstallmentDueDate))
                );
    end;

    local procedure BuildLoanReminderEmailBody(Loan: Record Loans; Member: Record Members; ArrearsAmount: Decimal; AsAt: Date): Text
    var
        FirstName: Text;
        ProductName: Text;
        PenaltyDate: Date;
        NextInstallmentTxt: Text;
        NextInstallmentAmount: Decimal;
        NextInstallmentDueDate: Date;
    begin
        FirstName := GetFirstName(Member.Name);
        if FirstName = '' then
            FirstName := Member.Name;

        ProductName := Loan."Loan Product Type Name";
        if ProductName = '' then
            ProductName := Loan."Loan Product Type";

        PenaltyDate := CalcDate('14D', CalcDate('-CM', Today()));
        GetNextInstallmentInfo(Loan, AsAt, NextInstallmentTxt, NextInstallmentAmount, NextInstallmentDueDate);

        exit(StrSubstNo(
            '<p>Dear %1,<b></b></p><p>Your %2 loan is overdue by Ksh.%3 as of %4.</p><p>If payment is not received by %5,a penalty of 5% of your principle loan installment will be incurred.</p><p>Your %6 installment of Ksh. %7 is due by %8.</p>',
            FirstName,
            ProductName,
            Format(ArrearsAmount),
            Format(AsAt, 0, '<Day> <Month Text> <Year4>'),
            Format(PenaltyDate),
            NextInstallmentTxt,
            Format(Round(NextInstallmentAmount, 0.01, '>')),
            Format(NextInstallmentDueDate)));
    end;

    local procedure GetNextInstallmentInfo(Loan: Record Loans; AsAt: Date; var NextInstallmentTxt: Text; var NextInstallmentAmount: Decimal; var NextInstallmentDueDate: Date)
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        MonthStartDate: Date;
        MonthEndDate: Date;
    begin
        NextInstallmentDueDate := CalcDate('CM', Today);
        NextInstallmentTxt := Format(NextInstallmentDueDate, 0, '<Month Text>');
        MonthStartDate := CalcDate('-CM', NextInstallmentDueDate);
        MonthEndDate := CalcDate('CM', NextInstallmentDueDate);

        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", Loan."Loan No.");
        LoanRepaymentSchedule.SetRange("Repayment Date", MonthStartDate, MonthEndDate);
        if LoanRepaymentSchedule.FindSet() then
            repeat
                NextInstallmentAmount += LoanRepaymentSchedule."Monthly Principal" + LoanRepaymentSchedule."Monthly Interest" + LoanRepaymentSchedule."Insurance Contribution" + LoanRepaymentSchedule."Monthly Shares";
            until LoanRepaymentSchedule.Next() = 0;

        if NextInstallmentAmount <= 0 then
            NextInstallmentAmount := GetMonthlyRepaymentAsAt(Loan, AsAt);
    end;

    local procedure GetLoanArrearsAsAt(var Loan: Record Loans; AsAt: Date): Decimal
    var
        SaccoActivities: Codeunit "Sacco Activities";
        SaccoSetup: Record "Sacco Setup";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        GracePeriod: DateFormula;
        InterestArrears: Decimal;
        InsuranceArrears: Decimal;
        TotalArrears: Decimal;
    begin
        if SaccoSetup.Get() then
            GracePeriod := SaccoSetup."Arrears Grace Period";

        SaccoActivities.GetDefaultedAmount(Loan."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);
        InterestArrears := SaccoActivities.GetInterestArrears(Loan."Loan No.", AsAt);
        InsuranceArrears := SaccoActivities.GetInsuranceArrears(Loan."Loan No.", AsAt);

        Loan.SetRange("Date Filter", 0D, Today);
        Loan.CalcFields("Outstanding Penalty");

        TotalArrears := DefAmount + InterestArrears + InsuranceArrears + Loan."Outstanding Penalty";
        if TotalArrears < 0 then
            TotalArrears := 0;

        exit(Round(TotalArrears, 0.05, '='));
    end;

    local procedure GetMonthlyRepaymentAsAt(Loan: Record Loans; AsAt: Date): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", Loan."Loan No.");
        LoanRepaymentSchedule.SetFilter("Repayment Date", '..%1', AsAt);
        LoanRepaymentSchedule.SetFilter("Monthly Repayment", '>%1', 0);
        if LoanRepaymentSchedule.FindLast() then
            exit(LoanRepaymentSchedule."Monthly Repayment");

        LoanRepaymentSchedule.SetRange("Repayment Date");
        if LoanRepaymentSchedule.FindFirst() then
            exit(LoanRepaymentSchedule."Monthly Repayment");

        if Loan.Repayment > 0 then
            exit(Loan.Repayment);

        if Loan."Total Monthly Repayment" > 0 then
            exit(Loan."Total Monthly Repayment");

        exit(0);
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

    [TryFunction]
    local procedure TrySendLoanReminderSms(MessageText: Text[250]; MemberNo: Code[20]; LoanNo: Code[20])
    var
        MemberActivities: Codeunit "Member Activities";
        Member: Record Members;
        SMSSource: Enum "SMS Source Enum";
    begin
        Member.Get(MemberNo);
        if Member."Mobile Phone No." <> '' then
            MemberActivities.SendSms(SMSSource::"Loan Reminder", Member."Mobile Phone No.", MessageText, MemberNo, LoanNo, false, false);
    end;

    [TryFunction]
    local procedure TrySendLoanReminderEmail(SMSLogs: Record "Loan Reminder Notifications")
    var
        Member: Record Members;
        Loan: Record Loans;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        Member.Get(SMSLogs."Member No");
        if Member."E-Mail" <> '' then begin

            if SMSLogs."Loan No." <> '' then
                Subject := StrSubstNo('Loan Reminder - %1', SMSLogs."Loan No.")
            else
                Subject := 'Loan Reminder';

            Body := SMSLogs.Message;
            if Loan.Get(SMSLogs."Loan No.") then
                Body := BuildLoanReminderEmailBody(Loan, Member, SMSLogs."Amount Due", SMSLogs."Expected Date");

            EmailMessage.Create(Member."E-Mail", Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    var
        AsAtDate: Date;
}
