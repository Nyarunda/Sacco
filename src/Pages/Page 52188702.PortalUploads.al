page 50365 "Portal Uploads"
{
    Caption = 'Portal Uploads';
    PageType = List;
    SourceTable = "Portal Uploads";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Path; Rec.Path)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Path field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Format; Rec.Format)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Format field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field("Application No."; Rec."Loan Application No.")
                {
                    ApplicationArea = All;

                }

            }
        }
    }


    actions
    {
        area(processing)
        {
            action("Open File")
            {
                ApplicationArea = Basic;
                Image = ChangeLog;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    file: File;
                    fileMan: Codeunit "File Management";
                begin
                    ///fileMan.open (file, Rec."Path");
                    if Rec."Blob Url" <> '' then
                        Hyperlink(Rec."Blob Url");
                end;
            }
        }
    }

}
