
Table 50081 "Loan Appraisal"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members;
        }
        field(3; "Loan Disbursement Account"; Code[20])
        {
            TableRelation = "Savings Accounts" where("Member No." = field("Member No."));
        }
        field(4; Name; Text[150])
        {
        }
        field(5; "Product Code"; Code[20])
        {
            TableRelation = "Product Setup";
        }
        field(6; "Requested Amount"; Decimal)
        {
        }
        field(7; "Approved Amount"; Decimal)
        {
        }
        field(8; "Bosa Deposits"; Decimal)
        {
        }
        field(9; "Class B Deposits"; Decimal)
        {
        }
        field(10; "Total Deposits"; Decimal)
        {
        }
        field(11; "Current Loan Balance"; Decimal)
        {
        }
        field(12; Installments; Decimal)
        {
        }
        field(13; "Amount Guaranteed"; Decimal)
        {
        }
        field(14; "No. of Guarantors"; Decimal)
        {
        }
        field(15; "Salary Through Fosa"; Boolean)
        {
        }
        field(16; "Share Capital"; Decimal)
        {
        }
        field(17; "Branch Code"; Code[20])
        {
        }
        field(18; "Activity Code"; Code[20])
        {
        }
        field(19; "Previous Contribution"; Decimal)
        {
            Description = 'Deposits Analysis';
        }
        field(20; Deposits; Decimal)
        {
        }
        field(21; "Deposit Financing"; Decimal)
        {
        }
        field(22; "Deposit Multiplier"; Decimal)
        {
        }
        field(23; "Loan Outstanding"; Decimal)
        {
        }
        field(24; "Principle Top Up"; Decimal)
        {
        }
        field(25; "Maximum Credit"; Decimal)
        {
        }
        field(26; "Minimum Share Capital"; Decimal)
        {
            Description = 'Share Capital Analysis';
        }
        field(27; "Current Share Capital"; Decimal)
        {
        }
        field(28; "Deficit Share Capital"; Decimal)
        {
        }
        field(29; "Share Financing"; Decimal)
        {
        }
        field(30; "Average Income"; Decimal)
        {
            Description = 'Income Analysis';
        }
        field(31; Earnings; Decimal)
        {
        }
        field(32; Allowances; Decimal)
        {
        }
        field(33; Deductions; Decimal)
        {
        }
        field(34; "2/3 of Average Income"; Decimal)
        {
        }
        field(35; "Net Salary"; Decimal)
        {
        }
        field(36; "External Effects"; Decimal)
        {
        }
        field(37; "Adjusted Net"; Decimal)
        {
        }
        field(38; "Current Loan Repayment"; Decimal)
        {
        }
        field(39; "Interest Top Up"; Decimal)
        {
            Description = 'Net Take Home Calculation';
        }
        field(40; "Top Up Commission"; Decimal)
        {
        }
        field(41; "External Commitment"; Decimal)
        {
        }
        field(42; "External Commitment Commission"; Decimal)
        {
        }
        field(43; "Total Charges"; Decimal)
        {
        }
        field(44; "Net Take Home"; Decimal)
        {
        }
        field(45; "Qualification As Per Deposits"; Decimal)
        {
        }
        field(46; "Qualification as Per Income"; Decimal)
        {
        }
        field(47; "Qualification as Per Guarantor"; Decimal)
        {
        }
        field(48; "Entrance Fee"; Decimal)
        {
        }
        field(49; Multiplier; Decimal)
        {
        }
        field(50; "Recommended Amount"; Decimal)
        {
        }
        field(51; "Expected Bonus"; Decimal)
        {
        }
        field(52; "Outstanding Tea Bills"; Decimal)
        {
        }
        field(53; "Rate on Expected Bonus"; Decimal)
        {
        }
        field(54; "Micro Deposits"; Decimal)
        {
        }
        field(55; "Total Financing"; Decimal)
        {
        }
        field(56; "Top Up Appraisal"; Decimal)
        {
        }
        field(57; "Top Up Penalty"; Decimal)
        {
        }
        field(58; "Excise Duty"; Decimal)
        {
        }
        field(59; "Exisiting Loan Repayment"; Decimal)
        {
        }
        field(60; "Available Deposits"; Decimal)
        {
        }
        field(61; "Committed Deposits"; Decimal)
        {
        }
        field(62; "New Total Repayment"; Decimal)
        {
        }
        field(63; "1/3 of Average Income"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Last Deposit Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Last Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "STO Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Apraisal Check No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Refinance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Margin (Ref)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Business Income Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Current Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Net + Current Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "New Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "New Loan Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "New Total Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "New Net Take Home"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Uncharged Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Net Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Gross Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "1/3 of Gross"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "2/3 of Gross"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Current Loans Repayments"; Decimal)
        {
        }
        field(87; "Product Frequency"; Decimal)
        {
        }
        field(88; "Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(89; "Appraisal Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(90; "Boosting Commission"; Decimal)
        {
        }
        field(91; "Other Clearance Desc."; Text[100])
        {
        }

        field(92; "Sacco Deduction"; Decimal)
        {
        }
        field(93; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Total Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
         field(96; "Appraised By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Appraised On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(98 ; "Monthly Expenditure"; Decimal)
        {
            DataClassification = ToBeClassified;    
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

