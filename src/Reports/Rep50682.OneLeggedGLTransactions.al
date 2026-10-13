report 50682 "One Legged G/L Transactions"
{
    Caption = 'One Legged G/L Transactions';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Permissions = tabledata "G/L Entry" = r;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
                GenerateExcel();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    Caption = 'Filters';

                    field(PostingDateFilter; PostingDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date Filter';
                        ToolTip = 'Specifies the posting date filter to apply before checking transaction balances.';
                    }
                    field(DocumentNoFilter; DocumentNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No. Filter';
                        ToolTip = 'Specifies the document number filter to apply before checking transaction balances.';
                    }
                    field(TransactionNoFilter; TransactionNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Transaction No.';
                        ToolTip = 'Specifies one transaction number to check. Leave blank to check all transactions.';
                    }
                    field(MinimumImbalance; MinimumImbalance)
                    {
                        ApplicationArea = All;
                        Caption = 'Minimum Imbalance';
                        ToolTip = 'Specifies the minimum absolute imbalance amount to include in the report.';
                    }
                    field(IncludeEntryLines; IncludeEntryLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Include G/L Entry Lines';
                        ToolTip = 'Specifies whether the Excel file should include the existing G/L entries under each unbalanced transaction.';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        MinimumImbalance := 0.01;
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        PostingDateFilter: Text[250];
        DocumentNoFilter: Text[250];
        TransactionNoFilter: Integer;
        MinimumImbalance: Decimal;
        IncludeEntryLines: Boolean;
        TransactionsFound: Integer;
        EntriesFound: Integer;
        TotalImbalance: Decimal;

    local procedure GenerateExcel()
    begin
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.CreateNewBook('One Legged GL');

        WriteHeader();
        WriteUnbalancedTransactions();

        if TransactionsFound = 0 then begin
            TempExcelBuffer.NewRow();
            AddTextCell('No one legged or unbalanced G/L transactions were found for the selected filters.', false);
        end else begin
            TempExcelBuffer.NewRow();
            TempExcelBuffer.NewRow();
            AddTextCell('Transactions Found', true);
            AddIntegerCell(TransactionsFound, true);
            TempExcelBuffer.NewRow();
            AddTextCell('Existing G/L Entry Lines', true);
            AddIntegerCell(EntriesFound, true);
            TempExcelBuffer.NewRow();
            AddTextCell('Total Imbalance', true);
            AddDecimalCell(TotalImbalance, true);
        end;

        TempExcelBuffer.WriteSheet('One Legged GL', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;

    local procedure WriteHeader()
    begin
        TempExcelBuffer.NewRow();
        AddTextCell('ONE LEGGED G/L TRANSACTIONS', true);

        TempExcelBuffer.NewRow();
        AddTextCell('Run Date', true);
        AddTextCell(Format(CurrentDateTime), false);

        if PostingDateFilter <> '' then begin
            TempExcelBuffer.NewRow();
            AddTextCell('Posting Date Filter', true);
            AddTextCell(PostingDateFilter, false);
        end;

        if DocumentNoFilter <> '' then begin
            TempExcelBuffer.NewRow();
            AddTextCell('Document No. Filter', true);
            AddTextCell(DocumentNoFilter, false);
        end;

        if TransactionNoFilter <> 0 then begin
            TempExcelBuffer.NewRow();
            AddTextCell('Transaction No.', true);
            AddIntegerCell(TransactionNoFilter, false);
        end;

        TempExcelBuffer.NewRow();
        TempExcelBuffer.NewRow();
        AddTextCell('Transaction No.', true);
        AddTextCell('Posting Date', true);
        AddTextCell('Document No.', true);
        AddTextCell('Description', true);
        AddTextCell('Entry Count', true);
        AddTextCell('Debit Total', true);
        AddTextCell('Credit Total', true);
        AddTextCell('Net Balance', true);
        AddTextCell('Missing Amount Needed', true);
        AddTextCell('First Entry No.', true);
        AddTextCell('Last Entry No.', true);
    end;

    local procedure WriteUnbalancedTransactions()
    var
        GLEntry: Record "G/L Entry";
        LastTransactionNo: Integer;
    begin
        ResetTotals();

        GLEntry.Reset();
        GLEntry.SetCurrentKey("Transaction No.");
        ApplyRequestFilters(GLEntry);

        if not GLEntry.FindSet() then
            exit;

        repeat
            if GLEntry."Transaction No." <> LastTransactionNo then begin
                LastTransactionNo := GLEntry."Transaction No.";
                WriteTransactionIfUnbalanced(GLEntry);
            end;
        until GLEntry.Next() = 0;
    end;

    local procedure WriteTransactionIfUnbalanced(GLEntry: Record "G/L Entry")
    var
        TransactionGLEntry: Record "G/L Entry";
        TransactionBalance: Decimal;
        DebitTotal: Decimal;
        CreditTotal: Decimal;
        EntryCount: Integer;
        FirstEntryNo: Integer;
        LastEntryNo: Integer;
        PostingDate: Date;
        DocumentNo: Code[20];
        Description: Text[100];
    begin
        TransactionGLEntry.Reset();
        TransactionGLEntry.SetRange("Transaction No.", GLEntry."Transaction No.");
        if TransactionGLEntry.FindSet() then
            repeat
                EntryCount += 1;
                TransactionBalance += TransactionGLEntry.Amount;
                DebitTotal += TransactionGLEntry."Debit Amount";
                CreditTotal += TransactionGLEntry."Credit Amount";

                if FirstEntryNo = 0 then begin
                    FirstEntryNo := TransactionGLEntry."Entry No.";
                    PostingDate := TransactionGLEntry."Posting Date";
                    DocumentNo := TransactionGLEntry."Document No.";
                    Description := TransactionGLEntry.Description;
                end;

                LastEntryNo := TransactionGLEntry."Entry No.";
            until TransactionGLEntry.Next() = 0;

        if Abs(TransactionBalance) < MinimumImbalance then
            exit;

        TransactionsFound += 1;
        EntriesFound += EntryCount;
        TotalImbalance += TransactionBalance;

        TempExcelBuffer.NewRow();
        AddIntegerCell(GLEntry."Transaction No.", false);
        AddTextCell(Format(PostingDate), false);
        AddTextCell(DocumentNo, false);
        AddTextCell(Description, false);
        AddIntegerCell(EntryCount, false);
        AddDecimalCell(DebitTotal, false);
        AddDecimalCell(CreditTotal, false);
        AddDecimalCell(TransactionBalance, true);
        AddDecimalCell(-TransactionBalance, true);
        AddIntegerCell(FirstEntryNo, false);
        AddIntegerCell(LastEntryNo, false);

        if IncludeEntryLines then
            WriteTransactionLines(GLEntry."Transaction No.");
    end;

    local procedure WriteTransactionLines(TransactionNo: Integer)
    var
        TransactionGLEntry: Record "G/L Entry";
    begin
        TransactionGLEntry.Reset();
        TransactionGLEntry.SetRange("Transaction No.", TransactionNo);

        if not TransactionGLEntry.FindSet() then
            exit;

        TempExcelBuffer.NewRow();
        AddTextCell('', false);
        AddTextCell('Entry No.', true);
        AddTextCell('G/L Account No.', true);
        AddTextCell('G/L Account Name', true);
        AddTextCell('Posting Date', true);
        AddTextCell('Document No.', true);
        AddTextCell('Description', true);
        AddTextCell('Amount', true);

        repeat
            TempExcelBuffer.NewRow();
            AddTextCell('', false);
            AddIntegerCell(TransactionGLEntry."Entry No.", false);
            AddTextCell(TransactionGLEntry."G/L Account No.", false);
            AddTextCell(TransactionGLEntry."G/L Account Name", false);
            AddTextCell(Format(TransactionGLEntry."Posting Date"), false);
            AddTextCell(TransactionGLEntry."Document No.", false);
            AddTextCell(TransactionGLEntry.Description, false);
            AddDecimalCell(TransactionGLEntry.Amount, false);
        until TransactionGLEntry.Next() = 0;
    end;

    local procedure ApplyRequestFilters(var GLEntry: Record "G/L Entry")
    begin
        if PostingDateFilter <> '' then
            GLEntry.SetFilter("Posting Date", PostingDateFilter);

        if DocumentNoFilter <> '' then
            GLEntry.SetFilter("Document No.", DocumentNoFilter);

        if TransactionNoFilter <> 0 then
            GLEntry.SetRange("Transaction No.", TransactionNoFilter);
    end;

    local procedure ResetTotals()
    begin
        TransactionsFound := 0;
        EntriesFound := 0;
        TotalImbalance := 0;
    end;

    local procedure AddTextCell(Value: Text; Bold: Boolean)
    begin
        TempExcelBuffer.AddColumn(Value, false, '', Bold, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure AddDecimalCell(Value: Decimal; Bold: Boolean)
    begin
        TempExcelBuffer.AddColumn(Value, false, '', Bold, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
    end;

    local procedure AddIntegerCell(Value: Integer; Bold: Boolean)
    begin
        TempExcelBuffer.AddColumn(Value, false, '', Bold, false, false, '#,##0', TempExcelBuffer."Cell Type"::Number);
    end;
}
