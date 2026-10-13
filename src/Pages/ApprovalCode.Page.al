Page 50458 "Approval Code"
{
    ApplicationArea = All;
    Caption = 'Approval Code';
    PageType = List;
    SourceTable = "Approval Code";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(LinkedToTableNo; Rec."Linked To Table No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Table Objects";
                }
                field(LinkedToTableName; Rec."Linked To Table Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Administration Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Administration Setups"');
    end;
}

