page 50479 FinanceModule
{
    Caption = 'Finance Module';
    PageType = RoleCenter;


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

                    action(skysearch)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Agent Tarrif Header';
                        Image = Quote;
                        Visible = false;


                        RunObject = Page "Agent Tarriff Header";
                    }

                    action(skyshyearch)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Agent Tarrif Details';
                        Image = Quote;
                        Visible = false;


                        RunObject = Page "Agent Tarriff Details";
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
                        Visible = false;


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
                    action("Trade Payables Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Reminder;
                        RunObject = Report "Trade Payables Report";
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

                    action("Calculate Depreciation Custom")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Calculate Depreciation Custom';
                        Image = Reminder;
                        visible = true;


                        RunObject = Report "Custom Depreciation Process";
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
                    action("Vote Transfer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Vote Transfer';
                        Image = TransferFunds;
                        RunObject = page "Vote Transfer List.";
                    }
                    action("Transfer Interest Overpayment 0 Bal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Transfer Int Overpy 0 Balance";
                    }
                    action("Vendor Listing Comparison")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Vendor Listing Comparison';
                        Image = Reminder;
                        RunObject = Report "Vendor Listing Balance Report";
                    }

                }


                group(FinancialReports)
                {
                    Caption = 'Financial Reports';

                    action(Action2365)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Remittance Report';
                        Image = Quote;

                        RunObject = Report "Monthly Remittance Report";
                    }
                    action(TreasurerReport)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Treasurer Report';
                        Image = Quote;

                        RunObject = Report "Treasurer Report V2";
                    }

                    action(Action2366)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'FORM 2B';
                        Image = Quote;


                        RunObject = Report "Daily Liquidity SASRA [FORM2B]";
                    }
                    action(Form2HOtherDisclosures)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'FORM 2H - Other Disclosures';
                        Image = Quote;
                        RunObject = Report "Form 2H Other Disclosures";
                    }
                    action(Action2367)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Account Schedules';
                        Image = Quote;


                        RunObject = Page "Account Schedule Names";
                    }
                    action(Action2368)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Financial Report';
                        Image = Quote;

                        RunObject = Page "Financial Reports";
                    }

                    action("Rent Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Visible = false;
                        Caption = 'Rent Analysis Report';
                        Image = ReturnCustomerBill;

                        RunObject = Report "Rent Analysis Report";
                    }

                    action("VAT Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'VAT Analysis Report';
                        Visible = false;
                        Image = ReturnCustomerBill;
                        RunObject = Report "VAT Report";
                    }
                    action("VAT Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'VAT Register Report';
                        Visible = false;
                        Image = ReturnCustomerBill;
                        RunObject = Report "VAT Register";
                    }
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
                    action("Trade Receivable Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = ReturnCustomerBill;
                        RunObject = Report "Trade Receivable Report";
                    }

                }

            }

            group(Action257)
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
                            ApplicationArea = RelationshipMgmt;

                            Image = BreakRulesOff;

                            RunObject = Page "Old Div Pages";
                        }
                        action("Old Div List 2025")
                        {
                            ApplicationArea = RelationshipMgmt;

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
                        action("Sky Mobile Transactions Reversed")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = Report;


                            RunObject = Page "Sky Mobile Trans. Reversed";
                        }
                        action("Mpesa Manual Uploads")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = Report;


                            RunObject = Page "Mpesa Manual Upload";
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

                        action("MLoan Member Analysis")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Image = Report;


                            RunObject = report "MLoan Member Analysis";
                        }




                    }
                    //END
                    //END

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


                    }
                }




            }
        }

        area(processing)
        {

        }
    }


}
