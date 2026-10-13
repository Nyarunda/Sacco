Page 50983 "HR Disciplinary Cases SF"
{
    PageType = ListPart;
    SourceTable = "HR Disciplinary Cases NCA";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(CaseNumber; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(DateOfOccurance; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Of Occurance';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic;
                    Caption = 'Repeat';
                }
                field(TypeComplaint; Rec."Type Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(DescriptionofComplaint; Rec."Description of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(CaseDiscussion; Rec."Case Discussion")
                {
                    ApplicationArea = Basic;
                }
                field(ModeofLodgingtheComplaint; Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(AccusedEmployee; Rec."Accused Employee")
                {
                    ApplicationArea = Basic;
                }
                field(Witness1; Rec."Witness #1")
                {
                    ApplicationArea = Basic;
                }
                field(Witness2; Rec."Witness #2")
                {
                    ApplicationArea = Basic;
                }
                field(RecommendedAction; Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field(ActionTaken; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations; Rec.Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field(DisciplinaryRemarks; Rec."Disciplinary Remarks")
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

