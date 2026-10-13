table 50611 "Write Off Lines"
{
    Caption = 'Write Off Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "Write Off No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1; "Member No"; Code[100])
        {
            Caption = 'Member No';
            DataClassification = ToBeClassified;
            TableRelation = Members;
            trigger OnValidate()
            begin

                Member.get("Member No");

                Member.GEt("Member No");
                "Old Member No" := Member."Old Member No.";
                "Member Name" := Member.Name;

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", "Member No");
                if MemberAccounts.FindFirst then begin
                    repeat
                        if MemberAccounts."Product Category" = MemberAccounts."product category"::"Deposit Contribution" then begin
                            Depostis := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                        end;
                        if MemberAccounts."Product Category" = MemberAccounts."product category"::"Share Capital" then
                            "Share Capital" := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                        if MemberAccounts."Product Category" = MemberAccounts."product category"::"Dividend Account" then
                            "Unpaid Dividend" := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                        "Total Share Amount" := Depostis + "Unpaid Dividend";

                    until MemberAccounts.Next = 0;
                end;
            end;
        }
        field(11; "Old Member No"; Code[100])
        {
            Caption = 'Old Member No';
            DataClassification = ToBeClassified;
        }
        field(21; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Share Capital"; Decimal)
        {
            Caption = 'Share Capital';
            DataClassification = ToBeClassified;
        }
        field(4; Depostis; Decimal)
        {
            Caption = 'Depostis';
            DataClassification = ToBeClassified;
        }
        field(5; "Unpaid Dividend"; Decimal)
        {
            Caption = 'Unpaid Dividend';
            DataClassification = ToBeClassified;
        }
        field(6; "Total Share Amount"; Decimal)
        {
            Caption = 'Total Share Amount';
            DataClassification = ToBeClassified;
        }
        field(18; "Member Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(24; "Loan Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Loan No"; Text[100])
        {
            Caption = 'Loan No';
            TableRelation = Loans where("Member No." = field("Member No"), Posted = const(true));
            trigger OnValidate()
            begin
                Loans.Reset;
                Loans.setrange("Loan No.", "Loan No");
                if Loans.findfirst then begin
                    Loans.CalcFields("Outstanding Interest", "Outstanding Principal");
                    "Interest Balance" := Loans."Outstanding Interest";
                    "Loan Balance" := Loans."Outstanding Principal";
                end;
                if ("Loan Balance" + "Interest Balance") <= 0 then
                    error('Member does not have a loan balance');

                "Loan + Interest Amount" := "Loan Balance" + "Interest Balance";


                "Total Write Off Amount" := "Total Share Amount" - "Loan + Interest Amount";
                if "Total Write Off Amount" < 0 then
                    "Total Write Off Amount" *= -1;
            end;
        }
        field(7; "Loan Balance"; Decimal)
        {
            Caption = 'Loan Balance';
            DataClassification = ToBeClassified;
        }
        field(8; "Interest Balance"; Decimal)
        {
            Caption = 'Interest Balance';
            DataClassification = ToBeClassified;
        }
        field(17; "Loan + Interest Amount"; Decimal)
        {
            Caption = 'Loan + Interest Amount';
            DataClassification = ToBeClassified;
        }
        field(9; "Total Write Off Amount"; Decimal)
        {
            Caption = 'Total Write Off Amount';
            DataClassification = ToBeClassified;
        }
        field(25; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

    }
    keys
    {
        key(Key1; "Write Off No", "Member No", "Loan No")
        {
            Clustered = true;
        }
    }
    var
        Member: Record Members;
        Loans: Record Loans;
        MemberAccounts: Record Vendor;
        MemberActivities: Codeunit "Member Activities";

}
