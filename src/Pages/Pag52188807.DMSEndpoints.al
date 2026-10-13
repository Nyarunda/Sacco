page 50489 "DMS Endpoints"
{
    Caption = 'DMS Endpoints';
    PageType = List;
    SourceTable = "DMS Endpoints";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Link Type"; Rec."Link Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Link field.';
                }
                field(Path; Rec.Path)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Path field.';
                }
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
        SaccoPermissions.SetRange("General Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "General Setups"');
    end;
}
