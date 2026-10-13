
Table 50279 "Status Change Permissions"
{

    fields
    {
        field(1; "User ID"; Code[80])
        {
            Caption = 'User ID.';
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(48; "Reset Mpesa Pin"; Boolean)
        {
        }
        field(49; "Update Paybill Transaction"; Boolean)
        {
        }
        field(50000; "Update Transactional Mobile No"; Boolean)
        {
        }
        field(50050; "Sky Mobile Setups"; Boolean)
        {
        }
        field(50051; "Reverse Sky Transactions"; Boolean)
        {
        }
        field(50052; "Black-List Accounts"; Boolean)
        {
        }
        field(50056; "Update MPESA Withdrawal"; Boolean)
        {
        }
        field(50060; "View BlackListed Accounts"; Boolean)
        {
        }
        field(50062; "Clear Transactional Mobile"; Boolean)
        {
        }
        field(50065; "Reverse Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Reverse Cheques"; Boolean)
        {
        }
        field(3; "Clear Lien"; Boolean)
        {
        }
        field(4; "Process POS"; Boolean)
        {
        }
        field(5; "Mark Loan As Posted"; Boolean)
        {
        }
        field(6; "Update Product Factory"; Boolean)
        {
        }
        field(7; "Re-Open Bankers Cheque"; Boolean)
        {
        }
        field(8; "Allow Defaulter Guarantorship"; Boolean)
        {
        }
        field(9; "Re-Open Cashier Transaction"; Boolean)
        {
        }
        field(10; "Change Schedule Start Date"; Boolean)
        {
        }
        field(11; "Allow Defaulter Loanee"; Boolean)
        {
        }
        field(12; "Edit Chart of Accounts"; Boolean)
        {
        }
        field(13; "Update Loan Recommended By"; Boolean)
        {
        }
        field(14; "Update Partial Disbursement"; Boolean)
        {
        }
        field(15; "Cheque Discounting"; Boolean)
        {
        }
        field(16; "Process Fixed Deposit"; Boolean)
        {
        }
        field(17; "Allow More Business Loans"; Boolean)
        {
        }
        field(18; "Initiate MPESA Change"; Boolean)
        {
        }
        field(19; "Effect MPESA Change"; Boolean)
        {
        }
        field(20; "Initiate PIN Change"; Boolean)
        {
        }
        field(21; "Issue Nominee Card"; Boolean)
        {
        }
        field(22; "Update POS Transaction"; Boolean)
        {
        }
        field(23; "Charge Account Statement"; Boolean)
        {
        }
        field(24; "Exempt Guarantor Blocking"; Boolean)
        {
        }
        field(25; "Update Posted Loan"; Boolean)
        {
        }
        field(26; "Update Loan Disb. Account"; Boolean)
        {
        }
        field(27; "Unblock Guarantors"; Boolean)
        {
        }
        field(28; "General PV"; Boolean)
        {
        }
        field(29; "Board PV"; Boolean)
        {
        }
        field(30; "Staff PV"; Boolean)
        {
        }
        field(31; "Petty Cash Voucher"; Boolean)
        {
        }

        field(50053; "Post Penalty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Monthly Contributions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Post Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "Move Creditor Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Edit User SetUp"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Edit Product Factory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Edit Member Categoty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Edit General Setups"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "HR Special"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Edit Member Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "View Next of Kin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Edit Workplan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "View Staff A/c"; Boolean)
        {

        }
        field(50066; "Post Bank Rec"; Boolean)
        {

        }
        field(50067; "Post Store Requisition"; Boolean)
        {

        }
        field(50068; "Run Xml Ports"; Boolean)
        {

        }
        field(50069; "View Post POS"; Boolean)
        {

        }
        field(50070; "BoardRoom Booking"; Boolean)
        {

        }
        field(50071; "Finance Setups"; Boolean)
        {

        }
        field(50072; "General Setups"; Boolean)
        {

        }
        field(50073; "Run Depreciation"; Boolean)
        { }
        field(50074; "Edit Deceased Members"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RestrictAccess(UserId);
    end;

    trigger OnInsert()
    begin
        //RestrictAccess(USERID);
    end;

    trigger OnModify()
    begin
        //RestrictAccess(USERID);
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        Temp: Record "User Setup";


    procedure RestrictAccess(UserNo: Code[100])
    var
        StatusPermission: Record "Status Change Permissions";
        ErrorOnRestrictViewTxt: label 'You do not have permissions to MODIFY or DELETE on this Page. Contact your system administrator for further details';
    begin
        //StatusPermission.RESET;
        //StatusPermission.SETRANGE("User ID",UserNo);
        //StatusPermission.SETRANGE("Edit Setup",TRUE);
        //IF NOT StatusPermission.FIND('-') THEN BEGIN
        // ERROR(ErrorOnRestrictViewTxt);
        //  END;
    end;
}

