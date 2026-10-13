
Page 50203 "Collateral Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Loan Collateral Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(CollateralMultiplier; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(RevaluationFrequency; Rec."Revaluation Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Tracker Validity Period";Rec."Tracker Validity Period")
                {
                    ApplicationArea = Basic;
                }
                field("Valuation Type"; Rec."Valuation Type")
                {
                    ApplicationArea = Basic;
                }


            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Credit Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Credit Setups"');
    end;

}

