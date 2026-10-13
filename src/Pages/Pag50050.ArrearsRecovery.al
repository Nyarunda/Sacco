namespace UnitedWomen_Production.UnitedWomen_Production;

page 50050 "Arrears Recovery"
{
    ApplicationArea = All;
    Caption = 'Arrears Recovery';
    PageType = List;
    SourceTable = "Arrears Recovery";

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
                field("Loan Name"; Rec."Loan Name")
                {
                    //
                }
                field("Interest Arrears"; Rec."Interest Arrears")
                {
                    ToolTip = 'Specifies the value of the Interest Arrears field.', Comment = '%';
                }
                field("Interest Arrears Recover"; Rec."Interest Arrears Recovered")
                {
                    ToolTip = 'Specifies the value of the Interest Arrears Recover field.', Comment = '%';
                }
                field("Principal Arrears"; Rec."Principal Arrears")
                {
                    ToolTip = 'Specifies the value of the Principal Arrears field.', Comment = '%';
                }
                field("Principal Arrears Recover"; Rec."Principal Arrears Recovered")
                {
                    ToolTip = 'Specifies the value of the Principal Arrears Recover field.', Comment = '%';
                }
            }
        }
    }
}
