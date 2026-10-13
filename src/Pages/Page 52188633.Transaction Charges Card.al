
Page 50296 "Transaction Charges Card"
{
    PageType = Card;
    SourceTable = "Transaction Charges";

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultMode; Rec."Default Mode")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control9; "Transaction Charges Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = "Transaction Type" = field(Code);
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
            Error('You do not have the following permission: "Saving Setups"');
    end;

}

