namespace UnitedWomen_Production.UnitedWomen_Production;

page 50003 "SMS Messages"
{
    ApplicationArea = All;
    Caption = 'SMS Messages';
    PageType = List;
    SourceTable = "SMS Messages";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("SMS ID"; Rec."SMS ID")
                {
                    ToolTip = 'Specifies the value of the SMS ID field.', Comment = '%';
                }
                field(Source; Rec.Source)
                {
                    ToolTip = 'Specifies the value of the Source field.', Comment = '%';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.', Comment = '%';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.', Comment = '%';
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.', Comment = '%';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ToolTip = 'Specifies the value of the Entered By field.', Comment = '%';
                }
                field("SMS Message"; Rec."SMS Message")
                {
                    ToolTip = 'Specifies the value of the SMS Message field.', Comment = '%';
                }
                field("Sent To Server"; Rec."Sent To Server")
                {
                    ToolTip = 'Specifies the value of the Sent To Server field.', Comment = '%';
                }
                field("Date Sent to Server"; Rec."Date Sent to Server")
                {
                    ToolTip = 'Specifies the value of the Date Sent to Server field.', Comment = '%';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Bulk SMS Balance"; Rec."Bulk SMS Balance")
                {
                    ToolTip = 'Specifies the value of the Bulk SMS Balance field.', Comment = '%';
                }
                field(IsChargeable; Rec.IsChargeable)
                {
                    ToolTip = 'Specifies the value of the IsChargeable field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Post to Loan Penalty"; Rec."Post to Loan Penalty")
                {
                    ToolTip = 'Specifies the value of the Post to Loan Penalty field.', Comment = '%';
                }
                field("Charge Not Found"; Rec."Charge Not Found")
                {
                    ToolTip = 'Specifies the value of the Charge Not Found field.', Comment = '%';
                }
                field("SMS Cost"; Rec."SMS Cost")
                {
                    ToolTip = 'Specifies the value of the SMS Cost field.', Comment = '%';
                }
                field(Remark; Rec.Remark)
                {
                    ToolTip = 'Specifies the value of the Remark field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(ResponseID; Rec.ResponseID)
                {
                    ToolTip = 'Specifies the value of the ResponseID field.', Comment = '%';
                }
            }
        }
    }




    actions
    {
        area(Processing)
        {

            action(SendMessage)
            {
                ApplicationArea = All;
                Caption = 'Send Message';
                Image = SendElectronicDocument;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                ToolTip = 'Sends the selected SMS message to the server for processing.';

                trigger OnAction()
                var
                    SMSMessage: Record "SMS Messages";
                    SMSMessageHandler: Codeunit SMSDispatcher;
                begin

                    rec.TestField("Sent To Server", Rec."Sent To Server"::No);

                    if Rec.Source = Rec.Source::PIN then
                        SMSMessageHandler.SendOtp(Rec."SMS ID")
                    else
                        SMSMessageHandler.SendSMS(Rec."SMS ID");
                    Message('The message has been sent to the server for processing.');
                    CurrPage.Update(false);
                end;
            }

            action(SendALLMessage)
            {
                ApplicationArea = All;
                Caption = 'Send All Messages';
                Image = SendElectronicDocument;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                ToolTip = 'Sends the selected SMS message to the server for processing.';

                trigger OnAction()
                var
                    SMSMessage: Record "SMS Messages";
                    SMSMessageHandler: Codeunit SMSDispatcher;
                begin

                    SMSMessage.SetRange("Sent To Server", Rec."Sent To Server"::No);
                    if SMSMessage.FindSet() then
                        repeat
                            if SMSMessage.Source = SMSMessage.Source::PIN then
                                SMSMessageHandler.SendOtp(SMSMessage."SMS ID")
                            else
                                SMSMessageHandler.SendSMS(SMSMessage."SMS ID");
                        until SMSMessage.Next() = 0;

                    Message('All messages have been sent to the server for processing.');
                    CurrPage.Update(false);
                end;
            }



            action(SendBatch)
            {
                ApplicationArea = All;
                Caption = 'Send Batch Message';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                ToolTip = 'Sends the selected SMS message to the server for processing.';

                trigger OnAction()
                var
                    SMSMessage: Record "SMS Messages";
                    SMSMessageHandler: Codeunit SMSDispatcher;
                begin

                    SMSMessageHandler.SendBulkSMS(0);

                    Message('The message has been sent to the server for processing.');
                    CurrPage.Update(false);
                end;
            }

        }
    }

}
