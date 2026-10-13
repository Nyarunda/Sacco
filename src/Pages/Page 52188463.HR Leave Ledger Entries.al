
Page 50126 "HR Leave Ledger Entries"
{
    Caption = 'Leave Ledger Entries';
    DataCaptionFields = "Leave Calendar Code";
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Ledger Entries.";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveCalendarCode; Rec."Leave Calendar Code")
                {
                    ApplicationArea = Basic;
                }
                field(StaffNo; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(StaffName; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveType; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveEntryType; Rec."Leave Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field(Noofdays; Rec."No. of days")
                {
                    ApplicationArea = Basic;
                }
                field(LeavePostingDescription; Rec."Leave Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Entry)
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    RunObject = Page "Default Dimension Where-Used";
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
        area(processing)
        {
            action(Navigate)
            {
                ApplicationArea = Basic;
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run;
                end;
            }
            action(Reverse)
            {
                ApplicationArea = Basic;
                Caption = '&Reverse';
                Promoted = true;
                PromotedCategory = Process;
                Image = ReverseLines;
                trigger OnAction()
                var
                    USetup: Record "User Setup";
                    LeaveLedger: Record "HR Leave Ledger Entries.";
                    LeaveCal: Record "HR Leave Calendar.";
                    EntryNo: Integer;
                begin
                    USetup.Reset();
                    USetup.SetRange("User ID", UserId);
                    USetup.SetRange("Is HR", true);
                    USetup.FindFirst();
                    if not Confirm('Are sure that you want to reverse leave line \ %1', false,
                    Rec."Leave Posting Description" + ' ' + Format(Rec."Posting Date") + ' ' + Rec."Staff Name") then
                        exit;

                    LeaveCal.Get(Rec."Leave Calendar Code");
                    LeaveCal.TestField("Current Leave Calendar", true);

                    Rec.Reversed := true;
                    Rec.Modify();

                    LeaveLedger.Reset();
                    if LeaveLedger.FindLast() then EntryNo := LeaveLedger."Entry No." + 1;

                    LeaveLedger.Init();
                    LeaveLedger.TransferFields(Rec);
                    LeaveLedger."Entry No." := EntryNo;
                    LeaveLedger."No. of days" *= -1;
                    LeaveLedger.Insert();

                    Message('Entry %1, was reversed successfully!', Rec."Entry No.");

                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
        Comp: Record "Company Information";
}

