page 50491 "AuditModule"

{
    Caption = 'Audit Role Center', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
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
            part(Control1; "Loan Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control12; "Member Activites")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control13; "Common Activities")
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

            group(Action157)
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
                        Image = CustomerContact;


                        RunObject = Page "Chart of Accounts";
                    }
                    action(Action268)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Blocked Chart of Accounts';
                        Image = CustomerContact;


                        RunObject = Page "Blocked Chart of Accounts";
                    }
                    action(Action166)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'G/L Budgets';


                        RunObject = Page "G/L Budget Names";
                    }
                    action(Action165)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Journal';
                        Image = Quote;
                        Visible = false;


                        RunObject = Page "General Journal";
                    }
                    action(Action14)
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

                    action(Action2367)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Account Schedules';
                        Image = Quote;


                        RunObject = Page "Account Schedule Names";
                    }

                    action(Action2168)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Revised Trial Balance';
                        Image = Quote;
                        RunObject = Report "Revised Trial Balance";
                    }

                    action(Action2169)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sacco Trial Balance';
                        Image = Quote;


                        RunObject = Report "Sacco Trial Balance";
                    }

                }
                //FINish
                group(CashManagement)
                {
                    Caption = 'Cash Management';

                    action(Action634)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Bank Account List';
                        Image = "Order";


                        RunObject = Page "Bank Account List";
                    }
                    action("Cash Receipt Journal")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Cash Receipt Journal';
                        Image = Reminder;


                        RunObject = Page "Cash Receipt Journal";
                    }
                    action("Payment Journal")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Payment Journal';
                        Image = Reminder;


                        RunObject = Page "Payment Journal";
                    }
                    action("Bank Acc. Reconciliation List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Bank Acc. Reconciliation';
                        Image = Reminder;


                        RunObject = Page "Bank Reconcilliation List";
                    }
                    action("Cash Book")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Cash Book advice';
                        Image = Reminder;


                        RunObject = Report "Cash Book";
                    }


                }
                //START
                group(Receivables)
                {
                    Caption = 'Receivables';

                    action(Action639)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customers';
                        Image = "Order";


                        RunObject = Page "Customer List";
                    }
                    action("Customer - Checkoff")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customer - Checkoff';
                        Image = "Order";


                        RunObject = Page "Customer List - CheckOff";
                    }
                    action("Customer - Salary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customer - Salary';
                        Image = "Order";
                        Visible = false;

                        RunObject = Page "Customer List - Salary";
                    }
                    action("Customer - Staff Advance")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customer - Staff Advance';
                        Image = "Order";


                        RunObject = Page "Customer - Staff List";
                    }
                    action("Customer - Imprest")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customer - Imprest';
                        Image = "Order";


                        RunObject = Page "Customer List -ImprestAccount";
                    }
                    action("Customer - Investment")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customer - Investment';
                        Image = "Order";


                        RunObject = Page "Customer Investiment - List";
                    }
                    action("Sales Invoice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Sales Invoice';
                        Image = Reminder;


                        RunObject = Page "Sales Invoice List";
                    }
                    action("Posted Sales Invoice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Sales Invoice';
                        Image = Reminder;


                        RunObject = Page "Posted Sales Invoices";
                    }
                    action("Sales Credit Memo")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Sales Credit Memo';
                        Image = Reminder;


                        RunObject = Page "Sales Credit Memos";
                    }
                    action("Posted Sales Credit Memo")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Sales Credit Memo';
                        Image = Reminder;


                        RunObject = Page "Posted Sales Credit Memos";
                    }


                    action("Customer - Summary Aging")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;


#pragma warning disable AL0432
                        RunObject = Report "Customer - Summary Aging";
