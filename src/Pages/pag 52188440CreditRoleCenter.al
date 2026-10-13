page 50084 "Credit Role Module"
{

    Caption = 'Credit Role', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
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
                visible = true;
                ;
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
                    group("Customer Reports")
                    {
                        Caption = 'Customer Reports';

                        action("Cutomer Summary Aging Report")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
#pragma warning disable AL0432
                            RunObject = Report "Customer - Summary Aging";
#pragma warning restore AL0432
                        }
                        action("Cutomer Summary Aging Simp.")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
#pragma warning disable AL0432
                            RunObject = Report "Customer - Summary Aging Simp.";
#pragma warning restore AL0432
                        }
                        action("Cutomer Detailed Aging")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
                            RunObject = Report "Customer Detailed Aging";
                        }
                        action("Aged Accounts Receivable")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
#pragma warning disable AL0432
                            RunObject = Report "Aged Accounts Receivable";
#pragma warning restore AL0432
                        }
                        action("Customer - Balance to Date")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
                            RunObject = Report "Customer - Balance to Date";
                        }
                        action("Customer - Detail Trial Bal.")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
                            RunObject = Report "Customer - Detail Trial Bal.";
                        }
                        action("Customer - List")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
#pragma warning disable AL0432
                            RunObject = Report "Customer - List";
#pragma warning restore AL0432
                        }

                        action("Customer Register")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
                            RunObject = Report "Customer Register";
                        }
                        action("Customer - Order Summary")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
                            RunObject = Report "Customer - Order Summary";
                        }
                        action("Customer - Order Detail")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
                            RunObject = Report "Customer - Order Detail";
                        }
                        action("Customer - Top 10 List")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
#pragma warning disable AL0432
                            RunObject = Report "Customer - Top 10 List";
#pragma warning restore AL0432
                        }
                        action("Customer - Sales List")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
#pragma warning disable AL0432
                            RunObject = Report "Customer - Sales List";
#pragma warning restore AL0432
                        }
                        action("Customer - Labels")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
                            RunObject = Report "Customer - Labels";
                        }
                        action("Sales Stats")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = ReturnCustomerBill;
#pragma warning disable AL0432
                            RunObject = Report "Sales Statistics";
#pragma warning restore AL0432
                        }

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


                        RunObject = Page "Posted Purchase Invoice";
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
                    action(Action230)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Inactive Fixed Assets';
                        Image = "Order";
                        RunObject = Page "FA List [Inactive]";
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
                        group(Inventory)
                        {
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
                    action("Employer Change")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Previous Employer Report';
                        Image = "Order";
                        RunObject = Report "Employer Change";
                    }
                    action("Transfer Interest Overpayment")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Transfer Overpayment Interest";
                    }
                    action("Transfer Interest Overpayment 0 Bal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Transfer Int Overpy 0 Balance";
                    }

                }
                group(FinancialReports)
                {
                    Caption = 'Financial Reports';


                    action(Action2366)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'FORM 2B';
                        Image = Quote;


                        RunObject = Report "Daily Liquidity SASRA [FORM2B]";
                    }

                    action("Rent Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Rent Analysis Report';
                        Image = ReturnCustomerBill;
                        RunObject = Report "Rent Analysis Report";
                    }
                    action("VAT Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'VAT Analysis Report';
                        Image = ReturnCustomerBill;
                        RunObject = Report "VAT Report";
                    }
                    action("VAT Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'VAT Register Report';
                        Image = ReturnCustomerBill;
                        RunObject = Report "VAT Register";
                    }



                }

            }

            group(Action257)
            {
                Caption = 'Registry';

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


                    action("Meeting Attendance")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Image = Reminder;
                        RunObject = Page "Meeting Attendance List";
                    }

                }

                group(Reports)
                {
                    Caption = 'Reports';

                    action("Member List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member List Report';
                        Image = "Order";
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
                    action("Monthly Contribution Changes")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Contribution Changes';
                        Image = "Order";
                        RunObject = Report "Monthly Contribution Changes";
                    }
                    action("GFE Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Next of Kin';
                        Image = Report2;

                        RunObject = Report GFE;
                    }
                    action("MFI Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'MFI Report';
                        Image = "Order";


                        RunObject = Report "MFI Report";
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
                        Visible = false;

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
                        Visible = false;

                        RunObject = Page "Loan Disbursement List";
                    }


                    action(PostedLoans)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Loans';
                        Image = "Order";


                        RunObject = Page "Loan Posted List";
                    }
                    action("Partial Loan Disbursement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Partial Loan Disbursement';
                        Image = DistributionGroup;


                        RunObject = Page "Partial Loan Disb. List";
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
                        action("Sacco Categorization")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Loan Aging- SACCO';
                            Image = "Order";
                            Visible = true;


                            RunObject = report "SACCO Loan Categorization";
                        }
                        action("Loans Defaulter Aging - SACCO")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Defaulter Aging - SACCO';
                            Image = "Order";
                            Visible = true;

                            RunObject = report "Loans Defaulter Aging - SACCO";
                        }
                        action("Loans Register")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Register';
                            Image = "Order";


                            RunObject = Report "Loans Register";
                        }
                        action("Sacco Loan Categorization")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Loan Aging- SACCO';
                            Image = "Order";
                            Visible = false;


                            RunObject = report "SACCO Loan Categorization";
                        }
                        action("SASRA Loan Categorization")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Loan Aging- SASRA';
                            Image = "Order";


                            RunObject = report "SASRA Loan Categorization";
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
                    action("Daily CRB")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Daily CRB Main Data';
                        Image = "Order";


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
                    action("Recovery Loan Lien")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;
                        Visible = false;

                        RunObject = report "Recover Arrears Lien";
                    }
                    action("Checkoff Codes")
                    {
                        ApplicationArea = RelationshipMgmt;
                        RunObject = Page "CheckOff Codes";
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
                        Visible = false;

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

            //BEGIN
            group(Action5)
            {
                Caption = 'Alternative Channels';

                group(MBanking)
                {
                    Caption = 'Sky Mobile Banking';
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

                    action("Loan Reminder Notifications")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Reminder Notifications';
                        Image = SendTo;

                        RunObject = Page "Loan Reminder Notifications";
                    }

                    action("Loan Reminder Sent Items")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Reminder Sent Items';
                        Image = EntriesList;

                        RunObject = Page "Loan Reminder Sent Items";
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
                    action("SpotCash Agency Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "SpotCash Agency Transactions";
                    }
                    action("Sky Agent Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Sky Agent Transactions";
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
