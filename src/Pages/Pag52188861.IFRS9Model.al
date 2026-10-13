page 50563 "IFRS-9 Model"
{
    Caption = 'IFRS-9 Model';
    PageType = List;
    SourceTable = "IFRS-9 Model";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stage field.';
                }
                field("IFRS Stage"; Rec."IFRS Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stage field.';
                }
                field(PD; Rec.PD)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PD field.';
                }
                field(LGD; Rec.LGD)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LGD field.';
                }
                field("No. Of Loans"; Rec."No. Of Loans")
                {
                    ApplicationArea = All;
                }
                field("Total Outstanding Balance"; Rec."Total Outstanding Balance")
                {
                    ApplicationArea = All;
                }
                field("Total ECL"; Rec."Total ECL")
                {
                    ApplicationArea = All;
                }
                field("As At"; Rec."As At")
                {
                    ApplicationArea = All;
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
        SaccoPermissions.SetRange("General Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "General Setups"');
    end;
}
