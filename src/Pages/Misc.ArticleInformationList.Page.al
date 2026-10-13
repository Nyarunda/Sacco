Page 50870 "Misc. Article Information List"
{
    Caption = 'Misc. Article Information';
    //DataCaptionFields = Field1;
    PageType = ListPart;
    SourceTable = "Misc. Article Information";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(MiscArticleCode; Rec."Misc. Article Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(SerialNo; Rec."Serial No.")
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
                    Editable = false;
                }
                field(InUse; Rec."In Use")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
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

