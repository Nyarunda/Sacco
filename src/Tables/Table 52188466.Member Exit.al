table 50129 "Member Exit"
{
    LookupPageID = "Member Exit List All";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(50002; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin

                if Members.Get("Member No.") then begin
                    SaccoSetup.Get;
                    "Total Guaranteed" := 0;
                    "Self Guaranteed Amount" := 0;


                    LoansGuaranteed := 0;
                    LoanSecurity.Reset;
                    LoanSecurity.SetRange(LoanSecurity."Member No", "Member No.");
                    LoanSecurity.SETRANGE(LoanSecurity."Guarantor Type", LoanSecurity."Guarantor Type"::Guarantor);
                    LoanSecurity.SETRANGE(Substituted, false);
                    if LoanSecurity.Find('-') then begin
                        repeat
                            if Loans.Get(LoanSecurity."Loan No.") then begin
                                Loans.CalcFields(Loans."Total Outstanding Balance");
                                if Loans."Total Outstanding Balance" > 0 then begin
                                    LoansGuaranteed += 1;
                                    if Loans."Member No." = "Member No." then
                                        // member guaranteeing their own loan -> not deducted (loan already in Total Loan Outstanding)
                                        "Self Guaranteed Amount" += LoanSecurity."Current Committed"
                                    else
                                        "Total Guaranteed" += LoanSecurity."Current Committed";
                                end;
                            end;
                        until LoanSecurity.Next = 0;

                        /*RETURN THIS if LoansGuaranteed > 0 then
                            Message('Member is Guaranteeing %1 Active Loans', LoansGuaranteed);
                        */
                    end;




                    "Member Name" := Members.Name;
                    "ID No." := Members."ID No.";

                    "Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Members."Global Dimension 2 Code";

                    Date := Today;
                    if "Closure Type" <> "Closure Type"::" " then begin

                        Validate("Closure Type");
                        ValidateAmounts;
                    end;
                end;
            end;
        }
        field(50001; "Self Guaranteed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Closing Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Closing Date" > Today then
                    Error('Closing Date cannot be Greater than TODAY');

                if "Closure Type" <> "Closure Type"::" " then begin
                    Validate("Closure Type");

                end;
                ValidateAmounts;

            end;
        }
        field(50005; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected,Forfeited';
            OptionMembers = Open,Pending,Approved,Rejected,Forfeited;
        }

        field(50056; WithdrawalType; Option)

        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Partial Withdrawal,Full Withdrawal';
            OptionMembers = " ","Partial Withdrawal","Full Withdrawal";

        }
        field(50006; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Total Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Total Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Member Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Closure Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',60 days’ Notice,Withdrawal - Death,Quick Exit';
            OptionMembers = " ","Withdrawal - Normal","Withdrawal - Death","Withdrawal - Immediate";

            trigger OnValidate()
            begin

                "Insurance Amount" := 0;

                if ("Closure Type" = "closure type"::"Withdrawal - Normal") or ("Closure Type" = "closure type"::"Withdrawal - Immediate") then begin
                    LoansGuaranteed := 0;
                    LoanSecurity.Reset;
                    LoanSecurity.SetRange(LoanSecurity."Member No", "Member No.");
                    LoanSecurity.SETRANGE(LoanSecurity."Guarantor Type", LoanSecurity."Guarantor Type"::Guarantor);
                    if LoanSecurity.Find('-') then begin

                        repeat
                            if Loans.Get(LoanSecurity."Loan No.") then begin
                                Loans.CalcFields(Loans."Total Outstanding Balance");
                                if Loans."Total Outstanding Balance" > 0 then begin
                                    LoansGuaranteed += 1;
                                end;
                            end;
                        until LoanSecurity.Next = 0;

                        /*RETURN THIS if LoansGuaranteed > 0 then
                            Error('Member is Guaranteeing %1 Active Loans', LoansGuaranteed);
                        */
                        ValidateAmounts();
                    end;
                end;
                ValidateAmounts();
            end;
        }
        field(50012; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Total Refundable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Close Account"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,All,Specific';
            OptionMembers = " ",All,Specific;
        }
        field(50017; "Entered By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; Transaction; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member Withdrawal';
            OptionMembers = "Member Withdrawal";
        }
        field(50019; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Benevolent Fund"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50022; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50023; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                IF "Insurance Amount">0 THEN
                  TESTFIELD("Closure Type","Closure Type"::"Withdrawal - Death");
                
                */

            end;
        }
        field(50024; "Transfer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Transfer Account Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Total Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Total Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Total Savings"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50029; "Total Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Minute Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Withdrawable Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Non-Withdrawable Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Term Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Total Loan Outstanding"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Duty on Exit Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Exit Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; MemberExitCharge; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Notice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Exit Notice" where(Status = const(Approved),
                                                        "Member No." = field("Member No."));

            trigger OnValidate()
            begin
                "Early Exit" := false;
                if "Notice No." <> '' then begin

                    Notice.Get("Notice No.");
                    Validate("Closure Type", Notice."Closure Type");
                    SaccoSetup.Get();
                    if Notice."Maturity Date" > "Closing Date" then begin
                        if "Closure Type" <> "Closure Type"::"Withdrawal - Death" then begin

                            if SaccoSetup."Activate Early Exit Charge" then begin

                                if confirm('Member Notice period not reached. Notice Maturity Date is ' + Format(Notice."Maturity Date") + '. Early Charge Fee Applies. Do you want to Proceed?') then
                                    "Early Exit" := true
                                else
                                    Error('Aborted');
                            end
                            else
                                Error('Member Notice period not reached. Notice Maturity Date is ' + Format(Notice."Maturity Date"));

                        end;
                    end;
                end;

                ValidateAmounts();

            end;

        }
        field(50039; "Charge GL"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Normal charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Retained Shares Deductable"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50042; "MDF Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50043; "Early Exit"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50044; "Beneficiary Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Member Exit Beneficiary"."Amount" where("Exit No." = field("No.")));
        }
        field(50045; "Dividends/Rebates"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50046; "Paying Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Bank Account";
        }
        field(50047; "Cheque No."; Code[6])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50048; "Reason for Withdrawal"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(50049; "Application Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Member Exit Notice"."Withdrawa Noticel Date" where("No." = field("Notice No.")));
        }

        field(50050; "Maturity Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Member Exit Notice"."Maturity Date" where("No." = field("Notice No.")));
        }
        field(50051; "Contact"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Mobile Phone No." where("Member No." = field("Member No.")));
        }
        field(50052; "Customer Feedback"; Text[500])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Member Exit Notice"."Customer Feedback" where("No." = field("Notice No.")));
        }

        field(50053; "Interest to Rejoin"; Option)
        {
            OptionMembers = " ",Yes;
            FieldClass = FlowField;
            CalcFormula = lookup("Member Exit Notice"."Interest to Rejoin" where("No." = field("Notice No.")));
        }
        field(50054; "Date to Rejoin"; Date)
        {

            FieldClass = FlowField;
            CalcFormula = lookup("Member Exit Notice"."Date to Rejoin" where("No." = field("Notice No.")));
        }
        field(50055; "Total Guaranteed"; Decimal)
        {

        }
        field(50057; "Net Refundable"; Decimal)
        {
        }
        field(50058; EmployerCode; Code[20])
        {
        }
        field(50059; MembershipDate; DateFormula)
        {
        }

        field(50060; "Partial Withdrawal Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Closing Date" > Today then
                    Error('Closing Date cannot be Greater than TODAY');

                ValidateAmounts;

            end;
        }
        field(50062; "Share Capital Sale To"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts"."No." where("Product Category" = const("Share Capital"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //"Share Capital Amount To Sale" := 0;
                //"Share Capital Sale To" := '';
                "Share Charge" := 0;
                "Share Charge GL" := '';
                ValidateAmounts();
            end;
        }
        field(50063; "Share Capital Amount To Sale"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //"Share Capital Amount To Sale" := 0;
                //"Share Capital Sale To" := '';
                "Share Charge" := 0;
                "Share Charge GL" := '';
                ValidateAmounts();

            end;
        }
        field(50064; "Share Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Share Charge GL"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Source Share Capital"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Junior Savings"; Decimal)
        {
            DataClassification = AccountData;
        }

        field(50069; "Holiday Savings"; Decimal)
        {
            DataClassification = AccountData;
        }
        field(50071; "Outstanding Insurance"; Decimal)
        {
            DataClassification = AccountData;
        }
        field(50072; "Deposit Contribution"; Decimal)
        {
            DataClassification = AccountData;
        }
        field(50073; "Unallocated Fund"; Decimal)
        {
            DataClassification = AccountData;
        }
        field(50074; "Fixed Deposit"; Decimal)
        {
            DataClassification = AccountData;
        }
        field(50075; "Ordinary Savings"; Decimal)
        {
            DataClassification = AccountData;
        }
        field(50076; "Dividend Account"; Decimal)
        {
            DataClassification = AccountData;
        }
        field(50077; "PV No."; Code[100])
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
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Member Exit Nos");
            "No." := NoSeries.GetNextNo(SalesSetup."Member Exit Nos", WorkDate(), true);
        end;


        "Entered By" := UserId;
        Date := Today;

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

        if UserSetup."Member Exit" = false then
            Error(Text0001);
    end;

    var
        Text0001: Label 'You do not have the permission to process member exit.';
        NoSeries: Codeunit "No. Series";
        Members: Record Members;
        SaccoSetup: Record "Sacco Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
        LoansGuaranteed: Integer;
        LoanSecurity: Record "Loan Security";
        Loans: Record Loans;
        ProductSetup: Record "Product Setup";
        Savings: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        Value: Decimal;
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        SharingAmt: Decimal;
        SharingDuty: Decimal;
        SharingChargeAcctType: Enum "Gen. Journal Account Type";
        SharingChargeAcct: Code[20];
        TransactionCharges: Record "Transaction Charges";
        Notice: Record "Member Exit Notice";
        ChargeWithdrawalFee: Boolean;
        /* 
            for Wanandege sacco only
         */
        MemberExitCharge: Decimal;
        MemberExitChargeExcise: Decimal;


    local procedure ValidateAmounts()
    begin


        "Withdrawable Savings" := 0;
        "Non-Withdrawable Savings" := 0;
        "Share Capital" := 0;
        "Term Savings" := 0;
        "Member Savings" := 0;
        "Total Refundable" := 0;
        "Total Appraisal" := 0;
        "Total Interest" := 0;
        "Total Penalty" := 0;
        "Total Principal" := 0;
        "Retained Shares Deductable" := 0;
        "MDF Contribution" := 0;
        "Early Exit" := false;
        "Dividends/Rebates" := 0;
        "Junior Savings" := 0;
        "Holiday Savings" := 0;
        "Deposit Contribution" := 0;
        "Fixed Deposit" := 0;
        "Ordinary Savings" := 0;
        "Dividend Account" := 0;
        "Exit Charge" := 0;
        "Duty on Exit Charge" := 0;
        "Total Charges" := 0;
        "Total Refundable" := 0;
        "Net Refundable" := 0;
        "Unallocated Fund" := 0;
        "Outstanding Insurance" := 0;
        "Source Share Capital" := '';


        SaccoSetup.Get();
        if SaccoSetup."Activate Early Exit Charge" then begin
            if "Notice No." <> '' then begin
                Notice.Get("Notice No.");
                if "Closure Type" = "Closure Type"::"Withdrawal - Immediate" then begin
                    "Early Exit" := true;
                end;
            end;
        end;


        SaccoSetup.Get;
        if CheckMemberType("Member No.") then begin
            Savings.Reset;
            Savings.SetRange(Savings."Member No.", "Member No.");
            Savings.SetFilter("Product Type", SaccoSetup."Member Exit Transfer Account");
            if Savings.Find('-') then begin
                "Transfer Account" := Savings."No.";
                "Transfer Account Name" := Savings."Product Name";
            end;

        end else begin
            Savings.Reset;
            Savings.SetRange(Savings."Member No.", "Member No.");
            Savings.SetRange("Product Type", SaccoSetup."Chamaa Exit Transfer Account");
            if Savings.Find('-') then begin
                "Transfer Account" := Savings."No.";
                "Transfer Account Name" := Savings."Product Name";
            end;
        end;


        Savings.Reset;
        Savings.SetRange(Savings."Member No.", "Member No.");
        Savings.SetFilter("Product Category", '<>%1&<>%2', Savings."product category"::"Benevolent Fund", Savings."product category"::"Registration Fee");
        if Savings.Find('-') then begin
            repeat

                Savings.CalcFields("Balance (LCY)");
                ProductSetup.Get(Savings."Product Type");

                //MESSAGE('%1 = %2', Savings."Product Name", Savings."Balance (LCY)");



                if ProductSetup."Product Category" = ProductSetup."product category"::"Share Capital" then begin
                    "Share Capital" += Savings."Balance (LCY)";
                    "Source Share Capital" := Savings."No.";
                end else begin
                    if ProductSetup."Savings Type" = ProductSetup."savings type"::"Non-Withdrawable" then
                        "Non-Withdrawable Savings" += Savings."Balance (LCY)";
                    if ProductSetup."Savings Type" = ProductSetup."savings type"::Withdrawable then
                        "Withdrawable Savings" += Savings."Balance (LCY)";
                    if ProductSetup."Savings Type" = ProductSetup."savings type"::Term then
                        "Term Savings" += Savings."Balance (LCY)";
                end;

                // Retained Shares mandatory-contribution shortfall (unchanged)
                if ProductSetup."Savings Type" = ProductSetup."savings type"::"Retained Shares" then begin
                    if Savings."Balance (LCY)" < ProductSetup."Mandatory Contribution" then begin
                        "Retained Shares Deductable" += (ProductSetup."Mandatory Contribution" - Savings."Balance (LCY)");
                    end;
                end;


                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Dividend Account" then
                    "Dividends/Rebates" += Savings."Balance (LCY)";
                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Junior Savings" then
                    "Junior Savings" += Savings."Balance (LCY)";
                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Holiday Savings" then
                    "Holiday Savings" += Savings."Balance (LCY)";
                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Deposit Contribution" then
                    "Deposit Contribution" += Savings."Balance (LCY)";
                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Unallocated Fund" then
                    "Unallocated Fund" += Savings."Balance (LCY)";
                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Fixed Deposit" then
                    "Fixed Deposit" += Savings."Balance (LCY)";
                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Ordinary Savings" then
                    "Ordinary Savings" += Savings."Balance (LCY)";
            until Savings.Next = 0;
        end;

        "Total Savings" := "Non-Withdrawable Savings" + "Withdrawable Savings";



        Loans.Reset;
        Loans.SetRange("Member No.", "Member No.");
        Loans.SetFilter("Total Outstanding Balance", '<>0');
        if Loans.FindFirst then begin
            repeat
                Loans.CalcFields("Outstanding Appraisal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty", "Outstanding Principal");
                "Total Appraisal" += Loans."Outstanding Appraisal";
                "Total Penalty" += Loans."Outstanding Penalty";
                "Total Interest" += Loans."Outstanding Interest";
                "Total Principal" += Loans."Outstanding Principal";
                "Outstanding Insurance" += Loans."Outstanding Insurance";

            until Loans.Next = 0;
        end;
        "Total Loan Outstanding" := "Total Appraisal" + "Total Interest" + "Total Penalty" + "Total Principal" + "Outstanding Insurance";


        Value := "Non-Withdrawable Savings" - "Total Loan Outstanding" - "Retained Shares Deductable" - "Total Guaranteed";


        if WithdrawalType = WithdrawalType::"Partial Withdrawal" then begin
            TestField("Partial Withdrawal Amount");
            "Total Refundable" := "Partial Withdrawal Amount";

            Value := "Total Refundable";
        end
        else begin
            if "Closure Type" = "Closure Type"::"Withdrawal - Death" then
                "Total Refundable" := "Non-Withdrawable Savings" - "Total Loan Outstanding" - "Retained Shares Deductable"
            else
                "Total Refundable" := "Non-Withdrawable Savings" - "Total Loan Outstanding" - "Retained Shares Deductable" - "Total Guaranteed";

            Value := "Total Refundable";
        end;

        ChargeWithdrawalFee := true;
        if "Closure Type" = "Closure Type"::"Withdrawal - Death" then begin
            ChargeWithdrawalFee := false;
            if SaccoSetup."Charge Deceased Withdrawal" then
                ChargeWithdrawalFee := true;
        end;

        if ChargeWithdrawalFee then begin

            "Exit Charge" := 0;
            "Duty on Exit Charge" := 0;
            MemberExitCharge := 0;
            MemberExitChargeExcise := 0;
            // if "Closure Type" <> "Closure Type"::"Withdrawal - Death" then begin
            if "Closure Type" = "Closure Type"::"Withdrawal - Immediate" then begin
                if CheckMemberType("Member No.") then begin
                    MemberActivities.GetGeneral_SharingChargeAmount(SaccoSetup."Early Member Exit Charge", Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
                    MemberActivities.GetGeneral_SharingChargeAmount(SaccoSetup."Member Exit Charge", Value, MemberExitCharge, MemberExitCharge, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
                end
                else
                    MemberActivities.GetGeneral_SharingChargeAmount(SaccoSetup."Chamaa Early Exit Charge", Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct)

            end

            else begin
                if CheckMemberType("Member No.") then
                    MemberActivities.GetGeneral_SharingChargeAmount(SaccoSetup."Member Exit Charge", Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct)
                else
                    MemberActivities.GetGeneral_SharingChargeAmount(SaccoSetup."Chamaa Exit Charge", Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
            end;

            //end;


            "Exit Charge" := ChargeAmt + MemberExitChargeExcise;
            "Duty on Exit Charge" := ChargeDuty;
            "Charge GL" := ChargeAcct;
            "Normal charges" := MemberExitCharge + MemberExitCharge;
            "Total Charges" := "Exit Charge" + "Duty on Exit Charge" + "Normal charges";
            "Net Refundable" := "Total Refundable" - "Total Charges";
            "Net Refundable" += "Dividends/Rebates";
            MemberExitCharge := (0.15 * "Net Refundable");

            if "Share Capital Amount To Sale" <> 0 then begin

                ChargeAmt := 0;
                ChargeDuty := 0;
                ChargeAcct := '';


                MemberActivities.GetGeneral_SharingChargeAmount(SaccoSetup."Share Capital Charge", "Share Capital Amount To Sale", ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
                "Share Charge" := ChargeAmt;
                "Share Charge GL" := ChargeAcct;
                "Total Charges" += ChargeAmt;
            end;
        end else
            "Net Refundable" := "Total Refundable";
    end;

    procedure CheckMemberType(memberNo: code[20]): Boolean
    var
        CustMember: Record Members;
    begin
        CustMember.Reset();
        CustMember.SetRange("No.", memberNo);
        CustMember.SetRange(Type, CustMember.Type::Member);
        if CustMember.FindFirst() then
            exit(true)
        else
            exit(false);
    end;


}