xmlport 51009 "Import G/L Entry Migration"
{
    Caption = 'Import G/L Entry Migration';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(GLEntryMigration; "G/L Entry Migration")
            {
                XmlName = 'GLEntryMigration';

                fieldelement(EntryNo; GLEntryMigration."Entry No.")
                {
                }
                fieldelement(GLAccountNo; GLEntryMigration."G/L Account No.")
                {
                }
                fieldelement(PostingDate; GLEntryMigration."Posting Date")
                {
                }
                fieldelement(DocumentType; GLEntryMigration."Document Type")
                {
                }
                fieldelement(DocumentNo; GLEntryMigration."Document No.")
                {
                }
                fieldelement(Description; GLEntryMigration.Description)
                {
                }
                fieldelement(BalAccountNo; GLEntryMigration."Bal. Account No.")
                {
                }
                fieldelement(Amount; GLEntryMigration.Amount)
                {
                }
                fieldelement(GlobalDimension1Code; GLEntryMigration."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDimension2Code; GLEntryMigration."Global Dimension 2 Code")
                {
                }
                fieldelement(UserID; GLEntryMigration."User ID")
                {
                }
                fieldelement(SourceCode; GLEntryMigration."Source Code")
                {
                }
                fieldelement(SystemCreatedEntry; GLEntryMigration."System-Created Entry")
                {
                }
                fieldelement(PriorYearEntry; GLEntryMigration."Prior-Year Entry")
                {
                }
                fieldelement(JobNo; GLEntryMigration."Job No.")
                {
                }
                fieldelement(Quantity; GLEntryMigration.Quantity)
                {
                }
                fieldelement(VATAmount; GLEntryMigration."VAT Amount")
                {
                }
                fieldelement(BusinessUnitCode; GLEntryMigration."Business Unit Code")
                {
                }
                fieldelement(JournalBatchName; GLEntryMigration."Journal Batch Name")
                {
                }
                fieldelement(ReasonCode; GLEntryMigration."Reason Code")
                {
                }
                fieldelement(GenPostingType; GLEntryMigration."Gen. Posting Type")
                {
                }
                fieldelement(GenBusPostingGroup; GLEntryMigration."Gen. Bus. Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; GLEntryMigration."Gen. Prod. Posting Group")
                {
                }
                fieldelement(BalAccountType; GLEntryMigration."Bal. Account Type")
                {
                }
                fieldelement(TransactionNo; GLEntryMigration."Transaction No.")
                {
                }
                fieldelement(DebitAmount; GLEntryMigration."Debit Amount")
                {
                }
                fieldelement(CreditAmount; GLEntryMigration."Credit Amount")
                {
                }
                fieldelement(DocumentDate; GLEntryMigration."Document Date")
                {
                }
                fieldelement(ExternalDocumentNo; GLEntryMigration."External Document No.")
                {
                }
                fieldelement(SourceType; GLEntryMigration."Source Type")
                {
                }
                fieldelement(SourceNo; GLEntryMigration."Source No.")
                {
                }
                fieldelement(NoSeries; GLEntryMigration."No. Series")
                {
                }
                fieldelement(DimensionSetID; GLEntryMigration."Dimension Set ID")
                {
                }
                fieldelement(Posted; GLEntryMigration.Posted)
                {
                }
                fieldelement(Skipped; GLEntryMigration.Skipped)
                {
                }
                fieldelement(StaffAccount; GLEntryMigration."Staff Account")
                {
                }
                fieldelement(SystemDate; GLEntryMigration."System Date")
                {
                }
                fieldelement(TransactionType; GLEntryMigration."Transaction Type")
                {
                }
            }
        }
    }
}
