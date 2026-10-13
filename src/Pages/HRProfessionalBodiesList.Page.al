Page 50854 "HR Professional Bodies List"
{
    CardPageID = "HR Professional bodies";
    PageType = List;
    SourceTable = "HR Professional body Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field(ProfessionalBody; Rec."Professional Body")
                {
                    ApplicationArea = Basic;
                }
                field(Members; Rec.Members)
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

