report 51050 "Interest Reversal"
{
    Caption = 'Transaction Reversal';
    ProcessingOnly = true;
    dataset
    {
        dataitem(CustLedgerEntry; "Savings Ledger Entry")
        {
            RequestFilterFields = "Document No.";
            column(EntryNo; "Entry No.")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(CustomerNo; "Account No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }

            column(Amount; Amount)
            {
            }
            trigger OnAfterGetRecord()
            var
                Cledger: Record "Savings Ledger Entry";
                GLentry: Record "G/L Entry";

                ReversalEntry: Record "Auto Reversal Entry";
                GLRegister: Record "G/L Register";


            begin
                // if not Confirm('Are you ABSOLUTELY sure you want to Reverse this Transaction?') then
                //     Error('ABORTED');5

                IntAmt := 0;

                sno += 1;
                Cledger.Reset();
                Cledger.SetRange("Account No.", CustLedgerEntry."Account No.");
                Cledger.SetRange("Document No.", CustLedgerEntry."Document No.");
                if Cledger.FindLast() then begin
                    if Cledger."Document No." = 'FINT00051' then begin



                        GLentry.Reset;
                        GLentry.SetRange("Entry No.", Cledger."Entry No.");
                        GLentry.SetRange("Document No.", Cledger."Document No.");
                        GLentry.SetRange("Posting Date", Cledger."Posting Date");
                        GLentry.SetRange("Reversed", false);
                        GLentry.SetRange(Amount, Cledger."Amount (LCY)");
                        if GLentry.FindFirst then begin
                            GLRegister.Reset;
                            GLRegister.SetFilter("From Entry No.", '<=%1', GLentry."Entry No.");
                            GLRegister.SetFilter("To Entry No.", '>=%1', GLentry."Entry No.");
                            if GLRegister.FindFirst then begin
                                ReversalEntry.ReverseRegister(GLRegister."No.");
                                IntAmt := GLentry.Amount;
                            end;

                        end
                        else
                            CurrReport.Skip();

                    end
                    else
                        CurrReport.skip;
                end;

            end;

            trigger OnPostDataItem()
            var
            begin
                Message('Done!!');
            end;

            trigger OnPreDataItem()
            var

            begin
                RestrictAccess();

                SetRange("Document No.", 'FINT00051');
            end;

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

    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Reverse Transactions", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Reverse Transactions"');
    end;

    var
        IntAmt: Decimal;
        Sno: Integer;
}
