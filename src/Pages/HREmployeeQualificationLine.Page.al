Page 50873 "HR Employee Qualification ln"
{
    Caption = 'Employee Qualification Lines';
    PageType = List;
    SourceTable = "HR Employee Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
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
                field(FromDate; Rec."From Date")
                {
                    ApplicationArea = Basic;
                }
                field(ToDate; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(InstitutionCompany; Rec."Institution/Company")
                {
                    ApplicationArea = Basic;
                }
                field(CourseGrade; Rec."Course Grade")
                {
                    ApplicationArea = Basic;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Qualification)
            {
                Caption = 'Q&ualification';
                action(Comments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    /*RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name"=const(2),
                                  "No."=field("Employee No."),
                                  "Table Line No."=field("Line No.");*/
                }
                separator(Action1102755021)
                {
                }
                action(QualificationOverview)
                {
                    ApplicationArea = Basic;
                    Caption = 'Q&ualification Overview';
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}

