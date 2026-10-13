table 50372 "Dividend Instructions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = "Pay Internal Loan","Pay Internal Savings";

            trigger OnValidate()
            begin
                "Account No." := '';
                "Account Name" := '';
                Amount := 0;
                "Loan No." := '';
            end;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No,';
            DataClassification = ToBeClassified;

            TableRelation = if (Type = const("Pay Internal Savings")) "Savings Accounts" where("Member No." = field("Member No."));

            trigger OnValidate()
            var
                Cust: Record Members;
                Vend: Record "Savings Accounts";
            begin
                "Account Name" := '';

                if Cust.get("Account No.") then
                    "Account Name" := Cust.Name;

                If Vend.get("Account No.") then begin
                    //"Account Name" := Vend.Name;
                    "Account Name" := Vend."Product Name";
                end;
            end;

            trigger OnLookUp()
            var
                Vend: Record "Savings Accounts";
                Cust: Record Members;
                Loans: Record Loans;
            begin

                if (Type = Type::"Pay Internal Savings") then begin
                    Vend.RESET;
                    Vend.SetFilter("Member No.", "Member No.");
                    if Vend.FindFirst() then begin

                        IF PAGE.RUNMODAL(Page::"Member Accounts List", Vend) = ACTION::LookupOK THEN BEGIN
                            "Account No." := Vend."No.";
                            VALIDATE("Account No.");
                        END
                    end;
                end;

                if (Type = Type::"Pay Internal Loan") then begin
                    Loans.RESET;
                    Loans.SetFilter("Member No.", "Member No.");
                    if Loans.FindFirst() then begin
                        IF PAGE.RUNMODAL(Page::"Loan Posted List", Loans) = ACTION::LookupOK THEN BEGIN
                            "Account No." := Loans."Loan Account";
                            VALIDATE("Account No.");
                        END
                    end;
                end;
            end;
        }
        field(5; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
            TableRelation = Loans Where("Member No." = field("Member No."), "Total Outstanding Balance" = filter(> 0));
            trigger OnValidate()
            var
                Loans: Record Loans;
            begin
                Loans.Get("Loan No.");
                "Account No." := Loans."Loan Account";
                "Account Name" := Loans."Loan Product Type Name";
            end;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(10; "Process Type"; Option)
        {
            OptionMembers = " ",Dividends,"Excess-Checkoff","Excess-Receipt",Provisioning;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Member No.", "Account No.", "Loan No.", "Process Type")
        {
            Clustered = true;
        }
    }
}
