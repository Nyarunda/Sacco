codeunit 50124 GLPostPreviewExt
{
    EventSubscriberInstance = Manual;

    var
        TempSavingsLedgerEntry: Record "Savings Ledger Entry" temporary;
        TempCreditLedgerEntry: Record "Credit Ledger Entry" temporary;

    /// <summary>
    /// Event subscriber to add savings/credit entries to the post preview
    /// </summary>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnAfterShowEntries', '', false, false)]
    local procedure OnAfterShowEntries(TableNo: Integer)
    begin
        case TableNo of

            DATABASE::"Savings Ledger Entry":
                begin
                    Page.Run(Page::"Savings Ledger Entries", TempSavingsLedgerEntry);
                    clear(TempSavingsLedgerEntry);
                end;

            Database::"Credit Ledger Entry":
                begin
                    Page.Run(Page::"Credit Ledger Entries", TempCreditLedgerEntry);
                    Clear(TempCreditLedgerEntry);
                end;

        end;
    end;

    /// <summary>
    /// Event Subscriber to populate post preview on 
    /// the savings/Credit ledger entries
    /// </summary>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnGetEntries', '', false, false)]
    local procedure OnGetEntries(TableNo: Integer; var RecRef: RecordRef)
    begin
        case TableNo of

            DATABASE::"Savings Ledger Entry":
                RecRef.GetTable(TempSavingsLedgerEntry);
            Database::"Credit Ledger Entry":
                RecRef.GetTable(TempCreditLedgerEntry);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnAfterFillDocumentEntry', '', false, false)]
    local procedure OnAfterFillDocumentEntry(var DocumentEntry: Record "Document Entry")
    var
        PreviewPost: Codeunit "Posting Preview Event Handler";
    begin
        PreviewPost.InsertDocumentEntry(TempSavingsLedgerEntry, DocumentEntry);
        PreviewPost.InsertDocumentEntry(TempCreditLedgerEntry, DocumentEntry);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Savings Ledger Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnInsertSavingsLedgEntry(var Rec: Record "Savings Ledger Entry"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary() then
            exit;


        TempSavingsLedgerEntry := Rec;

        TempSavingsLedgerEntry.Insert();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Credit Ledger Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnInsertCreditLedgEntry(var Rec: Record "Credit Ledger Entry"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary() then
            exit;


        TempCreditLedgerEntry := Rec;

        TempCreditLedgerEntry.Insert();
    end;


}
