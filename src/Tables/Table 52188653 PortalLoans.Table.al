Table 50316 "Portal Loans"
{

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Account No"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                SavingsAccount: Record "Savings Accounts";
            begin
                if SavingsAccount.Get("Account No") then begin
                    Rec."Member No." := SavingsAccount."Member No.";
                    Rec."Account Name" := SavingsAccount."Name";
                end;
            end;
        }
        field(3; Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionMembers = Open,GuarantorUpload,DocumentUpload,"Pending Guarantor Action",Pending,Appraisal,Successful,Failed,Approved,"Pending Appraisal";
        }
        field(7; "Date Posted"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; DocumentNo; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Latest Salary Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "STO Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Net Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Total loans"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Commision Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LoanType: Record "Product Setup";
            begin
                if LoanType.Get("Loan Product Type") then
                    Rec."Loan Name" := LoanType.Description;
            end;
        }
        field(17; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Session ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Telephone No"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Message; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Member: Record "Members";
            begin
                if Member.Get(Rec."Member No.") then
                    Rec."Loan Name" := Member.Name
                else
                    Rec."Loan Name" := '';
            end;
        }
        field(24; "Entry Code"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; Deactivated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Deactivated By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Date Deactivated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Micro Loan Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Needs Guarantors"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Micro Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Salary Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Account Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Loan Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Expected Guarantors"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; Password; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Loan Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Loan Purpose"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; Source; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; Branch; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; Category; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "Step Completed"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "Basic Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50071; "Allowances"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "PAYE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Loan Witness"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Loan Witness Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Loan Witness Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Date Of Appointment"; Date)
        {
            DataClassification = ToBeClassified;
        }



        field(50078; "Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }


        field(50079; "Terms Of Appointment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Employer"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Source Application"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50082; "Guaranteed By Other Members"; Boolean)
        {
            Caption = 'Guaranteed By Other Members';
            DataClassification = CustomerContent;
        }

        field(50083; "Use My Deposits"; Boolean)
        {
            Caption = 'Use My Deposits';
            DataClassification = CustomerContent;
        }

        field(50084; "Use Holiday Savings"; Boolean)
        {
            Caption = 'Use Holiday Savings';
            DataClassification = CustomerContent;
        }




    }

    keys
    {
        key(Key1; "Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //   ERROR('Deletion not allowed');
    end;

    trigger OnInsert()
    begin

        if "Application No." = '' then begin
            NSetup.Get;
            NSetup.TestField("Portal Loan Nos");
            "Application No." := NoSeriesMgt.GetNextNo(NSetup."Portal Loan Nos", WorkDate(), true);
        end;
    end;

    var
#pragma warning disable AL0432
        NoSeriesMgt: Codeunit "No. Series";
#pragma warning restore AL0432
        NSetup: Record "Sales & Receivables Setup";
        Loans: Record Loans;
}

