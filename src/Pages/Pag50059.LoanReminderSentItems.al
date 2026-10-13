page 50059 "Loan Reminder Sent Items"
{
    ApplicationArea = All;
    Caption = 'Loan Reminder Sent Items';
    PageType = List;
    SourceTable = "Loan Reminder Notifications";
    SourceTableView = where(Status = const(Sent));
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Expected Date"; Rec."Expected Date")
                {
                    ApplicationArea = All;
                }
                field("Amount Due"; Rec."Amount Due")
                {
                    ApplicationArea = All;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ApplicationArea = All;
                }
                field("Notification Type"; Rec."Notification Type")
                {
                    ApplicationArea = All;
                }
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
