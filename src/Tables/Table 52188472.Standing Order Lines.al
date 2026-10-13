
Table 50135 "Standing Order Lines"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Destination Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,External,Fixed Asset,IC Partner,Employee,Internal,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,External,"Fixed Asset","IC Partner",Employee,Internal,Credit;
            ValuesAllowed = "G/L Account", External, Internal, Credit;

            trigger OnValidate()
            begin
                Validate("Destination Account No.", '');

                if "Destination Account Type" = "destination account type"::External then begin
                    if STOHeader.Get("Document No.") then begin
                        if STOHeader."Allow Partial Deduction" = true then
                            Error('An external standing order cannot be partially deducted');
                    end;
                end;


                /*
                STOLines.RESET;
                STOLines.SETRANGE(STOLines."Document No.","Document No.");
                IF STOLines.FIND('-')=TRUE THEN //BEGIN
                //IF STOLines.COUNT>1 THEN
                  ERROR('Only one entry is allowed for this type of standing order, Please delete the lines before proceeding');
                //END;
                */

            end;
        }
        field(18; "Destination Account No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Destination Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Destination Account Type" = const(Customer)) Customer
            else
            if ("Destination Account Type" = const(Vendor)) Vendor
            else
            if ("Destination Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Destination Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Destination Account Type" = const(Internal)) "Savings Accounts" where("Member No." = field("Member No."))
            else
            if ("Destination Account Type" = const(Credit)) "Credit Accounts" where("Member No." = field("Member No."));

            trigger OnValidate()
            begin
                "Destination Account Name" := '';

                if "Destination Account Type" = "destination account type"::Internal then begin
                    if Account.Get("Destination Account No.") then begin
                        "Destination Account Name" := Account.Name;
                    end;
                end;

                if "Destination Account Type" = "destination account type"::External then begin
                    if BankAcc.Get("Destination Account No.") then begin
                        //"Destination Account Name":=BankAcc.Name;
                        //"Bank Code":=BankAcc."Bank No.";


                        if StrLen("Destination Account No.") > 14 then
                            Error('Invalid Bank Account No. Please enter a bank account with less than 15 digits.');

                        if STOHeader.Get("Document No.") then begin
                            if STOHeader."Allow Partial Deduction" = true then
                                Error('An external standing order cannot be partially deducted');
                        end;
                    end;
                end;

                /*if "Destination Account Type" = "destination account type"::Credit then begin
                    if Members.Get("Destination Account No.") then begin
                        "Destination Account Name" := Members.Name;
                    end;
                end; 8?

                /*
                STOLines.RESET;
                STOLines.SETRANGE(STOLines."Document No.","Document No.");
                IF STOLines.FIND('-')=TRUE THEN //BEGIN
                //IF STOLines.COUNT>1 THEN
                  ERROR('Only one entry is allowed for this type of standing order, Please delete the lines before proceeding');
                //END;
                */

            end;
        }
        field(19; "Destination Account Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Loan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."), "Outstanding Principal" = filter(> 0));
            trigger OnValidate()
            var
                Loans: Record Loans;
            begin
                if Loans.get("Loan No.") then begin
                    "Destination Account No." := Loans."Loan Account";
                    "Destination Account Name" := Loans."Member Name";
                end
            end;
        }
        field(21; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Amount < 0 then
                    Error(LessThanZeroAmount);


                if "Destination Account Type" = "destination account type"::Credit then begin
                    if "Loan No." = '' then
                        Error('Kindly specify the loan no. before proceeding');

                end;
            end;
        }
        field(22; "Bank Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                IF "Destination Account Type"="Destination Account Type"::Internal THEN
                  ERROR('Only applicable FOR external STOs');
                
                BankCodeStructure.RESET;
                BankCodeStructure.SETRANGE(BankCodeStructure."Bank Code","Bank Code");
                IF BankCodeStructure.FIND('-') THEN
                  "Bank Name":=BankCodeStructure."Bank Name";
                  */

            end;
        }
        field(23; "Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                IF "Destination Account Type"<>"Destination Account Type"::External THEN
                  ERROR('Only applicable for external STOs');
                
                
                 BankCodeStructure.RESET;
                   BankCodeStructure.SETRANGE(BankCodeStructure."Branch Code","Branch Code");
                   IF BankCodeStructure.FIND('-') THEN BEGIN
                  "Bank Code":=BankCodeStructure."Bank Code";
                  "Bank Name":=BankCodeStructure."Bank Name";
                  "Branch Name":=BankCodeStructure.Branch;
                   END;
                
                IF "Branch Code"='' THEN BEGIN
                 "Bank Code":= ''; "Bank Name":=''; "Bank Account No.":=''; END;
                 */

            end;
        }
        field(24; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "Destination Account Type" <> "destination account type"::External then
                    Error('Only applicable for external STOs');
            end;
        }
        field(25; "Bank Account No."; Code[105])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Destination Account Type" <> "destination account type"::External then
                    Error('Only applicable for external STOs');

                //*
                if "Destination Account Type" = "destination account type"::External then begin
                    if StrLen("Bank Account No.") <> 13 then
                        Error('Invalid Bank account No. Please enter the correct Bank Account No.');
                end;
            end;
        }
        field(26; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Branch Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(28; Priority; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Destination Account No.", "Loan No.")
        {
            Clustered = true;
        }
        key(Key2; "Destination Account Type")
        {
        }
        key(Key3; Priority)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
    end;

    var
        Account: Record "Savings Accounts";
        BankAcc: Record "Bank Account";
        Members: Record Members;
        StrTel: Text;
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        LessThanZeroAmount: label 'Amount cannot be less than zero (0)';
}

