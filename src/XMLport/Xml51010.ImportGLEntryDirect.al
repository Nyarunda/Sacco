xmlport 51010 "Import G/L Entry Direct"
{
    Caption = 'Import G/L Entry Direct';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    TextEncoding = UTF8;
    Permissions = tabledata "G/L Entry" = rim;

    schema
    {
        textelement(Root)
        {
            tableelement(GLEntry; "G/L Entry")
            {
                XmlName = 'GLEntry';

                fieldelement(PostingDate; GLEntry."Posting Date")
                {
                }
                fieldelement(DocumentType; GLEntry."Document Type")
                {
                }
                fieldelement(DocumentNo; GLEntry."Document No.")
                {
                }
                fieldelement(ExternalDocumentNo; GLEntry."External Document No.")
                {
                }
                fieldelement(Amount; GLEntry.Amount)
                {
                }
                fieldelement(UserID; GLEntry."User ID")
                {
                }
                fieldelement(GLAccountNo; GLEntry."G/L Account No.")
                {
                }
                fieldelement(Description; GLEntry.Description)
                {
                }
                fieldelement(BalAccountType; GLEntry."Bal. Account Type")
                {
                }
                fieldelement(SourceNo; GLEntry."Source No.")
                {
                }
                fieldelement(SourceType; GLEntry."Source Type")
                {
                }
                fieldelement(TransactionNo; GLEntry."Transaction No.")
                {
                }
                fieldelement(EntryNo; GLEntry."Entry No.")
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    ExistingGLEntry: Record "G/L Entry";
                    GLAccount: Record "G/L Account";
                begin
                    if GLEntry."Entry No." = 0 then
                        GLEntry."Entry No." := GetNextGLEntryNo();

                    if ExistingGLEntry.Get(GLEntry."Entry No.") then
                        Error('G/L Entry No. %1 already exists. Direct import cannot overwrite existing posted entries.', GLEntry."Entry No.");

                    GLAccount.Get(GLEntry."G/L Account No.");
                    GLEntry."G/L Account Name" := GLAccount.Name;

                    if (GLEntry."Debit Amount" = 0) and (GLEntry."Credit Amount" = 0) then
                        SetDebitCreditAmounts();

                    if GLEntry."Last Modified DateTime" = 0DT then
                        GLEntry."Last Modified DateTime" := CurrentDateTime;

                    if GLEntry."User ID" = '' then
                        GLEntry."User ID" := CopyStr(UserId, 1, MaxStrLen(GLEntry."User ID"));
                end;
            }
        }
    }

    local procedure GetNextGLEntryNo(): Integer
    var
        LastGLEntry: Record "G/L Entry";
    begin
        LastGLEntry.LockTable();
        if LastGLEntry.FindLast() then
            exit(LastGLEntry."Entry No." + 1);

        exit(1);
    end;

    local procedure SetDebitCreditAmounts()
    begin
        GLEntry."Debit Amount" := 0;
        GLEntry."Credit Amount" := 0;

        if GLEntry.Amount > 0 then
            GLEntry."Debit Amount" := GLEntry.Amount
        else
            if GLEntry.Amount < 0 then
                GLEntry."Credit Amount" := -GLEntry.Amount;
    end;
}
