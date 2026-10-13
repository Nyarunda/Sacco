


enum 50017 "Marital Status Enum"
{
    Extensible = true;

    value(0; "")
    {
    }
    value(1; Single)
    {
    }
    value(2; Married)
    {
    }
    value(3; Divorced)
    {
    }
    value(4; Widowed)
    {
    }
}

enum 50018 "Member Status Enum"
{
    Extensible = true;
    value(0; " ")
    {
    }
    value(1; Active)
    {
    }
    value(2; Dormant)
    {
    }
    value(3; "Withdrawal Application")
    {
    }
    value(4; Withdrawn)
    {
    }
    value(5; Deceased)
    {
    }
    value(6; "Closed")
    {
    }
    value(7; New)
    {
    }
    value(8; Fraud)
    {
    }
    value(9; Defaulter)
    {
    }
}

enum 50019 "New Member Type Enum"
{
    Extensible = true;

    value(0; Person)
    {
    }
    value(1; Joint)
    {
    }
    value(2; Group)
    {
    }
    value(3; Institution)
    {
    }
}

enum 50063 "Next Of Kin Relationship Enum"
{
    Extensible = true;

    value(0; "")
    {
    }
    value(1; Father)
    {
    }
    value(2; Mother)
    {

    }
    value(3; Brother)
    {

    }
    value(4; Sister)
    {
    }
    value(5; Uncle)
    {
    }
    value(6; Aunt)
    {
    }
    value(7; Cousin)
    {
    }
    value(8; "Grand Father")
    {
    }
    value(9; "Grand Mother")
    {
    }
    value(10; Relative)
    {
    }
    value(11; Other)
    {
    }
}

enum 50064 "Credit Status Enum"
{
    value(0; "") { }
    value(1; Active) { }
    value(2; Defaulter) { }
    value(3; "Cleared") { }

}
enum 50065 "Recruited By Type"
{
    value(0; "") { }
    value(1; Walkins) { }
    value(2; Member) { }
    value(3; Staff) { }
    value(4; Marketer) { }
}
//' ',Active,Retired,Resigned,Dismissed,Suspended 
enum 50067 "Job Status Enum"
{
    Extensible = true;

    value(0; "") { }
    value(1; Active) { }
    value(2; Retired) { }
    value(3; Resigned) { }
    value(4; Dismissed) { }
    value(5; Suspended) { }
}
enum 50075 "Member Category Enum"
{
    Extensible = true;
    value(0; Member) { }
    value(1; Staff) { }
    value(2; Board) { }
}

enum 50076 "Approval Status Enum"
{
    value(0; Open) { }
    value(1; Pending) { }
    value(2; Approved) { }
    value(3; Rejected) { }
}

enum 50077 "Product Category Enum"
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Registration Fee") { }
    value(2; "Share Capital") { }
    value(3; "Deposit Contribution") { }
    value(4; "Benevolent Fund") { }
    value(5; "Fixed Deposit") { }
    value(6; "Dividend Account") { }
    value(7; "Junior Savings") { }
    value(8; "Holiday Savings") { }
    value(9; "Micro Member Deposit") { }
    value(10; "Micro Group Deposit") { }
    value(11; "Ordinary Savings") { }

}

enum 50078 "Account Status Enum"
{
    Extensible = true;

    value(0; Active) { }
    value(1; Dormant) { }
    value(2; Closed) { }
    value(3; Frozen) { }
    value(4; Deceased) { }
    value(5; Withdrawn) { }
    value(6; New) { }
    value(7; Fraud) { }
    value(8; "Withdrawal Application") { }
}
enum 50092 "HR Lookup Values Enum"
{
    Extensible = true;

