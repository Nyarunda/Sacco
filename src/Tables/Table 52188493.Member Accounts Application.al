
Table 50156 "Member Accounts Application"
{
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Member Accounts App. List";
    LookupPageID = "Member Accounts App. List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeries.TestManual(SalesSetup."Account Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[200])
        {
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
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
        field(22; "Document Type"; enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;
        }
        field(24; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(25; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(50001; "Product Category"; Option)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Virtual Account","FOSA Shares",Business,Jipange,"Agent Float","Agent Commission";
        }
        field(50002; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));

            trigger OnValidate()
            begin
                "Product Name" := '';

                if ProductSetup.Get("Product Type") then begin
                    ProductSetup.TestField("Global Dimension 1 Code");
                    "Product Name" := ProductSetup.Description;
                    "Global Dimension 1 Code" := ProductSetup."Global Dimension 1 Code";
                    "Product Category" := ProductSetup."Product Category";
                end;
            end;
        }
        field(50003; "Product Name"; Text[30])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50004; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;// where(Type = const(Member));
        }
        field(50005; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "ID No."; Code[30])
        {
            CalcFormula = lookup(Members."ID No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Mobile Phone No."; Code[30])
        {
            CalcFormula = lookup(Members."Mobile Phone No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Payroll/Staff No."; Code[50])
        {
            CalcFormula = lookup(Members."Payroll/Staff No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected,Created;
        }
        field(50012; "Group No."; Code[20])
        {
            CalcFormula = lookup(Members."Group No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Reference Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Child Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        // field(50014; "Child Date Of Birth"; Date)
        // {
        //     DataClassification = ToBeClassified;

        //     trigger OnValidate()
        //     var
        //         DateofBirthError: label 'This date cannot be greater than today.';
        //         SaccoSetup: Record "Sacco Setup";
        //         MinDOBAllowed: Date;
        //     begin
        //         if "Child Date Of Birth" > Today then
        //             Error(DateofBirthError);

        //         SaccoSetup.Get();



        //         MinDOBAllowed := CalcDate('-' + Format(SaccoSetup."Membership Age"), Today);

        //         if "Child Date Of Birth" <= MinDOBAllowed then
        //             Error('Only individuals under %1 years can be registered.', SaccoSetup."Membership Age");
        //     end;



        // }
        field(50014; "Child Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DateofBirthError: Label 'This date cannot be greater than today.';
                SaccoSetup: Record "Sacco Setup";
                MinDOBAllowed: Date;
                CurrentYear: Integer;
                BirthYear: Integer;
                CurrentMonth: Integer;
                BirthMonth: Integer;
                CurrentDay: Integer;
                BirthDay: Integer;
            begin
                if "Child Date Of Birth" > Today then
                    Error(DateofBirthError);

                SaccoSetup.Get();

                MinDOBAllowed := CalcDate('-' + Format(SaccoSetup."Membership Age"), Today);

                if "Child Date Of Birth" <= MinDOBAllowed then
                    Error('Only individuals under %1 years can be registered.', SaccoSetup."Membership Age");

                if "Child Date Of Birth" = 0D then begin
                    "Child Age" := 0;
                    exit;
                end;

                BirthYear := Date2DMY("Child Date Of Birth", 3);
                BirthMonth := Date2DMY("Child Date Of Birth", 2);
                BirthDay := Date2DMY("Child Date Of Birth", 1);

                CurrentYear := Date2DMY(Today, 3);
                CurrentMonth := Date2DMY(Today, 2);
                CurrentDay := Date2DMY(Today, 1);

                "Child Age" := CurrentYear - BirthYear;

                if (CurrentMonth < BirthMonth) or
                ((CurrentMonth = BirthMonth) and (CurrentDay < BirthDay))
                then
                    "Child Age" := "Child Age" - 1;
            end;
        }

        field(50021; "Child Age"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Child Birth Cet. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Signing Instruction Narration"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Mandate;
        }
        field(50020; "Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
            //ValuesAllowed = " ", Salary, Milk, Tea,"Staff Salary","Business","Check Off","Dividends","Internal Standing Order","External Standing Order","Pension","Bonus","Mini-Bonus",Allowance,Cash;
            ValuesAllowed = " ", Salary, "Check Off", "Internal Standing Order", Cash;

        }

        field(50087; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50088; Gender; Option)
        {
            OptionMembers = " ",Female,Male;
        }
        field(50089; "Date of Registration"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnDelete()
    var

    begin
    end;

    trigger OnInsert()
    begin


        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Account Application Nos.");
            // Get the next number
            "No." := NoSeries.GetNextNo(SalesSetup."Account Application Nos.", WorkDate(), true);
            "No. Series" := SalesSetup."Account Application Nos.";
        end;


        "Document Type" := "Document Type"::Savings;
        "Application Date" := Today;
        "Captured By" := UserId;
        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;

    trigger OnModify()
    begin

        if "Global Dimension 1 Code" = '' then
            Validate("Product Type");

        if "Global Dimension 2 Code" = '' then begin

            UserSetup.Get(UserId);
            UserSetup.TestField("Global Dimension 2 Code");

            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        end;
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
        NoSeries: Codeunit "No. Series";
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
        ProductSetup: Record "Product Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";

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

    procedure CheckBlockedVendOnJnls(Vend2: Record "Savings Accounts"; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; Transaction: Boolean)
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
}

