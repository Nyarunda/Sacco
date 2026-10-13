namespace CentralDB.CentralDB;

codeunit 50131 "Custom Job Scheduler"
{
    procedure processjob(job_id: Integer)
    var
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        Sky: Codeunit "Sky MBanking";
        MpesaActivities: Codeunit "Mpesa Activities";
        SpotCash: Codeunit "SpotCash Mbanking";
        CustomNotification: Codeunit "Custom Notifications";
        Coop: Codeunit "Coop Processing";
        Members: Record Members;
        TransactionsToPost: Record "Sky M-Banking Transactions";
        LoanSource: Enum "Loan Source";
        PostingValidationError: Text[250];
        PostingError: Text;
    begin

        case job_id of
            1:
                begin

                end;
            2:
                begin

                end;
            3:
                begin

                end;
            4:
                begin
                    //Coop.PostATM('');
                end;
            5:
                begin
                    SaccoActivities.SendLoansEmails('', LoanSource);
                    SaccoActivities.SendPartialLoansEmails('', LoanSource::"Partial Letter");
                end;
            6:
                begin

                    //MemberActivities.RegistrationEmail();
                end;
            7:
                begin
                    // CustomNotification.UpdateLoansArrears();

                end;
            8:
                begin
                    //Sky.RecoverDefaultedMobileLoans('');
                end;
            9:
                begin
                    //SaccoActivities.AutomatedPenaltyRecovery()
                end;
            10:
                begin
                    Members.Reset();
                    if Members.FindSet() then
                        repeat
                            MemberActivities.SendBirthDaySms(Members);
                        until Members.Next() = 0;
                end;
            11:
                begin

                end;
            12:
                begin
                    CallSkyMobileService('DEPOSIT');
                end;
            13:
                begin
                    CallSkyMobileService('WITHDRAWAL');
                end;
            14:
                begin
                    CallSkyMobileService('MOBILE_LOAN_DISBURSEMENT');
                end;
            15:
                begin
                    CallSkyMobileService('INTERNAL');
                end;
        end;

    end;

    local procedure CallSkyMobileService(ServiceID: Text[30])
    var
        SkyMobileBanking: Codeunit "Sky Mobile Banking Integration";
        RequestJson: JsonObject;
        PayloadJson: JsonObject;
        RequestText: Text;
        ResponseText: Text;
    begin
        PayloadJson.Add('service_id', ServiceID);
        RequestJson.Add('action', 'CALL_SERVICE_JOB_QUEUE');
        RequestJson.Add('api_request_id', Format(CreateGuid()));
        RequestJson.Add('payload', PayloadJson);
        RequestJson.WriteTo(RequestText);

        ResponseText := SkyMobileBanking.HandleRequest(RequestText);
        if StrPos(ResponseText, '"request_status":"ERROR"') > 0 then
            Error(ResponseText);
    end;

    local procedure GetMpesaPostingLengthValidationError(SkyTransaction: Record "Sky M-Banking Transactions"): Text[250]
    begin
        if StrLen(SkyTransaction."Transaction ID") > 20 then
            exit(StrSubstNo('Transaction ID %1 exceeds 20 characters and cannot be posted automatically.', SkyTransaction."Transaction ID"));

        if StrLen(SkyTransaction."Savings Account") > 20 then
            exit(StrSubstNo('Savings Account %1 exceeds 20 characters and cannot be posted automatically.', SkyTransaction."Savings Account"));

        exit('');
    end;

    [TryFunction]
    local procedure TryPostMpesaDepositsTransaction(TransactionID: Code[20])
    var
        MpesaActivities: Codeunit "Mpesa Activities";
    begin
        MpesaActivities.PostMpesaDepositsTransaction(TransactionID);
    end;
}
