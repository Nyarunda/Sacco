page 50385 Mandate
{
    Caption = 'Mandate';
    PageType = List;
    SourceTable = Mandate;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Mandate; Rec.Mandate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mandate field.';
                }
            }
        }
    }
}