    value(0; "") { }
    value(1; Religion) { }
    value(2; Language) { }
    value(3; "Contract Type") { }
    value(4; "Qualification Type") { }
    value(5; Grade) { }
    value(6; Tribe) { }
    value(7; "Training Cost Item") { }
    value(8; Institution) { }
    value(9; "Appraisal Type") { }
    value(10; "Appraisal Period") { }
    value(11; Urgency) { }
    value(12; Succession) { }
    value(13; Security) { }
    value(14; "Disciplinary Case Rating") { }
    value(15; "Disciplinary Case") { }
    value(16; "Disciplinary Action") { }
    value(17; "Next of Kin") { }
    value(18; Country) { }
    value(19; "Checklist Item") { }
    value(20; "Appraisal Sub Category") { }
    value(21; "Appraisal Group Item") { }
    value(22; "Transport Type") { }
    value(23; "Grievance Cause") { }
    value(24; "Grievance Outcome") { }
    value(25; "Appraiser Recom") { }
    value(26; "Job Group") { }
    value(27; "Ethnic Origin") { }
    value(28; "Interview Areas") { }
    value(29; Competency) { }
    value(30; "Appraisal Pillar") { }
    value(31; "Appraisal Core Values") { }
    value(32; "Performance Rating Scale") { }

}

enumextension 50079 GenJournalLineAccountType extends "Gen. Journal Account Type"
{
    value(50000; Savings)
    {
    }
    value(50001; Credit)
    {
    }
}

enumextension 50081 GenJournalLineSourceType extends "Gen. Journal Source Type"
{
    value(50000; Savings)
    {
    }
    value(50001; Credit)
    {
    }
}

enum 50082 "Transaction Type Enum"
{
    Extensible = true;


    value(50000; " ") { }
    value(50001; "Loan Disbursement") { }
    value(50002; "Principal Repayment") { }
    value(50003; "Interest Due") { }
    value(50004; "Interest Paid") { }
    value(50005; "Appraisal Due") { }
    value(50006; "Appraisal Paid") { }
    value(50007; "Penalty Due") { }
    value(50008; "Penalty Paid") { }
    value(50009; "Partial Disbursement") { }
    value(50010; "Insurance Due") { }
    value(50011; "Insurance Paid") { }
}

enum 50083 "SMS Source Enum"
{
    Extensible = true;
    value(50001; "New Member") { }
    value(50002; "New Account") { }
    value(50003; "Loan Approval") { }
    value(50004; "Deposit Confirmation") { }
    value(50005; "Cash Withdrawal Confirm") { }
    value(50006; "Loan Application") { }
    value(50007; "Loan Appraisal") { }
    value(50008; "Loan Guarantors") { }
    value(50009; "Loan Rejected") { }
    value(50010; "Loan Posted") { }
    value(50011; "Loan defaulted") { }
    value(50012; "Salary Processing") { }
    value(50013; "Teller Cash Deposit") { }
    value(50014; "Teller Cash Withdrawal") { }
    value(50015; "Teller Cheque Deposit") { }
    value(50016; "Fixed Deposit Maturity") { }
    value(50017; "InterAccount Transfer") { }
    value(50018; "Account Status") { }
    value(50019; "Status Order") { }
    value(50020; "EFT Effected") { }
    value(50021; "ATM Application Failed") { }
    value(50022; "ATM Collection") { }
    value(50023; MBanking) { }
    value(50024; "Member Changes") { }
    value(50025; "Cashier Below Limit") { }
    value(50026; "Cashier Above Limit") { }
    value(50027; "Chq Book") { }
    value(50028; "Bankers Cheque") { }
    value(50029; "Teller Cheque Transfer") { }
    value(50030; "Defaulter Loan Issued") { }
    value(50031; Bonus) { }
    value(50032; Bulk) { }
    value(50033; "Standing Order") { }
    value(50034; "Loan Bill Due") { }
    value(50035; "POS Deposit") { }
    value(50036; "Mini Bonus") { }
    value(50037; "Leave Application") { }
    value(50038; "Loan Witness") { }
    value(50039; PV) { }
    value(50040; PIN) { }
    value(50041; "Loan Reminder") { }
    value(50042; "Account Dormancy") { }
    value(50043; "Sky Agency") { }
    value(50044; "Spotcash Agency") { }
    value(50045; Dividends) { }
    value(50046; Birthday) { }
    value(50047; GFE) { }
    value(50048; AGM) { }
    value(50049; "Defaulter Recovery") { }
    value(50050; Coop) { }
    value(50051; PORTAL) { }
    value(50052; SkyMobile) { }
    value(50053; "Savings Interest") { }

}

