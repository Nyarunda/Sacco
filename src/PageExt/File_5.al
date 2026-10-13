
PageExtension 50212 pageextension50111 extends "Approval Entries"
{
    layout
    {
        modify(RecordIDText)
        {
            Visible = false;
        }
        addafter(Details)
        {
            field("Custom Document Type"; Rec."Custom Document Type")
            {
                ApplicationArea = Basic;
                Caption = 'Document To Approve';
            }
            field(DocumentIDText; DocumentIDText)
            {
                ApplicationArea = Basic;
                Caption = 'Document To Approve';
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = Basic;
            }
            field("Tracker ID"; Rec."Tracker ID")
            {
                ApplicationArea = Basic;
            }
            field("Document Table ID"; Rec."Document Table ID")
            {
                ApplicationArea = Basic;
            }
        }
    }

    var
        DocumentIDText: Text;


}

