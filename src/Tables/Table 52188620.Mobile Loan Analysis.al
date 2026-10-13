
Table 50283 "Mobile Loan Analysis"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Entered By"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Member Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Notification; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10";
        }
        field(25; "Penalty Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Next Loan Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Recovered From Deposits"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Deposits Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Recovered From FOSA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "FOSA Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Loan Product"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Total Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment" | "Interest Due" | "Interest Paid" | "Penalty Due" | "Penalty Paid" | "Appraisal Due" | "Appraisal Paid"),
                                                                        "User ID" = filter(<> ''),
                                                                        Amount = filter(<> 0),
                                                                        "Amount (LCY)" = filter(<> 0)));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

