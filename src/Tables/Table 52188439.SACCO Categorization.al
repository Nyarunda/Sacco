
Table 50083 "SACCO Categorization"
{
    DrillDownPageId = "Sacco Categorization List";
    LookupPageId = "Sacco Categorization List";

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Outstanding Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Outstanding Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Outstanding Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Total Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Principal Expected"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Principal Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Principal Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Days in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loan Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Performing,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Performing,Watch,Substandard,Doubtful,Loss;
        }
        field(16; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sasra Up to Date","Sacco Up to Date","Sasra Filtered","Sacco Filtered";
        }
        field(17; "Total Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "As At"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "User Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Interest Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Months in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(109; "Total Balance"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment" | "Interest Due" | "Interest Paid" | "Penalty Due" | "Penalty Paid" | "Appraisal Due" | "Appraisal Paid"),
                                                                        "User ID" = filter(<> ''),
                                                                        Amount = filter(<> 0),
                                                                        "Amount (LCY)" = filter(<> 0),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Loan Disbursement|Principal Repayment),Posting Date=FIELD(Date Filter)))';
            Editable = false;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(110; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }

        field(111; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts";
        }

        field(112; Balance; Decimal)
        {

            CalcFormula = - Sum("Savings Ledger Entry".Amount WHERE("Account No." = FIELD("Account No.")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }

        field(113; "Next Run Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(114; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


        field(115; "Employer Code"; Code[20])
        {

            CalcFormula = lookup(Members."Employer Code" WHERE("No." = FIELD("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(116; "Installments Defaulted"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(117; "Repay Mode"; Enum "Repay Mode Enum")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Repay Mode" where("Loan No." = field("Loan No.")));
            Editable = false;
        }
        field(118; "Arrears Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(119; "Mobile Loan"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Mobile Loan" where("Loan No." = field("Loan No.")));
            Editable = false;
        }
        field(120; "Deposit Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "User Name")
        {
            Clustered = true;
        }
        key(Key2; "Issued Date")
        {
        }
    }

    fieldgroups
    {
    }
}

