Page 50906 "HR OSSafety Checklist List"
{
    PageType = ListPart;
    SourceTable = "HR OSSafety Checklist";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SafetyNo; Rec.SafetyNo)
                {
                    ApplicationArea = Basic;
                }
                field(SafetyRules; Rec."Safety Rules")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Observed; Rec.Observed)
                {
                    ApplicationArea = Basic;
                }
                field(NotObserved; Rec."Not Observed")
                {
                    ApplicationArea = Basic;
                }
                field(ObservationMade; Rec."Observation Made")
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

