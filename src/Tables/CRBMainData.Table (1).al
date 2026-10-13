Table 50543 "CRB Main Data"
{

    fields
    {
        field(1; Surname; Text[100])
        {
        }
        field(2; "Name 2"; Text[100])
        {
        }
        field(3; "Name 3"; Text[100])
        {
        }
        field(4; "Name 4"; Text[100])
        {
        }
        field(5; Salutation; Code[10])
        {
        }
        field(6; "Date of Birth"; Text[30])
        {
        }
        field(7; "Client Code"; Code[20])
        {
        }
        field(8; "Account No."; Code[20])
        {
        }
        field(9; Gender; Code[1])
        {
        }
        field(10; Nationality; Code[10])
        {
        }
        field(11; "Marital Status"; Code[1])
        {
        }
        field(12; "Primary Identification Code"; Code[3])
        {
        }
        field(13; "Primary Identification 1"; Code[100])
        {
        }
        field(14; "Secondary Identification Code"; Code[3])
        {
        }
        field(15; "Secondary Identification 1"; Code[100])
        {
        }
        field(16; "Other Identification Code"; Code[3])
        {
        }
        field(17; "Other Identification 1"; Code[100])
        {
        }
        field(18; "Mobile No."; Code[100])
        {
        }
        field(19; "Home Telephone"; Code[100])
        {
        }
        field(20; "Work Telephone"; Code[100])
        {
        }
        field(21; "Postal Address 1"; Text[100])
        {
        }
        field(22; "Postal Address 2"; Text[100])
        {
        }
        field(23; "Postal Location Town"; Text[100])
        {
        }
        field(24; "Postal Location Country"; Text[100])
        {
        }
        field(25; "Post Code"; Code[100])
        {
        }
        field(26; "Physical Address 1"; Text[100])
        {
        }
        field(27; "Physical Address 2"; Text[100])
        {
        }
        field(28; "Plot No."; Text[100])
        {
        }
        field(29; "Location Town"; Text[100])
        {
        }
        field(30; "Location Country"; Text[100])
        {
        }
        field(31; "Date of Physical Address"; Text[100])
        {
        }
        field(32; "PIN No."; Text[100])
        {
        }
        field(33; "Customer Work Email"; Text[100])
        {
        }
        field(34; "Employer Name"; Text[100])
        {
        }
        field(35; "Employer Industry Type"; Text[100])
        {
        }
        field(36; "Employment Date"; Text[100])
        {
        }
        field(37; "Employment Type"; Text[100])
        {
        }
        field(38; "Salary Band"; Text[100])
        {
        }
        field(39; "Lenders Registered Name"; Text[100])
        {
        }
        field(40; "Lenders Trading Name"; Text[100])
        {
        }
        field(41; "Lenders Branch Name"; Text[100])
        {
        }
        field(42; "Lenders Branch Code"; Text[100])
        {
        }
        field(43; "Account Type"; Code[100])
        {
        }
        field(44; "Account Product Type"; Code[100])
        {
        }
        field(45; "Date Account Opened"; Text[100])
        {
        }
        field(46; "Installment Due Date"; Text[100])
        {
        }
        field(47; "Original Amount"; Text[100])
        {
        }
        field(48; "Currency of Facilty"; Text[100])
        {
        }
        field(49; "Amount in KSHs"; Text[100])
        {
        }
        field(50; "Current Balance"; Text[100])
        {
        }
        field(51; "Overdue Balance"; Text[100])
        {
        }
        field(52; "Overdue Date"; Text[100])
        {
        }
        field(53; "No. of Days in Arrears"; Integer)
        {
        }
        field(54; "No. of Installments in Arrears"; Integer)
        {
        }
        field(55; "Performing/NPL Indicator"; Code[1])
        {
        }
        field(56; "Account Status"; Code[1])
        {
        }
        field(57; "Account Status Date"; Text[100])
        {
        }
        field(58; "Account Closure Reason"; Text[100])
        {
        }
        field(59; "Repayment Period"; Integer)
        {
        }
        field(60; "Deferred Payment Date"; Text[100])
        {
        }
        field(61; "Deferred Payment"; Text[100])
        {
        }
        field(62; "Payment Frequency"; Text[100])
        {
        }
        field(63; "Disbursement Date"; Text[100])
        {
        }
        field(64; "Installment Amount"; Text[100])
        {
        }
        field(65; "Date of Latest Payment"; Text[100])
        {
        }
        field(66; "Last Payment Amount"; Text[100])
        {
        }
        field(67; "Type of Security"; Code[1])
        {
        }
        field(68; "No."; Integer)
        {
        }
        field(69; "Guarantee Type"; Code[1])
        {
        }
        field(70; "Group Name"; Text[100])
        {
        }
        field(71; "Guarantor Relationship"; Code[1])
        {
        }
        field(72; "Guarantee Limit"; Text[100])
        {
        }
        field(73; "Client Type"; Option)
        {
            OptionCaption = 'Loanee,Guarantor';
            OptionMembers = Loanee,Guarantor;
        }
        field(74; "Scheduled Payment"; Text[30])
        {
        }
        field(75; "Amount Paid"; Text[30])
        {
        }
        field(76; "Update Date of Birth"; Text[30])
        {
        }
        field(77; "Update Original Amount"; Text[30])
        {
        }
        field(78; "Update Amount Paid"; Text[30])
        {
        }
        field(79; "Update Current Balance"; Text[30])
        {
        }
        field(80; "Update Date of Last Payment"; Text[30])
        {
        }
        field(81; "Update Overdue Balance"; Text[30])
        {
        }
        field(82; "Update Scheduled Payment"; Text[30])
        {
        }
        field(83; MemberNo; code[30])
        {
            //TableRelation = Members where(Type = const(Member));
        }
        field(84; "annual_turnover_band"; Text[30])
        {
        }
        field(85; "country"; Text[30])
        {
        }
        field(86; "industry_code"; Text[30])
        {
        }
        field(87; "number_of_shares"; Text[30])
        {
        }
        field(88; "previous_registration_number"; Text[30])
        {
        }
        field(89; "trading_status"; Text[30])
        {
        }
        field(90; "vat_number"; Text[30])
        {
        }
        field(91; "trading_status_date"; Text[30])
        {
        }
        field(92; "town"; Text[30])
        {
        }
        field(93; "registration_date"; Text[30])
        {
        }
        field(94; "registration_number"; Text[30])
        {
        }
        field(95; "security_type"; Text[30])
        {
        }
        field(96; "snapshot_date"; Text[30])
        {
        }
        field(97; "HeaderNo"; Integer)
        {
        }
        field(98; "Old Account Number"; Code[20])
        {
        }
        field(99; "Passport Country Code"; Code[30])
        {
        }
        field(100; "Group ID"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

