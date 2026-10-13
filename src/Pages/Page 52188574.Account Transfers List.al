
Page 50237 "Account Transfers List"
{
    ApplicationArea = Basic;
    CardPageID = "Account Transfer Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Account Transfers";
    UsageCategory = History;
    SourceTableView = where(Posted = const(false));
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
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
        Usersetup: record "User Setup";
    begin

        Rec.SetRange("Created By", UserId);

        UserSetup.Get(UserId);
        if not UserSetup."Account Transfer" then
            Error('You do not have any permissions for account transfer to access. Contact the administrator!');
    end;


}

