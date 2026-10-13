
Page 50805 "FD Types List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "FD Types";
    CardPageId = "FD Types";
    UsageCategory = Tasks;

   layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("FD Duration"; Rec."FD Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FD Duration field.';
                }
                field(Months; Rec.Months)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Months field.';
                }
            }
        }
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
        SaccoPermissions.SetRange("Savings Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Savings Setups"');
    end;

}

