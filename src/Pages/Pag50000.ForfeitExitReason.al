page 50000 "Forfeit Exit Reason"
{
    Caption = 'Forfeit Exit Reason';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ForfeitReason; ForfeitReason)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reason';
                    MultiLine = true;
                }
            }
        }
    }

    var
        ForfeitReason: Text[250];

    procedure GetForfeitReason(): Text[250]
    begin
        exit(ForfeitReason);
    end;
}