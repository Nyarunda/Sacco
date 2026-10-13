Page 50852 "HR Job Requirement Lines"
{
    PageType = List;
    SourceTable = "HR Job Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(QualificationType; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(QualificationCode; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(QualificationDescription; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(MinimumScore; Rec."Minimum Score")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumScore; Rec."Maximum Score")
                {
                    ApplicationArea = Basic;
                }
                field(Control4; Rec."Related Qualification")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Action3)
            {
                ApplicationArea = Basic;
                Caption = 'Related Qualification';
                Image = JobLines;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Related Job Qualification";
                RunPageLink = "Qualification ID" = field("Qualification Code"),
                              "Qualification Type" = field("Qualification Type");
            }
        }
    }
}

