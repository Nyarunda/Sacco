Page 51131 "HR Related Job Qualification"
{
    PageType = List;
    SourceTable = "HR Job Related Requirements";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(QualificationID; Rec."Qualification ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(QualificationType; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(QualificationCode; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field(QualificationDescription; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumScore; Rec."Minimum Score")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumScore; Rec."Maximum Score")
                {
                    ApplicationArea = Basic;
                }
                field(Relevant; Rec.Relevant)
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

