Page 50902 "HR Applicant Qualifications"
{
    Caption = 'Applicant Qualifications';
    PageType = List;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Applicant Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(QualificationType; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(QualificationCode; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field(QualificationDescription; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
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
                    Importance = Promoted;
                }
                field(ScoreID; Rec."Score ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }
}