#pragma warning restore AL0432
                    }
                    action("Customer - Aging Report")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;


                        RunObject = Report "Customer Aging Report";
                    }

                }
                //FINISH
                group(Payables)
                {
                    Caption = 'Payables';

                    action(Action239)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Vendors';
                        Image = "Order";


                        RunObject = Page "Vendor List";
                    }
                    action(Action240)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Vendors - Valuer';
                        Image = "Order";


                        RunObject = Page "Vendor - Valuer";
                    }
                    action(Action241)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Vendors - Lawyers';
                        Image = "Order";


                        RunObject = Page "Vendor - Lawyers";
                    }
                    action("Purchase Invoice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Purchase Invoice';
                        Image = Reminder;


                        RunObject = Page "Purchase Invoice List";
                    }
                    action("Posted Purchase Invoice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Purchase Invoice';
                        Image = Reminder;


                        RunObject = Page "Posted Purchase Invoices";
                    }

                    action("Purchase Credit Memo")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Purchase Credit Memo';
                        Image = Reminder;


                        RunObject = Page "Purchase Credit Memos";
                    }

                    action("Posted Purchase Credit Memo")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Purchase Credit Memo';
                        Image = Reminder;


                        RunObject = Page "Posted Purchase Credit Memos";
                    }
                    action("Vendor - Summary Aging")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;


#pragma warning disable AL0432
                        RunObject = Report "Vendor - Summary Aging";
#pragma warning restore AL0432
                    }
                    action("Sky World Commission")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;


                        RunObject = Report "Sky World Commission";
                    }

                }

                group(FixedAssets)
                {
                    Caption = 'Fixed Assets';

                    action(Action229)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Assets';
                        Image = "Order";
                        RunObject = Page "Fixed Asset List";
                    }
                    action("Fixed Asset G/L Journal")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'FA G/L Journal';
                        Image = Reminder;


                        RunObject = Page "Fixed Asset G/L Journal";
                    }
                    action("Fixed Asset Journal")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'FA Journal';
                        Image = Reminder;


                        RunObject = Page "Fixed Asset Journal";
                    }

                    action("FA Reclass. Journals")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'FA Reclass. Journals';
                        Image = Reminder;


                        RunObject = Page "FA Reclass. Journal";
                    }
                    action("Calculate Depreciation")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Calculate Depreciation';
                        Image = Reminder;


                        RunObject = Report "Calculate Depreciation";
                    }
                    action("Fixed Asset List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        RunObject = Report "FA List";
                        Caption = 'Fixed Asset List';
                    }

                }

                group(FixedAssetsReports)
                {
                    Caption = 'Fixed Assets Reports';


                    action(FAR004)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Assets Register';
                        Image = "Order";
                        RunObject = report "Fixed Assets Register";
                    }
                    action(FAR002)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset - Book Value 01';
                        Image = "Order";
                        RunObject = report "Fixed Asset - Book Value 01";
                    }
                    action(FAR005)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset - Book Value 02';
                        Image = "Order";
                        RunObject = report "Fixed Asset - Book Value 02";
                    }
                    action(FAR006)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset Movement Schedule';
                        Image = MoveUp;
                        RunObject = report "FA Movement Schedule - Revised";
                    }
                    action(FAR007)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset - Acquisition';
                        Image = MoveUp;
                        RunObject = report "Fixed Asset - Acquisition";
                    }
                    action(FAR008)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset - Analysis';
                        Image = MoveUp;
#pragma warning disable AL0432
                        RunObject = report "Fixed Asset - Analysis";
#pragma warning restore AL0432
                    }
                    action(FAR009)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset - Details';
                        Image = MoveUp;
#pragma warning disable AL0432
                        RunObject = report "Fixed Asset - Details";
#pragma warning restore AL0432
                    }
                    action(FAR0010)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset -  G/L Analysis';
                        Image = MoveUp;
                        RunObject = report "Fixed Asset - G/L Analysis";
                    }
                    action(FAR0011)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset -  Projected Value';
                        Image = MoveUp;
#pragma warning disable AL0432
                        RunObject = report "Fixed Asset - Projected Value";
