Page 51045 "HR Professional Body Lines"
{
    PageType = ListPart;
    SourceTable = "HR Professional Bodies Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(QualificationType; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                }
                field(QualificationCode; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field(QualificationDescription; Rec."Qualification Description")
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

