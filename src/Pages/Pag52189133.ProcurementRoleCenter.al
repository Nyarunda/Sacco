page 50835 "Procurement Role Center"
{
    PageType = RoleCenter;
    Caption = 'Procurement Role Center';

    layout
    {
        area(rolecenter)
        {
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

        area(sections)
        {

            group(Action157)
            {
                Caption = 'Finance';


                group(Procurement)
                {
                    group("Purchase Requisition List")
                    {

                        action(PRL)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Purchase Requisition List';
                            Image = "Order";


                            RunObject = Page "Purchase Requisition List";
                        }

                        action(RFQ)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Request For Quotation';
                            Image = "Order";


                            RunObject = Page "RFQ List";
                        }

                        action(VendorQuotation)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Vendor Quotation';
                            Image = "Order";



                            RunObject = Page "Vendor Quotation List";
                        }
                        action(LPOsLSOs)
                        {
                            ApplicationArea = All;
                            Caption = 'LPO/LSO List';
                            RunObject = page "Purchase Order List";
                        }

                        action(GoodsReceiptNotes)
                        {
                            ApplicationArea = All;
                            Caption = 'Goods Receipt Notes';
                            RunObject = page "Goods Receipt Note List";
                        }

                        group(SRQN)
                        {
                            Caption = 'Store Requisition';
                            action(SRL)
                            {
                                ApplicationArea = RelationshipMgmt;
                                Caption = 'Store Requisition List';
                                Image = Suggest;


                                RunObject = Page "Store Requisitions List";
                            }
                            action(RSRL)
                            {
                                ApplicationArea = RelationshipMgmt;
                                Caption = 'Released Store Requisition List';
                                Image = ReleaseDoc;


                                RunObject = Page "ReleasedStore Requisition List";
                            }
                            action(PSRL)
                            {
                                ApplicationArea = RelationshipMgmt;
                                Caption = 'Posted Store Requisition List';
                                Image = PostedDeposit;


                                RunObject = Page "Posted Store Requisitions List";
                            }
                            action(CSRL)
                            {
                                ApplicationArea = RelationshipMgmt;
                                Caption = 'Cancelled Store Requisition List';
                                Image = Cancel;


                                RunObject = Page "Cancelled Store Requisitions";
                            }

                        }

                        group("Asset Transfers")
                        {

                            action("Asset Transfer")
                            {
                                ApplicationArea = RelationshipMgmt;


                                RunObject = Page "HR Asset Transfer List";
                            }
                            action("Effected Asset Transfer")
                            {
                                ApplicationArea = RelationshipMgmt;


                                RunObject = Page "HR EffectedAsset Transfer List";
                            }
                        }

                        group(Items)
                        {
                            action(ItemList)
                            {
                                ApplicationArea = All;
                                Caption = 'Items';
                                RunObject = page "Item List";
                            }

                            group(InventoryReports)
                            {

                                action("Inventory Valution")
                                {
                                    ApplicationArea = RelationshipMgmt;
                                    Image = Inventory;


                                    RunObject = Report "Inventory Valuation";
                                }
                                action("Inventory List")
                                {
                                    ApplicationArea = RelationshipMgmt;
                                    Image = Inventory;


                                    RunObject = Report "Inventory - List";
                                }
                                action("Inventory Transaction Detail")
                                {
                                    ApplicationArea = RelationshipMgmt;
                                    Image = Inventory;


                                    RunObject = Report "Inventory - Transaction Detail";
                                }
                                action("Inventory Availability")
                                {
                                    ApplicationArea = RelationshipMgmt;
                                    Image = Inventory;


                                    RunObject = Report "Inventory Availability";
                                }
                            }
                        }

                    }

                }


            }

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

                    action("Loan Appraisal List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Appraisal List';
                        Image = "Order";

                        RunObject = Page "Loan Appraisal List";
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


                group(DefaulterManagement)
                {
                    Caption = 'Defaulter Management';

                    action("Defaulter Notices")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Defaulter Notices';
                        Image = "Order";


                        RunObject = Page "Loans Deaulter Notices List";
                    }
                    action("Loan Recovery")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Recovery';
                        Image = "Order";


                        RunObject = Page "Defaulter Loan Recovery List";
                    }
                    action("Distribution List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reconcile;

                        RunObject = Page "Distribution List";
                    }
                    action("Posted Distribution List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reconcile;

                        RunObject = Page "Posted Distribution List";
                    }

                    action("Daily CRB")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Daily CRB Main Data';
                        Image = "Order";
                        Visible = false;


                        RunObject = Page "CRB Daily Payments";
                    }
                    action("CRB")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'CRB Main Data';
                        Image = "Order";


                        RunObject = Page "CRB Main Data";
                    }
                    action("Recover Loans From Savings")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        Visible = false;
                        RunObject = Report "Recover Loans From Savings";
                    }
                    action("Defaulter Recovery Buffer")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reconcile;

                        RunObject = Page "Defaulter Recovery Buffer List";
                    }
                    action("Defaulter SMS")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reconcile;

                        RunObject = Report "Defaulter SMS";
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
            }

            group(AdvancedHR)
            {
                Caption = 'Advanced HR';
                group("Jobs Management")
                {

                    action("HR Jobs")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Jobs List";
                    }
                    action("HR Job Qualifications")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Qualifications";
                    }
                    action("HR Job Requirements")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Requirements";
                    }
                    action("HR Responsibilities")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Responsibilities";
                    }
                }
                group("Employee Recruitment")
                {

                    action("Employee Requisitions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Requisitions List";
                    }
                    action("Job Applications")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Applications List";
                    }
                    action("Shortlisting")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Shortlisting List";
                    }
                    action("Applicants Qualified")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Applicants Qualified L";
                    }
                    action("Applicants Unqualified")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Applicants Unqualified";
                    }

                    action("Successful Job Applicants")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR  App Qualified Applicants";
                    }
                    action("Job Applicants Uploaded")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Applicants Uploaded";
                    }
                    action("Employee Requisitions Approved")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Requisitions List";
                    }
                }


                group("Training Management")
                {

                    action("Training Needs")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Training Needs List";
                    }
                    action("Training Applications")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Training Application List";
                    }
                    action("Approved Training Applications")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Training App List -Approved";
                    }
                    action("Training Feedback")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Training Feedback";
                    }
                }

                group("HR Transport Management")
                {
                    action("HR Vehicle List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        RunObject = Page "HR Vehicle List";
                    }
                    action("HR Transport Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        RunObject = Page "HR Trasport Application List";
                    }


                }
                group("HR Fuel Requisition")
                {
                    Visible = false;
                    action(FuelRequisition)
                    {
                        ApplicationArea = RelationshipMgmt;
                        RunObject = page "Fuel Requisition List";
                    }


                }

                group("Company Activites")
                {

                    action("Company Activities/Welfare")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Company Activities List";
                    }
                    action("Closed Company Activites")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Company Activities List Clo";
                    }
                }

                group("Medical Schemes Management")
                {
                    Visible = false;

                    action("Medical Schemes")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Medical Schemes List";
                    }
                    action("Medical Scheme Members")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Medical Scheme Members List";
                    }
                    action("Medical Claims")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Medical Claims List";
                    }
                }

                group("Performance Management")
                {

                    action("360 Appraisals List - Appraisee")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Appraisal Balance Score Card List';

                        RunObject = Page "HR 360 Appraisals List";
                    }
                    action("360 Appraisals List - Supervisor")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Appraisal Balance Score -Supervisor';

                        RunObject = Page "HR360AppraisalList-Super";
                    }
                    action("360 Appraisals List - Evaluation")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Appraisal Balance Score -Evaluation';


                        RunObject = Page "HR 360 Appraisals List - EV";
                    }
                    action("Approve Appraisals")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Approve Appraisals List";
                    }
                    /*
                    action("BSC Targets")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Targets";
                    }
                    action("BSC Targets Supervisor")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Targets-Supervisor";
                    }

                    action("BSC Qaurter 1")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Qaurter 1";
                    }
                    action("BSC Review")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Review";
                    }
                    action("BSC Qaurter 3")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Qaurter 3";
                    }
                    action("BSC Targets Approved")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Targets-Approved";
                    }
                    action("BSC End Year")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List End Year";
                    }
                    action("BSC Closed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Closed";
                    }
                    action("Appraissal Appeal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR Appraissal Appeal";
                    }
                    action("Appraisal Period Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR Appraisal Period Setup";
                    }
                      */
                }

                group("Disciplinary Management")
                {


                    action("Disciplinary Cases")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Disciplinary Cases List";
                    }

                    action("Closed Disciplinary Cases")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Disciplinary Cases ListClsd";
                    }
                    /* action("Disciplinary Actions List")
                     {
                         ApplicationArea = RelationshipMgmt;


                         //RunObject = Page "HR Disciplinary Cases List N";
                     }
                     action("Disciplinary WIthdrawal")
                     {
                         ApplicationArea = RelationshipMgmt;


                         //RunObject = Page hr dis;
                     }
                     action("Disciplinary Appeal")
                     {
                         ApplicationArea = RelationshipMgmt;


                         //RunObject = Page Appeal;
                     }*/
                    action("Employee Grievance")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Grievance List";
                    }
                }


                group("Employee Transfers")
                {

                    action("Employee Transfer")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Transfer List";
                    }
                    action("Effected Employee Transfer")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Transfer List Effe";
                    }
                }

                group("Overtime Management")
                {

                    action("Overtime List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Overtime List";
                    }
                    action("Overtime List - Converted")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Overtime List - Converted";
                    }
                    action("Overtime Rates")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Overtime Rates List";
                    }
                }
                group("Employee Exit")
                {

                    action("Exit Interview List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Exit Interview list";
                    }
                    action("Closed Exit Interview List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Closed HR Exit Interview list";
                    }
                }


            }


            group(Action13)
            {
                Caption = 'HR & Payroll';

                group(EmployeeManagement)
                {
                    Caption = 'Employee Management';

                    action("Employee List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List';
                        Image = CustomerContact;


                        RunObject = Page "Employee List";
                    }
                    action("Employee List - Contract")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List - Contract';


                        RunObject = Page "Employee List - Contract";
                    }
                    action("Employee List - Interns")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List - Interns';


                        RunObject = Page "Employee List - Interns";
                    }
                    action("HR Employee List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Employee List';


                        RunObject = Report "HR Employee List";
                    }

                }

                group(LeaveManagement)
                {
                    Caption = 'Leave Management';

                    action("HR Leave Applications List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Applications List';
                        Image = CustomerContact;


                        RunObject = Page "HR Leave Applications List";
                    }
                    action("HR Leave App. - Pending")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave App. - Pending';


                        RunObject = Page "HR Leave App. - Pending";
                    }
                    action("HR Leave App. - Approved")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave App. - Approved';


                        RunObject = Page "HR Leave App. - Approved";
                    }
                    action("HR Leave Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Application List';


                        RunObject = Report "HR Leave Application List";
                    }
                    action("HR Leave Statement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Statement';


                        RunObject = Report "HR Leave Statement";
                    }
                    action("HR Leave Planner")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leave Planner List';
                        RunObject = Page "HR Leave Planner List";
                    }
                    action("HR Leave Schedule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Schedule';
                        RunObject = Report "HR Leave Schedule";
                    }

                }
                group(StaffLoans)
                {
                    Caption = 'Staff Loans';

                    action("Staff Loan Applications")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Loan Applications List';
                        Image = Loaner;
                        RunObject = Page StaffAppraisalApplication;
                    }

                    action("Staff Appraisal Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Appraisal Application List';
                        Image = List;
                        RunObject = Page "Staff Appraisal List";
                    }
                    action("Completed Staff Loan Appraisal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Completed Staff Loan Appraisal';
                        Image = History;
                        RunObject = Page "Completed Salary Appraisal";
                    }
                    action("Staff Loans Approved")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Appraisal Approved';
                        Image = Approve;
                        RunObject = Page "Staff Loans Approved List";
                    }
                    action("Staff Loans Pending Approval")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Loans Pending Approval';
                        Image = SendApprovalRequest;
                        RunObject = Page "Staff Loan Pending Approval_";
                    }


                    action("Staff Loans Rejected")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Loans Rejected';
                        Image = Reject;
                        RunObject = Page "Staff Loan Rejected List_";
                    }

                    action("Staff Loans Pending Disbursement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Loans Pending Disbursement';
                        Image = Payment;
                        RunObject = Page "Staff Loan Pending Disbur._";
                        RunPageView = where(Status = const(Approved));
                    }

                    action("Posted Staff Loans")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Staff Loans';
                        Image = PostedOrder;
                        RunObject = Page "Loan Posted List";
                        RunPageView = where("Appraisal Type" = filter(Staff));

                    }
                }


                group(HReports)
                {
                    Caption = 'HR Reports';

                    /* action("Employee Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List';
                        Image = "Order";


                        RunObject = Report Emplo;
                    } */
                    action("HRLeave Applications List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leave Applications List';
                        Image = "Order";


                        RunObject = Report "HR Leave Applications List";
                    }
                    action("HR Leave Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leave Summary';
                        Image = "Order";


                        RunObject = Report "HR Leave Summary";
                    }
                    action("HR Leave Balances")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Balances';
                        Image = "Order";


                        RunObject = Report "HR Leave Balances";
                    }
                    action("Leave Planner Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        image = Planning;
                        Caption = 'HR Leave Planner Report';

                        RunObject = report "Leave Planner Report";
                    }

                    action("Timesheet Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        image = Timesheet;
                        Caption = 'HR Timesheet Report';

                        RunObject = report "Timesheets Report";
                    }
                    action("HR Transport Logs")
                    {
                        ApplicationArea = RelationshipMgmt;
                        image = Timesheet;
                        Caption = 'HR Transport Logs';

                        RunObject = report "HR Transport Logs";
                    }
                    action("Update 2025 Leave Entries")
                    {
                        ApplicationArea = RelationshipMgmt;
                        image = Timesheet;
                        Caption = 'Update 2025 Leave Entries';

                        RunObject = report "Update 2025 Leave Entries";
                    }
                    action("Hr next of kin")
                    {
                        ApplicationArea = RelationshipMgmt;
                        image = Timesheet;
                        Caption = 'Hr next of kin';

                        RunObject = report "Hr next of kin";
                    }
                    action("Hr Nominee")
                    {
                        ApplicationArea = RelationshipMgmt;
                        image = Timesheet;
                        Caption = 'Hr Nominee';

                        RunObject = report "Hr Nominee report";
                    }




                }

            }


        }

        area(processing)
        {

        }


    }

}
