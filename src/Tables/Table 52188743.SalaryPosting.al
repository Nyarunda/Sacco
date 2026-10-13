

Table 50417 "Salary Posting"
{

    fields
    {
        field(2; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(50002; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            DataClassification = ToBeClassified;
        }
        field(50003; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(50004; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(50005; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(50006; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50007; "Member No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Credit Amount" := 0;
                "Debit Amount" := 0;
                if Amount > 0 then
                    "Debit Amount" := Amount;
                if Amount < 0 then
                    "Credit Amount" := Amount * -1;
            end;
        }
        field(50009; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;
        }
        field(50010; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;
        }
        field(50011; "Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF "Transaction Type"="Transaction Type"::"Registration Fee" THEN
                  Description:='Registration Fee';
                IF "Transaction Type"="Transaction Type"::Loan THEN
                  Description:='Loan';
                IF "Transaction Type"="Transaction Type"::Repayment THEN
                  Description:='Loan Repayment';
                IF "Transaction Type"="Transaction Type"::Withdrawal THEN
                  Description:='Withdrawal';
                IF "Transaction Type"="Transaction Type"::"Interest Due" THEN
                  Description:='Interest Due';
                IF "Transaction Type"="Transaction Type"::"Interest Paid" THEN
                  Description:='Interest Paid';
                IF "Transaction Type"="Transaction Type"::"Benevolent Fund" THEN
                  Description:='ABF Fund';
                IF "Transaction Type"="Transaction Type"::"Deposit Contribution" THEN
                  Description:='Shares Contribution';
                IF "Transaction Type"="Transaction Type"::"Appraisal Fee" THEN
                  Description:='Appraisal Fee';
                IF "Transaction Type"="Transaction Type"::"Application` Fee" THEN
                  Description:='Application Fee';
                IF "Transaction Type"="Transaction Type"::"Unallocated Funds" THEN
                  Description:='Unallocated Funds';
                         */


                //GenSet.GET;
                /*
                IF "Account Type"="Account Type"::Member THEN BEGIN
                CustMember.RESET;
                CustMember.SETRANGE(CustMember."No.","Account No.");
                IF CustMember.FIND('-') THEN BEGIN
                IF "Transaction Type"="Transaction Type"::Bills THEN
                "Bal. Account No.":=GenSet."Bill Account"
                ELSE
                "Bal. Account No.":='';
                END;
                END;
                
                
                
                PartOfAcc:='';
                
                PartOfAcc:=COPYSTR("Account No.",1,3);
                
                IF ((PartOfAcc='S01') OR (PartOfAcc='S02') OR (PartOfAcc='S06') OR (PartOfAcc='S09')  ) AND ("Transaction Type"<>"Transaction Type"::"Deposit Contribution") THEN
                ERROR('The chosen transaction type should be deposit contribution');
                
                IF ((PartOfAcc='S03') OR (PartOfAcc='S04')) AND ("Transaction Type"<>"Transaction Type"::"Share Capital") THEN
                ERROR('The chosen transaction type should be share Capital');
                
                IF ((PartOfAcc='L01') OR (PartOfAcc='L04') OR (PartOfAcc='L05')) AND ("Transaction Type"<>"Transaction Type"::" ") THEN
                ERROR('The transaction type should be blank');
                */

            end;
        }
        field(50012; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50013; "Product Type Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50015; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50016; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Product Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(50019; "Bal. Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(50020; Blocked; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(50021; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51021; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Loan Product"; Code[20])
        {
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(50023; Transaction; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Gross,Tax,Processing Fee,Duty on Processing Fee,Loan,SMS,Capitalized';
            OptionMembers = " ",Gross,Tax,"Processing Fee","Duty on Processing Fee",Loan,SMS,Capitalized;
        }


        field(50024; "Header No."; Code[20])
        {

        }
        field(50025; "Running Balance"; Decimal)
        {

        }

        field(50026; Type; Option)
        {
            OptionMembers = " ",Savings,"Interest Arrears","Principlal Arrears","Loan Interest","Loan Principal","Internal STO","External STO";
        }

    }

    keys
    {
        key(Key1; "Header No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

