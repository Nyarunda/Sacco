
Page 50294 "Transaction Charges List"
{
    ApplicationArea = Basic;
    CardPageID = "Transaction Charges Card";
    Editable = false;
    PageType = List;
    SourceTable = "Transaction Charges";
    UsageCategory = Tasks;

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
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        UserSet: Record "User Setup";
    begin
        UserSet.Get(UserId);
        if Not UserSet."Update Transaction Charges" then error('You Do not have permission to update charges.[Update Transaction Charges]');
    end;
}

