
report 50484 "Reverse Dividend Posted"
{
    ProcessingOnly = true;
    Caption = 'Reverse Dividend Posted';
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            RequestFilterFields = "No.", "Product Category", "Product Type";
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                GLRegister: Record "G/L Register";
                Custom: Record "Reversal Entry";
                SavingsLedger: Record "Savings Ledger Entry";
                CreditLedger: Record "Credit Ledger Entry";
                BankLedger: Record "Bank Account Ledger Entry";
            begin
                SavingsLedger.Reset();
                SavingsLedger.SetRange("Account No.", SavingsAccounts."No.");
                SavingsLedger.SetRange("Document No.", DocNo);
                SavingsLedger.SetRange(Reversed, false);
                //SavingsLedger.SetRange("Posting Date", CheckoffHeader."Posting Date");
                //SavingsLedger.SetRange(Amount, CheckoffLines.Amount * -1);
                if SavingsLedger.FindFirst() then begin
                    Custom.SetHideWarningDialogs;
                    Custom.ReverseTransaction(SavingsLedger."Transaction No.");
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if DocNo = '' then
                    Error('Document no is required');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(DocNo; DocNo)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        DocNo: Code[50];
}
