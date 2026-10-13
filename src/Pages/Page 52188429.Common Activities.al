
Page 50064 "Common Activities"
{
    PageType = CardPart;
    SourceTable = "Sacco Cues";

    layout
    {
        area(content)
        {
            cuegroup(Leave)
            {
                field(LeaveApplication; Rec."Leave - Application")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeavePending; Rec."Leave - Pending")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeaveApproved; Rec."Leave - Approved")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeaveRejected; Rec."Leave - Rejected")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }

                actions
                {
                    action("Staff Claims List")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    action("Staff Imprest Requisition")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    action("Staff Imprest Surrender")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    action("Travel Advance Requisition")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    action("Travel Advance Surrender")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                }
            }
            cuegroup(Approvals)
            {
                field(ApprovalEntry; Rec."Approval Entry")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
                    LookupPageID = "Requests to Approve";
                }

                actions
                {
                    action("Requests to Approve")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "Requests to Approve";
                    }
                    action("Approval Request Entries")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "Approval Request Entries";
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        CustomNotification: Codeunit "Custom Notifications";

    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;


        //Create the notification
        //CustomNotification.Message('Test Notification');
        //CustomNotification.Scope := NotificationScope::LocalScope;
        //Send the notification to the client.
        //CustomNotification.Send();

        CustomNotification.GetApprovalsNotification();
        CustomNotification.GetFileMovementNotifications;
        CustomNotification.GetPendingChequeNotifications();
        CustomNotification.NotifyFinanceOfExitNotice();
        CustomNotification.NotifyCrditOfExitNotice();
        CustomNotification.GetLeaveBalanceNotifications();
        CustomNotification.GetExpiringContract();
        CustomNotification.GetExpiringProbation();
        CustomNotification.TreasuryNotifications();
        CustomNotification.GetJuniorAccountAgeNotifications();
        CustomNotification.SendLoanAppraiserNotification();
        CustomNotification.GetNextValuationExpiringCollateral();
        CustomNotification.GetApprovedStoreRequisitions();
        CustomNotification.GetATMExpiry();
        CustomNotification.GetApprovedFixedDeposits();
    end;
}

