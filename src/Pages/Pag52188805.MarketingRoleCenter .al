page 50487 "Marketing Role Center"

{
    Caption = 'Marketing', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
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
            part(Control16; "Team Member Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control6; "Sales Pipeline Chart")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control4; "Opportunity Chart")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control11; "Relationship Performance")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("My Job Queue"; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
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
                        Caption = 'Group List';
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


                }

                group("File Management")
                {

                    action(Action699)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement List - To Issue/Transfer';
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
                    action(Action269)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Portal Change Request';
                        Image = "Order";


                        RunObject = Page "Portal Change Request";
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
                    action(ExitNotice)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal Notice';
                        Image = Reminder;


                        RunObject = Page "Member Exit Notice";
                    }

                    action(MemberExit)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Member Withdrawal';
                        Image = Reminder;
                        RunObject = Page "Member Exit List";
                    }

                    action(PortalUploads)
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Portal Uploads';
                        Image = UpdateXML;


                        RunObject = Page "Portal Uploads";
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

                }

                group(Reports)
                {
                    Caption = 'Reports';

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

                }
            }


            group(Action357)
            {
                Caption = 'Credit';

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
                        action("Update Guarantor Committement")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Guarantor Committement';
                            Image = Line;
                            RunObject = report "Update Guarantor Commitment";
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


                group(Sasra)
                {
                    Caption = 'SASRA';

                    group("Loan Aging")
                    {


                        action("Loans Register")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Register';
                            Image = "Order";


                            RunObject = Report "Loans Register";
                        }

                        action("SASRA Listing")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = CalculateCrossDock;


                            RunObject = report "Sasra Listing";
                        }
                        action("Loans Classfication")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = CalculateCrossDock;


                            RunObject = report "Loans Classifications";
                        }
                        action("Loans Defaulter Aging - SASRA")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Defaulter Aging - SASRA';
                            Image = "Order";


                            RunObject = report "Loans Defaulter Aging - SASRA";
                        }
                        action("Loans Provisioning")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Provisioning';
                            Image = "Order";


                            RunObject = report "Loans Provisioning Summary.";
                        }

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

                    group(MicroReports)
                    {
                        action("Weekly Transaction Report-R")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Weekly Transaction Report-R';
                            Image = "Order";


                            RunObject = Report "Weekly Transaction Report-R";
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

                    action("Savings Advice")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = SettleOpenTransactions;
                        Caption = 'Savings Advice';


                        RunObject = Report "Savings Advice";
                    }
                }






#if not CLEAN18
                group(SetupAndExtensions)
                {
                    Caption = 'Setup & Extensions';
                    //Image = Setup;
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
#endif
            }

            //BEGIN
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




                }



                //END
                group(ATM)
                {
                    Caption = 'Coop ATM Applications';

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

        }

        area(processing)
        {







        }


    }

}
