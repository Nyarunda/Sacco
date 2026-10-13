
codeunit 50004 "SMS Provider"
{
    procedure SendSMS(PhoneNo: Text; Message: Text)
    begin
        Message('SMS Sent to %1: %2', PhoneNo, Message);
    end;
}
