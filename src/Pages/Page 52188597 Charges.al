
Page 50260 Charges
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Charges.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChargeCode; Rec."Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount; Rec."Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeMethod; Rec."Charge Method")
                {
                    ApplicationArea = Basic;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic;
                }

                field(ChargeType; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargingOption; Rec."Charging Option")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account Type"; Rec."Charge Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargesGLAccount; Rec."Charges G_L Account")
                {
                    ApplicationArea = Basic;
                }
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic;
                }
                field(EffectExciseDuty; Rec."Effect Excise Duty")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Prorate; Rec.Prorate)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Type"; Rec."Posting Type")
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
        RestrictAccess
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

