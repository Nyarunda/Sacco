page 50482 "Teller Role"

{
    Caption = 'Teller Role Center', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;


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
        area(reporting)
        {
        }

        area(sections)
        {

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

            group(Action157)//FINANCE
            {
                Caption = 'Finance';
                //START
                group(GeneralLedger)
                {
                    Caption = 'General Ledger';

                    action(Action267)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Chart of Accounts';
                        Image = Quote;


                        RunObject = Page "Chart of Accounts";
                    }
                    action(Action98267)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Journal';
                        Image = Quote;


                        RunObject = Page "Sacco General Journal";
                    }
                    action(Action164)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Revised General Journal';
                        Image = Quote;


                        RunObject = Page "Sacco Journals List";
                    }

                    action(Action16w4)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Revised General Journal';
                        Image = Quote;


                        RunObject = Page "Posted Sacco Journals List";
                    }

                    action(Action168)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sacco Journals Report';
                        Image = Quote;
                        RunObject = Report "Sacco Journal Report";
                    }

                }

                group(Banking)
                {
                    Caption = 'Bank List';

                    action(Action16)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Bank Account List';
                        RunObject = Page "Bank Account List";
                    }
                }

                group(Procurement)
                {
                    group("Purchase Order")
                    {

                        action("Purchase Order List")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Purchase Order List';
                            Image = "Order";


                            RunObject = Page "Purchase Order List";
                        }

                        action("Posted Purchase Order List")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Posted Purchase Order List';
                            Image = "Order";


                            RunObject = Page "Purchase Order Archive";

                        }
                    }

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
                            group(InventoryReports)
                            {

                                action("Inventory List")
                                {
                                    ApplicationArea = RelationshipMgmt;
                                    Image = Inventory;


                                    RunObject = Report "Inventory - List";
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
                Caption = 'Registry';

                group(Registration)
                {
                    Caption = 'Registration';


                    action(Action167)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Individual Member Registration';
                        Image = CustomerContact;


                        RunObject = Page "Member Registration List";
                        ToolTip = 'Create Individual Member Account';
                    }
                    action(Action66)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Joint Account Registration';


                        RunObject = Page "Joint Account Registration";
                        ToolTip = 'Create Group Account';
                    }
                    action(Action70)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Welfare Account Registration';


                        RunObject = Page "Welfare Account Registration";
                        ToolTip = 'Create Welfare Account';
                    }
                    action(Action65)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Micro Group Application';
                        Image = Quote;


                        RunObject = Page "Micro Group Application";
                    }
                    action(Action1w65)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Chamaa Registration';
                        Image = Quote;


                        RunObject = Page "Chamaa Registration";
                    }
                    action(Action67)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Business Reg. List';
                        Image = Quote;


                        RunObject = Page "Business Reg. List";
                    }

                    action(Action68)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Savings Account Application';
                        Image = Quote;


                        RunObject = Page "Member Accounts App. List";
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
                        Caption = 'Member List - Joint';
                        Image = "Order";


                        RunObject = Page "Joint Members";
                        ToolTip = 'List of all SACCO Members';
                    }

                    action(Action650)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Welfare List - Joint';
                        Image = "Order";


                        RunObject = Page "Welfare Members";
                        ToolTip = 'List of all Welfare SACCO Members';
                    }
                    action(Actin1w65)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Chamaa/Investment List';
                        Image = Quote;


                        RunObject = Page "Chamaa List";
                    }
                    action("Group List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Micro Group List';
                        Image = Reminder;


                        RunObject = Page "Group List";
                    }
                    action(Business)
                    {
                        ApplicationArea = RelationshipMgmt;
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

                }

                group("Cheque Dispatch")
                {
                    action(Action006)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Cheque Dispatch';
                        Image = CheckLedger;
                        RunObject = Page "Cheque Dispatch List";
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
                        ToolTip = 'Edit Member Details';
                    }


                    action(Action90)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Member Changes';
                        Image = "Order";


                        RunObject = Page "Posted Member Changes";
                        ToolTip = 'Edit Member Details';
                    }

                    action(Action270)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leads';
                        Image = "Order";


                        RunObject = Page Leads;
                        ToolTip = 'Leads';
                    }

                    action(Action269)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Portal Change Request';
                        Image = "Order";


                        RunObject = Page "Portal Change Request";
                        ToolTip = 'Edit Member Details';
                    }
                    action(ExitNotice)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice';
                        Image = Reminder;


                        RunObject = Page "Member Exit Notice";
                    }
                    action("Pending Exit Notice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice Pending';
                        Image = Reminder;


                        RunObject = Page "Member Exit Notice Pending";
                    }
                    action("Approved ExitNotice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice Approved';
                        Image = Reminder;


                        RunObject = Page "Member Exit Notice Approved";
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


                        RunObject = Report "New Members Report";
                    }
                    action("Member Balances Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Balances Report';
                        Image = "Order";


                        RunObject = Report "Savings List Register";
                    }
                    action("Member Deposit Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Deposit Report';
                        Image = "Order";


                        RunObject = Report "Member Deposit Report";
                    }
                    action("Members Without Shares")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Members Without Shares';
                        Image = "Order";


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
                        Caption = 'Member Withdrawals Report';
                        Image = "Order";


                        RunObject = Report "Member Withdrawals";
                    }
                    action("Member Recruitement Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Recruitement Report';
                        Image = "Order";


                        RunObject = Report "Member Recruitement Report";
                    }

                    action("Next of Kin")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report GFE;
                    }
                    action("MFI CSR Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'MFI CSR Report';
                        Image = "Order";


                        RunObject = Report "MFI CSR Report";
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
                            Caption = 'Collateral Register Report';

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

                    action(LoanCalculator)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Loan Calculator';
                        Image = Reminder;


                        RunObject = Page "Loan Calculator";
                    }

                    action("Salary Appraisal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Appraisal List';
                        Image = "Order";


                        RunObject = Page "Salary Appraisal";
                    }

                    // 50476
                    action("Completed Salary Appraisal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Completed Loan Appraisal List';
                        Image = History;
                        RunObject = Page "Completed Salary Appraisal";
                    }

                    action("Online Mobile Loan Applications")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Page "Online Mobile Loans";
                    }

                    action(LoanApplication)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Registration';
                        Image = "Order";


                        RunObject = Page "Loan Application List";
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
                        Caption = 'Loans Approved';
                        Image = "Order";


                        RunObject = Page "Loans Approved List";
                    }
                    action(LoanFinance)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Pending Finance';
                        Image = "Order";


                        RunObject = Page "Loan Pending Finance List";
                    }
                    action(LoanDisbursement)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Pending Disbursment';
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

                }

                group(LoanReports)
                {
                    Caption = 'Reports';
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
                    action("Weekly Transaction Report-R")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Weekly Transaction Report-R';
                        Image = "Order";


                        RunObject = Report "Weekly Transaction Report-R";
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
                            Caption = 'Loan Guarantors Report';
                            Image = GanttChart;
                            RunObject = report "Loan Guarantors Reports";
                        }
                        action("Loans Guaranteed Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Guaranteed Report';
                            Image = Line;
                            RunObject = report "Loan Guaranteed";
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
                    action("Loans Defaulter Recpvery")
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

                group(CheckOff)
                {
                    Caption = 'CheckOff';

                    action("Monthly Advice - Posted")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Advice - Posted';
                        Image = "Order";


                        RunObject = Page "Monthly Advice List - Posted";
                    }

                    action("Posted Checkoff")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted-Monthly CheckOff';
                        Image = "Order";


                        RunObject = Page "Posted Checkoff";
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

                group("Periodic Activities")
                {


                    action("Posted Loan Interest Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;


                        RunObject = Page "Posted Loan Interest Buffer";
                    }
                    action("Monthly Processes Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;


                        RunObject = Page "Monthly Processes Buffer";
                    }
                    action("Posted Monthly Process Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;


                        RunObject = Page "Posted Monthly Process Buffer";
                    }

                }

            }

            group(Action564)
            {
                Caption = 'Micro-Credit';
                group("Micro-Registration")
                {
                    Caption = 'Registration';
                    action(Reg)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Micro Group Application';
                        Image = Quote;


                        RunObject = Page "Micro Group Application";
                    }
                    action("Micro Group List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Micro Group List';
                        Image = Reminder;


                        RunObject = Page "Group List";
                    }

                }
                group("Micro-Transactions")
                {
                    action("Micro-TransList")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Micro Transactions List';
                        Image = CustomerContact;


                        RunObject = Page "Micro Transactions List";
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
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Direct Debit List';
                        Image = History;


                        RunObject = Page "Direct Debit List";
                    }
                    action("Posted Direct Debit")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Direct Debit List';
                        Image = History;


                        RunObject = Page "Posted Direct Debit";
                    }
                }

                group(Overdraft)
                {
                    Caption = 'Overdraft Management';


                }

                group(ChequeManagement)
                {
                    Caption = 'Cheque Management';

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

                    action("Create Savings Accounts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Create Savings Accounts"';
                        Image = "Order";


                        RunObject = Report "Create Savings Accounts";
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
                    Caption = 'FOSA Interest';

                    action(Action5229)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'FOSA Interest List';
                        Image = "Order";
                        RunObject = Page "FOSA Interest List";
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

                }


            }

            group(Action57)//funds management
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

                            Visible = false;
                            RunObject = Page "MEmber PV List";
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
                        Visible = false;

                        RunObject = Page "Imprest List";
                    }
                    action("Posted Imprest List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Imprest List';
                        Image = "Order";
                        Visible = false;

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
                    action("Posted IBT")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Inter-Bank Transfers List';
                        Image = "Order";


                        RunObject = Page "Posted Inter Bank Transfers";
                    }
                }
            }

            group(Action5)
            {
                Caption = 'Alternative Channels';

                group(MBanking)
                {
                    Caption = 'Sky Mobile Banking';

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

                    action("Mbanking Loans")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Sky Mobile Loans";
                    }

                    action("Sky SMS Messages")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Sky SMS Messages";
                    }

                    action("SMS Messages")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "SMS Messages";
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




                }
                //END
                group(SpotMBanking)
                {
                    Caption = 'SpotCash';
                    Visible = false;

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

                }
            }

            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                ObsoleteTag = '18.0';
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Manual Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manual Setup';
                    RunObject = Page "Manual Setup";
                    ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Service Connections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page "Service Connections";
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Extensions';
                    Image = NonStockItemSetup;
                    RunObject = Page "Extension Management";
                    ToolTip = 'Install Extensions for greater functionality of the system.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Workflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Workflows';


                    RunObject = Page Workflows;
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
            }

        }

        area(processing)
        {







        }

    }

}
