page 50790 "Member Notifications List"
{
    ApplicationArea = All;
    Caption = 'Member Notifications';
    PageType = List;
    SourceTable = "Member Notifications";
    UsageCategory = Lists;
    CardPageId = "Member Notifications Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number of the notification.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number.';
                }
                field("Title"; Rec."Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification title.';
                    StyleExpr = TitleStyleExpr;
                }
                field("Contents"; Rec."Content")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification content.';
                }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification category.';
                    StyleExpr = CategoryStyleExpr;
                }
                field("Is Read"; Rec."Is Read")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the notification has been read.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the notification was created.';
                }
                field("Relative Date"; Rec.FormatRelativeDate())
                {
                    ApplicationArea = All;
                    Caption = 'Relative Date';
                    ToolTip = 'Shows the relative time since notification was created.';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the notification expires.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the notification.';
                }
                field("Link Text"; Rec."Link Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the link text for the notification.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Mark as Read")
            {
                ApplicationArea = All;
                Caption = 'Mark as Read';
                Image = Confirm;
                ToolTip = 'Mark the selected notifications as read.';

                trigger OnAction()
                var
                    MemberNotifications: Record "Member Notifications";
                begin
                    CurrPage.SetSelectionFilter(MemberNotifications);
                    if MemberNotifications.FindSet() then begin
                        repeat
                            MemberNotifications."Is Read" := true;
                            MemberNotifications.Modify();
                        until MemberNotifications.Next() = 0;
                        CurrPage.Update();
                    end;
                end;
            }
            action("Mark as Unread")
            {
                ApplicationArea = All;
                Caption = 'Mark as Unread';
                Image = MakeOrder;
                ToolTip = 'Mark the selected notifications as unread.';

                trigger OnAction()
                var
                    MemberNotifications: Record "Member Notifications";
                begin
                    CurrPage.SetSelectionFilter(MemberNotifications);
                    if MemberNotifications.FindSet() then begin
                        repeat
                            MemberNotifications."Is Read" := false;
                            MemberNotifications.Modify();
                        until MemberNotifications.Next() = 0;
                        CurrPage.Update();
                    end;
                end;
            }
            action("Delete Expired")
            {
                ApplicationArea = All;
                Caption = 'Delete Expired';
                Image = Delete;
                ToolTip = 'Delete all expired notifications.';

                trigger OnAction()
                var
                    MemberNotifications: Record "Member Notifications";
                    DeletedCount: Integer;
                begin
                    if Confirm('Do you want to delete all expired notifications?') then begin
                        MemberNotifications.SetFilter("Expiry Date", '<%1', CurrentDateTime);
                        DeletedCount := MemberNotifications.Count;
                        MemberNotifications.DeleteAll();
                        Message('%1 expired notifications deleted.', DeletedCount);
                        CurrPage.Update();
                    end;
                end;
            }
        }
        area(navigation)
        {
            action("Member Card")
            {
                ApplicationArea = All;
                Caption = 'Member Card';
                Image = Customer;
                RunObject = page "Member Card";
                RunPageLink = "No." = field("Member No.");
                ToolTip = 'Open the member card.';
            }
            action("Follow Link")
            {
                ApplicationArea = All;
                Caption = 'Follow Link';
                Image = Web;
                ToolTip = 'Follow the notification link.';
                Enabled = LinkEnabled;

                trigger OnAction()
                begin
                    if Rec."Link URL" <> '' then
                        Hyperlink(Rec."Link URL");
                end;
            }
        }
    }

    views
    {
        view(UnreadNotifications)
        {
            Caption = 'Unread Notifications';
            Filters = where("Is Read" = const(false));
            OrderBy = descending("Created Date");
        }
        view(ImportantNotifications)
        {
            Caption = 'Important Notifications';
            Filters = where("Category" = const(Important));
            OrderBy = descending("Created Date");
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyleExpressions();
        LinkEnabled := Rec."Link URL" <> '';
    end;

    local procedure SetStyleExpressions()
    begin
        // Set title style based on read status
        if not Rec."Is Read" then
            TitleStyleExpr := 'Strong'
        else
            TitleStyleExpr := '';

        // Set category style based on category type
        case Rec.Category of
            Rec.Category::Important:
                CategoryStyleExpr := 'Attention';
            Rec.Category::System:
                CategoryStyleExpr := 'StandardAccent';
            Rec.Category::Loan:
                CategoryStyleExpr := 'Favorable';
            else
                CategoryStyleExpr := '';
        end;
    end;

    var
        TitleStyleExpr: Text;
        CategoryStyleExpr: Text;
        LinkEnabled: Boolean;
}