Page 50445 "ATM Card Types"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "ATM Card Types";

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
                field(ApplicationChargeCode; Rec."Application Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(ReplacementChargeCode; Rec."Replacement Charge Code")
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

