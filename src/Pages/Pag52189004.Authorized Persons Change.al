namespace CentralDB.CentralDB;

page 50706 "Authorized Persons Changes"
{
    ApplicationArea = All;
    Caption = 'Authorized Persons Changes';
    PageType = ListPart;
    SourceTable = "Account Signatories.";
    SourceTableView = where(Type = filter(Authorized));


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.', Comment = '%';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.', Comment = '%';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field.', Comment = '%';
                }
                field("ID Type"; Rec."ID Type")
                {
                    ToolTip = 'Specifies the value of the ID Type field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the value of the Picture field.', Comment = '%';
                }
            }
        }
    }
}