#pragma warning restore AL0432

                    }
                    action(FAR0012)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset Document Nos.';
                        Image = MoveUp;
                        RunObject = report "Fixed Asset Document Nos.";
                    }
                    action(FAR0013)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset Journal - Test';
                        Image = MoveUp;
                        RunObject = report "Fixed Asset Journal - Test";
                    }
                    action(FAR0014)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Asset Register';
                        Image = MoveUp;
                        RunObject = report "Fixed Asset Register";
                    }

                }

                group("Purchase Requisition List")
                {
                    Caption = 'Procurement';

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

                }

                group(PeriodicActivities)
                {
                    Caption = 'Periodic Activities';

                    action(Action29)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Accounting Periods';
                        Image = "Order";
                        RunObject = Page "Accounting Periods";
                    }

                    action("Close Income Statement")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Close Income Statement';
                        Image = Reminder;
                        RunObject = Report "Close Income Statement";
                    }

                    action("Product Listing Comparison")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Product Listing Comparison';
                        Image = Reminder;
                        RunObject = Report "Product Listing Comparison";
                    }

                    action("Vendor Listing Comparison")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Vendor Listing Comparison';
                        Image = Reminder;
                        RunObject = Report "Vendor Listing Balance Report";
                    }

                    action("Credit Ledger Missing in TB")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Credit Ledger Missing in GL';
                        Image = Reminder;
                        RunObject = Report "Credit Ledger Missing in TB";
                    }

                    action("Savings Ledger Missing in TB")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Savings Ledger Missing in TB';
                        Image = Reminder;
                        RunObject = Report "Savings Ledger Missing in TB";
                    }

                    action("TB Missing in Credit Ledger")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'TB Missing in Sub-Ledger';
                        Image = Reminder;
                        RunObject = Report "TB Missing in Credit Ledger";
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
                    action(Action400)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement Logs';
                        Image = Quote;
                        RunObject = Page "File Movement Log";
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

                    action("Loan Interest Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;


                        RunObject = Page "Loan Interest Buffer";
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
                    action("Loans Disbursement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Disbursement';
                        Image = "Order";


                        RunObject = Report "Loan Disbursement";
                    }

                    action("Loan Repayment Analysis")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Repayment Analysis';
                        Image = "Order";


                        RunObject = Report "Loan Repayment Analysis";
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
                    action("Loans Interest Monitor")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Interest Monitor';
                        Image = "Order";


                        RunObject = Report "Loans Interest Monitor";
                    }

                }

                group(CheckOff)
                {
                    Caption = 'CheckOff';

                    action("Monthly Advice")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Advice';
                        Image = "Order";


                        RunObject = Page "Monthly Advice List";
                    }


                    action("Monthly Advice - Posted")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Advice - Posted';
                        Image = "Order";


                        RunObject = Page "Monthly Advice List - Posted";
                    }

                    action("Monthly CHeckoff")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly CheckOff';
                        Image = "Order";


                        RunObject = Page "CheckOff List";
                    }

                    action("Posted Checkoff")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted-Monthly CheckOff';
                        Image = "Order";


                        RunObject = Page "Posted Checkoff";
                    }


                }

                group(Sasra)
                {
                    Caption = 'SASRA';

                    group("Loan Aging")
                    {
                        action("LoanAging")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Loan Aging';
                            Image = "Order";


                            RunObject = report "SASRA Loan Categorization";
                        }
                        action("Loan-Aging")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loan Aging - SASRA';
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

                    action("Loan Recovery")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Recovery';
                        Image = "Order";


                        RunObject = Page "Defaulter Loan Recovery List";
                    }

                    action("CRB")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'CRB Reporting';
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
                    action("Teller Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Teller Report';
                        Image = Report;


                        RunObject = Report "Teller Report";
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
                }

                group(Overdraft)
                {
                    Visible = false;
                    Caption = 'Overdraft Management';



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

                    action("Account Transfers Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Account Transfers Report';
                        Image = "Order";


                        RunObject = Report "Account Transfers Report";
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


                        RunObject = Page "HR 360 Appraisals List";
                    }
                    action("360 Appraisals List - Supervisor")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR 360 Appraisals List";
                    }
                    action("360 Appraisals List - Evaluation")
                    {
                        ApplicationArea = RelationshipMgmt;


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

                group(HReports)
                {
                    Caption = 'HR Reports';

                    action("Employee Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List';
                        Image = "Order";


                        RunObject = Report "Employee - List";
                    }
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

                }

                group(Payroll)
                {
                    Caption = 'Payroll';

                    action("Staff Payroll List.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Payroll List.';
                        Image = "Order";


                        RunObject = Page "Staff Payroll List.";
                    }
                    action("Payroll Periods.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Periods.';
                        Image = "Order";


                        RunObject = Page "Payroll Periods.";
                    }

                    action("Payroll Periods Transaction")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Period Transaction';
                        Image = "Order";


                        RunObject = page "Payroll Period transactions.";
                    }
                    action("Payroll Journal Trasnfer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Journal Trasnfer';
                        Image = "Order";


                        RunObject = Report "Payroll Journal Transfer";
                    }



                }

                group(PayrollReports)
                {
                    Caption = 'Payroll Reports';

                    action("Payroll Codes Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Codes Report';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Payroll Codes Report";
                    }
                    action("P9 Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'P9 Report';
                        Image = "Order";


                        RunObject = Report "P9 Report";
                    }
                    action("Payroll Summary Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Summary Report';
                        Image = "Order";
                        Visible = true;


                        RunObject = Report "Payroll Summary Report";
                    }
                    action("Payroll Transactions Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Transactions Summary';
                        Image = "Order";
                        Visible = true;

                        RunObject = Report "Payroll Transactions Summary";
                    }
                    action("prPayrollSummary-List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'prPayrollSummary-List';
                        Image = "Order";
                        Visible = true;


                        RunObject = Report "prPayrollSummary-List";
                    }
                    action("Payroll Transaction List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Transaction List';
                        Image = "Order";
                        Visible = true;


                        RunObject = Report "Payroll Transaction List";
                    }

                    action("Payroll Summary Report Deductions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Summary Report - Deductions';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Payroll Summary - Ded Report";
                    }
                    action("Payroll Variance")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Varaince ';
                        Image = "Order";

                        RunObject = Report "Payroll Variance Rpt";
                    }
                    action("Detailed Payroll Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Detailed Payroll Summary Report';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Payroll Summary Detailed";
                    }
                    action("P9 Report - Board")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'P9 Report - Board';
                        Image = "Order";


                        RunObject = Report "P9 Report - Board";
                    }
                    action("Payroll Net Pay Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Net Pay Report';
                        Image = "Order";


                        RunObject = Report "Payroll Net Pay Report";
                    }
                    action("NITA Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "NITA Report";
                    }
                    action(NSSF)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report prNSSF;
                    }
                    action(NHIF)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report prNHIF;
                    }
                    action(HELB)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR HELB";
                    }
                    action(KUCDAW)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR KUCFAW";
                    }
                    action(COTU)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR COTU";
                    }
                    action(PROVIDENT)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR Provident NSSF";
                    }
                    action("A Third Rule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "A Third Rule";
                    }
                    action("Earnings Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Earnings Listing -List";
                    }
                    action("Deductions Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Deductions Listing-List";
                    }
                    action("Paye Schedule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "prPaye Schedule";
                    }
                    action("Pension Contributions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "prStaff Pension Contrib";
                    }
                    action("Transactions Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report prAllowances_Deductions;
                    }
                    action(P10A)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report P10A;
                    }

                }

            }


            group(Action3)
            {
                Caption = 'Setups';

                group(Finance)
                {
                    Caption = 'Setups';

                    action("General Ledger Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Ledger Setup';
                        Image = CustomerContact;


                        RunObject = Page "General Ledger Setup";
                    }
                    action("Accounting Periods")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Accounting Periods';


                        RunObject = Page "Accounting Periods";
                    }
                    action("No. Series")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'No. Series';


                        RunObject = Page "No. Series";
                    }
                    group("Posting Groups")
                    {
                        action("Gen. Business Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Gen. Business Posting Groups";
                        }
                        action("Gen. Product Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Gen. Product Posting Groups";
                        }
                        action("General Posting Setup")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "General Posting Setup";
                        }
                        action("Customer Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Customer Posting Groups";
                        }
                        action("Vendor Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Vendor Posting Groups";
                        }
                        action("FA Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "FA Posting Groups";
                        }
                        action("Bank Account Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Bank Account Posting Groups";
                        }
                        action("Inventory Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Inventory Posting Groups";
                        }
                        action("Inventory Posting Setup")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Inventory Posting Setup";
                        }

                    }
                    action("Dimensions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dimensions';


                        RunObject = Page "Dimensions";
                    }
                    action("General Journal Templates")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Journal Templates';


                        RunObject = Page "General Journal Templates";
                    }

                }

                group(HRPayrollSetups)
                {
                    Caption = 'HR & PayrollSetups';

                    action(HRSetups)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** HR Setups *****';
                        Image = CustomerContact;


                    }
                    action("Human Resources Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Human Resources Setup';


                        RunObject = Page "Human Resources Setup";
                    }
                    action("HR Advanced Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Advanced Setup';


                        RunObject = Page "HR Advanced Setup";
                    }
                    action("HR Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR General Setup';


                        RunObject = Page "HR Setup";
                    }
                    action("HR Leave Types")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Types';


                        RunObject = Page "HR Leave Types";
                    }
                    action("HR Leave Jnl. Template List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Jnl. Template List';


                        RunObject = Page "HR Leave Jnl. Template List";
                    }
                    action("HR Leave Batches")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Batches';


                        RunObject = Page "HR Leave Batches";
                    }
                    action("HR Leave Journal Lines")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Journal Lines';


                        RunObject = Page "HR Leave Journal Lines";
                    }
                    action("HR Leave Calendsr.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Calendar.';


                        RunObject = Page "HR Leave Calendsr.";
                    }


                    action(PayrollSetups)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** Payroll Setups *****';
                        Image = CustomerContact;


                    }
                    action("Payroll Posting Group.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Posting Group';


                        RunObject = Page "Payroll Posting Group.";
                    }
                    action("Payroll Codes List.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Codes List';


                        RunObject = Page "Payroll Codes List.";
                    }
                    action("Payroll Rates.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Rates.';


                        RunObject = Page "Payroll Rates.";
                    }
                    action("PAYE Setup.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'PAYE Setup.';


                        RunObject = Page "PAYE Setup.";
                    }
                    action("SetNHIF Setupup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'NHIF Setup';


                        RunObject = Page "NHIF Setup";
                    }

                    action("NSSF Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'NSSF Setup';


                        RunObject = Page "NSSF Setup";
                    }

                }

                group(SaccoSetups)
                {
                    Caption = 'Sacco Setups';

                    action(Credit)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** Credit Setups *****';
                        Image = CustomerContact;


                    }
                    action("DMS Endpoints")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'DMS Endpoints';
                        RunObject = Page "DMS Endpoints";
                    }
                    action("Sacco Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sacco Setup';


                        RunObject = Page "Sacco Setup";
                    }
                    action("IFRS-9 Model")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'IFRS-9 Model';


                        RunObject = Page "IFRS-9 Model";
                    }
                    action("Product Setup List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Product Setup';


                        RunObject = Page "Product Setup List";
                    }
                    action("Collateral Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Collateral Setup';


                        RunObject = Page "Collateral Setup";
                    }
                    action("Charges")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Charges';


                        RunObject = Page Charges;
                    }

                    action(Savings)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** Savings Setups *****';
                        Image = CustomerContact;


                    }
                    action("STO Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'STO Setups';
                        Image = ReceiveLoaner;
                        RunObject = page "STO Recovery Priority List";


                    }
                    action("FD Types")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Deposit Types';


                        RunObject = Page "FD Types List";
                    }
                    action("Transaction Charges List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Transaction Charges List';


                        RunObject = Page "Transaction Charges List";
                    }
                    action("Banking User Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Banking User Setup';


                        RunObject = Page "Banking User Setup";
                    }
                    action("CharCheque Typesges")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Cheque Types';


                        RunObject = Page "Cheque Types";
                    }

                    action(General)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** General Setups *****';
                        Image = CustomerContact;


                    }
                    action("SMS Charges")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'SMS Charges';


                        RunObject = Page "SMS Charges";
                    }
                    action("Bank COde")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Bank Code';


                        RunObject = Page "Bank COde";
                    }
                    action("Branch COde")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Branch Code';


                        RunObject = Page "Bank Branches";
                    }
                    action("Sacco Nos.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sacco Nos.';


                        RunObject = Page "Sacco Nos.";
                    }
                    action("Portal Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Portal Setup';


                        RunObject = Page "Portal Setup";
                    }
                    action("PUpGrade")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Calwide Upgrade';


                        RunObject = Page "UPG_XML Library";
                    }
                }

                group(Administration)
                {
                    Caption = 'Administration';

                    action("Users")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Users';
                        Image = "Order";


                        RunObject = Page Users;
                    }
                    action("User Setup")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'User Setup';
                        Image = Reminder;


                        RunObject = Page "User Setup";
                    }
                    action("Job Queue Category List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Job Queue Category';
                        Image = Reminder;


                        RunObject = Page "Job Queue Category List";
                    }

                    action("Job Queue Entries")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Job Queue Entries';
                        Image = Reminder;


                        RunObject = Page "Job Queue Entries";
                    }

                    action("Approval Setup")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;
                        RunObject = Page "Approval Setup";
                    }
                    action("Approval Code")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;
                        RunObject = Page "Approval Code";
                    }
                    action("Approval Templates")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;
                        RunObject = Page "Approval Templates";
                    }




                    action("Workflow - Table Relations")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Workflow - Table Relations';
                        Image = Reminder;


                        RunObject = Page "Workflow - Table Relations";
                    }

                    action("Workflow")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Workflow';
                        Image = Reminder;


                        RunObject = Page Workflow;
                    }

                    action("Workflow User Group")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Workflow User Group';
                        Image = Reminder;


                        RunObject = Page "Workflow User Group";
                    }

                    action("Approval User Setup")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Approval User Setup';
                        Image = Reminder;


                        RunObject = Page "Approval User Setup";
                    }

                    action("Profiles")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Profiles';
                        Image = Reminder;


                        RunObject = Page "Profile List";
                    }

                    action("User Personalization List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'User Personalization List';
                        Image = Reminder;


                        RunObject = Page "User Settings List";
                    }


                }
            }

            group(Action4)
            {
                Caption = 'Management';

                group(ManReports)
                {
                    Caption = 'Management Reports';

                    action("Account Application Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Account Application Summary";
                    }

                    action("Bank Branch Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Bank Branch Transactions";
                    }

                    action("Cashier Branch Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Cashier Branch Summary";
                    }

                    action("Credit PAR Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Credit PAR Report";
                    }

                    action("Exposure Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Exposure Report";
                    }

                    action("Interest Accrual Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Interest Accrual Report";
                    }

                    action("Loan Daily Report - Detailed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Loan Daily Report - Detailed";
                    }

                    action("Loan Daily Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Loan Daily Transactions";
                    }

                    action("Loan Topup Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Loan Topup Report";
                    }

                    action("Loans Repaid Via Payout")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Loans Repaid Via Income";
                    }

                    action("Product Activity Variance")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Product Activity Variance";
                    }

                    action("Top Performers Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Top Performers Report";
                    }

                    action("Treasury Daily Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Treasury Daily Report";
                    }

                    action("User profiling Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "User profiling Report";
                    }

                    action("Dashboard")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = PayrollStatistics;


                        RunObject = Page "Dashboard.";
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

                    action("Mbanking Permissions")
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

            group(Additional)
            {
                Caption = 'Additional';
                action(CheckoffReport)
                {
                    ApplicationArea = RelationshipMgmt;


                    RunObject = report " Monthly Checkoff Report";
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
