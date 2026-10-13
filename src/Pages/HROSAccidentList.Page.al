Page 50932 "HR OSAccident List"
{
    CardPageID = "HR OSAccident Card";
    PageType = List;
    SourceTable = "HR OSAccident";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AccidentNo; Rec."Accident No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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

