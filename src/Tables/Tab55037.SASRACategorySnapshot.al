
namespace UnitedWomen.UnitedWomen;

using System.Security.User;

table 55037 "SASRA Category Snapshot"
{
    Caption = 'SASRA Category Snapshot';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "As At"; Date)
        {
            Caption = 'As At';
            DataClassification = CustomerContent;
        }

        field(2; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = CustomerContent;
        }

        field(3; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = CustomerContent;
        }

        field(4; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            DataClassification = CustomerContent;
        }

        field(5; "Loan Product Type"; Code[20])
        {
            Caption = 'Loan Product Type';
            DataClassification = CustomerContent;
        }

        field(6; "Relationship Officer"; Code[50])
        {
            Caption = 'Relationship Officer';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }

        field(7; "Loan Officer"; Code[50])
        {
            Caption = 'Loan Officer';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }

        field(8; "Loan Category"; Option)
        {
            Caption = 'Loan Category';
            OptionMembers = Performing,Watch,Substandard,Doubtful,Loss;
            OptionCaption = 'Performing,Watch,Substandard,Doubtful,Loss';
            DataClassification = CustomerContent;
        }

        field(9; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;
        }

        field(10; "Outstanding Principal"; Decimal)
        {
            Caption = 'Outstanding Principal';
            DataClassification = CustomerContent;
        }

        field(11; "Outstanding Interest"; Decimal)
        {
            Caption = 'Outstanding Interest';
            DataClassification = CustomerContent;
        }

        field(12; "Outstanding Penalty"; Decimal)
        {
            Caption = 'Outstanding Penalty';
            DataClassification = CustomerContent;
        }

        field(13; "Total Outstanding Balance"; Decimal)
        {
            Caption = 'Total Outstanding Balance';
            DataClassification = CustomerContent;
        }

        field(14; "Principal Expected"; Decimal)
        {
            Caption = 'Principal Expected';
            DataClassification = CustomerContent;
        }

        field(15; "Principal Paid"; Decimal)
        {
            Caption = 'Principal Paid';
            DataClassification = CustomerContent;
        }

        field(16; "Interest Paid"; Decimal)
        {
            Caption = 'Interest Paid';
            DataClassification = CustomerContent;
        }

        field(17; "Principal Arrears"; Decimal)
        {
            Caption = 'Principal Arrears';
            DataClassification = CustomerContent;
        }

        field(18; "Total Arrears"; Decimal)
        {
            Caption = 'Total Arrears';
            DataClassification = CustomerContent;
        }

        field(19; "Days in Arrears"; Integer)
        {
            Caption = 'Days in Arrears';
            DataClassification = CustomerContent;
        }

        field(20; "Months in Arrears"; Integer)
        {
            Caption = 'Months in Arrears';
            DataClassification = CustomerContent;
        }

        field(21; "IFRS Stage"; Option)
        {
            Caption = 'IFRS Stage';
            OptionMembers = "Stage 1","Stage 2","Stage 3";
            OptionCaption = 'Stage 1,Stage 2,Stage 3';
            DataClassification = CustomerContent;
        }

        field(22; ECL; Decimal)
        {
            Caption = 'ECL';
            DataClassification = CustomerContent;
        }

        field(23; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
        }

        field(24; "Issued Date"; Date)
        {
            Caption = 'Issued Date';
            DataClassification = CustomerContent;
        }

        field(25; "User Name"; Code[50])
        {
            Caption = 'User Name';
            DataClassification = CustomerContent;
        }

        field(26; "Created At"; DateTime)
        {
            Caption = 'Created At';
            DataClassification = SystemMetadata;
        }
        field(27; "Run ID"; Guid)
        {
            DataClassification = SystemMetadata;
        }
    }

   keys
{
    key(PK; "As At", "Loan No.")
    {
        Clustered = true;
    }

    key(LoanOfficerAsAtCategoryKey; "Loan Officer", "As At", "Loan Category")
    {
        Clustered = false;
    }

    key(CategoryAsAtKey; "Loan Category", "As At")
    {
        Clustered = false;
    }
}
}