enumextension 50113 "Workflow Approval Limit Type" extends "Workflow Approval Limit Type"
{

    value(50002; "Tiered Limits") { }
}

enumextension 50084 "Approval Document Type Ext" extends "Approval Document Type"
{
    value(50000; "Tracker") { }
    value(50001; "Member Application") { }
    value(50002; "Loan Application") { }
    value(50003; "Savings Application") { }
    value(50004; FDR) { }
    value(50005; "Def. Recovery") { }
    value(50006; "Loan Changes") { }
    value(50007; "Guarantor Sub.") { }
    value(50008; "Member Exit") { }
    value(50009; "Member Exit Notice") { }
    value(50010; "Member Changes") { }
    value(50011; STO) { }
    value(50012; "Cheque Book App") { }
    value(50013; "Account Transfer") { }
    value(50014; "Teller Transaction") { }
    value(50015; "Micro Transaction") { }
    value(50016; PV) { }
    value(50017; "Petty Cash") { }
    value(50018; "Collateral Register") { }
    value(50019; "Collateral Return") { }
    value(50020; "CheckOff") { }
    value(50022; Overdraft) { }
    value(50023; Imprest) { }
    value(50024; "Imprest Surrender") { }
    value(50025; Teller) { }
    value(50026; "Mbanking Application") { }
    value(50027; Leave) { }
    value(50028; "Loan Batch") { }
    value(50029; "HR Jobs") { }
    value(50030; "HR Job Requisition") { }
    value(50031; "Purchase Requisition") { }
    value(50050; "Bankers Cheque Application") { }

}


enumextension 50085 "Workflow Appr Limit Type Ext" extends "Workflow Approver Limit Type"
{
    value(50001; "Self Approver") { }
}


enumextension 50013 "Purchase Document Ext" extends "Purchase Document Type"
{
    value(50001; "Purchase Requisition") { }
    value(50002; "Fuel Requisition") { }
}


Enum 50086 "Creditor Type Enum"
{
    value(50001; " ") { }
    value(50002; "Supplier") { }
    value(50003; "FOSA") { }
}

Enum 50087 "Repay Mode Enum"
{
    Caption = 'Loan Repayment Points';

    value(50001; " ") { Caption = ''; }
    value(50002; "Salary") { }
    value(50003; "Milk") { }
    value(50004; "Tea") { }
    value(50005; "Staff Salary") { }
    value(50006; "Business") { Caption = 'Date Based'; }
    value(50007; "Check Off") { }
    value(50008; "Dividends") { }
    value(50009; "Internal Standing Order") { }
    value(50010; "External Standing Order") { }
    value(50011; "Pension") { }
    value(50012; "Bonus") { }
    value(50013; "Mini-Bonus") { }
    value(50014; Allowance) { }
    value(50015; Cash) { }
    value(50016; Property) { }
    value(50017; "Direct Debit") { }
    value(50018; PloughBack) { }

}

Enum 50088 "How Did You Know About Us Enum"
{
    value(50001; " ") { }
    value(50002; "Newspapaer") { }
    value(50003; "Radio") { }
    value(50004; "Television") { }
    value(50005; "Advert") { }
    value(50006; "Website") { }
    value(50007; "Facebook") { }
    value(50008; "Tweeter") { }
    value(50009; "Another member") { }
    value(50010; "Sales Representative") { }
    value(50011; "Staff") { }
    value(50012; "Others") { }
}

Enum 50093 "Beneficiary Enum"
{
    value(50001; " ") { }
    value(50002; "Member") { }
    value(50003; "Spouse") { }
    value(50004; "Children") { }
    value(50005; "Other Beneficiary") { }
}

Enum 50111 "Employer Type"
{
    value(50001; " ") { }
    value(50003; Checkoff) { }
    value(50005; Salary) { }
    value(50008; "Staff Advance") { }
    value(50009; Imprest) { }
    value(50010; Investment) { }
    value(50011; Tenant) { }
}

Enum 50113 "BBF Claim Type"
{
    value(50001; " ") { }
    value(50003; Death) { }
    value(50005; "Medical Claim") { }
}

