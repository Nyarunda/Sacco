namespace CentralDB.CentralDB;


page 50746 "Loan Attachment Factbox"
{
    Caption = 'Loan Attachment Factbox';
    PageType = CardPart;
    SourceTable = "Loan Attachments";
    layout
    {
        area(content)
        {
            group(Control2)
            {
                ShowCaption = false;
                field(Documents; NumberOfRecords)
                {
                    ApplicationArea = All;
                    Caption = 'Documents';
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the number of attachments.';

                    trigger OnDrillDown()
                    var
                        Loans: Record Loans;
                        DocumentAttachmentDetails: Page Wanandage.Wanandage."Loan Attachment Details";
                        RecRef: RecordRef;
                    begin
                        case Rec."Table ID" of
                            0:
                                exit;
                            DATABASE::Loans:
                                begin
                                    RecRef.Open(DATABASE::Loans);
                                    if Loans.Get(Rec."Document No.") then
                                        RecRef.GetTable(Loans);
                                end;
                            else
                                OnBeforeDrillDown(Rec, RecRef);
                        end;

                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
            }
        }
    }

    actions
    {
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Loan Attachments"; var RecRef: RecordRef)
    begin
    end;

    trigger OnAfterGetCurrRecord()
    var
        currentFilterGroup: Integer;
    begin
        currentFilterGroup := Rec.FilterGroup;
        Rec.FilterGroup := 4;

        NumberOfRecords := 0;
        if Rec.GetFilters() <> '' then
            NumberOfRecords := Rec.Count;
        Rec.FilterGroup := currentFilterGroup;
    end;

    var
        NumberOfRecords: Integer;
        PRec: Page "Loan Attachment Factbox";
}

