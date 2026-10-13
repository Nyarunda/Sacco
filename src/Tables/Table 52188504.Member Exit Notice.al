
Table 50167 "Member Exit Notice"
{
    DrillDownPageID = "Member Exit Notice";
    LookupPageID = "Member Exit Notice";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Error('Invalid Operation');
            end;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            var
                MemberNotice: Record "Member Exit Notice";
            begin
                Name := '';

                if Members.Get("Member No.") then begin
                    Name := Members.Name;
                    CheckBalances();
                end;

                if Rec."Member No." <> '' then begin
                    MemberNotice.Reset();
                    MemberNotice.SetRange("Member No.", Rec."Member No.");
                    MemberNotice.SetFilter(Status, '%1|%2', MemberNotice.Status::Open, MemberNotice.Status::Pending);
                    MemberNotice.SetFilter("No.", '<>%1', Rec."No.");
                    if MemberNotice.FindFirst() then
                        Error('An unposted exit open/pending notice (%1) already exists for this member. Please process it before creating another.', MemberNotice."No.");
                end;
            end;
        }
        field(3; "Reason for withdrawal"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Withdrawa Noticel Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Withdrawal Notice Date';
            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId);
                if "Withdrawa Noticel Date" < Today then
                    if not UserSetup.Backdate then
                        error(ErrMsg);

                SaccoSetup.Get;
                SaccoSetup.TestField(SaccoSetup."Member Exit Notice Period");
                SaccoSetup.TestField("Early Exit Notice Period");
                if "Closure Type" = "Closure Type"::"Withdrawal - Normal" then
                    "Maturity Date" := CalcDate(Format(SaccoSetup."Member Exit Notice Period"), "Withdrawa Noticel Date")
                else if "Closure Type" = "Closure Type"::"Withdrawal - Normal (Quick)" then
                    "Maturity Date" := CalcDate(Format(SaccoSetup."Early Exit Notice Period"), "Withdrawa Noticel Date")
            end;
        }
        field(5; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected,Forfeited';
            OptionMembers = Open,Pending,Approved,Rejected,Forfeited;

        }
        field(10; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(14; "Letter of Withdrawal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Deceased Exit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Guarantor Substituted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Loans Offset"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Notice Received From"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Email,Written/In Person';
            OptionMembers = Email,"Written/In Person";
        }
        field(18; "Email Address Used"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Occupation Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Employed,UnEmployed,Contracting,Business,Self-Employed,Pensioner,Permanent,Retired';
            OptionMembers = Employed,UnEmployed,Contracting,Business,"Self-Employed",Pensioner,Permanent,Retired;
        }
        field(20; "Notice Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Customer Care","HOD","Credit Department 1","Finance Notice","Credit Department 2","HOD Credit";
            OptionCaption = 'Customer Care,HOD,Credit Department 1,Finance Notice,Credit Department 2,HOD Credit';

        }
        field(21; "Recommendation Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "Closure Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',60 days’ Notice,Withdrawal - Deceased,Quick Exit';
            OptionMembers = " ","Withdrawal - Normal","Withdrawal - Death","Withdrawal - Normal (Quick)";
            trigger OnValidate()
            begin
                GetBeneficiaries();

                Validate("Withdrawa Noticel Date");
            end;
        }
        field(50012; "Member Exit Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Administrator,Marketing,Credit,Finance';
            OptionMembers = "Administrator","Marketing","Credit","Finance";
        }
        field(50013; "Exit No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Customer Feedback"; TExt[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Interest to Rejoin"; Option)
        {
            OptionMembers = " ",Yes;
        }
        field(50016; "Date to Rejoin"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Withdrawal Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Member Closure","Account Closure";
            ValuesAllowed = "Member Closure";

            trigger onValidate()
            var
                TCharges: Record "Transaction Charges";
            begin
                if "Withdrawal Type" = "Withdrawal Type"::"Account Closure" then begin
                    TCharges.Reset();
                    TCharges.SetRange(Type, TCharges.Type::"Account Closure");
                    if TCharges.FindFirst() then "Transaction Type" := TCharges.code;
                end;
            end;
        }
        field(50018; "Account To Close"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts"."No." where("Member No." = field("Member No."));
            trigger OnValidate()
            var
                MA: Codeunit "Member Activities";
            begin
                "Account Balance" := MA.GetAccountBalance("Account To Close");
            end;
        }
        field(50019; "Account Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50020; "Transaction Type"; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50021; "Transfer Account"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts"."No." where("Member No." = field("Member No."));

            trigger onvalidate()
            begin
                if "Account To Close" = "Transfer Account" then Error('Transfer Account must not be similar to the Account To Close');
            end;
        }
        field(50022; "Share Capital Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(23; "HOD Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'CSD Approver';
        }
        field(24; "Credit Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Closure Type", "Withdrawa Noticel Date", Name)
        {
        }
    }

    trigger OnInsert()
    begin


        if "No." = '' then begin
            SalesSetup.get();
            SalesSetup.TestField("Member Exit Notice Nos");
            "No." := NoSeries.GetNextNo(SalesSetup."Member Exit Notice Nos", WorkDate(), true);
        end;


        "Date Entered" := Today;
        "Entered By" := UserId;
        "Time Entered" := Time;

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;

    var
        Members: Record Members;
        Txt00001: label 'You cannot delete approved record';
        ErrMsg: label 'You cannot base Withdrawa Noticel Date in the past';
        SaccoSetup: Record "Sacco Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";

    procedure ValidateStatus()
    var
        Savings: Record "Savings Accounts";
    begin
        if Rec.Status = Rec.Status::Approved then begin
            Members.Get(Rec."Member No.");
            Members."Member Status" := Members."Member Status"::"Withdrawal Application";
            Members.Modify();
            /* 
                        Savings.Reset();
                        Savings.SetRange("Member No.", Members."No.");
                        if Savings.FindSet() then
                            Savings.ModifyAll(Status, Savings.Status::"Withdrawal Application"); */
        end;
    end;

    local procedure GetBeneficiaries()
    var
        ben: Record "Member Exit Beneficiary";
        Nok: Record "Next of Kin.";
    begin


        ben.Reset();
        ben.SetRange("Exit No.", "No.");
        if ben.FindFirst() then begin
            ben.DeleteAll();
        end;


        if "Closure Type" = "Closure Type"::"Withdrawal - Death" then begin

            Nok.Reset();
            Nok.SetRange("No.", "Member No.");
            //Nok.SetRange(Beneficiary, true);
            if Nok.FindFirst() then begin
                repeat

                    ben.Init();
                    ben."Exit No." := "No.";
                    ben."Principal Member No." := "Member No.";
                    ben."Principal Member Name" := Name;
                    ben."Beneficiary Name" := Nok.Name;
                    ben.Relation := Nok.Relationship;
                    ben.Insert();

                until Nok.Next() = 0;
            end;

        end;
    end;

    procedure CheckBalances()
    var
        Loans: Record Loans;
        LoanBal: Decimal;
        DepoAcc: Record "Savings Accounts";
        DepoBal: Decimal;

    begin
        Loans.reset;
        Loans.SetRange("Member No.", "Member No.");
        Loans.SetFilter("Total Outstanding Balance", '>0');
        if Loans.Find('-') then
            repeat
                Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                LoanBal += Loans."Outstanding Principal" + Loans."Outstanding Interest";

            until Loans.next = 0;
        DepoAcc.Reset();
        DepoAcc.SetRange("Member No.", "Member No.");
        DepoAcc.SetRange("Product Category", DepoAcc."Product Category"::"Deposit Contribution");
        if DepoAcc.Find('-') then
            repeat
                DepoAcc.CalcFields(Balance, "Balance (LCY)");
                DepoBal += DepoAcc."Balance (LCY)";
            until DepoAcc.Next = 0;

        if DepoBal < LoanBal then
            Message('Please note that the member has a loan balance of %1, against a non withdrawable deposits balance of %2', Format(LoanBal), Format(DepoBal));

    end;


}

