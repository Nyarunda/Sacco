
Page 50234 "EFT List"
{
    PageType = List;
    SourceTable = "EFT Header";

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
                field(LastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
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

