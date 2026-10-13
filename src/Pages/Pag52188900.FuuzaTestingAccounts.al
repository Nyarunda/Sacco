page 50602 "Fuuza Testing Accounts"
{
    Caption = 'Fuuza Testing Accounts';
    PageType = List;
    SourceTable = "Fuuza Testing Accounts";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        RestrictAccess;
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
