namespace UnitedWomen_Production.UnitedWomen_Production;

page 50110 "Reason Dialog"
{
    PageType = StandardDialog;
    Caption = 'Enter Reason';
    layout
    {
        area(Content)
        {
            field(ReasonText; ReasonText)
            {
                ApplicationArea = All;
                Caption = 'Reason for changing delinking';
            }
        }
    }

    var
        ReasonText: Text;
}
