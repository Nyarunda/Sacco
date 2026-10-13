xmlport 50081 "Account Transfer Source"
{
    Caption = 'Account Transfer Source';
    Format = VariableText;
    Direction = Both;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(SourceAccountTransfer; "Source Account Transfer")
            {

                fieldelement(MemberNo; SourceAccountTransfer."Member No.")
                {
                }
                fieldelement(SourceAccountType; SourceAccountTransfer."Source Account Type")
                {
                }
                fieldelement(SourceAccountNo; SourceAccountTransfer."Source Account No.")
                {
                }
                fieldelement(SourceAmount; SourceAccountTransfer."Source Amount")
                {
                }
                fieldelement(SourceLoanNo; SourceAccountTransfer."Source Loan No.")
                {
                }
                fieldelement(SourceTransactionType; SourceAccountTransfer."Source Transaction Type")
                {
                }
                fieldelement(ExternalDocumentNo; SourceAccountTransfer."External Document No.")
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
            '📄 Import Format Guidelines:' +
            '\n1. Member No' +
            '\n2. Source Account Type' +
            '\n3. Source Account No' +
            '\n4. Source Amount' +
            '\n5. Source Loan No' +
            '\n6. Source Transaction Type' +
            '\n7. External Document No' +
            '\n\n✅ Notes:' +
            '\n- The document must be in Excel format (.xlsx).' +
            '\n- All columns should be present, even if some values are optional.'
        );
    end;

}