Enum 50114 "Transaction Channel"
{
    value(50001; " ") { }
    value(50002; Agency) { }
    value(50003; Mobile) { }
    value(50005; ATM) { }
    value(50007; USSD) { }
    value(50009; Teller) { }
    value(50010; "Account Transfer") { }
    value(50011; Recovery) { }
    value(50012; Receipt) { }
    value(50013; Restructure) { }
    value(50014; Salary) { }
    value(50015; STO) { }
    value(50016; Offset) { }
    value(50017; Portal) { }
    value(50018; "COOP ATM") { }
    value(50019; "Bank Transfer") { }
    value(50020; "Member Exit") { }
    value(50021; PV) { }
    value(50022; Loan) { }
    value(50023; Defaulter) { }
    value(50024; "Loan Changes") { }
    value(50025; "Interest Billing") { }
    value(50026; Dividends) { }
    value(50027; "Sacco Journal") { }
    value(50028; Treasury) { }
    value(50029; Checkoff) { }
    value(50030; Overdraft) { }
    value(50031; Benevolent) { }
    value(50032; "Cash Withdrawal") { }
    value(50033; "Cash Deposit") { }
    value(50034; "Cheque Deposit") { }
    value(50035; "Bankers Cheque Withdrawal") { }
    value(50036; "Credit Receipt") { }
    value(50037; "Credit Cheque") { }
    value(50038; "Stop Cheque") { }
    value(50039; "Cheque Discounting") { }
    value(50040; "Teller Mpesa") { }
    value(50041; "Cheque Withdrawal") { }
    value(50042; "Fixed Deposit") { }
    value(50043; "Bal") { }
    value(50044; "Withdrawal") { }
    value(50045; "Paybill") { }
    value(50046; "Loan Repayment") { }
    value(50047; "MDeposit") { }
    value(50048; "BDeposit") { }
    value(50049; "Pay Loan From Account") { }
    value(50050; "Bank Agent Deposit") { }
    value(50051; "Mobile Loan") { }
    value(50052; "Open Balance") { }
    value(50053; "Bank FD") { }
    value(50054; "Direct Debit") { }
    value(50055; "Share Transfer") { }
    value(50056; "FOSA Interest") { }
    value(50057; "Coop B2B") { }
    value(50058; "Coop P2F") { }
    value(50059; "Distribution") { }
    value(50060; "Insurance Billing") { }
    value(50061; "Penalty Billing") { }
}

Enum 50115 "Commission Type"
{
    value(50001; "Walk In") { }
    value(50002; Marketer) { }
    value(50003; Staff) { }
    value(50004; "Board Member") { }
    value(50005; Member) { }
    value(50010; Website) { }


}
Enum 50116 "Product Sub. Type"
{
    value(50000; " ") { }
    value(50001; MOVABLE) { }
    value(50002; IMMOVABLE) { }
}

Enum 50118 "Penalty Calculation Method"
{

}

Enum 50119 "Schedule Start"
{
    value(5000; " ") { }
    value(5010; "On 1st") { }
    value(50000; "On 5th") { }
    value(50001; "On 10th") { }
    value(50002; "On 15th") { }
    value(50003; "On 20th") { }
    value(50004; "On 25th") { }
    value(50005; "On 30th") { }
}

Enum 50121 "Vendor Type"
{
    value(50001; " ") { }
    value(50003; Valuer) { }
    value(50005; Lawyer) { }
    value(50006; "Debtor Collector") { }
    value(50007; Tracker) { }
    value(50008; Training) { }
}

Enum 50122 "Member Classes"
{
    value(50001; " ") { }
    value(50003; "CLASS A") { }
    value(50005; "CLASS B") { }
    value(50006; "CLASS C") { }
    value(50007; "CLASS D") { }
    value(50008; "CLASS E") { }
}

Enum 50123 "File Movement Type"
{
    value(50001; " ") { }
    value(50003; "File Movement") { }
}
Enum 50124 "Notice Type"
{
    value(50001; " ") { }
    value(50002; "Notice 1") { }
    value(50003; "Notice 2") { }
    value(50004; "Notice 3") { }
}


