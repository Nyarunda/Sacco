
Report 50136 "Post Provisional FD"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Post Provisional FD.rdlc';

    dataset
    {
        dataitem(SavingsInterestBuffer; "Savings Interest Buffer")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                UserSetup.Get;
                InterestBuffer.Reset;
                InterestBuffer.SetRange("Account No.", "Account No.");
                InterestBuffer.SetRange(Accrued, false);
                if InterestBuffer.FindFirst then begin
                    //MESSAGE('test5');
                    repeat
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := 'FD INTEREST';
                        GenJournalLine."External Document No." := InterestBuffer."Account No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := AccountTypes."Interest Expense Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := InterestBuffer.Description;
                        GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                        GenJournalLine.Amount := InterestBuffer."Interest Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        InterestBuffer.Accrued := true;
                    //InterestBuffer.MODIFY;

                    until InterestBuffer.Next = 0;
                end;

                AccountTypes.Reset;
                AccountTypes.SetRange("Product ID", '013');
                if AccountTypes.Find('-') then begin
                    // MESSAGE('test6');

                    LineNo := LineNo + 10000;
                    //Account.CALCFIELDS("Untranfered Interest");

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JTemplate;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Document No." := 'FD INTEREST';
                    GenJournalLine."External Document No." := Account."Savings Account";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                    GenJournalLine."Account No." := Account."Savings Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'FD Interest - ' + Format(Account."FD Maturity Date", 0, ' <Day,2>-<Month Text,3>-<Year4> ');
                    GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                    GenJournalLine.Amount := -InterestBuffer."Interest Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Account."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                end;
            end;

            trigger OnPreDataItem()
            begin
                UserSetup.Reset;
                UserSetup.SetRange("User ID", UserId);
                if UserSetup.FindFirst then begin
                    JTemplate := UserSetup."Payment Journal Template";
                    JBatch := UserSetup."Payment Journal Batch";

                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        InterestBuffer: Record "Savings Interest Buffer";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        AccountTypes: Record "Product Setup";
        UserSetup: Record "User Setup";
        Account: Record "Fixed Deposit Accounts";
        JTemplate: Code[20];
        JBatch: Code[20];
}

