Page 50083 "Credit Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control60; "Headline RC Relationship Mgt.")
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


            group(MembershipManagement)
            {
                Caption = 'Membership Management';


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




                }



                group(MembershipExit)
                {
                    Caption = 'Membership Exit';



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
                    action(PostedMemberChanges)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Changes report';
                        Image = Log;
                        RunObject = Report "Posted Member Changes Log";
                        ToolTip = 'View posted member changes report';
                    }


                }

            }

            group(CreditManagement)
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



                group(Sasra)
                {
                    Caption = 'SASRA';

                    group("Loan Aging")
                    {
                        action(Form2HOtherDisclosures)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'FORM 2H - Other Disclosures';
                            Image = Quote;
                            RunObject = Report "Form 2H Other Disclosures";
                        }

                        action("SASRA Loan Categorization")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Loan Aging- SASRA';
                            Image = "Order";


                            RunObject = report "SASRA Loan Categorization";
                        }
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
                        action("SASRA Loan Listing")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = CalculateCrossDock;
                            RunObject = report "Loan Listing";
                        }
                        action("SASRA Deposit Listing")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = CalculateCrossDock;
                            RunObject = report "Deposit Listing";
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
                        action("Loans Defaulter Aging - Security")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Defaulter Aging - Security';
                            Image = "Order";


                            RunObject = report "Loans Defaulter Aging -report";
                        }


                        action("Loans Provisioning")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Provisioning';
                            Image = "Order";


                            RunObject = report "Loans Provisioning Summary.";
                        }
                        action("IFRS6 Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'IFRS Report';
                            Image = "Order";


                            RunObject = report "IFRS6 Report";
                        }
                        action("IFRS STaging Summary")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'IFRS Staging Summary';
                            Image = "Order";


                            RunObject = report "IFRS STaging Summary";
                        }


                        action("Insider Lending - Board")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";


                            RunObject = report "Insider Lending Board";
                        }
                        action("Insider Lending - Staff")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";


                            RunObject = report "Insider Lending";
                        }
                        action("Insider Lending - All")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = "Order";


                            RunObject = report "Sasra Insider Lending";
                        }
                        action("Loans Int Defaulter Aging")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Int Defaulter Aging';
                            Image = "Order";

                            RunObject = report "Loan Int Defaulter Agings";
                        }
                        action("Loans Restructured Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Restructured Report';
                            Image = "Order";
                            RunObject = report "Loans Restructured Report";
                        }

                    }

                    group("DepositReturn")
                    {
                        Caption = 'Deposit Return';

                        action("DepositReturn1")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Deposit Return';
                            Image = "Order";


                            RunObject = report "Update Deposit Return";
                        }
                        action("DepositReturn2")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Deposit Return Report';
                            Image = "Order";


                            RunObject = report "Sasra Deposit Return";
                        }
                    }
                    action("Sectorial")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sectorial Lending';
                        Image = "Order";


                        RunObject = page "Sasra - Annex 1 Table 1";
                    }

                    group("Sectorial Setups")
                    {

                        action("MainSector")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Sasra Main Sector';
                            Image = "Order";


                            RunObject = page "Sasra Main Sector";
                        }
                        action("SubSector1")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Sasra Sub-Sector Level 1';
                            Image = "Order";


                            RunObject = page "Sasra Sub-Sector Level 1";
                        }
                        action("SubSector2")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Sasra Sub-Sector Level 2';
                            Image = "Order";


                            RunObject = page "Sasra Sub-Sector Level 2";
                        }

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


                    action("CRB")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'CRB Main Data';
                        Image = "Order";


                        RunObject = Page "CRB Main Data";
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
                    action("Loan Reminder Notifications")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Reminder Notifications';
                        Image = SendTo;

                        RunObject = Page "Loan Reminder Notifications";
                    }

                }

                group("Periodic Activities")
                {

                    action("Loan Interest Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;


                        RunObject = Page "Loan Interest Buffer";
                    }

                    action("Posted Loan Interest Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;


                        RunObject = Page "Posted Loan Interest Buffer";
                    }
                    action("Loan Insurance Buffer")
                    {
                        ApplicationArea = Relationshipmgt, all;
                        image = Insurance;
                        RunObject = page "Loan Insurance Buffer";
                    }
                    action("Posted Loan Insurance")
                    {
                        ApplicationArea = RelationshipMgmt, all;
                        image = InsuranceLedger;
                        RunObject = page "Posted Loan Insurance";
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

            group(SavingsAccount)
            {
                Caption = 'Savings';


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

                }




            }


        }

        area(processing)
        {

        }


    }
}
