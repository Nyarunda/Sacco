/// <summary>
/// Page Super Admin Role Center (ID 50350).
/// </summary>
Page 50350 "Super Admin Role Center"

{
    ApplicationArea = All;
    Caption = 'Super Admin', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control60; "Headline RC Relationship Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }
            /*  part(SaccoNewsActivities; "Sacco News Activities Part")
             {
                 ApplicationArea = RelationshipMgmt;
             } */
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
                Visible = false;
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
                    action("Ledger Branch Update")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Ledger Branch Update';
                        Image = Quote;
                        Visible = false;


                        RunObject = report 50542;
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



                    // 50476

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

                group(CheckOff)
                {
                    Caption = 'CheckOff';
                    Visible = false;


                    action("Monthly Advice")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Advice';
                        Image = "Order";


                        RunObject = Page "Monthly Advice List";
                    }


                    action("Variance Monthly Advice")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Variance';
                        Image = "Order";


                        RunObject = Page "Monthly Variance Advice List";
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
                        action("Loans Defaulter Aging - SACCO")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Defaulter Aging - SACCO';
                            Image = "Order";
                            Visible = false;

                            RunObject = report "Loans Defaulter Aging - SACCO";
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
                        action("SASRA Reports Listing")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'SASRA Reports Listing';
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

                        action("Loans Provisioning Sacco")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Provisioning Sacco';
                            Image = "Order";
                            Visible = false;


                            RunObject = report "Loans Provisioning Summary_S";
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

                group("Periodic Activities")
                {

                    action("Loan Interest Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;


                        RunObject = Page "Loan Interest Buffer";
                    }


                    action("Generate Mobile Loan Interest ")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = BreakRulesOff;
                        Visible = false;


                        RunObject = Report "Generate Mobile loans Interest";
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

                group("TransUnion Integration")
                {
                    Caption = 'TransUnion Kenya CRB';
                    Visible = false;

                    action("TransUnion Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'TransUnion Setup';
                        Image = Setup;
                        ToolTip = 'Configure TransUnion Kenya API settings';
                        RunObject = Page "TransUnion Setup";
                    }

                    action("TransUnion Daily Payments")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'TransUnion Daily Payments';
                        Image = CustomerContact;
                        ToolTip = 'Manage TransUnion daily payment information records';
                        RunObject = Page "TransUnion Daily Payments";
                    }

                    action("Generate TransUnion Data")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Generate TransUnion Data';
                        Image = CreateDocument;
                        ToolTip = 'Generate TransUnion payment records from existing loan data';
                        RunObject = Report "Generate TransUnion Data";
                    }

                    action("Generate Batch Data")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Generate Batch Data';
                        Image = PostBatch;
                        ToolTip = 'Generate TransUnion batch data from existing records';
                        RunObject = Report "Generate TransUnion Batch Data";
                    }

                    action("TransUnion API Log")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'TransUnion API Log';
                        Image = Log;
                        ToolTip = 'View TransUnion API submission history and responses';
                        RunObject = Page "TransUnion API Log List";
                    }

                    action("TransUnion Error Log")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'TransUnion Error Log';
                        Image = ErrorLog;
                        ToolTip = 'View and resolve TransUnion API validation errors';
                        RunObject = Page "TransUnion Error Log List";
                    }

                    action("TransUnion Batch Submissions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Batch Submissions';
                        Image = List;
                        ToolTip = 'Manage TransUnion batch submissions';
                        RunObject = Page "TransUnion Submission List";
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
                        Caption = 'Closed Fixed Deposit Accounts';
                        Image = List;

                        RunObject = Page "Fixed Deposit Accounts";
                        RunPageView = where("FD Status" = const(Closed));
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
                    action(Action5298)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Old Fosa Interest List';
                        Image = "Order";
                        RunObject = Page 50825;
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

                        Image = BreakRulesOff;

                        RunObject = Page "Old Div Pages";
                    }
                    action("Old Div List 2025")
                    {

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
                    action(EmployeeGymClaims)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee Gym Claims';
                        Image = "Order";

                        RunObject = Page "Employee Gym Claims";
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
                    action("E-Mail Staff Payslip")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "E-Mail Staff Payslip";
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

                    action(action0069)
                    {
                        Caption = 'Staff Welfare Schedule';
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Staff Welfare Schedule";
                    }
                    action("NSSF Tier 1 Schedule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'NSSF Tier 1 Schedule';
                        Image = "Order";
                        RunObject = Report "NSSF Tier 1 Schedule";
                    }
                    action("NSSF Tier 2 Schedule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'NSSF Tier 2 Schedule';
                        Image = "Order";
                        RunObject = Report "NSSF Tier 2 Schedule";
                    }
                    action(action0070)
                    {
                        Caption = 'Transfer Net to Journal';
                        ApplicationArea = Basic, Suite;
                        RunObject = report "PR Bank Summary";
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
                    action("Bank Payment Schedule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Bank Payment Schedule';
                        Image = "Order";


                        RunObject = Report "Bank Payment Schedule";
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
                        Caption = 'SHA';
                        RunObject = Report prNHIF;
                    }
                    action(HousingLevy)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report prHousinglevy;
                    }
                    action(HELB)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR HELB";
                    }
                    action(KUCFAW)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR KUCFAW";
                        Visible = false;
                    }
                    action(COTU)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR COTU";
                        Visible = false;
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
                        action("Tariff Codes")
                        {
                            ApplicationArea = RelationshipMgmt;

                            RunObject = Page "Tariff Code";
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

                    group(ProcurementSetup)
                    {
                        Caption = 'Procurement Setup';

                        action(ProcurSetup)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Procurement Setup';
                            Image = "Order";
                            RunObject = page "Procurement Setup";
                        }
                        action(ProcApprovalSetup)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Procurement Approval Setup';
                            Image = "Order";
                            RunObject = page "Proc Appr WF Setup";
                        }
                        action(RFQScoringSetup)
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'RFQ Scoring Criteria Setup';
                            Image = "Order";
                            RunObject = page "RFQ Scoring Criteria Setup";
                        }
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
                    action("HR Salary Grades")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Salary Grades';


                        RunObject = Page "Salary Grades List";
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
                    action(HRMailSetup)
                    {
                        ApplicationArea = All;
                        Caption = 'HR EMail Paramters Setup', comment = 'NLB="YourLanguageCaption"';
                        Image = "Invoicing-MailSent";

                        RunObject = Page "HR E-Mail Parameters List";
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
                    action("Loan Graduation Models")
                    {
                        ApplicationArea = All;
                        Caption = 'Loan Graduation Setup';
                        Image = Setup;
                        RunObject = Page "Loan Graduation Models";
                    }
                    action("Checkoff Codes")
                    {
                        ApplicationArea = RelationshipMgmt;
                        RunObject = Page "CheckOff Codes";
                    }
                    action("Member Class")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Class';


                        RunObject = Page "Member Class";
                    }
                    action("Default Products")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Default Products';


                        RunObject = Page "Default Product Class";
                    }
                    action("Board Committee List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Board Committee List';
                        RunObject = Page "Board Committee List";
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
                    action("Loan Documents Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Documents Setup';


                        RunObject = Page "Loan Documents";
                    }
                    action("General Loan Documents")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Loan Documents';


                        RunObject = Page "General Loan Documents";
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
                    action("Email Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Email Setup';
                        Image = Email;

                        RunObject = Page "Email Setup";
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

                    action("Benevolent Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Benevolent Setup';


                        RunObject = Page "BBF Entitlements";
                    }
                    action("Commission Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Registration Commission Setup';


                        RunObject = Page "Commissions Setup";
                    }
                    action("PUpGrade")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Calwide Upgrade';


                        RunObject = Page "UPG_XML Library";
                    }
                    action("Status Change Permission")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Status Change Permission';


                        RunObject = Page "Status Change Permissions";
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

                    action("Workflow User Group List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Workflow User Group List';
                        Image = Reminder;


                        RunObject = Page "Workflow User Group List";
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
                    action("Share Capital Capitalization")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Share Capital Capitalization';
                        Image = Reminder;


                        RunObject = Report "Capitalize Shares";
                    }
                    action("Budgetary Control Setup")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Budgetary Control Setup";
                    }
                    action("API Test Console")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Page "API Test Console";
                    }



                }
            }
            group(AMLModule)
            {
                Caption = 'Anti-Money Laundering (AML)';

                group(AMLMonitoring)
                {
                    Caption = 'Monitoring';

                    action(AMLTransactionMonitor)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Transaction Monitor';
                        Image = LedgerEntries;
                        RunObject = Page "AML Transaction Monitor List";
                        ToolTip = 'Monitor transactions for suspicious activity and compliance violations';
                    }

                    action(AMLSuspiciousActivities)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Suspicious Activities';
                        Image = Warning;
                        RunObject = Page "AML Suspicious Activity List";
                        ToolTip = 'View and manage suspicious activity investigations and alerts';
                    }

                    action(AMLCustomerRiskProfiles)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customer Risk Profiles';
                        Image = Customer;
                        RunObject = Page "AML Customer Risk Profile List";
                        ToolTip = 'View and manage customer risk assessments and profiles';
                    }
                }

                group(AMLAdministration)
                {
                    Caption = 'Administration';

                    action(AMLSetup)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'AML Setup';
                        Image = Setup;
                        RunObject = Page "AML Setup";
                        ToolTip = 'Configure AML system parameters, thresholds, and compliance settings';
                    }

                }

                group(AMLReporting)
                {
                    Caption = 'Reporting & Compliance';

                    action(AMLDashboard)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'AML Dashboard';
                        Image = Statistics;
                        RunObject = Page "AML Transaction Monitor List";
                        ToolTip = 'View AML compliance dashboard with key metrics and alerts';
                    }

                    action(AMLComplianceReport)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Compliance Report';
                        Image = Report;
                        ToolTip = 'Generate AML compliance reports for regulatory authorities';

                    }

                    action(SARReporting)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Suspicious Activity Reporting';
                        Image = SendTo;
                        ToolTip = 'Generate and submit Suspicious Activity Reports (SAR) to authorities';

                    }
                }
            }

            group(Action4)
            {
                Caption = 'Management';

                group(ManReports)
                {
                    Caption = 'Management Reports';



                    action("CreateAccounts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Create Savings Accounts";
                    }
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

                    action("FOSA Balances Analysis")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = AnalysisView;
                        RunObject = report "Fosa Balance Analysis";
                    }
                    action("FOSA Balances Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = AnalysisView;
                        RunObject = report "Fosa Balance Summary";
                    }

                    action("Ledger Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = LedgerBook;
                        RunObject = report "Ledgers Report";
                    }
                    action("Loans Variance Summary Div")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = PayrollStatistics;
                        RunObject = report "Loans Var Summary Div";
                    }
                    action("Loans Variance Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = ItemVariant;


                        RunObject = report "Loans Variance Summary";
                    }
                    action("Move Zero Balance A/C")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = CreateMovement;
                        RunObject = report "Move Zero Balance A/C";
                    }
                    action("Payroll  Received Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Payroll;
                        RunObject = report "Payroll  Received Summary";
                    }
                    action("Close Dormant Savings 0 bal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = ApplicationWorksheet;
                        RunObject = report "Close Dormant Savings 0 bal";
                    }
                    action("Approval Request")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = ApplicationWorksheet;
                        RunObject = report "Approval Request Report";
                    }
                    action("Savings Advice")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = ApplicationWorksheet;
                        RunObject = report "Savings Advice";
                    }




                    action("Reverse Dividends")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Reverse Dividend Posted";
                    }
                    action("Board Members Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Committee Approval";
                    }
                    action("All in One")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Page "UPG_XML Library";
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

                    action("Transaction Keyword Setup")
                    {
                        ApplicationArea = RelationshipMgmt;

                        RunObject = Page "Transaction Keyword Setup";
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
                    action("Sky Blank Receiver Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Page "Sky Blank Receiver Trans.";
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
                    action("Send Bulk Email")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Email;


                        RunObject = Page "Bulk Email Header List";
                    }

                    action("Posted Bulk Email")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Email;


                        RunObject = Page "Posted Bulk Email Header List";
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
                        Caption = 'Loan Defaulter Reminder Notifications';
                        Image = SendTo;

                        RunObject = Page "Loan Reminder Notifications";
                    }

                    action("Loan Reminder Sent Items")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Defaulter Reminder Sent Items';
                        Image = EntriesList;

                        RunObject = Page "Loan Reminder Sent Items";
                    }


                    action("Send Loan SMS")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;
                        Caption = 'Send Loan Reminder SMS';

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

            group(Additional)
            {
                Caption = 'Additional';
                action(CheckoffReport)
                {
                    ApplicationArea = RelationshipMgmt;


                    RunObject = report " Monthly Checkoff Report";
                }
                action("Clear Empty Journal")
                {
                    ApplicationArea = RelationshipMgmt;

                    RunObject = Report "Clear Journal";
                }
                action("Data Importation")
                {
                    ApplicationArea = RelationshipMgmt;

                    RunObject = Page "Data Importation";
                }
                action("Job Scheduler")
                {
                    ApplicationArea = RelationshipMgmt;

                    RunObject = Report "Process Job Schedule";
                }
                action("Upload Picture")
                {
                    ApplicationArea = RelationshipMgmt;

                    RunObject = Report "Upload Pictures";
                }
                action("Email Statement")
                {
                    ApplicationArea = RelationshipMgmt;

                    RunObject = Report "Email Stetements Job Que";
                }
                action("Auto Interest")
                {
                    ApplicationArea = RelationshipMgmt;
                    Image = "Order";


                    RunObject = Report "Automated Loan Interest";
                }
                action("Update Bosa Status")
                {
                    ApplicationArea = RelationshipMgmt;
                    Image = "Order";


                    RunObject = Report "Update Bosa Status";
                }
                action("Update Loan Schedules")
                {
                    ApplicationArea = RelationshipMgmt;
                    Image = "Order";


                    RunObject = Report "Update Loans Schedule";
                }
                action("Transfer Interest Overpayment")
                {
                    ApplicationArea = RelationshipMgmt;
                    Image = "Order";


                    RunObject = Report "Transfer Interest Overpayment";
                }
                action("Automated Interest")
                {
                    ApplicationArea = RelationshipMgmt;
                    Image = "Order";


                    RunObject = Report "Automated Loan Interest";
                }
                action("Manual Dividend Loans")
                {
                    ApplicationArea = RelationshipMgmt;
                    Image = "Order";


                    RunObject = Report "Generate Dividend Loans Manual";
                }
                action("Loan Reminder SMS")
                {
                    ApplicationArea = RelationshipMgmt;
                    Image = PayrollStatistics;


                    RunObject = Report "Loan Reminder SMS";
                }
                action("Deposits to Arrears")
                {
                    ApplicationArea = RelationshipMgmt;
                    Image = PayrollStatistics;


                    RunObject = Report "Recover Wrong Posted Arrears";
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


            group(ShareTradingModule)
            {
                Caption = 'Share Trading';

                group(ShareTradingSetup)
                {
                    Caption = 'Setup';

                    action("Share Trading Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Share Trading Setup';
                        Image = Setup;
                        RunObject = Page "Share Trading Setup";
                        ToolTip = 'Configure share trading parameters and settings';
                    }
                }

                group(OrderManagement)
                {
                    Caption = 'Order Management';

                    action("Share Trading Orders")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Share Trading Orders';
                        Image = OrderList;
                        RunObject = Page "Share Trading Order List";
                        ToolTip = 'View and manage all share trading orders';
                    }

                    action("New Buy Order")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'New Buy Order';
                        Image = New;
                        RunObject = Page "Share Trading Order Card";
                        RunPageMode = Create;
                        ToolTip = 'Create a new share buy order';
                    }

                    action("New Sell Order")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'New Sell Order';
                        Image = New;
                        RunObject = Page "Share Trading Order Card";
                        RunPageMode = Create;
                        ToolTip = 'Create a new share sell order';
                    }
                }

                group(MatchingAndExecution)
                {
                    Caption = 'Matching & Execution';

                    action("Share Trading Matches")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Share Trading Matches';
                        Image = "Order";
                        RunObject = Page "Share Trading Match List";
                        ToolTip = 'View all share trading matches';
                    }

                    action("Match Details")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Match Details';
                        Image = ViewDetails;
                        RunObject = Page "Share Trading Match Details";
                        ToolTip = 'View detailed match information';
                    }

                    action("Process Order Matching")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Process Order Matching';
                        Image = CreateForm;
                        RunObject = Codeunit "Share Trading Management";
                        ToolTip = 'Run automatic order matching process';
                    }
                }

                group(ShareTradingReports)
                {
                    Caption = 'Reports';

                    action("Order Book Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Order Book Report';
                        Image = Report;
                        RunObject = Report "Share Trading Order Book";
                        ToolTip = 'View current order book status';
                    }

                    action("Trading Activity Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Trading Activity Report';
                        Image = Report;
                        RunObject = Report "Share Trading Activity";
                        ToolTip = 'View share trading activity report';
                    }

                    action("Match Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Match Report';
                        Image = Report;
                        RunObject = Report "Share Trading Match Report";
                        ToolTip = 'View detailed match report with financial breakdown';
                    }

                    action("Member Order History")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Order History';
                        Image = Report;
                        RunObject = Report "Member Order History";
                        ToolTip = 'View member share trading history';
                    }
                }

                group(ShareTradingMonitoring)
                {
                    Caption = 'Monitoring';

                    action("Trading Statistics")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Trading Statistics';
                        Image = Statistics;
                        RunObject = Page "Share Trading Order Stats";
                        ToolTip = 'View share trading statistics and performance metrics';
                    }

                    action("Member Share Balances")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Share Balances';
                        Image = Balance;
                        RunObject = Page "Member List";
                        ToolTip = 'View member share balances and available shares';
                    }
                    action("DeleteScehdules")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Delete Loan Schedules';
                        Image = Delete;
                        RunObject = Report "Delete Loan Schedules";
                        ToolTip = 'Delete loan schedules with Line No. >= 1000 for selected loans';
                    }
                }
            }


        }

        area(processing)
        {

        }


    }

}
