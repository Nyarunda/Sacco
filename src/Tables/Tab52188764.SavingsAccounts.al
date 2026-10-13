table 50446 "Savings Accounts"
{
    Caption = 'Savings Accounts';
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Member Accounts List";
    LookupPageID = "Member Accounts List";
    Permissions = TableData "Cust. Ledger Entry" = r;

    fields
    {
        field(01; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin

                // TestNoEntriesExist(FieldCaption("No."), "No.");
            end;
        }
        field(02; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                //     if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then "Search Name" := UpperCase(Name);

                //     if Name <> '' then begin
                //         if "Member No." <> '' then begin
                //             Cust.Reset;
                //             Cust.SetRange("Member No.", "Member No.");
                //             Cust.SetFilter("No.", '<>%1', "No.");
                //             if Cust.FindFirst then begin
                //                 Cust.ModifyAll(Name, Name);
                //             end;
                //             if Members.Get("Member No.") then begin
                //                 Members.Name := Name;
                //                 //Members.MODIFY;
                //             end;
                //         end;
                //     end;
            end;
        }

        field(03; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(04; "Creditor Type"; Enum "Creditor Type Enum")
        {
            Caption = 'Creditor Type';
            DataClassification = ToBeClassified;
        }


        field(05; "Authorised Over Draft"; Decimal)
        {
            CalcFormula = sum("Overdraft Header"."Approved Amount" where("Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          Expired = const(false)));
            Description = 'Sum("Overdraft Header"."Approved Amount" WHERE (Account No.=FIELD(No.),Posted=CONST(Yes),Expired=CONST(No)))';
            FieldClass = FlowField;
        }
        field(06; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum("Teller Transaction".Amount where("Account No." = field("No."),
                                                                 Posted = const(true),
                                                                 Type = filter("Cheque Deposit" | "Credit Cheque"),
                                                                 "Cheque Status" = filter(Pending | Matured)));
            FieldClass = FlowField;
        }
        field(07; "Lien Placed"; Decimal)
        {
            CalcFormula = sum("Teller Transaction".Amount where("Account No." = field("No."),
                                                                 Posted = const(true),
                                                                 Type = filter(Lien),
                                                                 "Cheque Status" = filter(Pending)));
            FieldClass = FlowField;
        }

        field(08; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Virtual Account","FOSA Shares",Business,Jipange,"Agent Float","Agent Commission",Investment,Jiajiri,"Salary Account","MFI Deposit";
        }
        field(09; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
            trigger OnValidate()
            var
                PSetup: Record "Product Setup";
            begin
                if PSetup.Get(Rec."Product Type") then begin
                    Rec."Customer Posting Group" := PSetup."Product Posting Group";
                    Rec."Product Name" := PSetup.Description;
                end;
            end;
        }
        field(10; "Product Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
            trigger OnValidate()
            var
                Member: Record Members;
            begin
                Member.get("Member No.");
                Name := Member.Name;
                "Member ID" := Member."ID No.";
            end;
        }
        field(12; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
            end;
        }
        field(13; "ID No."; Code[50])
        {
            CalcFormula = lookup(Members."ID No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(14; "Payroll/Staff No."; Code[50])
        {
            CalcFormula = lookup(Members."Payroll/Staff No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Status; Enum "Account Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Group No."; Code[20])
        {
            CalcFormula = lookup(Members."Group No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(17; "Child Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Child Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Child Age"; Integer)
        {
            Caption = 'Child Age (Years)';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(19; "Child Birth Cet. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Test Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Signing Instructions Narration"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Mandate;
        }
        field(22; "Transactional Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Monthly Contribution Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Contribution Updated By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Cheque Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Old Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Old Member No."; Code[20])
        {
            CalcFormula = lookup(Members."Old Member No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(28; "Next MLoan Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Member Category"; Option)
        {
            CalcFormula = lookup(Members."Member Category" where("No." = field("Member No.")));
            FieldClass = FlowField;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member";
        }
        field(30; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(31; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(32; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(33; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(35; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,Blocked);
            end;
        }
        field(36; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Last Date Modified");
            end;
        }
        field(37; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";

            trigger OnValidate()
            begin
                //TestNoEntriesExist(FieldCaption("No."), "No.");
            end;
        }
        field(38; Blocked; enum "Vendor Blocked")
        {
            Caption = 'Blocked';
        }
        field(39; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Net Change"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry".Amount WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."), "Posting Date" = FIELD(UPPERLIMIT("Date Filter")), "Initial Entry Due Date" = FIELD("Date Filter"), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(44; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."), "Posting Date" = FIELD(UPPERLIMIT("Date Filter")), "Initial Entry Due Date" = FIELD("Date Filter"), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Mobile Phone No."; code[20])
        {
            Caption = 'Mobile Phone No.';
        }

        field(46; "Loan Disbursement Account"; Boolean)
        {

        }
        field(47; "Phone No."; code[14])
        {
            Caption = 'Phone No.';
        }
        field(48; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Savings Ledger Entry"."Debit Amount" WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Savings Ledger Entry"."Credit Amount" WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Savings Ledger Entry"."Debit Amount (LCY)" WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Currency Code" = FIELD("Currency Code"), "Document No." = FIELD("Document No. Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Savings Ledger Entry"."Credit Amount (LCY)" WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Document No." = FIELD("Document No. Filter"), "Currency Code" = FIELD("Currency Code")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

        field(58; "Last Transaction Date"; Date)
        {
            CalcFormula = max("Savings Ledger Entry"."Posting Date" where("Amount (LCY)" = filter(<> 0),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Account No." = field("No."),
                                                                           Channel = filter(<> "Recovery")
                                                                           ));
            FieldClass = FlowField;
        }
        field(59; "Mobile Withdrawals"; Decimal)
        {
            CalcFormula = sum("Mobile Withdrawal Buffer".Amount where("Account No" = field("No."),
                                                                        Posted = const(false)));
            FieldClass = FlowField;
        }
        field(60; "Cheque Book Mandate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Child Account Status"; Option)
        {
            OptionMembers = Child,"Pending Conversion",Converted;
        }

        field(63; "Dormancy Period"; DateFormula)
        {
            CalcFormula = lookup("Product Setup"."Dormancy Period" where("Product ID" = field("Product Type")));
            FieldClass = FlowField;
        }

        field(64; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loan Security" where("Account No." = field("No."),
                                                       Substituted = const(false),
                                                       "Outstanding Principal" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }


        field(65; "ATM No."; Code[20])
        {
            Editable = false;
        }
        field(66; "ATM Balance"; Decimal)
        {
            CalcFormula = sum("Coop ATM Transaction"."Total Account Debit" where("Member Account" = field("No."),
                                                                 Posted = const(false),
                                                                 "Transaction Type" = filter(<> 1420)));
            FieldClass = FlowField;
        }


        field(67; "Piggy Bank Issued"; Boolean)
        {
            Editable = false;
        }


        field(74; "Allow Bank Transfer"; Boolean)
        {
            Editable = false;
        }
        field(68; "Mbanking Registered"; Boolean)
        {
            Editable = false;
        }
        field(69; "Bank Transfer Trans. Limit"; Decimal)
        {
            Editable = false;
        }
        field(70; "Bank Transfer Daily Limit"; Decimal)
        {
            Editable = false;
        }

        field(71; "Allow Withdrawal To Others"; Boolean)
        {
            Editable = false;
        }
        field(72; "Salary Processing"; Boolean)
        {
            Editable = false;
        }



        field(73; "Old ATM No"; Code[20])
        {
            Editable = false;
        }

        field(75; "Mobile Loan Limit"; Decimal)
        {
            Editable = true;
        }

        field(76; "EFT Balance"; Decimal)
        {
            CalcFormula = sum("EFT Line".Amount where("Account No." = field("No."), Posted = const(false)));
            FieldClass = FlowField;
        }
        field(80; "Repay Mode"; Enum "Repay Mode Enum")
        {
            //ValuesAllowed = " ", Salary, Milk, Tea,"Staff Salary","Business","Check Off","Dividends","Internal Standing Order","External Standing Order","Pension","Bonus","Mini-Bonus",Allowance,Cash;
            //ValuesAllowed = " ", Salary, "Check Off", "Internal Standing Order", "External Standing Order", "Pension", Allowance, Cash;

        }


        field(81; "Active Fixed Deposit"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Fixed Deposit Accounts"."FD Amount" where("Fixed Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          "FD Status" = const(Active),
                                                                          "No." = field("FD Filter"),
                                                                          "Approval Status" = const(Approved)));
        }


        field(82; "FD Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

        field(83; "Block Instant Loans"; Boolean)
        {
        }

        field(87; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(88; "Old Amount"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
        }


        field(89; "OLD ATM Balance"; Decimal)
        {
            CalcFormula = sum("ATM Transactions".Amount where("Account No" = field("No."),
                                                                 Posted = const(false),
                                                                 Transfered = const(false)));
            FieldClass = FlowField;
        }

        field(90; "Old Uncleared Cheques"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transactions- CBS".Amount WHERE("Account No" = FIELD("No."), Posted = CONST(true), "Cheque Processed" = CONST(False), Type = CONST('Cheque Deposit')));
        }

        field(91; "Employer Code"; Code[20])
        {
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No.")));
            FieldClass = FlowField;
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(92; "Membership Date"; Date)
        {
            CalcFormula = lookup(Members."Registration Date" where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(93; "Member ID"; Code[50])
        {
        }
        field(94; "Member Staff No."; Code[50])
        {
        }
        field(95; "Old Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Member Ledger Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Old Net Change';
            Editable = false;
            FieldClass = FlowField;
        }


        field(96; "Cummulative Contribution"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
            end;
        }

        field(97; "Current Balance"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
                "Cummulative Contribution" := "Monthly Contribution" + "Change Balance" + "Current Balance";
            end;
        }

        field(98; "Change Balance"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
                "Cummulative Contribution" := "Monthly Contribution" + "Change Balance" + "Current Balance";

            end;
        }


        field(99; "Total Loan Arrears"; Decimal)
        {
            CalcFormula = Sum("SACCO Categorization"."Total Arrears" where("Member No." = field("Member No.")));
            FieldClass = FlowField;
        }


        field(50100; "Duplicates"; Integer)
        {
            CalcFormula = count("Savings Accounts" where("Product Category" = field("Product Category"), "Member No." = field("Member No.")));
            FieldClass = FlowField;
        }

        field(50101; "ATM Delinked By"; Code[50])
        {
            Editable = false;
        }
        field(50102; "Date Delinked"; Date)
        {
            Editable = false;
        }


        field(50103; "Old Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Member Ledger Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                   "Posting Date" = FIELD("Date Filter")));

            Editable = false;
            FieldClass = FlowField;
        }


        field(50104; "Salaried"; Boolean)
        {
            CalcFormula = lookup(Vendor."Salary Processing" where("Member No." = field("Member No."), "Product Category" = const("Ordinary Savings")));
            FieldClass = FlowField;
        }


        field(50105; "Loan Lien"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Current Committed" where("Account No." = field("No."),
                                                                 "Guarantor Type" = filter(Lien), "Outstanding Principal" = filter(> 0)));
            FieldClass = FlowField;
        }

        field(50106; "KRA Pin No."; code[11])
        {
            DataClassification = ToBeClassified;

        }
        field(50107; "Next Capitalization Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "New Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("No."),
                                                                                   "Currency Code" = FIELD("Currency Filter"), "Posting Date" = FIELD("Date Filter")));
            Caption = 'New Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;

        }


        field(50151; "Approved Fuuza"; Decimal)
        {
            CalcFormula = sum("Fuliza"."Approved Amount" where("Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          Expired = const(false)));
            FieldClass = FlowField;
        }


        field(190; "Allow Fuuza"; Boolean)
        {
            CalcFormula = lookup("Product Setup"."Allow Fuuza" where("Product ID" = field("Product Type")));
            FieldClass = FlowField;
        }
        field(200; "Virtual Account No."; Code[20])
        {
            TableRelation = Vendor where("Product Category" = const("Virtual Account"), "Member No." = field("Member No."));
        }

        field(201; "Virtual Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("Virtual Account No."),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Virtual Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }


        field(202; "Fuuza Interest"; Decimal)
        {


            CalcFormula = lookup("Fuuza Interest Buffer"."Interest Amount" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(203; "Virtual Account Interest"; Decimal)
        {
            CalcFormula = lookup("Fuuza Interest Buffer"."Interest Amount" where("Account No" = field("Virtual Account No.")));
            FieldClass = FlowField;
        }
        field(204; "Exempt Charges"; Boolean)
        {
            FieldClass = Normal;
        }
        field(205; "Document Type"; enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;
        }

        field(50157; "Virtual Approved Fuuza"; Decimal)
        {
            CalcFormula = sum("Fuliza"."Approved Amount" where("Account No." = field("Virtual Account No."),
                                                                          Posted = const(true),
                                                                          Expired = const(false)));
            FieldClass = FlowField;
        }

        field(50160; "Property Repayment"; Code[20])
        {
            FieldClass = Normal;

        }
        field(51200; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = true;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                OldDimSetID: Integer;
                IsHandled: Boolean;
                DimMgt: Codeunit DimensionManagement;
            begin

                OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet(
                    Rec, "Dimension Set ID", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }
        field(51201; Passport; Code[50])
        {
            CalcFormula = lookup(Members.Passport where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51202; "Deposit Changed By"; Code[50])
        {
            Editable = false;
            TableRelation = Members where("Member Category" = filter("Staff Members"));
            ;
        }



        field(51203; "Share Trading Buffer"; Decimal)
        {
            CalcFormula = sum("Share Trading Match"."Matched Amount" where("Buy Account No." = field("No."),
                                                                 Posted = const(false),
                                                                 Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(51204; "Document Ref. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50161; "Saving Type"; Option)
        {

            FieldClass = FlowField;
            CalcFormula = lookup("Product Setup"."Savings Type" where("Product ID" = field("Product Type")));
            OptionMembers = " ",Withdrawable,"Non-Withdrawable","Retained Shares",Term;
        }
        field(50162; "Old Member Number"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50163; "Member Registration Date"; Date)
        {
            CalcFormula = lookup(Members."Registration Date" where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }



    keys
    {
        key(Key1; "No.")
        {
        }

        key(Key2; Name)
        {
        }

        key(Key3; "Global Dimension 1 Code")
        {
        }

        key(Key4; "Member No.")
        {
        }
        key(Key5; "Member ID")
        {
        }
        key(Key6; "Member Staff No.")
        {
        }
        key(Key7; "Old Member Number")
        {
        }


    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Product Name", "Transactional Mobile No", Name, "ID No.", "Member No.", "Product Category", "Payroll/Staff No.", Status, "Old Member Number")
        {
        }
        fieldgroup(Brick; "No.", "Old Member Number", Name, "Member No.", "Member ID", "Member Staff No.")
        {
        }
    }
    trigger OnDelete()
    var
        CampaignTargetGr: Record "Campaign Target Group";
        ContactBusRel: Record "Contact Business Relation";
        Job: Record Job;

        StdCustSalesCode: Record "Standard Customer Sales Code";
    begin
        DimMgt.DeleteDefaultDim(DATABASE::Members, "No.");
    end;

    Var
        DimMgt: Codeunit DimensionManagement;



    procedure GetAvailableBalance() AccountBal: Decimal
    var
        MemberActivities: Codeunit "Member Activities";
        SavingsAcc: Record "Savings Accounts";
        SaccoCategory: Record "SACCO Categorization";
        TArrears: Decimal;
    begin


        AccountBal := MemberActivities.GetAccountBalance("No.");
        exit(AccountBal);
    end;


    procedure CheckBlockedVendOnJnls(Vend2: Record "Savings Accounts"; DocType: Enum "Gen. Journal Document Type"; Transaction: Boolean)
    var
        Source: Option Journal,Document;
    begin
    end;

}
