table 50589 "Loan Graduation Score"
{
    Caption = 'Loan Graduation Score';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No"; Code[20])
        {
            Caption = 'Member No';
            TableRelation = Members;
        }
        field(2; "Evaluation Date"; Date)
        {
            Caption = 'Evaluation Date';
        }
        field(10; "Repayment History Score"; Decimal)
        {
            Caption = 'Repayment History Score';
            DecimalPlaces = 0 : 2;
            MaxValue = 45;
            MinValue = 0;
        }
        field(11; "Repayment Category"; Option)
        {
            Caption = 'Repayment Category';
            OptionCaption = 'Poor,Moderate,Minor,Perfect';
            OptionMembers = Poor,Moderate,Minor,Perfect;
        }
        field(12; "No Of Mobile Loans"; Integer)
        {
            Caption = 'No Of Mobile Loans';
        }
        field(13; "Max Arrears Days"; Integer)
        {
            Caption = 'Max Arrears Days';
        }
        field(14; "Loans In Arrears"; Integer)
        {
            Caption = 'Loans In Arrears';
        }
        field(15; "Defaulted Loans"; Integer)
        {
            Caption = 'Defaulted Loans';
        }
        field(16; "On Time Payment %"; Decimal)
        {
            Caption = 'On Time Payment %';
            DecimalPlaces = 0 : 2;
        }
        field(17; "Has Rollovers"; Boolean)
        {
            Caption = 'Has Rollovers';
        }
        field(18; "Has Restructuring"; Boolean)
        {
            Caption = 'Has Restructuring';
        }
        field(20; "Savings Consistency Score"; Decimal)
        {
            Caption = 'Savings Consistency Score';
            DecimalPlaces = 0 : 2;
            MaxValue = 20;
            MinValue = 0;
        }
        field(21; "Savings Category"; Option)
        {
            Caption = 'Savings Category';
            OptionCaption = 'Poor,Irregular,Good,Perfect';
            OptionMembers = Poor,Irregular,Good,Perfect;
        }
        field(22; "Expected Contributions"; Integer)
        {
            Caption = 'Expected Contributions';
        }
        field(23; "Actual Contributions"; Integer)
        {
            Caption = 'Actual Contributions';
        }
        field(24; "Contribution Rate %"; Decimal)
        {
            Caption = 'Contribution Rate %';
            DecimalPlaces = 0 : 2;
        }
        field(25; "Consecutive Missed Months"; Integer)
        {
            Caption = 'Consecutive Missed Months';
        }
        field(30; "Loan To Savings Ratio Score"; Decimal)
        {
            Caption = 'Loan To Savings Ratio Score';
            DecimalPlaces = 0 : 2;
            MaxValue = 10;
            MinValue = 0;
        }
        field(31; "Ratio Category"; Option)
        {
            Caption = 'Ratio Category';
            OptionCaption = 'Very High,High,Moderate,Very Healthy';
            OptionMembers = "Very High",High,Moderate,"Very Healthy";
        }
        field(32; "Total Loan Balance"; Decimal)
        {
            Caption = 'Total Loan Balance';
            DecimalPlaces = 0 : 2;
        }
        field(33; "Total Savings"; Decimal)
        {
            Caption = 'Total Savings';
            DecimalPlaces = 0 : 2;
        }
        field(34; "Loan To Savings Ratio"; Decimal)
        {
            Caption = 'Loan To Savings Ratio';
            DecimalPlaces = 0 : 2;
        }
        field(40; "Membership Length Score"; Decimal)
        {
            Caption = 'Membership Length Score';
            DecimalPlaces = 0 : 2;
            MaxValue = 5;
            MinValue = 0;
        }
        field(41; "Membership Category"; Option)
        {
            Caption = 'Membership Category';
            OptionCaption = 'New Member,Medium Term,Long Membership';
            OptionMembers = "New Member","Medium Term","Long Membership";
        }
        field(42; "Membership Start Date"; Date)
        {
            Caption = 'Membership Start Date';
        }
        field(43; "Membership Years"; Decimal)
        {
            Caption = 'Membership Years';
            DecimalPlaces = 0 : 2;
        }
        field(45; "CRB Score"; Decimal)
        {
            Caption = 'CRB Score';
            DecimalPlaces = 0 : 2;
            MaxValue = 20;
            MinValue = 0;
        }
        field(46; "CRB Category"; Option)
        {
            Caption = 'CRB Category';
            OptionCaption = 'Poor,Weak,Fair,Perfect';
            OptionMembers = Poor,Weak,Fair,Perfect;
        }
        field(47; "CRB Status"; Text[50])
        {
            Caption = 'CRB Status';
        }
        field(48; "CRB Last Check Date"; Date)
        {
            Caption = 'CRB Last Check Date';
        }
        field(50; "Final Score"; Decimal)
        {
            Caption = 'Final Score';
            DecimalPlaces = 0 : 2;
            MaxValue = 100;
            MinValue = 0;
        }
        field(51; "Score Percentage"; Decimal)
        {
            Caption = 'Score Percentage';
            DecimalPlaces = 0 : 2;
        }
        field(52; "Eligible Hela Amount"; Decimal)
        {
            Caption = 'Eligible Hela Amount';
            DecimalPlaces = 0 : 2;
        }
        field(53; "Qualification Tier"; Option)
        {
            Caption = 'Qualification Tier';
            OptionCaption = 'Tier D,Tier C,Tier B,Tier A';
            OptionMembers = "Tier D","Tier C","Tier B","Tier A";
        }
        field(54; "Risk Category"; Option)
        {
            Caption = 'Risk Category';
            OptionCaption = 'Very High Risk,High Risk,Moderate Risk,Low Risk,Very Low Risk';
            OptionMembers = "Very High Risk","High Risk","Moderate Risk","Low Risk","Very Low Risk";
        }
        field(55; "Is Qualified"; Boolean)
        {
            Caption = 'Is Qualified';
        }
        field(60; "Computed By"; Code[50])
        {
            Caption = 'Computed By';
        }
        field(61; "Computed At"; DateTime)
        {
            Caption = 'Computed At';
        }
        field(62; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
        field(63; "Calculation Version"; Code[20])
        {
            Caption = 'Calculation Version';
        }
        field(64; "Months With Deposits"; Integer)
        {
        }
        field(65; "Total Months Evaluated"; Integer)
        {
        }
        field(66; "Savings Consistency %"; Decimal)
        {
        }
        field(67; "Total Topups"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Member No", "Evaluation Date")
        {
        }
        key(Key2; "Final Score")
        {
        }
        key(Key3; "Evaluation Date", "Final Score")
        {
        }
        key(Key4; "Is Qualified", "Final Score")
        {
        }
    }

    fieldgroups
    {
    }
}
