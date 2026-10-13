page 50492 "Registry & Credit Role Center"
{
    Caption = 'Registry & Credit Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control60; "Headline RC Relationship Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(SaccoNewsActivities; "Sacco News Activities Part")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control13; "Common Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control1; "Loan Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(CategoriesPieChart; "Categories Chart")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control12; "Member Activites")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control56; "User Tasks Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }

            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control45; "Self Service")
            {
                ApplicationArea = RelationshipMgmt;
            }
            /*part(Control16; "Team Member Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }*/
        }
    }

    actions
    {
        area(reporting)
        {

        }

        area(sections)
        {


            group(Action257)
            {
                Caption = 'Membership Management';
                group(IDM)
                {
                    Caption = 'IDM';


                    action(Action1670)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Individual Member Registration';
                        Image = CustomerContact;


                        RunObject = Page "Member IDM Registration List";
                        ToolTip = 'Create Individual Member Account';
                    }
                    action(Action660)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'IDM Verification Workbench';


                        RunObject = Page "IDM Verification Workbench";
                        ToolTip = 'Create Group Account';
                    }
                }

                group(Registration)
                {
                    Caption = 'Registration';

                    action(MemberRegistrationOpenList)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Registration - Open List';
                        Image = CustomerContact;
                        RunObject = Page "Member Registration List";
                        RunPageView = where(Status = const(Open));
                        ToolTip = 'View open member registration applications';
                    }
                    action(MemberRegistrationPendingList)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Registration - Pending List';
                        Image = SendApprovalRequest;
                        RunObject = Page "Member Registration List";
                        RunPageView = where(Status = const(Pending));
                        ToolTip = 'View pending member registration applications';
                    }
                    action(MemberRegistrationApprovedList)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Registration - Approved List';
                        Image = Approve;
                        RunObject = Page "Member Registration List";
                        RunPageView = where(Status = const(Approved));
                        ToolTip = 'View approved member registration applications';
                    }
                    action(MemberRegistrationCreatedList)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Registration - Created List';
                        Image = CreateDocument;
                        RunObject = Page "Member Registration List";
                        RunPageView = where(Status = const(Created));
                        ToolTip = 'View created member registration applications';
                    }
                    action(Action66)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Joint Account Registration';


                        RunObject = Page "Joint Account Registration";
                        ToolTip = 'Create Group Account';
                    }
                    action(Action70)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Welfare Account Registration';
                        visible = false;

                        RunObject = Page "Welfare Account Registration";
                        ToolTip = 'Create Welfare Account';
                    }
                    action(Action65)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Micro Group Application';
                        Image = Quote;


                        RunObject = Page "Micro Group Application";
                    }
                    action(Action1w65)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Chamaa Registration';
                        Image = Quote;


                        RunObject = Page "Chamaa Registration";
                    }
                    action(Action67)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Business Reg. List';
                        Image = Quote;


                        RunObject = Page "Business Reg. List";
                    }

                    action(Action68)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Savings Account Application - Open List';
                        Image = Quote;


                        RunObject = Page "Member Accounts App. List";
                    }
                    action(MemberAccPendingApprovalList)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Savings Account Application - Pending Approval List';
                        Image = SendApprovalRequest;
                        RunObject = page "Member Acc App List - Pending";
                    }
                    action(MemberAccApprovedList)
                    {
                        ApplicationArea = Basic;
                        Image = Approve;
                        Caption = 'Savings Account Application -  Approved List';
                        RunObject = page "Member Acc App List - Approved";
                    }
                    action(MemberAccPostedList)
                    {
                        ApplicationArea = Basic;
                        Image = PostDocument;
                        Caption = 'Savings Account Application - Posted List';
                        RunObject = page "Member Acc App List - Posted";
                    }

                }

                group(Membership)
                {
                    Caption = 'Membership';

                    action(Action64)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member List';
                        Image = "Order";


                        RunObject = Page "Member List";
                        ToolTip = 'List of all SACCO Members';
                    }
                    action(Action655)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Member List - Joint';
                        Image = "Order";


                        RunObject = Page "Joint Members";
                        ToolTip = 'List of all SACCO Members';
                    }

                    action(Action650)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Welfare List - Joint';
                        Image = "Order";


                        RunObject = Page "Welfare Members";
                        ToolTip = 'List of all Welfare SACCO Members';
                    }
                    action(Actin1w65)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Chamaa/Investment List';
                        Image = Quote;


                        RunObject = Page "Chamaa List";
                    }
                    action("Group List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        visible = false;
                        Caption = 'Micro Group List';
                        Image = Reminder;


                        RunObject = Page "Group List";
                    }
                    action(Business)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Business Member List';
                        Image = Quote;


                        RunObject = Page "Business Member List";
                    }
                    action("Information Base Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Information Base Report';
                        Image = Quote;


                        RunObject = Report "Info Base";
                    }


                }

                group("File Management")
                {
                    Visible = false;

                    action(Action699)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement List - To Issue/Return';
                        //Caption = 'File Movement List - To Issue/Transfer';
                        Image = Quote;
                        RunObject = Page "File Movement - To Issue";
                    }

                    action(Action799)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement List - To Receive';
                        Image = Quote;
                        RunObject = Page "File Movement - To Receive";
                    }
                    action(Action899)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement List - Processed';
                        Image = Quote;
                        RunObject = Page "File Movement - Processed";
                    }
                    action(Action399)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement Report';
                        Image = Quote;
                        RunObject = Report "File Movement Report";
                    }

                }

                group("Cheque Dispatch")
                {
                    action(Action006)
                    {
                        ApplicationArea = RelationshipMgmt;
                        visible = false;
                        Caption = 'Cheque Dispatch';
                        Image = CheckLedger;
                        RunObject = Page "Cheque Dispatch List";
                    }

                }
                group(MembershipExit)
                {
                    Caption = 'Membership Exit';

                    action(ExitNotice)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice - Customer Care';
                        Image = Reminder;


                        RunObject = Page "Member Exit Notice";
                    }
                    action("HOD Exit Notice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice - HOD Customer Care';
                        Image = Reminder;
                        RunObject = Page "Member Exit Notice - HOD";
                    }

                    action("Credit Exit Notice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice - Credit';
                        Image = Reminder;
                        RunObject = Page "Member Exit Notice - Credit";
                    }


                    action("Pending Exit Notice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice HOD Credit';
                        Image = Reminder;


                        RunObject = Page "Member Exit Notice Pending";
                    }
                    /* action("Approved ExitNotice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice Approved';
                        Image = Reminder;


                        RunObject = Page "Member Exit Notice Approved";
                    } */
                    action("Finance Exit Notice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice - Finance';
                        Image = Reminder;
                        RunObject = Page "Member Exit Notice - Finance";
                    }

                    action(MemberExit)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal';
                        Image = Reminder;
                        RunObject = Page "Member Exit List";
                    }
                    action("Pending Member Exit")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Pending Member Withdrawal';
                        Image = Reminder;
                        RunObject = Page "Member Exit Pending";
                    }
                    action("Approved Member Exit")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Approved Member Withdrawal';
                        Image = Reminder;
                        RunObject = Page "Member Exit Approved";
                    }

                }

                group(Periodic)
                {
                    Caption = 'Periodic Activities';

                    action(Action69)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Changes';
                        Image = "Order";


                        RunObject = Page "Member Changes List";
                        RunPageView = where("Approval Status" = const(Open), Posted = const(false));
                        ToolTip = 'Edit Member Details';
                    }

                    action(MemberChangesPendingApproval)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Changes Pending Approval';
                        Image = Approval;

                        RunObject = Page "Member Changes List";
                        RunPageView = where("Approval Status" = const(Pending), Posted = const(false));
                        ToolTip = 'View member changes pending approval';
                    }

                    action(MemberChangesApproved)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Changes Approved';
                        Image = Approval;

                        RunObject = Page "Member Changes List";
                        RunPageView = where("Approval Status" = const(Approved), Posted = const(false));
                        ToolTip = 'View member changes pending Approved';
                    }
                    action(Action90)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Member Changes';
                        Image = "Order";


                        RunObject = Page "Posted Member Changes";
                        ToolTip = 'Edit Member Details';
                    }



                    // "Sky NOK Application List"
                    action("Sky NOK Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Next of Kin Applications';
                        Image = "Order";
                        RunObject = Page "Sky NOK Application List";
                        ToolTip = 'View Next of Kin Applications';
                    }
                    // "Contact Person App.List
                    action("Contact Person Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Contact Person Applications';
                        Image = "Order";
                        RunObject = Page "Contact Person App. List";
                        ToolTip = 'View Contact Person Applications';
                    }
                    action(Action270)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customer Complaints';
                        Image = Campaign;
                        RunObject = Page "Case List";
                        ToolTip = 'Customer Complaints List';
                    }

                    action(Action269)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Portal Change Request';
                        Image = "Order";


                        RunObject = Page "Portal Change Request";
                        ToolTip = 'Edit Member Details';
                    }

                    action(PortalUploads)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Portal Uploads';
                        Image = UpdateXML;

                        RunObject = Page "Portal Uploads";
                    }

                    action(PortalUsers)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Portal Users';
                        Image = UpdateXML;

                        RunObject = Page "Portal users";
                    }
                    action("BBF Entitlement")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'GFE Claims';
                        Image = AdjustEntries;
                        Visible = false;

                        RunObject = Page "BBF Entitlements List";
                    }

                    action("Registration Commissions")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Registration Commissions';
                        Visible = false;
                        Image = Reminder;
                        RunObject = Page "Registration Commissions";
                    }
                    action("E-Mail Member Statement")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'E-Mail Member Statement';
                        Image = Reminder;
                        RunObject = Report "E-Mail Member Statement";
                    }
                    action("Meeting Attendance")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;
                        RunObject = Page "Meeting Attendance List";
                    }
                    action("Meeting Attendance - ALL")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;
                        RunObject = Page "Meeting Attendance List - ALL";
                    }

                }

                group(Reports)
                {
                    Caption = 'Reports';

                    action("Member List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Listing';
                        Image = "Order";
                        Visible = false;
                        RunObject = Report "Member List";
                    }
                    action("Member Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Register';
                        Image = "Order";
                        RunObject = Report "Member Register";
                    }
                    action("New Members Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'New Members Report';
                        Image = "Order";
                        visible = false;


                        RunObject = Report "New Members Report";
                    }
                    action("Close Of Day Membership")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Close of Day Membership Report';
                        Image = "Order";


                        RunObject = Report "Close of Day Membership Report";
                    }
                    action("Member Balances Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Balances Report';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Savings List Register";
                    }
                    action(PostedMemberChanges)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Changes report';
                        Image = Log;
                        RunObject = Report "Posted Member Changes Log";
                        ToolTip = 'View posted member changes report';
                    }
                    action("Member Deposit Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Deposit Report';
                        Image = "Order";
                        visible = false;


                        RunObject = Report "Member Deposit Report";
                    }
                    action("Members Without Shares")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Members Without Shares';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Members Without Shares";
                    }
                    action("Deceased Acc. With Balances")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Deceased Members With Balances';
                        Image = "Order";


                        RunObject = Report "Deceased Acc. With Balances";
                    }
                    action("Member Withdrawals Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Exit Notice Report';
                        Image = "Order";


                        RunObject = Report "Membership Closure Report";
                    }
                    action("Member Recruitement Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Recruitement Report';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Member Recruitement Report";
                    }
                    action("GFE Claims Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'GFE Claims Report';
                        Image = Report2;
                        Visible = false;

                        RunObject = Report "GFE Claims";
                    }

                    action("Member GFE Contribution")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member GFE Contribution';
                        Image = Report2;
                        Visible = false;

                        RunObject = Report "Member GFE Contribution";
                    }
                    action("Next of Kin")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        Caption = 'Next of Kin/ Nominee Report';

                        RunObject = Report "BENEVOLENT/NEXT OF KIN DATA";
                    }

                }

            }

            group(Action357)
            {
                Caption = 'Credit';

                group(CollateralGroup)
                {
                    Caption = 'Collateral Management';

                    action(Collateral)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Collateral Register';
                        Image = CustomerContact;


                        RunObject = Page "Collateral List";
                    }
                    action(CollateralRetun)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Collateral Return';


                        RunObject = Page "Collateral Return List";
                    }
                    action(CollateralHistroy)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Collateral Valuation';


                        RunObject = Page "Collateral Histroy List";

                    }
                    action(SecurityChanges)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Security Changes';
                        Visible = false;

                        RunObject = Page "Loan Security Changes List";

                    }
                    group(Report)
                    {
                        action("Collateral Register Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Security Register Report';

                            RunObject = Report "Collateral Register";
                        }
                        action("Collateral Retun Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Collateral Return Report';

                            RunObject = Report "Collateral Return";
                        }
                    }
                }

                group(LoanManagement)
                {
                    Caption = 'Loan Management';

                    action("Salary Appraisal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Application List';
                        Image = "Order";


                        RunObject = Page "Salary Appraisal";
                    }

                    action("Loan Appraisal List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Appraisal List';
                        Image = "Order";

                        RunObject = Page "Loan Appraisal List";
                    }



                    // 52188794

                    action("Online Mobile Loan Applications")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        Visible = false;
                        RunObject = Page "Online Mobile Loans";
                    }
                    action(LoanPending)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Pending Approval';
                        Image = "Order";


                        RunObject = Page "Loan Application List - Pendin";
                    }
                    action(LoanRejected)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Rejected Approval';
                        Image = "Order";

                        RunObject = Page "Loan Rejected Approval";
                    }
                    action(LoanApproved)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Approved List';
                        Image = "Order";


                        RunObject = Page "Loans Approved List";
                    }

                    action("Completed Salary Appraisal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Completed Loan Appraisal List';
                        Image = History;

                        RunObject = Page "Completed Salary Appraisal";
                    }
                    action(LoanApplication)
                    {
                        ApplicationArea = RelationshipMgmt;

                        Image = "Order";
                        Caption = 'Loans Pending Disbursement';


                        RunObject = Page "Loan Application List";
                    }

                    action(LoanFinance)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Pending Finance';
                        Image = "Order";
                        Visible = false;


                        RunObject = Page "Loan Pending Finance List";
                    }

                    action(LoanDisbursement)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Pending Posting';
                        visible = false;
                        Image = "Order";

                        RunObject = Page "Loan Disbursement List";
                    }

                    action("Credit Accounts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Credit Accounts';
                        Image = "Order";


                        RunObject = Page "Credit Accounts List";
                    }
                    action(PortalLoans)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Portal Loan Application';
                        Image = "Order";


                        RunObject = Page "Portal Loans List";
                    }
                    action("Loan Batch List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Loan Batch List';
                        Image = Reminder;


                        RunObject = Page "Loan Disbursement List";
                    }


                    action(PostedLoans)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Loans';
                        Image = "Order";


                        RunObject = Page "Loan Posted List";
                    }
                    action("Loan Defaulter Analysis")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Page "Loan Defaulter Analysis";
                    }

                    action("Loan Changes")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Loan Changes List';
                        Image = Change;
                        RunObject = page "Loan Changes List";
                    }
                    action("Posted Loan Changes")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Loan Changes List';
                        Image = PostedOrder;
                        RunObject = page "Posted Loan Changes List";
                    }

                    action("Partial Loan Disbursement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Partial Loan Disbursement';
                        Image = DistributionGroup;


                        RunObject = Page "Partial Loan Disb. List";
                    }
                    action("Posted Partial Disbursement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Partial Disbursement';
                        Image = DistributionGroup;


                        RunObject = Page "Posted Partial Loan Disb. List";
                    }

                    action("PostedBatches")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Loan Batches';
                        Image = Reminder;
                        Visible = false;

                        RunObject = Page "Posted Loan Disbursement List";
                    }
                    action("Security Substitution List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;


                        RunObject = Page "Security Substitution List";
                    }

                    //SUB LIST 

                    action("Posted Security Substitution List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;


                        RunObject = Page "Posted Security Sub List";
                    }
                    action(LoanWriteoff)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Write-Off List';
                        Image = "Order";
                        RunObject = Page "Loans Writeoff List";

                    }

                }

                group(LoanReports)
                {
                    Caption = 'Reports';

                    action(LoanAppReg)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Application Register';
                        Image = "Order";


                        RunObject = Report "Loan Application Register";
                    }

                    action(LoanAnalysisByAmount)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Analysis By Amounts Disbursed';
                        Image = "Order";


                        RunObject = Report "Analysis By Amounts Disbursed";
                    }
                    action(membersWithMorethan1loan)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Members With More Than 1 Loan';
                        Image = "Order";


                        RunObject = Report "Members With More Than 1 Loan";
                    }
                    action(LoanSummarySheet)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Summary Sheet';
                        Image = "Order";


                        RunObject = Report "Loan Summary Sheet";
                    }
                    action(loansDisbursedList)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Disbursed List';
                        Image = "Order";
                        RunObject = Report "Loans Disbursed List";
                    }

                    action(loanRegister)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Register';
                        Image = "Order";
                        RunObject = Report "Loans Register";
                    }

                    action("Loan Register Age")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Register & Age';
                        Visible = false;
                        Image = "Order";


                        RunObject = Report "Member Age & Loans";
                    }
                    action("Loans Disbursement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Disbursement';
                        Image = "Order";


                        RunObject = Report "Loan Disbursement";
                    }

                    action("Loans Variance")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Loans Variance Report";
                    }

                    action("Savings Variance")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Savings Variance";
                    }
                    action("Loan Guard")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Loan Guard Report";
                    }

                    action("Loan Recheduled Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        Caption = 'Loan Recheduled Report';

                        RunObject = Report "Loan Rescheduled Report";

                    }

                    action("WriteOff Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        Caption = 'Write-Off Listing';

                        RunObject = Report "Writeoff Listing Report";
                    }


                    group(Summary)
                    {

                        action("Loan Product Summary")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loan Product Summary';
                            Image = "Order";


                            RunObject = Report "Loans Product Summary";
                        }
                        action("Loan Product Summ. Comparison")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loan Product Summ. Comparison';
                            Image = "Order";


                            RunObject = Report "Loan Product Summ. Comparison";
                        }
                        action("Loan Portfolio Summary")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loan Portfolio Summary';
                            Image = "Order";


                            RunObject = Report "Loan Portfolio Summary";
                        }
                        action("Gross Loans Disbursed")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";


                            RunObject = Report "Gross Loans Disbursed";
                        }
                        action("Graphical Gross Loans Disbursed")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";


                            RunObject = Report "Gross Loans Disbursed - G";
                        }
                        action("Net Loans Disbursed")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";


                            RunObject = Report "Net Loans Disbursed";
                        }
                        action("Product Variance Analysis-Annual")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Gross Loan Portfolio";
                        }
                        action("Summary Loan Ageing")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Summary Loan Ageing";
                        }
                        action("Loan Disburement Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Loan Disbursement Report";
                        }
                        /*action("Loan Performance Analysis")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Loan Performance Analysis";
                        action("Loan Product Analysis")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Loan Product Analysis";
                        }
                        }*/
                        action("Loan Performance Analysis New")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Loan Performance Analysis New";
                        }

                        action("NPL Analysis per RO")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "NPL Analysis per RO";
                        }
                        action("Arrears Movement per RO")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Arrears Movement per RO";
                        }
                        action("Loans Product Summary")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Loans Product Summary";
                        }
                        action("Loans Collection Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Collection Report";
                        }
                    }
                    group(Debt)
                    {
                        action("Debt Collection")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Debt Collection";
                        }
                        action("Debt Collector Allocation")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";
                            RunObject = Report "Debt Collector Allocation";
                        }
                    }
                    action("Monthly Contribution Changes")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Contribution Changes';
                        Image = "Order";
                        RunObject = Report "Monthly Contribution Changes";
                    }
                    group(Aging)
                    {

                        action("Prod Defaulter Aging")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Prod Defaulter Aging';
                            Image = "Order";
                            Visible = false;
                            RunObject = Report "Prod Defaulter Aging -report";
                        }
                        action("Emp Defaulter Aging")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Emp Defaulter Aging';
                            Image = "Order";
                            Visible = false;


                            RunObject = Report "Emp Defaulter Aging -report";
                        }

                    }
                    group(Interest)
                    {
                        action("Loans Due Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Due Report';
                            Image = DueDate;
                            RunObject = Report "Loans Due Report";
                        }
                        action("Loans Interest Monitor")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Interest Monitor';
                            Image = "Order";


                            RunObject = Report "Loans Interest Monitor";
                        }
                    }
                    group(Guarantors)
                    {
                        action("Loan Guarantors Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Guaranteed By Member';
                            Image = GanttChart;
                            RunObject = Report "Loans Guarantors";
                        }
                        action("Loans Guaranteed Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Guaranteed Report';
                            Image = Line;
                            RunObject = report "Loan Guaranteed";
                        }
                        action(Guarantorsub)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = Report;
                            Caption = 'Guarantor Substitution Report';

                            RunObject = report "Guarantor Substitution Report";
                        }
                        action("Update Guarantor Committement")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Guarantor Committement';
                            Image = Line;
                            RunObject = report "Update Guarantor Commitment";
                        }
                        action("Guarantors Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Guarantors Report';
                            Image = Line;
                            RunObject = report "Guarantors Report";
                        }
                    }


                    action("Collateral Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Collateral Register';
                        Image = Line;
                        RunObject = report "Collateral Register";
                    }
                    action("Expected vs Received")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Expected vs Received';
                        Image = ExportReceipt;
                        RunObject = report "Expected vs Received";
                    }
                    action("Loans Defaulter Recovery")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Defaulter Recovery';
                        Image = Report2;

                        RunObject = Report "Loan Defaulter Recovery";
                    }

                    action(Eligibility)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Loans Eligibility';
                        Image = "Order";


                        RunObject = Report "Member Loans Eligibility";
                    }

                }

            }

            group(Action457)
            {
                Caption = 'Savings';

                group(Accounts)
                {
                    Caption = 'Member Accounts';

                    action(MAccounts)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Accounts List';
                        Image = CustomerContact;


                        RunObject = Page "Member Accounts List";
                    }
                }

                group(Cashier)
                {
                    Caption = 'Cashier - Treasury';
                    Visible = false;

                    action("Teller Transactions List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Teller Transactions List';
                        Image = CustomerContact;


                        RunObject = Page "Teller Transactions List";
                    }
                    action(MicroTransList)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Micro Transactions List';
                        Image = CustomerContact;


                        RunObject = Page "Micro Transactions List";
                    }
                    action("Teller Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Teller Report';
                        Image = Report;


                        RunObject = Report "Teller Report";
                    }

                    action("Teller Summary Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Teller Summary Report';
                        Image = Report;
                        RunObject = Report "Daily Teller Transactions";
                    }

                    action("Treasury/Teller Transactions List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Treasury/Teller Transactions List';
                        Image = CustomerContact;


                        RunObject = Page "Treasury/Teller Trans. List";
                    }
                    action("Teller Transactions List - Posted")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Teller Transactions List - Posted';
                        Image = CustomerContact;


                        RunObject = Page "Teller Transactions - Posted";
                    }
                    action("Posted Treasury/Teller List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Treasury/Teller List';
                        Image = CustomerContact;
                        RunObject = Page "Posted Treasury/Teller List";
                    }


                }

                group(Transfers)
                {
                    Caption = 'Account Transfers';

                    action("Account Transfers List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Account Transfers List';
                        Image = "Order";


                        RunObject = Page "Account Transfers List";
                    }
                    action("Posted Account Transfers List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Account Transfers List';
                        Image = "Order";


                        RunObject = Page "Posted Acc Transfer List";
                    }
                    action("EFT Transfers List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'EFT/RTGS Transfers List';
                        Image = "Order";


                        RunObject = Page "EFT Transfer List";
                    }
                    action("Posted EFT Transfers List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted EFT/RTGS Transfers List';
                        Image = "Order";


                        RunObject = Page "Posted EFT Transfer List";
                    }

                }

                group(ShareTrading)
                {
                    Caption = 'Share Trading';
                    action("Share Trading List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Share Trading List';
                        Image = TransferFunds;


                        RunObject = Page "Share Trading List";
                    }
                    action("Posted Share Trading List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Share Trading List';
                        Image = TransferFunds;


                        RunObject = Page "Posted Share Transfer List";
                    }
                }

                group(FDRManagement)
                {
                    Caption = 'Fixed Deposit Management';

                    action(FDR)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Deposit Accounts';
                        Image = "Order";


                        RunObject = Page "Fixed Deposit Accounts";
                    }

                    action("Active Fixed Deposit Accounts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Active Fixed Deposit Accounts';
                        Image = List;

                        RunObject = Page "Fixed Deposit Accounts";
                        RunPageView = where("FD Status" = const(Active));
                    }

                    action("Matured Fixed Deposit Accounts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Matured Fixed Deposit Accounts';
                        Image = List;

                        RunObject = Page "Fixed Deposit Accounts";
                        RunPageView = where("FD Status" = const(Matured));
                    }

                    action("Forfeited Fixed Deposit Accounts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Forfeited Fixed Deposit Accounts';
                        Image = List;

                        RunObject = Page "Fixed Deposit Accounts";
                        RunPageView = where("FD Status" = const(Forfeited));
                    }

                    action("Process Fixed Deposit")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Process Fixed Deposit';
                        Image = Reminder;

                        RunObject = Report "Process Fixed Deposit";
                    }


                    action("Fixed Deposit Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Deposit Register';
                        Image = "Order";


                        RunObject = Report "Fixed Deposit Register";
                    }

                }

                group(STO)
                {
                    Caption = 'STO Management';

                    action("Standing Orders List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Standing Orders List';
                        Image = "Order";


                        RunObject = Page "Standing Orders List";
                    }
                    action("Standing Order Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Standing Order Register';
                        Image = "Order";


                        RunObject = Page "Standing Order Register";
                    }
                    action("Process Standing Order")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Process Standing Order';
                        Image = "Order";


                        RunObject = Report "Process Standing Order";
                    }

                }

                group(Salary)
                {
                    Caption = 'Salary Processing';
                    Visible = true;

                    action("Salary List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Salary List';
                        Image = "Order";


                        RunObject = Page "Salary List";
                    }
                    action("Posted Salary List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Salary List';
                        Image = History;


                        RunObject = Page "Posted Salary List";
                    }
                    action("Direct Debit")
                    {
                        Visible = false;
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Direct Debit List';
                        Image = History;


                        RunObject = Page "Direct Debit List";
                    }
                    action("Posted Direct Debit")
                    {
                        Visible = false;
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Direct Debit List';
                        Image = History;


                        RunObject = Page "Posted Direct Debit";
                    }
                }



                group(ChequeManagement)
                {
                    Caption = 'Cheque Management';
                    Visible = false;

                    action("Cheque Clearing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Cheque Clearing';
                        Image = "Order";


                        RunObject = Page "Cheque Clearing";
                    }

                    action("Old Cheque Clearing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'OLD Cheque Clearing';
                        Image = "Order";


                        RunObject = Page "Old Cheque Clearing";
                    }

                    action("Bankers Cheq. Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Bankers Cheq. Application List';
                        Image = "Order";


                        RunObject = Page "Bankers Cheq. Application List";
                    }

                    action("Cheques Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Cheques Register';
                        Image = "Order";


                        RunObject = Report "Cheques Register";
                    }

                    action("Cheque Register Detailed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Cheque Register Detailed';
                        Image = "Order";


                        RunObject = Report "Cheque Register Detailed";
                    }

                }

                group(SavingsReports)
                {
                    Caption = 'Reports';

                    action("Savings List Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Savings List Register';
                        Image = "Order";


                        RunObject = Report "Savings List Register";
                    }
                    action("Savings List Register DRS")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Savings List Register DRS';
                        Image = "Order";


                        RunObject = Report "Savings List Register DRS";
                    }

                    action("Fosa Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fosa Register';
                        Image = "Order";


                        RunObject = Report "Fosa Register";
                    }

                    action("Savings Progression Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Savings Progression Report';
                        Image = "Order";
                        Visible = true;


                        RunObject = Report "Savings Progression Report";
                    }
                    action("Savings Progression Money - IN ")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Savings Progression Money-IN';
                        Image = "Order";
                        Visible = true;


                        RunObject = Report "Savings Progression Money-IN";
                    }

                    action("Account Transfers Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Account Transfers Report';
                        Image = "Order";


                        RunObject = Report "Account Transfers Report";
                    }

                    action("Dividends To Deposits")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Dividends To Deposits";
                    }
                    action("Gl Entries TRansactions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = SettleOpenTransactions;
                        Caption = 'Deposit Mobilization';


                        RunObject = Report "Gl Transactions";
                    }
                }

                group("FOSA Interest")
                {
                    Caption = 'BOSA Interest';

                    action(Action5229)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'FOSA Interest List';
                        Image = "Order";
                        RunObject = Page "FOSA Interest List";
                    }
                    action(Action5295)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'FOSA Interest List 2';
                        Image = "Order";
                        RunObject = Page "FOSA Interest List 2";
                    }
                    action(Action5296)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'New FOSA Interest List';
                        Image = "Order";
                        RunObject = Page "Saving Interest Header";
                    }
                    action(Action5297)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Import Old Fosa Interest List';
                        Image = "Order";
                        RunObject = xmlport "Import Old Fosa Interest";
                    }
                    /* action(Action5298)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Old Fosa Interest List';
                        Image = "Order";
                        RunObject = Page 52189123;
                    } */

                    action(Action5299)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Transfer Old Fosa Interest';
                        Image = "Order";
                        RunObject = Report "Transfer Old Interest";
                    }

                    action(Action5230)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted FOSA Interest List';
                        Image = "Order";
                        RunObject = Page "Posted FOSA Interest List";
                    }

                    action("Post Annual FOSA Interest")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = TransferToGeneralJournal;

                        RunObject = Page "FOSA Interest Buffer Staging";
                    }


                }

                group(DividendProcessing)
                {
                    Caption = 'Dividend Processing';


                    action("Dividend Simulation")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dividend Simulation ';
                        Image = "Order";


                        RunObject = Page "Dividend Simulation Header";
                    }
                    action("Dividend Progression")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dividend Progression';
                        Image = "Order";


                        RunObject = Page "Dividend Progression";
                    }

                    action("Dividend Posting Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dividend Posting Buffer';
                        Image = "Order";


                        RunObject = Page "Dividend Posting Buffer";
                    }
                    action("Unqualified Dividend Advance")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Unqualified Dividend Advance';
                        Image = "Order";


                        RunObject = Report "Unqualified For Dividend Adv";

                    }
                    action("Old Div List 2024")
                    {
                        ApplicationArea = All;
                        Image = BreakRulesOff;

                        RunObject = Page "Old Div Pages";
                    }
                    action("Old Div List 2025")
                    {
                        ApplicationArea = All;
                        Image = BreakRulesOff;

                        RunObject = Page "Div Progression";
                    }
                    action("Import Dividends")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;


                        RunObject = xmlport "Old Div Import";
                    }

                }


            }

            group(Action57)
            {
                Caption = 'Funds Management';

                group(Receipts)
                {
                    Caption = 'Receipts';

                    action(Receipt)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Receipts List';
                        Image = CustomerContact;


                        RunObject = Page "Receipts List";
                    }
                    action("Pending Receipts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Pending Receipts';
                        Visible = false;


                        RunObject = Page "Pending Receipt List";
                    }
                    action("Approved Receipts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Approved Receipts';
                        Visible = false;


                        RunObject = Page "Approved Receipts List";
                    }
                    action("Posted Receipts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Receipts';


                        RunObject = Page "Posted Receipts List";
                    }
                    action("Receipts - report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Receipts Report';
                        Image = Receipt;


                        RunObject = Report Receipt;
                    }
                    action("BOSA Receipting - report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'BOSA Receipting Report';
                        Image = Receipt;


                        RunObject = Report "Bosa Receipting Report";
                    }

                }

                group(PaymentsVouchers)
                {
                    Caption = 'Payments';
                    group(Open)
                    {
                        action(Payments)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Payment Voucher';
                            Image = CustomerContact;


                            RunObject = Page "PV List";
                        }

                        action(BoardPayments)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Board Payment Voucher';
                            Image = CustomerContact;


                            RunObject = Page "Board PV List";
                        }
                        action(StaffPayments)
                        //action(StaffPayments)Exit
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Staff Payment Voucher';
                            Image = CustomerContact;
                            RunObject = Page "Staff PV List";
                        }
                        action(PettyCash)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Petty Cash';
                            Image = CustomerContact;


                            RunObject = Page "Petty Cash List";
                        }
                        action(MemberPayments)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Member FOSA Payment Voucher';
                            Image = CustomerContact;

                            Visible = true;
                            RunObject = Page "Member PV List";
                        }

                    }
                    group(PendingApproval)
                    {
                        action("Pending Payments Voucher")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Pending Payment Voucher';
                            Image = DocumentsMaturity;
                            RunObject = Page "PV Pending List";
                        }
                        action("Pending Board Payments Voucher")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Pending Board Payment Voucher';
                            Image = DocumentsMaturity;
                            RunObject = Page "Board PV List - Pending";
                        }
                        action("Pending Staff Payments Voucher")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Pending Staff Payment Voucher';
                            Image = DocumentsMaturity;
                            RunObject = Page "Pending Staff PV List";
                        }
                        action(PendingMemberPayments)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Member FOSA Payment Voucher';
                            Image = CustomerContact;

                            Visible = true;
                            RunObject = Page "Pending Member PV List";
                        }
                        action("Pending Patty Cash")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Pending Petty Cash';
                            Image = DocumentsMaturity;
                            RunObject = Page "Patty Cash List - Pending";
                        }
                    }
                    group(Approved)
                    {
                        action("Approved Payments Voucher")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Approved Payment Voucher';
                            Image = DocumentsMaturity;

                            RunObject = Page "PV Approved List";
                        }
                        action("Approved Board PV")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Approved Board PV';
                            Image = DocumentsMaturity;

                            RunObject = Page "Board PV List - Approved";
                        }
                        action("Approved Staff Payments Voucher")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Approved Staff Payment Voucher';
                            Image = DocumentsMaturity;
                            RunObject = Page "Approved Staff PV List";
                        }
                        action(ApprovedMemberPayments)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Approved Member FOSA Payment Voucher';
                            Image = CustomerContact;

                            Visible = true;
                            RunObject = Page "Approved Member PV List";
                        }
                        action("Approved Petty Cash List")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Approved Petty Cash List';
                            Image = DocumentsMaturity;

                            RunObject = Page "Petty Cash List - Approved";
                        }
                    }
                    group(Posted) //Posted
                    {
                        action("PaymentVouchers")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Posted Payment Voucher';


                            RunObject = Page "PV Posted List";
                        }
                        action("BoardPaymentVouchers")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Posted Board Payment Voucher';


                            RunObject = Page "Posted Board PVs";
                        }
                        action("MemberPaymentVouchers")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Posted Member FOSA Payment Voucher';
                            Visible = false;

                            RunObject = Page "Posted Member PVs";
                        }
                        action("StaffPaymentVouchers")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Posted Staff Payment Voucher';


                            RunObject = Page "Posted Staff PVs";
                        }
                        action(PostedPettyCash)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Posted Petty Cash';
                            Image = CustomerContact;


                            RunObject = Page "Posted Petty Cash List";
                        }
                        action(PostedMemberPayments)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Posted Member FOSA Payment Voucher';
                            Image = CustomerContact;

                            Visible = true;
                            RunObject = Page "Posted Member PV List";
                        }

                    }
                    group("Funds Reports")
                    {
                        action("Payments Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            RunObject = Report "Payments Report";
                        }
                    }
                }

                group(Imprest)
                {
                    Caption = 'Imprest';

                    action("Imprest Requisition List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Imprest Requisition List';
                        Image = "Order";


                        RunObject = Page "Imprest Requisition List";
                    }
                    action("Approved Imprest Requisition List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Approved Imprest Requisition List';
                        Image = "Order";


                        RunObject = Page "Approved Imprest Requisition";
                    }
                    action("Imprest List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Imprest List';
                        Image = "Order";


                        RunObject = Page "Imprest List";
                    }
                    action("Posted Imprest List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Imprest List';
                        Image = "Order";


                        RunObject = Page "Posted Imprest";
                    }
                    action("Imprest Surrender List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Imprest Surrender List';
                        Image = Reminder;


                        RunObject = Page "Imprest Surrender List";
                    }
                    action("Posted Imprest Surrender List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Imprest Surrender List';
                        Image = Reminder;


                        RunObject = Page "Posted Imprest Surrender List";
                    }

                }

                group(BankTransfers)
                {
                    Caption = 'Bank Transfers';

                    action("IBT")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Inter-Bank Transfers List';
                        Image = "Order";


                        RunObject = Page "IBT List";
                    }

                    action("PostedIBT")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Inter-Bank Transfers List';
                        Image = "Order";


                        RunObject = Page "Posted Inter Bank Transfers";
                    }
                }

            }

            //BEGIN
            group(Action5)
            {
                Caption = 'Alternative Channels';

                group(MBanking)
                {
                    Caption = 'Sky Mobile Banking';

                    action("Sky Permissions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky Permissions";
                    }
                    action("Sky Mobile Setup")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky Mobile Setup";
                    }

                    action("MBanking Application List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "MBanking Application List";
                    }
                    action("Activated MBanking Application")
                    {
                        ApplicationArea = RelationshipMgmt;

                        RunObject = Page "MBanking Applications Activate";
                    }
                    action("Sky USSD Auth")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky USSD Auth";
                    }

                    action("Mpesa Manual Uploads")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Mpesa Manual Upload";
                    }

                    action("Sky Mobile Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Sky Mobile Transactions";
                    }
                    action("Sky Mobile Transactions Reversed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Sky Mobile Trans. Reversed";
                    }

                    action("Mbanking Loans")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Sky Mobile Loans";
                    }

                    action("Send Bulk SMS")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Bulk SMS Header List";
                    }

                    action("Posted Bulk SMS")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Posted Bulk SMS Header List";
                    }
                    action("Loan Reminder Notifications")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Reminder Notifications';
                        Image = SendTo;

                        RunObject = Page "Loan Reminder Notifications";
                    }
                    action("Sky SMS Messages")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Sky SMS Messages";
                    }
                    action("Send Loan SMS")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;

                        RunObject = report "Send Loan SMSs";
                    }

                    action("MLoan Member Analysis")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = report "MLoan Member Analysis";
                    }
                    action("Mobile Logs")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Log;


                        RunObject = Page "Mobile Logs";
                    }




                }
                //END
                group(SpotMBanking)
                {
                    Caption = 'SpotCash';
                    action(SpotCashSetup)
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Spotcash Setup";
                    }
                    action("Safaricom Charges")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Safcom Charges";
                    }
                    action("Spotcash Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Spotcash Transactions";
                    }
                    action("Spotcash Paybills")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "SpotCash Paybills";
                    }
                    action("Spotcash Withdrawals")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "SpotCash Withdrawals";
                    }
                    action("Old ATM")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Old ATM";
                    }
                    action("Old Mpesa Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Old Mpesa Transactions";
                    }
                    action("Old Teller Trans")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Old Teller Trans";
                    }


                }


                //END

                group(AgencyBanking)
                {
                    Caption = 'Agency Banking';
                    action("Agent Application")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Agent Applications List";
                    }
                    action("Approved Agents List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Approved Agents List";
                    }

                    action("Spotcash Agency Setup")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Spotcash Agency Setup";
                    }

                    action("SpotCash Agency Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "SpotCash Agency Transactions";
                    }
                    action("Sky Agenct Auth")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky Agenct Auth";
                    }
                    action("Sky Search Options")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky Search Options";
                    }

                    action("Sky Agent Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky Agent Transactions";
                    }

                    action("Sky Agencies")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky Agencies";
                    }
                    action("Sky Agent Transfer List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky Agent Transfer List";
                    }
                    action("Agent Tariff Header")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Agent Tariff Header";
                    }

                }
                group(ATM)
                {
                    Caption = 'Coop ATM Applications';

                    action("ATM Application List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "ATM Application List";
                    }

                    action("Approved ATM Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Approved ATM Application List";
                    }

                    action("ATM Linking Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "ATM Linking Application List";
                    }

                    action("Approved ATM Linking List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Approved ATM Linking List";
                    }

                    action("ATM Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "ATM Report";
                    }


                }

                group(ATMTrans)
                {
                    Caption = 'Coop ATM Transactions';

                    action("Coop ATM Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Coop ATM Transactions";
                    }

                    action("Coop ATM Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Coop ATM Setup";
                    }

                    action("Coop ATM Charges")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Coop ATM Charges";
                    }
                    action("Coop Transaction Codes")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Coop Transaction Codes";
                    }


                }
            }


        }

        area(processing)
        {

        }


    }
}
