Page 51015 "HR Qualitative Appraisal"
{
    Caption = 'HR Qualitative Appraisal';
    PageType = List;
    SourceTable = "HR Qualitative Appraisal";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Code);
                    end;
                }
            }
        }
    }

    actions
    {
    }
}

