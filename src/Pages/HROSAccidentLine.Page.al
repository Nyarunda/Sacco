Page 50934 "HR OSAccident Line"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR OSAccident Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(AccidentNo; Rec."Accident No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

