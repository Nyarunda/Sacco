
Table 50093 "Member Accounts"
{
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Member Accounts List";
    LookupPageID = "Member Accounts List";

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
            Editable = true;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                UpdateCurrencyId;
            end;
        }
        field(39; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionMembers = " ",Debit,Credit,All;
        }
        field(53; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(60; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Account No." = field("No."),
                                                                    "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Savings Ledger Entry"."Amount (LCY)" where("Account No." = field("No."),
                                                                            "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(8001; "Currency Id"; Guid)
        {
            Caption = 'Currency Id';
            DataClassification = ToBeClassified;
            //TableRelation = Currency.Id;

            trigger OnValidate()
            begin
                UpdateCurrencyCode;
            end;
        }
        field(50006; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Vendor,Savings;
        }
        field(50008; "Mobile Phone No."; Code[30])
        {
            CalcFormula = lookup(Members."Mobile Phone No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Savings Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }


        field(50050; "Creditor Type"; Enum "Creditor Type Enum")
        {
            Caption = 'Creditor Type';
            DataClassification = ToBeClassified;
        }


        field(50051; "Authorised Over Draft"; Decimal)
        {
            CalcFormula = sum("Overdraft Header"."Approved Amount" where("Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          Expired = const(false)));
            Description = 'Sum("Overdraft Header"."Approved Amount" WHERE (Account No.=FIELD(No.),Posted=CONST(Yes),Expired=CONST(No)))';
            FieldClass = FlowField;
        }
        field(50052; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum("Teller Transaction".Amount where("Account No." = field("No."),
                                                                 Posted = const(true),
                                                                 Type = filter("Cheque Deposit" | "Credit Cheque"),
                                                                 "Cheque Status" = filter(Pending | Matured)));
            FieldClass = FlowField;
        }
        field(50053; "Lien Placed"; Decimal)
        {
            CalcFormula = sum("Teller Transaction".Amount where("Account No." = field("No."),
                                                                 Posted = const(true),
                                                                 Type = filter(Lien),
                                                                 "Cheque Status" = filter(Pending)));
            FieldClass = FlowField;
        }

        field(50001; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Virtual Account","FOSA Shares",Business,Jipange,"Agent Float","Agent Commission";
        }
        field(50002; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
        }
        field(50003; "Product Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(50005; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
            end;
        }
        field(50007; "ID No."; Code[50])
        {
            CalcFormula = lookup(Members."ID No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(50009; "Payroll/Staff No."; Code[50])
        {
            CalcFormula = lookup(Members."Payroll/Staff No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; Status; Enum "Account Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Group No."; Code[20])
        {
            CalcFormula = lookup(Members."Group No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(50013; "Child Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Child Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Child Birth Cet. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Test Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Signing Instructions Narration"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Mandate;
        }
        field(50018; "Transactional Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Monthly Contribution Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Contribution Updated By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Cheque Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Old Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Old Member No."; Code[20])
        {
            CalcFormula = lookup(Members."Old Member No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(50024; "Next MLoan Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Member Category"; Option)
        {
            CalcFormula = lookup(Members."Member Category" where("No." = field("Member No.")));
            FieldClass = FlowField;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member";
        }
        field(50058; "Last Transaction Date"; Date)
        {
            CalcFormula = max("Savings Ledger Entry"."Posting Date" where("Amount (LCY)" = filter(<> 0),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Account No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50059; "Mobile Withdrawals"; Decimal)
        {
            CalcFormula = sum("Mobile Withdrawal Buffer".Amount where("Account No" = field("No."),
                                                                        Posted = const(false)));
            FieldClass = FlowField;
        }
        field(50060; "Cheque Book Mandate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Child Account Status"; Option)
        {
            OptionMembers = Child,"Pending Conversion",Converted;
        }

        field(50063; "Dormancy Period"; DateFormula)
        {
            CalcFormula = lookup("Product Setup"."Dormancy Period" where("Product ID" = field("Product Type")));
            FieldClass = FlowField;
        }

        field(50064; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loan Security" where("Account No." = field("No."),
                                                       Substituted = const(false),
                                                       "Outstanding Principal" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }


        field(50065; "ATM No."; Code[20])
        {
            Editable = false;
        }
        field(50066; "ATM Balance"; Decimal)
        {
            CalcFormula = sum("Coop ATM Transaction"."Total Account Debit" where("Member Account" = field("No."),
                                                                 Posted = const(false),
                                                                 "Transaction Type" = filter(<> 1420)));
            FieldClass = FlowField;
        }


        field(50067; "Piggy Bank Issued"; Boolean)
        {
            Editable = false;
        }


        field(50074; "Allow Bank Transfer"; Boolean)
        {
            Editable = false;
        }
        field(50068; "Mbanking Registered"; Boolean)
        {
            Editable = false;
        }
        field(50069; "Bank Transfer Trans. Limit"; Decimal)
        {
            Editable = false;
        }
        field(50070; "Bank Transfer Daily Limit"; Decimal)
        {
            Editable = false;
        }

        field(50071; "Allow Withdrawal To Others"; Boolean)
        {
            Editable = false;
        }
        field(50072; "Salary Processing"; Boolean)
        {
            Editable = false;
        }



        field(50073; "Old ATM No"; Code[20])
        {
            Editable = false;
        }



        field(50080; "Repay Mode"; Enum "Repay Mode Enum")
        {
            //ValuesAllowed = " ", Salary, Milk, Tea,"Staff Salary","Business","Check Off","Dividends","Internal Standing Order","External Standing Order","Pension","Bonus","Mini-Bonus",Allowance,Cash;
            ValuesAllowed = " ", Salary, "Check Off", "Internal Standing Order", "External Standing Order", "Pension", Allowance, Cash;

        }


        field(50081; "Active Fixed Deposit"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Fixed Deposit Accounts"."FD Amount" where("Fixed Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          "FD Status" = const(Active),
                                                                          "No." = field("FD Filter"),
                                                                          "Approval Status" = const(Approved)));
        }


        field(50082; "FD Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

        field(50083; "Block Instant Loans"; Boolean)
        {
        }

        field(50087; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50088; "Old Amount"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
        }


        field(50089; "OLD ATM Balance"; Decimal)
        {
            CalcFormula = sum("ATM Transactions".Amount where("Account No" = field("No."),
                                                                 Posted = const(false),
                                                                 Transfered = const(false)));
            FieldClass = FlowField;
        }

        field(50090; "Old Uncleared Cheques"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transactions- CBS".Amount WHERE("Account No" = FIELD("No."), Posted = CONST(true), "Cheque Processed" = CONST(False), Type = CONST('Cheque Deposit')));
        }

        field(50091; "Employer Code"; Code[20])
        {
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No.")));
            FieldClass = FlowField;
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(50092; "Membership Date"; Date)
        {
            CalcFormula = lookup(Members."Registration Date" where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(50093; "Member ID"; Code[50])
        {
        }
        field(50094; "Member Staff No."; Code[50])
        {
        }
        field(50095; "Old Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Member Ledger Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Old Net Change';
            Editable = false;
            FieldClass = FlowField;
        }


        field(50096; "Cummulative Contribution"; Decimal)
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

        field(50097; "Current Balance"; Decimal)
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

        field(50098; "Change Balance"; Decimal)
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


        field(50099; "Total Loan Arrears"; Decimal)
        {
            CalcFormula = Sum("SACCO Categorization"."Total Arrears" where("Member No." = field("Member No.")));
            FieldClass = FlowField;
        }


        field(50100; "Duplicates"; Integer)
        {
            CalcFormula = count(Vendor where("Product Category" = field("Product Category"), "Member No." = field("Member No.")));
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
                                                                 "Guarantor Type" = filter(Lien)));
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
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));
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
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("Virtual Account No.")));
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

        field(50157; "Virtual Approved Fuuza"; Decimal)
        {
            CalcFormula = sum("Fuliza"."Approved Amount" where("Account No." = field("Virtual Account No."),
                                                                          Posted = const(true),
                                                                          Expired = const(false)));
            FieldClass = FlowField;
        }




    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
        key(Key3; "Product Category")
        {
        }
        key(Key4; "Old Account No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Old Account No.", Name, "Product Name", "Balance (LCY)")
        {
        }
        fieldgroup(Brick; "No.", Name, "Product Name", "Balance (LCY)")
        {
        }
    }

    trigger OnDelete()
    var
    begin
    end;

    trigger OnInsert()
    begin
        SetLastModifiedDateTime;
    end;

    trigger OnModify()
    begin
        SetLastModifiedDateTime;
    end;

    trigger OnRename()
    begin
        SetLastModifiedDateTime;
    end;

    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text002: label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?';
        Text003: label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";

        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        LeadTimeMgt: Codeunit "Lead-Time Management";
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        InsertFromContact: Boolean;
        Text004: label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: label 'post';
        Text006: label 'create';
        Text007: label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3';
        Text008: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.';
        Text009: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text010: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text011: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        SelectVendorErr: label 'You must select an existing vendor.';
        CreateNewVendTxt: label 'Create a new vendor card for %1.', Comment = '%1 is the name to be used to create the customer. ';
        VendNotRegisteredTxt: label 'This vendor is not registered. To continue, choose one of the following options:';
        SelectVendTxt: label 'Select an existing vendor.';
        InsertFromTemplate: Boolean;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Vendor, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;

    procedure CheckBlockedVendOnDocs(Vend2: Record "Savings Accounts"; Transaction: Boolean)
    begin
        if Vend2.Blocked = Vend2.Blocked::All then
            VendBlockedErrorMessage(Vend2, Transaction);
    end;

    procedure CheckBlockedVendOnJnls(Vend2: Record "Savings Accounts"; DocType: Enum "Gen. Journal Document Type"; Transaction: Boolean)
    begin
        if (Vend2.Blocked = Vend2.Blocked::All) then
            VendBlockedErrorMessage(Vend2, Transaction);
    end;

    procedure VendBlockedErrorMessage(Vend2: Record "Savings Accounts"; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        if Transaction then
            Action := Text005
        else
            Action := Text006;
        Error(Text007, Action, Vend2."No.", Vend2.Blocked);
    end;

    local procedure SetLastModifiedDateTime()
    begin
        "Last Modified Date Time" := CurrentDatetime;
        "Last Date Modified" := Today;
    end;

    local procedure UpdateCurrencyCode()
    var
        Currency: Record Currency;
    begin
        if not IsNullGuid("Currency Id") then begin
            //Currency.SetRange(Id,"Currency Id");
            //Currency.FindFirst;
        end;

        Validate("Currency Code", Currency.Code);
    end;


    procedure UpdateCurrencyId()
    var
        Currency: Record Currency;
    begin
        if "Currency Code" = '' then begin
            Clear("Currency Id");
            exit;
        end;

        if not Currency.Get("Currency Code") then
            exit;

        //"Currency Id" := Currency.Id;
    end;
}