enum 50567 "Sky M-Banking Trans Types"
{
    Extensible = true;

    value(0; " ") { Caption = 'Blank'; }
    value(1; "Account Balance Enquiry") { Caption = 'Account Balance Enquiry'; }
    value(2; "Account Mini-Statement") { Caption = 'Account Mini-Statement'; }
    value(3; "Account Full-Statement") { Caption = 'Account Full-Statement'; }
    value(4; "Loan Balance Enquiry") { Caption = 'Loan Balance Enquiry'; }
    value(5; "Loan Mini-Statement") { Caption = 'Loan Mini-Statement'; }
    value(6; "Loan Full-Statement") { Caption = 'Loan Full-Statement'; }
    value(7; "Mpesa Deposit") { Caption = 'Mpesa Deposit'; }
    value(8; "Mpesa Withdrawal") { Caption = 'Mpesa Withdrawal'; }
    value(9; "Loan Repayment") { Caption = 'Loan Repayment'; }
    value(10; "Pay Loan From Account") { Caption = 'Pay Loan From Account'; }
    value(11; "Bank Transfer") { Caption = 'Bank Transfer'; }
    value(12; "Utility Payment") { Caption = 'Utility Payment'; }
    value(13; "Airtime") { Caption = 'Airtime Purchase'; }
    value(14; "Account Transfer") { Caption = 'Account Transfer'; }
    value(15; "Loan Disbursement") { Caption = 'Loan Disbursement'; }
    value(16; "External Bank Transfer") { Caption = 'External Bank Transfer'; }

}


enum 50128 "CRB Report Type"
{
    Extensible = false;
    value(0; "Identity Verification")
    {
    }
    value(1; "Delinquency Status")
    {
    }
    value(2; "Credit Score")
    {
    }
    value(3; "PDF Report")
    {
    }
    value(4; "JSON Report")
    {
    }
    value(5; "Identity Scrub")
    {
    }
    value(6; "Credit Info")
    {
    }
    value(7; "Enhanced Credit Info")
    {
    }
    value(8; "Enhanced Credit Info Mobile")
    {
    }
    value(9; "Full Enhanced Credit Info")
    {
    }
    value(10; "Minified Credit Info")
    {
    }
    value(11; "Full JSON Report")
    {
    }
    value(12; "Credit Accounts Summary")
    {
    }
    value(13; "Accounts Info History")
    {
    }
}

enum 50133 "Loan Source"
{
    Extensible = true;
    value(0; " ")
    {
        Caption = ' ';
    }

    value(1; "Loan Application")
    {
        Caption = 'Loan Application';
    }

    value(2; Regstration)
    {
        Caption = 'Regstration';
    }

    value(3; Guarantor)
    {
        Caption = 'Guarantor';
    }

    value(4; "Partial Letter")
    {
        Caption = 'Partial Letter';
    }
}

enum 50129 "Bulk Sms Filter Type"
{
    Extensible = true;

    value(0; None)
    {
        Caption = ' ';
    }

    value(1; DormantWithDeposits)
    {
        Caption = 'Dormant with Deposits';
    }

    value(2; MembersWithOutLoans)
    {
        Caption = 'Members With Out Loans';
    }

    value(3; MemberWithLoanBalance)
    {
        Caption = 'Member with Loan Bal';
    }

    value(4; MemberActiveWithDeposits)
    {
        Caption = 'Active Member with Deposits';
    }

    value(5; MemberActiveWithNoDeposits)
    {
        Caption = 'Active Member with No Deposits';
    }

    value(6; JuniorAccount)
    {
        Caption = 'Junior Account';
    }

    value(7; MemberWithFixedDeposits)
    {
        Caption = 'Fixed Deposits';
    }

    value(8; ActiveMemberFosaAccount)
    {
        Caption = 'Active Member Fosa Account';
    }

    value(9; DormantMemberWithFosaAccount)
    {
        Caption = 'Dormant Member With Fosa Acc';
    }

    value(10; HolidaySavings)
    {
        Caption = 'Holiday Savings';
    }
}
