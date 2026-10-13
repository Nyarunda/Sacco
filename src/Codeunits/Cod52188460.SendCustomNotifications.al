codeunit 50123 "Send Custom Notifications"
{

    procedure CreditDefaulterSMS(Var LoanNo: code[50])
    var
        LoanDetails: Record Loans;
        MemberDetails: Record Members;
        MemberEmail: Text;
        MobileNo: Text;
        LoanDefaulter: Record "SACCO Categorization";
        SMSSource: Enum "SMS Source Enum";
        SMS: Codeunit "Member Activities";
        smsDefaulted: Label 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. Make IMMEDIATE PAYMENTS to avoid further accruals. TO PAY DIAL *882# OR *645# GO TO OPTION 3 (LOANS) THEN OPTION 2 (LOAN REPYMENT) AND FOLLOW PROMPTS.';

    begin
        IF LoanDetails.GET(LoanNo) THEN
            IF MemberDetails.GET(LoanDetails."Member No.") THEN begin
                MemberEmail := MemberDetails."E-Mail";
                MobileNo := MemberDetails."Mobile Phone No.";

                IF EmptyVal(MobileNo) THEN MobileNo := MemberDetails."Phone Number 2";
            end;
        LoanDefaulter.RESET;
        LoanDefaulter.SETRANGE("Loan No.", LoanNo);
        LoanDefaulter.SETFILTER("Principal Arrears", '>0');
        IF LoanDefaulter.FIND('-') THEN
            REPEAT
                //send SMS
                if ((NOT EMPTY(MobileNo))) THEN
                    SMS.SENDSMS(SMSSource::"Loan defaulted", MobileNo, STRSUBSTNO(smsDefaulted, Memberdetails.Name, LoanDetails."Loan Product Type Name", FORMAT(LoanDefaulter."Principal Arrears")),
                    LoanDetails."Loan No.", LoanDetails."Member No.", True, FALSE);
            until LoanDefaulter.Next() = 0;
    end;

    procedure CreditPaymentDue(LoanNumber: code[20])
    var
        LoanDetails: Record Loans;
        MemberDetails: Record Customer;
        MemberEmail: Text;
        SMSSource: Enum "SMS Source Enum";
        SMS: Codeunit "Member Activities";
        MobileNo: Text;
        TotalArrears: Decimal;
        RepaymentSchedule: Record "Loan Repayment Schedule";
        AmountPaid: Decimal;
        smsPaymentDue: Label 'Dear %1, Your %2 repayment of Ksh %3 is DUE on %4. TO PAY DIAL *882# OR *645# GO TO OPTION 3 (LOANS) THEN OPTION 2 (LOAN REPYMENT) AND FOLLOW PROMPTS.';
    begin
        IF LoanDetails.GET(LoanNumber) THEN
            IF MemberDetails.GET(LoanDetails."Member No.") then begin
                MemberEmail := MemberDetails."E-Mail";
                MobileNo := MemberDetails."Mobile Phone No.";

                IF EmptyVal(MobileNo) THEN MobileNo := MemberDetails."Phone No.";
                if LoanDetails."Mobile Loan" = true then
                    if LoanDetails."Total Outstanding Balance" > 0 then begin
                        //send sms
                        if ((NOT EMPTYVal(MobileNo))) THEN
                            SMS.SENDsms(smsSOURCE::"Loan Reminder",
                            MobileNo, STRSUBSTNO(smsPaymentDue, MemberDetails.Name, LoanDetails."Loan Product Type Name", FORMAT(LoanDetails.Repayment), FORMAT(CALCDATE('<CM>', Today))),
                            LoanDetails."Loan No.", LoanDetails."Member No.", true, FALSE);
                    end
            end;

    end;




    procedure EMPTY(TheString: Text): Boolean
    begin
        EXIT(STRLEN(DELCHR(TheString, '<>')) <= 0);
    end;

    local procedure EmptyVal(value: Text): Boolean
    begin
        EXIT(EMPTY(Value));
    end;

    var


}
