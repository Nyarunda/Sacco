Page 50981 "HR Training Bonding Cond. List"
{
    ApplicationArea = All;
    Caption = 'HR Training Bonding Conditions List';
    PageType = List;
    SourceTable = "HR Training Bonding Conditions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ConditionType; Rec."Condition Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        HRTrainingNeeds.Reset;
                        if HRTrainingNeeds.Get(Rec."Training Bonding Code") then begin
                            HRTrainingNeeds.TestField(HRTrainingNeeds."Allow Early Exit if Bonded?", true);
                        end;
                    end;
                }
                field(ConditionDescription; Rec."Condition Description")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Outlook)
            {
            }
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
    }

    var
        HRTrainingNeeds: Record "HR Training Needs";
}

