
PageExtension 50213 pageextension50113 extends "Approval Request Entries"
{


    layout
    {

        modify(RecordIDText)
        {
            Visible = false;
        }
        addfirst(Control1)
        {

            field("Document  Type"; Rec."Custom Document Type")
            {
                ApplicationArea = Basic;
            }
            field("Document  No."; Rec."Document No.")
            {
                ApplicationArea = Basic;
            }
            field("Tracker ID"; Rec."Tracker ID")
            {
                ApplicationArea = Basic;
            }
            field(DocumentIDText; DocumentIDText)
            {
                ApplicationArea = Basic;
                Caption = 'Document To Approve';
                Visible = false;
            }
        }
        addafter("Approver ID")
        {

            field("Approved By"; Rec."Approved By")
            {
                ApplicationArea = Basic;
            }
            field("Rejected By"; Rec."Rejected By")
            {
                ApplicationArea = Basic;
            }
        }
        addafter(RecordIDText)
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = Basic;
            }
            field(Name2; Rec.Name2)
            {
                ApplicationArea = Basic;
            }
        }
    }



    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        Rec.FilterGroup(2);

        Rec.Ascending(false);

        If Rec.findfirst then;

        Rec.FilterGroup(0);
    end;

    var
        DocumentIDText: Text;

}

