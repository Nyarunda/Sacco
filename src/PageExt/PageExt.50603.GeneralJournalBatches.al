namespace CentralDB.CentralDB;

using Microsoft.Finance.GeneralLedger.Journal;

pageextension 50603 "General Journal Batches Ext" extends "General Journal Batches"
{
    layout
    {
        addafter(Description)
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'Specifies the approval status of the general journal batch.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(ReopenJournalBatch)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                ToolTip = 'Reopens the selected general journal batch by changing the approval status to Open.';

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then begin
                        Message('General journal batch %1 is already open.', Rec.Name);
                        exit;
                    end;

                    if not Confirm('Reopen general journal batch %1?', false, Rec.Name) then
                        exit;

                    Rec.Status := Rec.Status::Open;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
