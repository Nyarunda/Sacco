Table 50295 "Sky Mobile Loans"
{

    fields
    {
        field(1; "Entry No"; Guid)
        {
            Editable = false;
        }
        field(2; "Account No"; Text[30])
        {
            Editable = false;
        }
        field(3; Date; DateTime)
        {
        }
        field(4; "Requested Amount"; Decimal)
        {
            Editable = false;
        }
        field(5; Posted; Boolean)
        {
            Editable = true;
        }
        field(6; Status; Option)
        {
            OptionCaption = 'Pending,Successful,Failed,Pending Guarantors,Appraisal,Approved,Pending Update';
            OptionMembers = Pending,Successful,Failed,"Pending Guarantors",Appraisal,Approved,"Pending Update";
        }
        field(7; "Date Posted"; DateTime)
        {
        }
        field(8; Remarks; Text[200])
        {
            Editable = false;
        }
        field(9; DocumentNo; Text[30])
        {
            Editable = false;
        }
        field(10; "Latest Salary Amount"; Decimal)
        {
            Editable = false;
        }
        field(11; "STO Amount"; Decimal)
        {
        }
        field(12; "Net Salary"; Decimal)
        {
        }
        field(13; "Total loans"; Decimal)
        {
        }
        field(14; "Approved Amount"; Decimal)
        {
        }
        field(15; "Commision Amount"; Decimal)
        {
        }
        field(16; "Loan Product Type"; Code[20])
        {
            TableRelation = "Product Setup"."Product ID";
        }
        field(17; Amount; Decimal)
        {
        }
        field(18; "Session ID"; Code[20])
        {
        }
        field(19; "Date Entered"; Date)
        {
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Telephone No"; Text[20])
        {
        }
        field(22; Remark; Text[250])
        {
        }
        field(23; "Member No."; Code[20])
        {
        }
        field(24; "Entry Code"; Code[50])
        {
        }
        field(30; "Line No."; Integer)
        {
            Editable = false;
        }
        field(31; Installments; Text[5])
        {
            Editable = false;
        }
        field(50050; Deactivated; Boolean)
        {
        }
        field(50051; "Deactivated By"; Code[50])
        {
        }
        field(50052; "Date Deactivated"; Date)
        {
        }
        field(50053; "Micro Loan Category"; Code[20])
        {
        }
        field(50054; "Needs Guarantors"; Boolean)
        {
        }
        field(50055; "Micro Loan"; Boolean)
        {
        }
        field(50056; Period; Integer)
        {
        }
        field(50057; Name; Text[200])
        {
            FieldClass = Normal;
        }
        field(50058; "Staff No"; Code[20])
        {
            FieldClass = Normal;
        }
        field(50059; "Member No"; Code[20])
        {
            FieldClass = Normal;
        }
        field(50060; "Account Name"; Text[200])
        {
        }
        field(50061; "Loan Name"; Text[30])
        {
        }
        field(50062; "Expected Guarantors"; Integer)
        {
        }
        field(50063; "Loan Period"; Integer)
        {
        }
        field(50064; "Repay Mode"; Text[50])
        {
        }
        field(50065; "Loan Purpose"; Code[20])
        {
        }
        field(50066; "Loan No."; Code[20])
        {
        }
        field(50067; "Message"; Text[200])
        {
        }
        field(50068; "Channel"; Option)
        {
            OptionMembers = "Sky World",SpotCash;
        }

        field(50069; "Mobile Loan"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(50070; "Needs Change"; Boolean)
        {

        }
        field(50071; "Source Application"; Text[50])
        {

        }
        field(50072; "Guaranteed By Other Members"; Boolean)
        {
            Caption = 'Guaranteed By Other Members';
            DataClassification = CustomerContent;
        }

        field(50073; "Use My Deposits"; Boolean)
        {
            Caption = 'Use My Deposits';
            DataClassification = CustomerContent;
        }

        field(50074; "Use Holiday Savings"; Boolean)
        {
            Caption = 'Use Holiday Savings';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Error('Deletion not allowed');
    end;

    var
        LoanProductTypes: Record "Product Setup";
}

