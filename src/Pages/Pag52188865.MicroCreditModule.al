page 50567 MicroCreditModule
{

    PageType = RoleCenter;
    Caption = 'Micro Credit Module', Comment = 'Use same translation as ''Profile Description'' (if applicable)';

    layout
    {
        area(rolecenter)
        {
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
                //startt
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
                //END

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
                        Caption = 'Salary Appraisal List';
                        Image = "Order";


                        RunObject = Page "Salary Appraisal";
                    }

                    // 50476
                    action("Completed Salary Appraisal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Completed Salary Appraisal List';
                        Image = History;
                        RunObject = Page "Completed Salary Appraisal";
                    }

                    action(LoanApplication)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Registration';
                        Image = "Order";


                        RunObject = Page "Loan Application List";
                    }
                    action(LoanCommittee)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Pending Committee List';
                        Image = "Order";


                        RunObject = Page "Loans Pending Committee List";
                    }
                    action(LoanApproved)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Approved';
                        Image = "Order";


                        RunObject = Page "Loans Approved List";
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
                    action("PostedBatches")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Loan Batches';
                        Image = Reminder;


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

                    action("Loans Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Register';
                        Image = "Order";


                        RunObject = Report "Loans Register";
                    }

                    action("Loan Repayment Analysis")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Repayment Analysis';
                        Image = "Order";


                        RunObject = Report "Loan Repayment Analysis";
                    }
                    action("Weekly Transaction Report-R")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Weekly Transaction Report-R';
                        Image = "Order";


                        RunObject = Report "Weekly Transaction Report-R";
                    }
                    action("Defaulter Aging")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Defaulter Aging';
                        Image = "Order";


                        RunObject = Report "Loans Defaulter Aging - SACCO";
                    }
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




            }
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

                    action("MLoan Member Analysis")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = report "MLoan Member Analysis";
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













#if not CLEAN18
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
#endif
        }

        area(processing)
        {







        }


    }

}
