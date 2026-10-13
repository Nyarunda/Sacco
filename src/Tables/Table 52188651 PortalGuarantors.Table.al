Table 50314 "Portal Guarantors"
{

    fields
    {
        field(1; "Loan Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Guarantor Mobile No."; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Guarantor Member No."; Code[200])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Available Deposits" := 0;

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", "Guarantor Member No.");
                SavingsAccounts.SetRange("Product Type", "Appraisal Deposit Products");
                if SavingsAccounts.FindFirst then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    "Available Deposits" := SavingsAccounts."Balance (LCY)";
                end;
            end;
        }
        field(4; "Loan Product"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Product Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Guarantor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Guarantor Accepted"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,No,Yes,Invalid;
        }
        field(8; "Guarantor Response Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Guarantor Response Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Pending Approval",Approved,Rejected;
        }
        field(11; "Appraisal Deposit Products"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Available Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Posted; Boolean)
        {
            CalcFormula = lookup("Portal Loans".Posted where("Application No." = field("Loan Entry No.")));
            FieldClass = FlowField;
        }



        field(15; "Loan Status"; Option)
        {
            OptionMembers = Open,GuarantorUpload,DocumentUpload,"Pending Guarantor Action",Pending,Appraisal,Successful,Failed,Approved;

            CalcFormula = lookup("Portal Loans".Status where("Application No." = field("Loan Entry No.")));
            FieldClass = FlowField;
        }

        field(16; "Blob Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Blob Url"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        field(18; Collateral; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Invalidated By"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan Entry No.", "Guarantor Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SavingsAccounts: Record "Savings Accounts";
}

