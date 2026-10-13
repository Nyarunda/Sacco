page 50776 "Attachment Documents"
{
    ApplicationArea = All;
    Caption = 'Application Documents';
    PageType = List;
    SourceTable = "Attachment Documents";
    //DeleteAllowed = false;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document ID field.';
                }
                field("Document Decsription"; Rec."Document Decsription")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Decsription field.';
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application Type field.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application Type field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
