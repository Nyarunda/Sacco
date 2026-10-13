
PageExtension 50075 pageextension50075 extends "G/L Account Card"
{
    layout
    {
        addafter("Direct Posting")
        {
            field("Cashier G/L"; Rec."Cashier G/L")
            {
                ApplicationArea = Basic;
            }
            field("Can Pay Board"; Rec."Can Pay Board")
            {
                ApplicationArea = Basic;
            }
            field("Can Pay Staff"; Rec."Can Pay Staff")
            {
                ApplicationArea = Basic;
            }

            field("Can Pay Member"; Rec."Can Pay Member")
            {
                ApplicationArea = Basic;
            }
            field("Budget Controlled"; Rec."Budget Controlled")
            {
                ApplicationArea = Basic;
            }
            field("Is VAT Account"; Rec."Is VAT Account")
            {
                ApplicationArea = Basic;
            }
        }


        modify("Direct Posting")
        {
            trigger OnAfterValidate()
            var
                GLEntry: Record "G/L Entry";
            begin
                if Rec."Direct Posting" then begin


                    GLEntry.Reset();
                    GLEntry.SetRange("G/L Account No.", Rec."No.");
                    if GLEntry.FindFirst() then
                        if (not GLEntry.IsEmpty()) and (not ByPassDirectPosting) then
                            Error('You do not have permission to direct post. "G/L Direct Posting"');
                    RestrictAccess;
                end;

            end;

        }

    }

    procedure ByPassDirectPosting(): Boolean
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("By Pass Direct Posting", true);
        if SaccoPermissions.FindFirst then
            exit(true)
        else
            exit(false);
    end;

    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("G/L Direct Posting", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "G/L Direct Posting"');
    end;
}

