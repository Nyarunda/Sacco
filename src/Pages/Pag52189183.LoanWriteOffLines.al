page 50885 "Loan WriteOff Lines"
{
    Caption = 'Loan WriteOff Lines';
    PageType = ListPart;
    SourceTable = "Write Off Lines";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Write Off No"; Rec."Write Off No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    LookupPageId = "Member List";
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Old Member No"; Rec."Old Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Old Member No field.', Comment = '%';
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Share Capital field.';
                }
                field(Depostis; Rec.Depostis)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Depostis field.';
                }
                field("Unpaid Dividend"; Rec."Unpaid Dividend")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Share Capital field.';
                }
                field("Total Share Amount"; Rec."Total Share Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Share Capital field.';
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No field.', Comment = '%';
                }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Balance field.';
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Balance field.';
                }
                field("Loan + Interest Amount"; Rec."Loan + Interest Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Balance field.';
                }
                field("Total Write Off Amount"; Rec."Total Write Off Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Share Capital field.';
                }
                field(Processed;Rec.Processed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Share Capital field.';
                }
            }
        }
    }
}
