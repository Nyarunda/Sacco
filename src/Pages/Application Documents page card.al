page 50756 "Application Doc. Setup Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Application Document Setup";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control; Notes)
            {
            }
            systempart(Controrol1; MyNotes)
            {
            }
            systempart(Controlol2; Links)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        SOControl;
    end;

    var
        SinglePartyMultiple: Boolean;

    procedure SOControl()
    begin
        CASE Rec."Document Type" OF
            Rec."Document Type"::Member, Rec."Document Type"::Account:
                BEGIN
                    SinglePartyMultiple := TRUE;
                END;

            Rec."Document Type"::" ", Rec."Document Type"::Loan:
                BEGIN
                    SinglePartyMultiple := FALSE;
                END;
        END;
    end;
}

