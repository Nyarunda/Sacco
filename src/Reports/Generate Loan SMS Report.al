/*report 51516356 "Generate Loan SMS Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Generate Loan SMS Report.rdlc';

    dataset
    {
        dataitem("Loans Register"; Loans)
        {
            DataItemTableView = WHERE("Outstanding Principal" = FILTER(> 0),
                                      "Disbursement Date" = FILTER(< 01-03-26));
            RequestFilterFields = "Loan No.";
            column(ClientName_LoansRegister; "Loans Register"."Member Name")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(MobilePhoneNo; MobilePhoneNo)
            {
            }
            column(SMSMessage; SMSMessage)
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan No.")
            {
            }
            column(TotalRepayment; Amount)
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Member No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Send Members with outstanding Loan Balances reminder of their monthly payments Every 1st of Every Month
                DateSending := DMY2DATE(GeneralSetup."SMS Reminder Day", DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));//Get the first date of that month

                IF TODAY = DateSending THEN
                    FnSendReminderSMS();
            end;

            trigger OnPreDataItem()
            begin
                GeneralSetup.GET();
                GeneralSetup.TESTFIELD("SMS Reminder Day");

                DateSending := DMY2DATE(GeneralSetup."SMS Reminder Day", DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));//Get the first date of that month
                IF TODAY <> DateSending THEN
                    CurrReport.SKIP();

                SMSLogs.RESET;
                SMSLogs.SETRANGE("Date Sent", TODAY);
                SMSLogs.SETRANGE(Status, SMSLogs.Status::Open);
                IF SMSLogs.FINDFIRST THEN
                    SMSLogs.DELETEALL;

                SMSLogs.RESET;
                IF SMSLogs.FINDLAST THEN
                    i := SMSLogs."Entry No"
                ELSE
                    i += 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SendSms; SendSMS)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DateSending: Date;
        MonthlyRepaymentAmount: Decimal;
        Schedule: Record "Loan Repayment Schedule";
        RepayStartDate: Date;
        SFactory: Codeunit "51516007";
        MembersReg: Record "Members";
        SMS: Text[300];
        Amount: Decimal;
        MobilePhoneNo: Code[15];
        SMSMessage: Text;
        SendSMS: Boolean;
        AsAt: Date;
        ExtraCharges: Decimal;
        GeneralSetup: Record "Sacco Setup";
        SMSLogs: Record SMS;
        i: Integer;

    procedure FnSendReminderSMS()
    var
        Arrears: Decimal;
    begin
        RepayStartDate := 0D;
        RepayStartDate := CALCDATE('CM', TODAY);
        "Loans Register".CALCFIELDS("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Insurance");

        Schedule.RESET;
        Schedule.SETRANGE("Loan No.", "Loans Register"."Loan No.");
        Schedule.SETFILTER("Monthly Repayment", '>%1', 0);
        Schedule.SETRANGE("Active Schedule", TRUE);
        Schedule.SETRANGE("Repayment Date", CALCDATE('-CM', TODAY), CALCDATE('CM', TODAY));

        ExtraCharges :=
            "Loans Register"."Outstanding Interest" +
            "Loans Register"."Outstanding Penalty" +
            "Loans Register"."Outstanding Insurance";

        IF Schedule.FINDFIRST THEN BEGIN



            // Calculate arrears - how far behind they are vs schedule
            Arrears := "Loans Register"."Outstanding Principal" - Schedule."Loan Balance";
            IF GeneralSetup."Minimum Arrears" > 0 THEN
                IF GeneralSetup."Minimum Arrears" > Arrears THEN
                    CurrReport.SKIP();

            // Skip if no arrears or arrears less than half of principal repayment
            /* IF (Arrears <= 0) OR (Arrears < (Schedule."Principal Repayment" / 2)) THEN
                 CurrReport.SKIP;
            */
            // In arrears beyond threshold - full amount + extras + shares
            /*Amount :=
                Arrears +
                ExtraCharges +
                Schedule."Deposit Amount";

        END ELSE BEGIN
            IF ExpiredLoans("Loans Register"."Loan No.") THEN
                Amount := "Loans Register"."Outstanding Principal" + ExtraCharges;
        END;

        IF Amount <= 0 THEN CurrReport.SKIP;

        Amount := ROUND(Amount, 0.01, '<');

        MembersReg.RESET;
        MembersReg.SETRANGE(MembersReg."No.", "Loans Register"."Member No.");
        MembersReg.SETFILTER("Mobile Phone No", '<>%1', '');
        IF MembersReg.FIND('-') THEN BEGIN
            MobilePhoneNo := MembersReg."Mobile Phone No";

            SMSMessage := 'Dear ' + SFactory.FnSplitString(MembersReg.Name, ' ') +
                    ' This is a polite reminder that your loan installment of Kshs.' + FORMAT(Amount) + ' is due by ' + FORMAT(RepayStartDate) +
                    ' Please ensure payment is made by this date to keep your account up to date.' +
                    ' Note:A 5% penalty will apply for late repayments. Kindly ignore if paid.';

            SMSLogs.INIT;
            SMSLogs."Entry No" := i;
            SMSLogs."Loan No." := "Loans Register"."Loan  No.";
            SMSLogs."Member No" := MembersReg."No.";
            SMSLogs.Name := MembersReg.Name;
            SMSLogs."First Name" := SFactory.FnSplitString(MembersReg.Name, ' ');
            SMSLogs."Amount Due" := Amount;
            SMSLogs."Date Sent" := TODAY;
            SMSLogs."Expected Date" := RepayStartDate;
            SMSLogs.Message := COPYSTR(SMSMessage, 1, 250);
            SMSLogs."Notification Type" := SMSLogs."Notification Type"::SMS;
            SMSLogs.INSERT();
            //IF (SendSMS=TRUE) AND (MobilePhoneNo <> '') THEN
            //    SFactory.FnSendCustomSMS('LoanSms',SMSMessage,"Loans Register"."Client Code");

            i += 1;
        END;

    end;

    procedure FnSendFirstDefaulterSMS()
    begin
    end;

    procedure FnSendSecondDefaulterSMS()
    begin
    end;

    procedure FnSendThirdDefaulterSMS()
    begin
    end;

    local procedure ExpiredLoans(LoanNo: Code[10]): Boolean
    var
        Rshedule: Record "51516375";
    begin
        Rshedule.RESET;
        Rshedule.SETRANGE(Rshedule."Loan No.", LoanNo);
        Rshedule.SETRANGE(Rshedule."Active Schedule", TRUE);
        Rshedule.SETFILTER(Rshedule."Repayment Date", '%1..%2', CALCDATE('-CM', TODAY), CALCDATE('CM', TODAY));
        IF NOT Rshedule.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
}*/

