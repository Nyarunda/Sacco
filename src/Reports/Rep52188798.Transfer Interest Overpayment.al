report 50480 "Transfer Interest Overpayment"
{
    ApplicationArea = All;
    Caption = 'Transfer Interest Overpayment';
    ProcessingOnly = true;
    dataset
    {
        dataitem(LoansApp; Loans)
        {
            DataItemTableView = where("Outstanding Principal" = filter(> 0), "Mobile Loan" = filter(false));
            RequestFilterFields = "Outstanding Interest", "Outstanding Principal", "Loan No.", "Loan Product Type", "Disbursement Date";

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId);
                if UserSetup.FindFirst() then begin

                    UserSetup.TestField("General Journal Template");
                    UserSetup.TestField("General Journal Batch");

                    JTemplate := UserSetup."General Journal Template";
                    JBatch := UserSetup."General Journal Batch";

                end else
                    Error('User setup missing');


                if PDate = 0D then
                    Error('Posting date is empty');

                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.FindFirst() then
                    GenJournalLine.DeleteAll();

                LineNo := 0;
            end;

            trigger OnAfterGetRecord()
            var
                DedAmt: Decimal;
                TotalDedAmt: Decimal;
            begin
                LoansApp.CalcFields("Outstanding Interest");
                DocNo := 'INT-OVER' + LoansApp."Loan No.";

                Loans.Reset;
                Loans.SetRange("Member No.", LoansApp."Member No.");
                Loans.SetFilter("Principal Arrears", '>0');
                Loans.SetRange("Mobile Loan", false);
                Loans.SetAutoCalcFields("Outstanding Principal", "Outstanding Interest");
                if Loans.FindSet() then begin

                    NoOfRecords := Loans.Count;

                    dWindow.Open('Loan Interest Gen.:      #1#########\'
                                        + 'Accounts:             #2#########\'
                                        + 'Counter:              #3#########\'
                                        + 'Progress:             @4@@@@@@@@@\'
                                        + 'Press Esc to abort');

                    dWindow.Update(2, NoOfRecords);

                    RunBal := LoansApp."Outstanding Interest" * -1;
                    TotalDedAmt := 0;

                    repeat

                        DedAmt := 0;

                        CurrentRecordNo += 1;
                        dWindow.Update(1, Loans."Loan No." + ': ' + Loans."Member Name");
                        dWindow.Update(3, CurrentRecordNo);
                        dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                        Loans.CalcFields("Principal Arrears");
                        DedAmt := Loans."Principal Arrears";

                        if RunBal > 0 then begin
                            if DedAmt > RunBal then
                                DedAmt := RunBal;

                            LineNo += 1;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                            GenJournalLine.Validate(GenJournalLine."Account No.", Loans."Loan Account");
                            GenJournalLine.Description := CopyStr(Loans."Loan Product Type Name" + ': Interest Overpayment Transfer', 1, 50);
                            GenJournalLine."Bal. Account Type" := BalAcctType::"G/L Account";
                            GenJournalLine."Bal. Account No." := '';
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine.Amount := -DedAmt;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."External Document No." := '';
                            GenJournalLine."Loan No." := Loans."Loan No.";
                            GenJournalLine."Transaction Type" := TransType::"Principal Repayment";
                            GenJournalLine."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := Loans."Booking Branch";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            RunBal -= DedAmt;
                            TotalDedAmt += DedAmt;

                        end;

                    until Loans.Next = 0;

                    LineNo += 1;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Journal Template Name" := JTemplate;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."Posting Date" := PDate;
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                    GenJournalLine."Account No." := LoansApp."Loan Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := CopyStr('Interest Overpayment Transfer', 1, 50);
                    GenJournalLine."Bal. Account Type" := BalAcctType::"G/L Account";
                    GenJournalLine."Bal. Account No." := '';
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine.Amount := TotalDedAmt;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."External Document No." := '';
                    GenJournalLine."Loan No." := LoansApp."Loan No.";
                    GenJournalLine."Transaction Type" := TransType::"Interest Paid";
                    GenJournalLine."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Loans."Booking Branch";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    dWindow.Close;
                end;


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
                    field(PDate; PDate)
                    {
                        ApplicationArea = All;

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
        UserSetup: Record "User Setup";
        Loans: Record Loans;
        GenJournalLine: Record "Gen. Journal Line";
        RunBal: Decimal;
        SaccoSetup: Record "Sacco Setup";
        PDate: Date;
        DocNo: Code[20];
        PostingRemarks: Text[50];
        DActivity2: Code[20];
        DBranch2: Code[20];
        LineNo: Integer;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        JTemplate: Code[10];
        JBatch: Code[10];
        EntryType: Option " ",Savings,"Interest Arrears","Principlal Arrears","Loan Interest","Loan Principal","Internal STO","External STO";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
}
