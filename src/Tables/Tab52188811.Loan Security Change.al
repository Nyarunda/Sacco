table 50493 "Loan Security Change"
{
    Caption = 'Loan Security Change';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members;
            Caption = 'Member No.';
            trigger OnValidate()
            var
                Member: Record Members;
            begin
                Member.Get("Member No.");
                "Member Name" := Member.Name;
                "Loan No" := '';
            end;
        }
        field(3; "Member Name"; Text[80])
        {
            Caption = 'Member Name';
            Editable = false;
        }
        field(4; "Loan No"; Code[20])
        {
            TableRelation = Loans where("Member No." = field("Member No."), "Outstanding Principal" = filter('>0'));
            Caption = 'Loan No';
            trigger OnValidate()
            var
                Loans: Record Loans;
                SecurityChangesLine: Record "Loan Security Lines Changes";
                Security: Record "Loan Security";
            begin
                Loans.Get("Loan No");
                Loans.CalcFields("Outstanding Interest", "Outstanding Principal");
                "Outstanding Balance" := Loans."Outstanding Principal";
                "Outstanding Interest" := Loans."Outstanding Interest";
                "Application Date" := Loans."Application Date";

                SecurityChangesLine.Reset();
                SecurityChangesLine.SetRange("Loan No", Loans."Loan No.");
                if SecurityChangesLine.FindSet then
                    SecurityChangesLine.DeleteAll();

                Security.Reset();
                Security.SetRange("Loan No.", Loans."Loan No.");
                if Security.FindSet then
                    repeat
                        SecurityChangesLine.Init();
                        SecurityChangesLine."Loan No" := Security."Loan No.";
                        SecurityChangesLine."Security Type" := Security."Guarantor Type";
                        SecurityChangesLine."Security Account" := Security."Account No.";
                        SecurityChangesLine."Collateral Reg. No." := Security."Collateral Reg. No.";
                        SecurityChangesLine."Security Name" := Security.Name;
                        SecurityChangesLine."Amount Guaranteed" := Security."Amount Guaranteed";
                        SecurityChangesLine."Commited Amount" := Security."Current Committed";
                        SecurityChangesLine.Insert();
                    until Security.Next() = 0;
            end;
        }
        field(5; "Outstanding Balance"; Decimal)
        {
            Caption = 'Outstanding Balance';
            Editable = false;
        }
        field(6; "Outstanding Interest"; Decimal)
        {
            Caption = 'Outstanding  Interest';
            Editable = false;
        }
        field(7; "Application Date"; Date)
        {
            Caption = 'Application Date';
            Editable = false;
        }
        field(8; "Global Dimension 1 Code"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Shortcut Dimension 2 Code"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No. Series"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Effected; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(35; Status; option)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            Description = 'Stores the status of the record in the database';
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }

    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        pay: record "Payment Header";
    begin


        if "No" = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Security Changes");
            No := NoSeries.GetNextNo(NoSetup."Security Changes", WorkDate(), true);
        end;




        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";


    end;

    var
        NoSeries: Codeunit "No. Series";
        NoSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";

}
