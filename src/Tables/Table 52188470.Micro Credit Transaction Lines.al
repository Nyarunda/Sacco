
Table 50133 "Micro Credit Transaction Lines"
{
    LookupPageID = "Transaction Specifications";

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Transction Type"; Option)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            OptionCaption = 'Savings,Repayment,Interest Paid,Registration Paid,Insurance ,Penalty';
            OptionMembers = Savings,Repayment,"Interest Paid","Registration Paid","Insurance ",Penalty;
        }
        field(3; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        }
        field(4; "Account Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Savings Accounts"."No.";

            trigger OnValidate()
            begin


                MemberAccounts.Reset;
                MemberAccounts.SetRange(MemberAccounts."No.", "Account Number");
                if MemberAccounts.Find('-') then begin
                    MemberAccounts.CalcFields(MemberAccounts."Balance (LCY)");
                    "Account Name" := MemberAccounts.Name;
                    "Group Code" := MemberAccounts."Group No.";
                    Savings := MemberAccounts."Balance (LCY)";
                end;
            end;
        }
        field(5; "Account Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin

                RunningBAL := Amount;

                Trans.Get("No.");
                "Deposit Paid" := 0;
                "Loan Clearance" := false;
                "Penalty Paid" := 0;
                "Appraisal Fee Paid" := 0;
                "Interest Amount Paid" := 0;
                "Principle Amount Paid" := 0;
                "Pass Book Charge" := 0;
                "Entrance Fee Charge" := 0;

                if Trans."Payment Type" = Trans."payment type"::Normal then begin


                    if "Entrance Fee Charge" > 0 then begin
                        if RunningBAL < "Entrance Fee Charge" then
                            "Entrance Fee Charge" := RunningBAL;

                        RunningBAL -= "Entrance Fee Charge";
                        if RunningBAL < 0 then
                            RunningBAL := 0;
                    end;



                    if "Pass Book Charge" > 0 then begin
                        if RunningBAL < "Pass Book Charge" then
                            "Pass Book Charge" := RunningBAL;

                        RunningBAL -= "Pass Book Charge";
                        if RunningBAL < 0 then
                            RunningBAL := 0;
                    end;



                    if RunningBAL > "Expected Deposits" then
                        "Deposit Paid" := 0//"Expected Deposits"
                    else
                        "Deposit Paid" := 0;//RunningBAL;
                    RunningBAL -= "Deposit Paid";


                    if RunningBAL < 0 then
                        RunningBAL := 0;

                    "Loan Clearance" := false;

                    if "Outstanding Balance" > 0 then begin
                        if RunningBAL >= "Outstanding Balance" then
                            "Loan Clearance" := true
                        else
                            "Loan Clearance" := false;
                    end;

                    if RunningBAL > "Expected Penalty" then
                        "Penalty Paid" := "Expected Penalty"
                    else
                        "Penalty Paid" := RunningBAL;
                    RunningBAL -= "Penalty Paid";

                    if RunningBAL < 0 then
                        RunningBAL := 0;


                    if "Loan Clearance" then begin
                        if RunningBAL > "Outstanding Appraisal" then
                            "Appraisal Fee Paid" := "Outstanding Appraisal"
                        else
                            "Appraisal Fee Paid" := RunningBAL;
                        RunningBAL -= "Outstanding Appraisal";
                    end
                    else begin
                        if RunningBAL > "Expected Appraisal Fee" then
                            "Appraisal Fee Paid" := "Expected Appraisal Fee"
                        else
                            "Appraisal Fee Paid" := RunningBAL;
                        RunningBAL -= "Appraisal Fee Paid";
                    end;

                    if RunningBAL < 0 then
                        RunningBAL := 0;

                    if "Loan Clearance" then begin
                        if RunningBAL > "Outstanding Interest" then
                            "Interest Amount Paid" := "Outstanding Interest"
                        else
                            "Interest Amount Paid" := RunningBAL;
                        RunningBAL -= "Outstanding Interest";
                    end
                    else begin
                        if RunningBAL > "Expected Interest" then
                            "Interest Amount Paid" := "Expected Interest"
                        else
                            "Interest Amount Paid" := RunningBAL;
                        RunningBAL -= "Interest Amount Paid";
                    end;

                    if RunningBAL < 0 then
                        RunningBAL := 0;

                    if RunningBAL > "Expected Principle Amount" then
                        "Principle Amount Paid" := "Expected Principle Amount"
                    else
                        "Principle Amount Paid" := RunningBAL;
                    RunningBAL -= "Principle Amount Paid";


                    if RunningBAL > 0 then begin

                        Loans.Reset;
                        Loans.SetRange(Loans."Loan No.", "Loan No.");
                        Loans.SetFilter("Outstanding Principal", '>0');
                        if Loans.Find('-') then begin
                            Loans.CalcFields("Outstanding Principal");
                            Rep := Loans."Outstanding Principal" - "Principle Amount Paid";
                            if Rep > RunningBAL then begin
                                Rep := RunningBAL;
                            end;
                            "Principle Amount Paid" += Rep;
                            RunningBAL -= "Principle Amount Paid";

                        end;
                    end;


                    /*
                    END
                    ELSE IF Trans."Payment Type"=Trans."Payment Type"::"Pass Book" THEN BEGIN


                      IF RunningBAL >=100 THEN
                      "Pass Book Charge":=100;

                      RunningBAL-="Pass Book Charge";

                      IF RunningBAL<0 THEN
                        RunningBAL:=0;

                      "Entrance Fee Charge":=RunningBAL;

                      RunningBAL-="Entrance Fee Charge";

                      IF RunningBAL<0 THEN
                        RunningBAL:=0;
                    */


                end;


                //MESSAGE('%1',"Deposit Paid");
                //if RunningBAL > 0 then
                //    "Deposit Paid" += RunningBAL;

            end;
        }
        field(7; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans;

            trigger OnValidate()
            begin

                /*
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Loan No.","Loan No.");
                IF Loans.FIND('-') THEN BEGIN
                "Expected Principle Amount":=Loans.Repayment;
                //"Expected Interest":=Loans.Lint;
                END;
                
                */

            end;
        }
        field(8; "G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = "G/L Account"."No.";
        }
        field(9; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Group Name" := '';

                if "Group Code" <> '' then
                    Members.Get("Group Code");


                "Group Name" := Members.Name;
            end;
        }
        field(10; "Expected Principle Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin

                //CALCFIELDS("Expected Penalty Charge","Expected Principle Amount","Expected Interest");
                //Amount:="Shares Capital"+"Deposit Savings"+"Expected Penalty Charge"+"Expected Interest"+"Registration Fee"+"Withdrawable Savings";
                GetValues;
            end;
        }
        field(11; "Expected Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //CALCFIELDS("Expected Penalty Charge","Expected Principle Amount","Expected Interest");

                //Amount:="Shares Capital"+"Deposit Savings"+"Expected Penalty Charge"+"Expected Interest"+"Registration Fee"+"Withdrawable Savings";


                GetValues;
            end;
        }
        field(12; "Interest Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Principle Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CALCFIELDS("Expected Penalty Charge","Expected Principle Amount","Expected Interest");

                //Amount:="Shares Capital"+"Deposit Savings"+"Expected Penalty Charge"+"Expected Interest"+"Registration Fee"+"Withdrawable Savings";
            end;
        }
        field(14; Savings; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                /*
                RunningBAL:=0;
                RunningBAL:=Amount-Savings;
                IF "Expected MF Insurance">0 THEN BEGIN
                IF RunningBAL>0 THEN BEGIN
                IF RunningBAL>"Expected MF Insurance" THEN
                  "MF Insurance Amount":="Expected MF Insurance"
                  ELSE
                   "MF Insurance Amount":=RunningBAL;
                END;
                RunningBAL:=RunningBAL- "MF Insurance Amount";
                END;
                IF "Expected Appraisal">0 THEN BEGIN
                IF RunningBAL>0 THEN BEGIN
                IF RunningBAL>"Expected Appraisal" THEN
                  "Appraisal Amount":="Expected Appraisal"
                  ELSE
                   "Appraisal Amount":=RunningBAL;
                END;
                RunningBAL:=RunningBAL- "Appraisal Amount";
                END;
                
                IF "Expected Penalty Charge">0 THEN BEGIN
                IF RunningBAL>0 THEN BEGIN
                IF RunningBAL>"Expected Penalty Charge" THEN
                  "Penalty Amount":="Expected Penalty Charge"
                  ELSE
                   "Penalty Amount":=RunningBAL;
                END;
                RunningBAL:=RunningBAL- "Penalty Amount";
                END;
                
                IF "Expected Interest">0 THEN BEGIN
                IF RunningBAL>0 THEN BEGIN
                IF RunningBAL>"Expected Interest" THEN
                  "Interest Amount":="Expected Interest"
                  ELSE
                  "Interest Amount":=RunningBAL;
                END;
                RunningBAL:=RunningBAL- "Interest Amount";
                END;
                
                
                IF "Expected Principle Amount">0 THEN BEGIN
                IF RunningBAL>0 THEN BEGIN
                 "Principle Amount":=RunningBAL
                END;
                END;
                
                
                
                IF Amount>("Expected Principle Amount"+"Expected Interest"+"Expected Penalty Charge") THEN BEGIN
                "Interest Amount":="Expected Interest";
                "Principle Amount":="Expected Principle Amount";
                "Penalty Amount":="Expected Penalty Charge";
                Savings:=Amount-("Expected Principle Amount"+"Expected Interest"+"Expected Penalty Charge");
                END;
                IF Amount<("Expected Principle Amount"+"Expected Interest"+"Expected Penalty Charge") THEN BEGIN
                IF Amount<"Expected Penalty Charge" THEN
                   "Penalty Amount":=Amount
                ELSE IF Amount>("Expected Penalty Charge"+"Expected Interest") THEN
                
                IF Amount<"Expected Interest" THEN
                   "Interest Amount":=Amount
                ELSE BEGIN
                "Interest Amount":="Expected Interest";
                "Principle Amount":=Amount-"Expected Interest";
                 "Expected Principal":="Expected Principle Amount"-"Expected Interest";
                END;
                END;
                */

            end;
        }
        field(15; "Expected Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CALCFIELDS("Expected Penalty Charge","Expected Principle Amount","Expected Interest");
                //Amount:="Shares Capital"+"Deposit Savings"+"Expected Penalty Charge"+"Expected Interest"+"Registration Fee"+"Withdrawable Savings";
                GetValues;
            end;
        }
        field(16; "Penalty Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Expected MF Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "MF Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Deposit Savings"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CALCFIELDS("Expected Penalty Charge","Expected Principle Amount","Expected Interest");

                //Amount:="Shares Capital"+"Deposit Savings"+"Expected Penalty Charge"+"Expected Interest"+"Registration Fee"+"Withdrawable Savings";
                GetValues;
                Savings := Savings + "Deposit Savings";
            end;
        }
        field(23; "Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CALCFIELDS("Expected Penalty Charge","Expected Principle Amount","Expected Interest");

                //Amount:="Shares Capital"+"Deposit Savings"+"Expected Penalty Charge"+"Expected Interest"+"Registration Fee"+"Withdrawable Savings";
                GetValues;
            end;
        }
        field(26; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Shares Capital"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CALCFIELDS("Expected Penalty Charge","Expected Principle Amount","Expected Interest");
                //Amount:="Shares Capital"+"Deposit Savings"+"Expected Penalty Charge"+"Expected Interest"+"Registration Fee"+"Withdrawable Savings";
                GetValues;
            end;
        }
        field(33; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Group Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Date Banked"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Branch/Agent"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Micro Savings"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CALCFIELDS("Expected Penalty Charge","Expected Principle Amount","Expected Interest");
                //Amount:="Shares Capital"+"Deposit Savings"+"Expected Penalty Charge"+"Expected Interest"+"Registration Fee"+"Withdrawable Savings";
                GetValues;
            end;
        }
        field(46; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Expected Appraisal Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Appraisal Fee Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Deposit Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Expected Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(51; "Pass Book Charge"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Amount <> 0 then
                    Error('Amount must be Zero before capturing Pass Book Charge');
            end;
        }
        field(52; "Entrance Fee Charge"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Amount <> 0 then
                    Error('Amount must be Zero before capturing Entrance Fee');
            end;
        }
        field(53; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Outstanding Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Loan Clearance"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "FOSA Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Loan Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Account Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Transction Type")
        {
        }
    }

    trigger OnDelete()
    begin
        Trans.Reset;
        if Trans.Get("No.") then
            if Trans.Posted = true then
                Error('Cannot modify a posted transaction');
    end;

    trigger OnInsert()
    begin
        Trans.Reset;
        if Trans.Get("No.") then
            if Trans.Posted = true then
                Error('Cannot modify a posted transaction');
    end;

    trigger OnModify()
    begin
        Trans.Reset;
        if Trans.Get("No.") then
            if Trans.Posted = true then
                Error('Cannot modify a posted transaction');
    end;

    trigger OnRename()
    begin
        Trans.Reset;
        if Trans.Get("No.") then
            if Trans.Posted = true then
                Error('Cannot modify a posted transaction');
    end;

    var
        MemberAccounts: Record "Savings Accounts";
        GL: Record "G/L Account";
        RunningBAL: Decimal;
        Loans: Record Loans;
        Members: Record Members;
        Rep: Decimal;
        Trans: Record "Micro Credit Transactions";


    procedure GetValues()
    begin
        Amount := "Shares Capital" + "Deposit Savings" + "Expected Penalty" + "Expected Interest" + "Registration Fee" + "Micro Savings";
    end;
}

