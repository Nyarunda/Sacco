namespace CentralDB.CentralDB;

page 50733 "Loan Changes Lines"
{
    ApplicationArea = All;
    Caption = 'Loan Changes Lines';
    PageType = ListPart;
    SourceTable = "Loan Security Lines Changes";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.', Comment = '%';
                }
                field("Security Type"; Rec."Security Type")
                {
                    ToolTip = 'Specifies the value of the Security Type field.', Comment = '%';
                }
                field("Security Name"; Rec."Security Name")
                {
                    ToolTip = 'Specifies the value of the Security Name field.', Comment = '%';
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ToolTip = 'Specifies the value of the Amount Guaranteed field.', Comment = '%';
                }
                field("Commited Amount"; Rec."Commited Amount")
                {
                    ToolTip = 'Specifies the value of the Commited Amount field.', Comment = '%';
                }
                field("New Commited Amount"; Rec."New Commited Amount")
                {
                    ToolTip = 'Specifies the value of the New Commited Amount field.', Comment = '%';
                }
                field("Security Account"; Rec."Security Account")
                {
                    ToolTip = 'Specifies the value of the Security Account field.', Comment = '%';
                }
                field("Collateral Reg. No."; Rec."Collateral Reg. No.")
                {
                    ToolTip = 'Specifies the value of the Collateral Reg. No. field.', Comment = '%';
                }
                field(Subtituted; Rec.Subtituted)
                {
                    ToolTip = 'Specifies the value of the Subtituted field.', Comment = '%';
                }
            }
        }
    }
}
