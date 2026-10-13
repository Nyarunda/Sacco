Table 50355 "Mobile Loan Guarantors"
{

    fields
    {
        field(1; "Loan Entry No."; Guid)
        {
        }
        field(2; "Guarantor Mobile No."; Code[20])
        {
        }
        field(3; "Guarantor Member No."; Code[20])
        {

            trigger OnValidate()
            begin
                "Available Deposits" := 0;

                Members.Reset;
                Members.SetRange("No.", "Guarantor Member No.");
                if Members.FindFirst then begin
                    "Available Deposits" := MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts("Guarantor Member No."));
                end;
            end;
        }
        field(4; "Loan Product"; Code[20])
        {
        }
        field(5; "Loan Product Name"; Text[100])
        {
        }
        field(6; "Guarantor Name"; Text[100])
        {
        }
        field(7; "Guarantor Accepted"; Option)
        {
            OptionMembers = Pending,No,Yes;
        }
        field(8; "Guarantor Response Date"; Date)
        {
        }
        field(9; "Guarantor Response Time"; Time)
        {
        }
        field(10; Status; Option)
        {
            OptionMembers = "Pending Approval",Approved,Rejected;
        }
        field(11; "Appraisal Deposit Products"; Code[20])
        {
        }
        field(12; "Available Deposits"; Decimal)
        {
        }
        field(13; "Amount Guaranteed"; Decimal)
        {
        }
        field(14; "Date Created"; DateTime)
        {
        }
        field(15; "Guarantor Dep. A/C"; Code[20])
        {
        }
        field(16; Posted; Boolean)
        {
        }
        field(17; "Loan Status"; Option)
        {
            CalcFormula = lookup("Sky Mobile Loans".Status where("Entry No" = field("Loan Entry No.")));
            Editable = true;
            FieldClass = FlowField;
            OptionCaption = 'Pending,Successful,Failed,Pending Guarantors,Appraisal,Approved';
            OptionMembers = Pending,Successful,Failed,"Pending Guarantors",Appraisal,Approved;
        }
        field(18; "Guarantor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Guarantor,Collateral,Lien';
            OptionMembers = Guarantor,Collateral,Lien;
        }
        field(19; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan Entry No.", "Guarantor Mobile No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SavingsAccounts: Record "Savings Accounts";
        Members: Record Members;
        MemberActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
}

