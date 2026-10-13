page 50224 "Payroll Periods Card"
{
    Caption = 'Payroll Periods Card';
    PageType = Card;
    SourceTable = "Payroll Periods";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Name field.';
                }

                field("Date Opened"; Rec."Date Opened")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Name field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        RestrictAccess();
    end;

    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Payroll"');
    end;
}
