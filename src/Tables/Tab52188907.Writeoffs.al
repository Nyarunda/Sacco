table 50610 "Write offs"
{
    Caption = '50380- Loan Write Off';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "Write Off No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()

            begin


                if "Write Off No" <> xRec."Write Off No" then begin
                    NSetup.Get;
                    NoSeriesMgt.TestManual(NSetup."Write Off No");

                    "No. Series" := '';
                end;

            end;
        }
        field(1; "Member No"; Code[100])
        {
            Caption = 'Member No';
            DataClassification = ToBeClassified;
            TableRelation = Members;
            trigger OnValidate()

            begin

                Cust.GEt("Member No");
                "Old Member No" := Cust."Old Member No.";
                "Member Name" := Cust.Name;

                "Created By" := UserId;
                "Date Created" := TODAY;

                UserSetup.Get(UserId);
                UserSetup.TestField("Global Dimension 1 Code");
                UserSetup.TestField("Global Dimension 2 Code");

                "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";

                "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";


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
        field(7; "Loan Balance"; Decimal)
        {
            Caption = 'Loan Balance';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Write Off Lines"."Loan Balance" where("Write Off No" = field("Write Off No")));
        }
        field(8; "Interest Balance"; Decimal)
        {
            Caption = 'Interest Balance';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Write Off Lines"."Interest Balance" where("Write Off No" = field("Write Off No")));
        }
        field(9; "Total Write Off Amount"; Decimal)
        {
            Caption = 'Total Write Off Amount';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Write Off Lines"."Total Write Off Amount" where("Write Off No" = field("Write Off No")));
        }
        field(17; "Loan + Interest Amount"; Decimal)
        {
            Caption = 'Loan + Interest Amount';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Write Off Lines"."Loan + Interest Amount" where("Write Off No" = field("Write Off No")));
        }
        field(10; "File Comments"; Text[250])
        {
            Caption = 'FIle Comments';
            DataClassification = ToBeClassified;
        }
        field(12; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(13; "Created By"; Text[100])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(14; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,"Pending Approval",Approved,Posted,Rejected;

        }
        field(16; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(18; "Printed By"; Text[100])
        {
            Caption = 'Report Printed By';
            DataClassification = ToBeClassified;
        }
        field(19; "Submitted By"; Text[100])
        {
            Caption = 'Submitted To FInance By';
            DataClassification = ToBeClassified;
        }
        field(20; "Posted By"; Text[100])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(21; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            DataClassification = ToBeClassified;
        }
        field(22; "Loan No"; Text[100])
        {
            Caption = 'Loan No';
            //TableRelation = Loans where("Member No." = field("Member No"), Posted = const(true));
            /*trigger OnValidate()
            begin
                WriteOffList.Reset();
                WriteOffList.Setrange("Loan No", "Loan No");
                if WriteOffList.FindFirst() then
                    error('Loan already on writeoff list');

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
            end;*/
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(25; Department; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Assistant Credit Officer","Credit Officer","Chief Accountant","Internal Auditor","CEO","Finance";

        }

    }
    keys
    {
        key(PK; "Write Off No")
        {
            Clustered = true;
        }
    }
    var
        MemberActivities: Codeunit "Member Activities";
        MemberAccounts: Record Vendor;
        Cust: Record Members;
        Loans: Record Loans;
        NSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        WriteOffList: Record "Write offs";

    trigger OnInsert()
    begin

        if "Write Off No" = '' then begin
            NSetup.Get;
            NSetup.TestField("Write Off No");
            "Write Off No" := NoSeriesMgt.GetNextNo(NSetup."Write Off No", WorkDate(), true);

        end;
        "Date Created" := Today;
        "Created By" := UserId;
    end;
}

