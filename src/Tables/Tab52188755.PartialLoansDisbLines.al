table 50537 "Partial Loans Disb. Lines"
{
    Caption = 'Partial Loans Disb. Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Member No"; Code[20])
        {
            Caption = 'Member No';
            DataClassification = ToBeClassified;
            TableRelation = Members where(Type = const(Member));
        }
        field(3; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No"), Posted = const(true));
            trigger OnValidate()
            var
                myInt: Integer;
                TotalAmount: Decimal;
                Loans: Record Loans;
            begin
                Loans.Reset();
                Loans.SetRange("Loan No.", "Loan No.");
                if Loans.FindFirst() then begin
                    Loans.CalcFields("Outstanding Principal");
                    "Loan Product Type" := Loans."Loan Product Type";
                    "Approved Amount" := Loans."Approved Amount";
                    "Disbused Amount" := Loans."Amount To Disburse";
                    "Member No" := Loans."Member No.";
                    "Outstanding Principal" := Loans."Outstanding Principal";

                    GetLoanCharges();
                    UpdateExpectedNetTakeHome();
                end;
            end;
        }
        field(4; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Disbused Amount"; Decimal)
        {
            Caption = 'Disbursed Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Remaining Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Amount to Disbuse"; Decimal)
        {
            Caption = 'Amount to Disbuse';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                TotalAmount: Decimal;
                Loans: Record Loans;
                Text001: Label 'The Loan Has Been Fully Disbursed';
                Text002: Label 'You Cannot Disbuse More Than approved Amount';
            begin

                TotalAmount := "Disbused Amount" + "Amount to Disbuse";
                if (TotalAmount > "Approved Amount") then
                    Error(Text002)
                else
                    GetLoanCharges;
                UpdateExpectedNetTakeHome();

                //check amount not guaranteed
                if Loans.get("Loan No.") then begin
                    Loans.CalcFields("Total Guaranteed");
                    if ("Amount to Disbuse" - Loans."Total Guaranteed") < 0 then
                        "Amount Not Guaranteed" := 0
                    else
                        "Amount Not Guaranteed" := ("Amount to Disbuse" + "Disbused Amount") - Loans."Total Guaranteed";
                end;

            end;
        }

        field(12; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Outstanding Principal"; Decimal)
        {
            trigger OnValidate()
            var
                Loans: Record Loans;
            begin
                if Loans.get("Loan No.") then begin
                    Loans.CalcFields("Outstanding Principal");
                    if "Outstanding Principal" > Loans."Outstanding Principal" then
                        error('Outstanding Principal cannot be more that the current Loan Outstanding Principal');

                end
            end;
        }
        field(14; "Amount Not Guaranteed"; Decimal)
        {
            Caption = 'Amount Not Guaranteded';
            DataClassification = ToBeClassified;
        }
        field(18; "Total Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Amount Guaranteed" where("Loan No." = field("Loan No."),
                                                                         Substituted = filter(false)));
            Description = 'Sum("Loan Guarantors and Security"."Amount Guaranteed" WHERE (Loan No=FIELD(Loan No.),Substituted=CONST(No)))';
            FieldClass = FlowField;
        }
        field(19; "New Repyament Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Total Charges Applied"; Decimal)
        {
            Caption = 'Total Charges Applied';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Loan Charges"."Total Charge" where("Loan No." = field("Header No."),
                                                                   "Charge Code" = filter(<> 'INS')));
        }
        field(21; "Expected Net Take Home"; Decimal)
        {
            Caption = 'Expected Net Take Home';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(58; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Credit Ledger Entry".Reversed where("Document No." = field("Header No."),
                                                                      "Loan No." = field("Loan No."),
                                                                      "Member No." = field("Member No.")));
        }
        field(59; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Amortised,Reducing Balance,Straight Line,Reducing Flat,Zero Interest';
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line","Reducing Flat","Zero Interest";
        }
    }
    keys
    {
        key(PK; "Header No.", "Entry No", "Member No", "Loan No.")
        {
            Clustered = true;
        }
    }

    procedure GetLoanCharges()
    var
        PCharges: Record "Loan Product Charges.";
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
        Members: Record Members;
        Continue: Boolean;
        Value: Decimal;
        GenSetup: Record "Sacco Setup";
        LoanApp: Record Loans;
        SavingsProduct: Record "Product Setup";
        Appraisal: Record "Loan Appraisal";
        HREmployees: Record Employee;
        GenJournalLine: Record "Gen. Journal Line";
        LoanCharges: Record "Loan Charges";
        SaccoActivies: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        otherComm: Record "Other Committments Clearance";
        Loans: Record Loans;
        PartialLoansDisbHeader: Record "Partial Loans Disb. Header";
    begin

        Loans.Get("Loan No.");

        LoanCharges.Reset;
        LoanCharges.SetRange("Loan No.", "Header No.");
        if LoanCharges.FindFirst then
            LoanCharges.DeleteAll;


        GenSetup.Get;
        Value := "Amount To Disbuse"; //+ Loans."Amount To Disburse";

        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Loan Processing Fee");
        if PCharges.Find('-') then begin
            repeat

                PChAmt := 0;
                GL := '';
                EDuty := 0;

                Value := "Amount to Disbuse";

                MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Value, PChAmt, EDuty, GL);

                LoanCharges.Init;
                LoanCharges."Loan No." := "Header No.";
                LoanCharges."Loan Product Type" := "Loan Product Type";
                LoanCharges."Charge Code" := PCharges."Charge Code";
                LoanCharges.Description := PCharges.Description;
                LoanCharges."Charge %" := PCharges.Percentage;
                LoanCharges.Amount := PChAmt;
                LoanCharges."Excise Duty" := EDuty;
                LoanCharges."Total Charge" := PChAmt + EDuty;
                LoanCharges."Account Type" := PCharges."Account Type";
                LoanCharges."Account No." := PCharges."Account No.";
                LoanCharges."Posting Type" := PCharges."Posting Type";
                LoanCharges."Is Sms Charge" := PCharges."Is Sms Alert";
                LoanCharges."Charge Type" := PCharges."Charge Type";


                if EDuty > 0 then begin
                    GenSetup.TestField("Excise Duty GL");
                    LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                end;
                LoanCharges.Insert;

            until PCharges.Next = 0;
        end;

        Members.get("Member No");
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
        PCharges.Setfilter(PCharges."Charge Type", '%1|%2', PCharges."charge type"::Insurance, PCharges."charge type"::Non_Individual);
        //if Members."Member Category" <> Members."Member Category"::"Staff Members" then
        if PCharges.Find('-') then begin
            repeat
                Continue := false;

                Value := "Amount to Disbuse";
                if PCharges."charge type" = PCharges."charge type"::Insurance then
                    Value := "Amount to Disbuse" + "Disbused Amount";


                if Members."Account Category" = Members."Account Category"::Individual then begin
                    if Members.Type = Members.Type::Group then begin
                        if PCharges."Charge Type" = PCharges."Charge Type"::Non_Individual then
                            Continue := true;
                    end
                    else
                        if Members.Type = Members.Type::Member then begin

                            if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then
                                Continue := true;
                        end;

                end
                else begin

                    if PCharges."Charge Type" = PCharges."Charge Type"::Non_Individual then
                        Continue := true;
                end;


                if PCharges."Charge Type" = PCharges."Charge Type"::"External Clearance" then
                    Continue := true;

                if Continue then begin

                    if PCharges."Charge Type" = PCharges."Charge Type"::"External Clearance" then begin
                        /*otherComm.Reset();
                        otherComm.SetRange("Loan Application No.", "Salary Appraisal No.");
                        if otherComm.FindFirst() then begin
                            otherComm.CalcSums(Amount);
                            Value := otherComm.Amount;
                        end;*/
                    end;

                    if PCharges."charge type" = PCharges."charge type"::Insurance then begin
                        Loans.calcFields("Total Disbursed");
                        //Value += Loans."Total Disbursed";
                    end;

                    PChAmt := 0;
                    GL := '';
                    EDuty := 0;
                    MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Value, PChAmt, EDuty, GL);

                    //if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then
                    //   PChAmt := PChAmt * Installments / 10;


                    //Message('PCharges."Charge Type" %1 \ PCHamt %2', PCharges."Charge Type", PChAmt);

                    LoanCharges.Init;
                    LoanCharges."Loan No." := "Header No.";
                    LoanCharges."Loan Product Type" := "Loan Product Type";
                    LoanCharges."Charge Code" := PCharges."Charge Code";
                    LoanCharges.Description := PCharges.Description;
                    LoanCharges."Charge %" := PCharges.Percentage;
                    LoanCharges.Amount := PChAmt;
                    LoanCharges."Excise Duty" := EDuty;
                    LoanCharges."Total Charge" := PChAmt + EDuty;
                    LoanCharges."Account Type" := PCharges."Account Type";
                    LoanCharges."Account No." := PCharges."Account No.";
                    LoanCharges."Posting Type" := PCharges."Posting Type";
                    LoanCharges."Charge Type" := PCharges."Charge Type";


                    if EDuty > 0 then begin
                        GenSetup.TestField("Excise Duty GL");
                        LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                    end;
                    LoanCharges.Insert;

                end;
            until PCharges.Next = 0;
        end;


        if PartialLoansDisbHeader.Get("Header No.") then
            if PartialLoansDisbHeader."Exempt Charges" then
                PartialLoansDisbHeader.ResetPartialDisbursementCharges();

        UpdateExpectedNetTakeHome();
    end;

    procedure UpdateExpectedNetTakeHome()
    begin
        CalcFields("Total Charges Applied");
        "Expected Net Take Home" := "Amount to Disbuse" - "Total Charges Applied";
        if "Expected Net Take Home" < 0 then
            "Expected Net Take Home" := 0;
    end;

    procedure ValidateGuarantorCoverage(HeaderNo: Code[20])
    var
        Lines: Record "Partial Loans Disb. Lines";
        Loans: Record Loans;
        Text003: Label 'Loan %1: Amount to Disburse (%2) + Already Disbursed (%3) = %4 exceeds Total Guaranteed (%5). Cannot send for approval.';
        TotalDisbursed: Decimal;
        TotalGuaranteed: Decimal;
        BufferGuaranteed: Decimal;
        SecurityBuffer: Record "Loan Security Buffer";
    begin
        Lines.Reset();
        Lines.SetRange("Header No.", HeaderNo);
        if Lines.FindSet() then
            repeat
                TotalDisbursed := Lines."Disbused Amount" + Lines."Amount to Disbuse";

                if Loans.Get(Lines."Loan No.") then begin

                    // Posted guarantors
                    Loans.CalcFields("Total Guaranteed");
                    TotalGuaranteed := Loans."Total Guaranteed";

                    // Buffer guarantors
                    SecurityBuffer.Reset();
                    SecurityBuffer.SetRange("Loan No.", Lines."Loan No.");
                    if SecurityBuffer.FindSet() then begin
                        repeat
                            BufferGuaranteed += SecurityBuffer."Amount Guaranteed";
                        until SecurityBuffer.Next() = 0;
                    end;

                    TotalGuaranteed += BufferGuaranteed;

                    if TotalDisbursed > TotalGuaranteed then
                        Error(Text003,
                            Lines."Loan No.",
                            Lines."Amount to Disbuse",
                            Lines."Disbused Amount",
                            TotalDisbursed,
                            TotalGuaranteed);
                end;
            until Lines.Next() = 0;
    end;


}
