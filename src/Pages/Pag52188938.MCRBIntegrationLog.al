page 50785 "MCRB Integration Log"
{
    Caption = 'MCRB Integration Log';
    PageType = ListPart;
    SourceTable = "MCRB Integration Log";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EntryID; Rec.EntryID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EntryID field.', Comment = '%';
                }
                field(ReportType; Rec.ReportType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ReportType field.', Comment = '%';
                }
                field(ErrorMessage; Rec.ErrorMessage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ErrorMessage field.', Comment = '%';
                }
            }
        }
    }
}
