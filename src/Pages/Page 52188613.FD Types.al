
Page 50276 "FD Types"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "FD Types";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(FDDuration; Rec."FD Duration")
                {
                    ApplicationArea = Basic;
                }
                field(Months; Rec.Months)
                {
                    ApplicationArea = Basic;
                }
                field(CallDeposit; Rec."Call Deposit")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control7; "FD Interest Rates")
            {
                SubPageLink = Code = field(Code);
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
        SaccoPermissions.SetRange("Savings Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Savings Setups"');
    end;

}

