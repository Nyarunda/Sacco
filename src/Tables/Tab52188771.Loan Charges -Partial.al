table 50538 "Loan Charges Partial"
{
    Caption = 'Loan Charges Partial';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Product Charges."."Charge Code" where("Product Code" = field("Loan Product Type"));

            trigger OnValidate()
            var
                Charges: Record "Loan Product Charges.";
                GenSetup: Record "Sacco Setup";
                MemberActivities: Codeunit "Member Activities";
                PChAmt: Decimal;
                ChargeAmt: Decimal;
                Duty: Decimal;
                ChargeGL: Code[20];
                Loans: Record Loans;
                LSecurity: Record "Loan Security";

            begin


                Description := '';
                "Charge %" := 0;
                Amount := 0;
                "Excise Duty" := 0;
                "Total Charge" := 0;
                "Account Type" := "account type"::"G/L Account";
                "Account No." := '';
                "Duty GL" := '';

                GenSetup.Get;

                Charges.Reset;
                Charges.SetRange("Charge Code", "Charge Code");
                if Charges.Find('-') then begin

                    PChAmt := 0;
                    ChargeGL := '';
                    Duty := 0;
                    //Loans.Get("Loan No.");
                    PLines.Reset();
                    PLines.SetRange("Loan No.", "Loan No.");
                    if PLines.FindFirst() then begin
                        //MESSAGE('%1',Loans."Approved Amount");
                        MemberActivities.GetLoanChargeAmount("Loan Product Type", Charges."Charge Code", Charges."Charge Type", PLines."Amount to Disbuse", PChAmt, Duty, ChargeGL);

                        if Charges."Charge Code" = 'SMS' then begin
                            LSecurity.Reset();
                            LSecurity.SetRange("Loan No.", "Loan No.");
                            if LSecurity.Find('-') then
                                PChAmt += PChAmt + (PChAmt * LSecurity.Count);

                        end;

                        "Loan No." := "Loan No.";
                        "Charge Code" := Charges."Charge Code";
                        Description := Charges.Description;
                        "Charge %" := Charges.Percentage;
                        Amount := PChAmt;
                        "Excise Duty" := Duty;
                        "Total Charge" := PChAmt + Duty;
                        "Account Type" := Charges."Account Type";
                        "Account No." := Charges."Account No.";


                        if Duty > 0 then begin
                            GenSetup.TestField("Excise Duty GL");
                            "Duty GL" := GenSetup."Excise Duty GL";
                        end;
                    end;
                end;
            end;
        }
        field(3; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Charge %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PLines.Reset();
                PLines.SetRange("Loan No.", "Loan No.");
                if PLines.FindFirst() then;

                SaccoSetup.Get;

                Amount := ROUND(PLines."Amount to Disbuse" * "Charge %" / 100);

                if "Excise Duty" > 0 then
                    "Excise Duty" := ROUND(Amount * SaccoSetup."Excise Duty (%)" / 100);

                "Total Charge" := Amount + "Excise Duty";

                //MESSAGE('%1\%2',Amount,Loans."Approved Amount");
            end;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                SaccoSetup.Get;

                if Amount > 0 then begin
                    "Charge %" := 0;
                    if "Excise Duty" > 0 then
                        "Excise Duty" := ROUND(Amount * SaccoSetup."Excise Duty (%)" / 100);
                    "Total Charge" := Amount + "Excise Duty";
                end;
            end;
        }
        field(6; "Excise Duty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Total Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(10; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee;
        }
        field(11; "Duty GL"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Loan Product Type"; Code[20])
        {
        }
        field(13; "Charge Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = General,"Top up","External Clearance","Deposit Financing","Share Capital","Share Financing","Deposit Financing on Maximum","Custom",Rescheduling,Insurance,Non_Individual,"Loan Processing Fee";
        }

        field(18; "Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Deduct From Net Payable","Add to Loan Amount";

        }
        field(19; "Is Sms Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Loan No.", "Charge Code", "Loan Product Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record Loans;
        PLines: Record "Partial Loans Disb. Lines";
        SaccoSetup: Record "Sacco Setup";
}