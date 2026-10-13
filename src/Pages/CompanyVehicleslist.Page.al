Page 51065 "Company Vehicles list"
{
    PageType = List;
    SourceTable = "Company Vehicles";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AssetNo; Rec."Asset No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RegistrationNo; Rec."Registration No.")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

