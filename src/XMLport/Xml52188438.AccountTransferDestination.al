xmlport 50082 "Account Transfer Destination"
{
    Caption = 'Account Transfer Destination';
    Format = VariableText;
    Direction = Both;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(DestinationAccountTransfers; "Destination Account Transfers")
            {
                fieldelement(MemberNo; DestinationAccountTransfers."Member No.")
                {
                }
                fieldelement(DestinationAccountNo; DestinationAccountTransfers."Destination Account No.")
                {
                }
                fieldelement(DestinationAccountType; DestinationAccountTransfers."Destination Account Type")
                {
                }
                fieldelement(DestinationAmount; DestinationAccountTransfers."Destination Amount")
                {
                }
                fieldelement(DestinationLoanNo; DestinationAccountTransfers."Destination Loan No.")
                {
                }
                fieldelement(DestinationTransactionType; DestinationAccountTransfers."Destination Transaction Type")
                {
                }

                fieldelement(ExternalDocumentNo; DestinationAccountTransfers."External Document No.")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnInitXmlPort()
    var
        myInt: Integer;
    begin
        Message(
            '📄 Destination Account Transfers Import Format:' +
            '\n1. Member No' +
            '\n2. Destination Account No' +
            '\n3. Destination Account Type' +
            '\n4. Destination Amount' +
            '\n5. Destination Loan No' +
            '\n6. Destination Transaction Type' +
            '\n7. External Document No' +
            '\n\n✅ Guidelines:' +
            '\n- The file must be in Excel format (.xlsx).' +
            '\n- All columns must be present, even if some values are optional.' +
            '\n- Header names must match exactly to avoid import errors.'
        );
    end;
}
