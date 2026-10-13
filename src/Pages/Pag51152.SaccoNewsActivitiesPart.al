page 51152 "Sacco News Activities Part"
{
    ApplicationArea = All;
    Caption = 'Sacco News & Activities';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Sacco News Activity";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    StyleExpr = TypeStyle;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    StyleExpr = TypeStyle;
                }
                field("Activity Date"; Rec."Activity Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ManageNewsActivities)
            {
                ApplicationArea = All;
                Caption = 'Manage';
                Image = EditList;
                RunObject = Page "Sacco News Activities";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetTypeStyle();
    end;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Active, "Sort Order", "Activity Date", "Entry No.");
        Rec.SetRange(Active, true);
        Rec.SetFilter("Valid From", '%1|<=%2', 0D, WorkDate());
        Rec.SetFilter("Valid To", '%1|>=%2', 0D, WorkDate());
    end;

    var
        TypeStyle: Text;

    local procedure SetTypeStyle()
    begin
        case Rec.Type of
            Rec.Type::Alert:
                TypeStyle := 'Attention';
            Rec.Type::Activity:
                TypeStyle := 'Strong';
            else
                TypeStyle := 'Standard';
        end;
    end;
}
