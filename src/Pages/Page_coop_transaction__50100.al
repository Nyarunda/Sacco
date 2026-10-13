page 50775 "Transaction Log API"
{
    PageType = API;
    APIPublisher = 'Wanandege';
    APIGroup = 'TransactionAPI';
    APIVersion = 'v1.0';
    EntityName = 'transactionLog';
    EntitySetName = 'transactionLogs';
    SourceTable = "Coop ATM Transaction Log";
    DelayedInsert = true;
    ODataKeyFields = "Entry No.";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(serviceName; Rec."Service Name")
                {
                    Caption = 'Service Name';
                }
                field(messageID; Rec."Message ID")
                {
                    Caption = 'Message ID';
                }
                field(connectionID; Rec."Connection ID")
                {
                    Caption = 'Connection ID';
                }
                field(transactionDate; Rec."Transaction Date")
                {
                    Caption = 'Transaction Date';
                }
                field(terminalID; Rec."Terminal ID")
                {
                    Caption = 'Terminal ID';
                }
                field(channel; Rec."Channel")
                {
                    Caption = 'Channel';
                }
                field(transactionType; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field(originalMessageID; Rec."Original Message ID")
                {
                    Caption = 'Original Message ID';
                }
                field(institutionCode; Rec."Institution Code")
                {
                    Caption = 'Institution Code';
                }
                field(institutionName; Rec."Institution Name")
                {
                    Caption = 'Institution Name';
                }
                field(debitAccount; Rec."Debit Account")
                {
                    Caption = 'Debit Account';
                }
                field(amount; Rec."Amount")
                {
                    Caption = 'Amount';
                }
                field(currency; Rec."Currency")
                {
                    Caption = 'Currency';
                }
                field(creditAccount; Rec."Credit Account")
                {
                    Caption = 'Credit Account';
                }
                field(chargeAmount; Rec."Charge Amount")
                {
                    Caption = 'Charge Amount';
                }
                field(chargeCurrency; Rec."Charge Currency")
                {
                    Caption = 'Charge Currency';
                }
                field(feeAmount; Rec."Fee Amount")
                {
                    Caption = 'Fee Amount';
                }
                field(feeCurrency; Rec."Fee Currency")
                {
                    Caption = 'Fee Currency';
                }
                field(narrative1; Rec."Narrative 1")
                {
                    Caption = 'Narrative 1';
                }
                field(narrative2; Rec."Narrative 2")
                {
                    Caption = 'Narrative 2';
                }
                field(createdDateTime; Rec."Created DateTime")
                {
                    Caption = 'Created DateTime';
                }
                field(processed; Rec."Processed")
                {
                    Caption = 'Processed';
                }
                field(processingStatus; Rec."Processing Status")
                {
                    Caption = 'Processing Status';
                }
                field(errorMessage; Rec."Error Message")
                {
                    Caption = 'Error Message';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ProcessTransaction)
            {
                Caption = 'Process Transaction';
                trigger OnAction()
                var
                    TransactionProcessor: Codeunit "Coop ATM Processor";
                    JsonPayload: Text;
                begin
                    JsonPayload := Rec.GetRawJsonPayload();
                    if JsonPayload <> '' then
                        TransactionProcessor.ProcessIncomingTransaction(JsonPayload);
                end;
            }
        }
    }
}

// Codeunit 50100 - Transaction Processor
