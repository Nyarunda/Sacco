page 50791 "Member Notifications Card"
{
    ApplicationArea = All;
    Caption = 'Member Notification Card';
    PageType = Card;
    SourceTable = "Member Notifications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number of the notification.';
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Title"; Rec."Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification title.';
                    ShowMandatory = true;
                }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification category.';
                    ShowMandatory = true;
                }
                field("Is Read"; Rec."Is Read")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the notification has been read.';
                }
            }

            group(NotContent)
            {
                Caption = 'Content';

                field("Contents"; Rec."Content")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification content.';
                    MultiLine = true;
                    ShowMandatory = true;
                }
            }

            group(Link)
            {
                Caption = 'Link';

                field("Link Text"; Rec."Link Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the link text for the notification.';
                }
                field("Link URL"; Rec."Link URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the link URL for the notification.';
                    ExtendedDatatype = URL;
                }
            }

            group(Dates)
            {
                Caption = 'Date Information';

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the notification was created.';
                    Editable = false;
                }
                field("Relative Date"; Rec.FormatRelativeDate())
                {
                    ApplicationArea = All;
                    Caption = 'Relative Date';
                    ToolTip = 'Shows the relative time since notification was created.';
                    Editable = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the notification expires.';
                    ShowMandatory = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the notification.';
                    Editable = false;
                }
            }
        }

        area(factboxes)
        {
            part(MemberDetails; "Member Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Member No." = field("Member No.");
                Caption = 'Member Details';
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
                ToolTip = 'Mark this notification as read.';
                Enabled = not Rec."Is Read";

                trigger OnAction()
                begin
                    Rec."Is Read" := true;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action("Mark as Unread")
            {
                ApplicationArea = All;
                Caption = 'Mark as Unread';
                Image = MakeOrder;
                ToolTip = 'Mark this notification as unread.';
                Enabled = Rec."Is Read";

                trigger OnAction()
                begin
                    Rec."Is Read" := false;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action("Test Link")
            {
                ApplicationArea = All;
                Caption = 'Test Link';
                Image = Web;
                ToolTip = 'Test the notification link.';
                Enabled = Rec."Link URL" <> '';

                trigger OnAction()
                begin
                    if Rec."Link URL" <> '' then
                        Hyperlink(Rec."Link URL")
                    else
                        Message('No link URL specified.');
                end;
            }
            action("Duplicate Notification")
            {
                ApplicationArea = All;
                Caption = 'Duplicate';
                Image = Copy;
                ToolTip = 'Create a duplicate of this notification.';

                trigger OnAction()
                var
                    NewNotification: Record "Member Notifications";
                begin
                    NewNotification := Rec;
                    NewNotification."Entry No." := 0;
                    NewNotification."Created Date" := 0DT;
                    NewNotification."Created By" := '';
                    NewNotification."Is Read" := false;
                    NewNotification."Expiry Date" := CreateDateTime(CalcDate('<+30D>', Today), Time);
                    NewNotification.Insert(true);

                    Page.Run(Page::"Member Notifications Card", NewNotification);
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
            action("All Member Notifications")
            {
                ApplicationArea = All;
                Caption = 'All Member Notifications';
                Image = List;
                RunObject = page "Member Notifications List";
                RunPageLink = "Member No." = field("Member No.");
                ToolTip = 'View all notifications for this member.';
            }
        }
        area(reporting)
        {
            action("Print Notification")
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                ToolTip = 'Print this notification.';

                trigger OnAction()
                var
                    MemberNotifications: Record "Member Notifications";
                begin
                    MemberNotifications := Rec;
                    MemberNotifications.SetRecFilter();
                    // Report.RunModal(Report::"Member Notification Report", true, true, MemberNotifications);
                    Message('Print functionality to be implemented with report.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if not Rec."Is Read" then begin
            Rec."Is Read" := true;
            Rec.Modify();
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created Date" := CurrentDateTime;
        Rec."Created By" := UserId;
        Rec."Expiry Date" := CreateDateTime(CalcDate('<+30D>', Today), Time);
    end;
}