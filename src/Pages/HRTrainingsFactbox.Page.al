Page 50971 "HR Trainings Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Training App Header";

    layout
    {
        area(content)
        {
            group(Control1102755018)
            {
                label(Control1102755019)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text1;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(ApplicationNo; Rec."Application No")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(Createdby; Rec."Created by")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(CourseTitle; Rec."Course Title")
                {
                    ApplicationArea = Basic;
                }
                field(CourseDescription; Rec."Course Description")
                {
                    ApplicationArea = Basic;
                }
                field(NoofParticipants; Rec."No. of Participants")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Training Details';
}

