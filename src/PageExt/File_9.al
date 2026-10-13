
PageExtension 50088 pageextension50088 extends "Bank Account List"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Bank Account List"(Page 371)".

    layout
    {
        addafter("Post Code")
        {
            field("GL Account"; Rec."GL Account")
            {
                ApplicationArea = Basic;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = Basic;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."View Banks" then
            error('You are not allowed to view bank accounts. Please concact ICT')

    end;
}

