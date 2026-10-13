/// <summary>
/// Page Status Change Permissions (ID 50323).
/// </summary>
page 50323 "Status Change Permissions"
{
    ApplicationArea = All;
    // StatusChangePermissions.RESET;
    // StatusChangePermissions.SETRANGE("User ID",USERID);
    // StatusChangePermissions.SETRANGE("Re-Open Cashier Transaction",TRUE);
    // IF NOT StatusChangePermissions.FINDFIRST THEN
    //   ERROR('You do not have the following Status Change Permission: "Re-Open Cashier Transaction". Contact the System Administrator for Assistance');

    PageType = List;
    SourceTable = "Status Change Permissions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Reverse Cheques"; Rec."Reverse Cheques")
                {
                    ApplicationArea = All;
                }
                field("Clear Lien"; Rec."Clear Lien")
                {
                    ApplicationArea = All;
                }
                field("Process POS"; Rec."Process POS")
                {
                    ApplicationArea = All;
                }
                field("Mark Loan As Posted"; Rec."Mark Loan As Posted")
                {
                    ApplicationArea = All;
                }
                field("Update Product Factory"; Rec."Update Product Factory")
                {
                    ApplicationArea = All;
                }
                field("Re-Open Bankers Cheque"; Rec."Re-Open Bankers Cheque")
                {
                    ApplicationArea = All;
                }
                field("Allow Defaulter Guarantorship"; Rec."Allow Defaulter Guarantorship")
                {
                    ApplicationArea = All;
                }
                field("Re-Open Cashier Transaction"; Rec."Re-Open Cashier Transaction")
                {
                    ApplicationArea = All;
                }
                field("Change Schedule Start Date"; Rec."Change Schedule Start Date")
                {
                    ApplicationArea = All;
                }
                field("Allow Defaulter Loanee"; Rec."Allow Defaulter Loanee")
                {
                    ApplicationArea = All;
                }
                field("Update Loan Recommended By"; Rec."Update Loan Recommended By")
                {
                    ApplicationArea = All;
                }
                field("Update Partial Disbursement"; Rec."Update Partial Disbursement")
                {
                    ApplicationArea = All;
                }
                field("Cheque Discounting"; Rec."Cheque Discounting")
                {
                    ApplicationArea = All;
                }
                field("Process Fixed Deposit"; Rec."Process Fixed Deposit")
                {
                    ApplicationArea = All;
                }
                field("Allow More Business Loans"; Rec."Allow More Business Loans")
                {
                    ApplicationArea = All;
                }
                field("Initiate MPESA Change"; Rec."Initiate MPESA Change")
                {
                    ApplicationArea = All;
                }
                field("Effect MPESA Change"; Rec."Effect MPESA Change")
                {
                    ApplicationArea = All;
                }
                field("Initiate PIN Change"; Rec."Initiate PIN Change")
                {
                    ApplicationArea = All;
                }
                field("Issue Nominee Card"; Rec."Issue Nominee Card")
                {
                    ApplicationArea = All;
                }
                field("Update POS Transaction"; Rec."Update POS Transaction")
                {
                    ApplicationArea = All;
                }
                field("Charge Account Statement"; Rec."Charge Account Statement")
                {
                    ApplicationArea = All;
                }
                field("Exempt Guarantor Blocking"; Rec."Exempt Guarantor Blocking")
                {
                    ApplicationArea = All;
                }
                field("Update Posted Loan"; Rec."Update Posted Loan")
                {
                    ApplicationArea = All;
                }
                field("Update Loan Disb. Account"; Rec."Update Loan Disb. Account")
                {
                    ApplicationArea = All;
                }
                field("Unblock Guarantors"; Rec."Unblock Guarantors")
                {
                    ApplicationArea = All;
                }
                field("General PV"; Rec."General PV")
                {
                    ApplicationArea = All;
                }
                field("Board PV"; Rec."Board PV")
                {
                    ApplicationArea = All;
                }
                field("Staff PV"; Rec."Staff PV")
                {
                    ApplicationArea = All;
                }
                field("Petty Cash Voucher"; Rec."Petty Cash Voucher")
                {
                    ApplicationArea = All;
                }
                field("Reset Mpesa Pin"; Rec."Reset Mpesa Pin")
                {
                    ApplicationArea = All;
                }
                field("Update Paybill Transaction"; Rec."Update Paybill Transaction")
                {
                }
                /*field("Process Staff Payroll"; Rec."Process Staff Payroll")
                {
                    ApplicationArea = All;
                }*/
                field("Reverse Transactions"; Rec."Reverse Transactions")
                {
                    ApplicationArea = All;
                }
                field("Black-List Accounts"; Rec."Black-List Accounts")
                {
                    ApplicationArea = All;
                }
                field("Post Penalty"; Rec."Post Penalty")
                {
                    ApplicationArea = All;
                }
                field("Monthly Contributions"; Rec."Monthly Contributions")
                {
                    ApplicationArea = All;
                }
                field("Post Interest"; Rec."Post Interest")
                {
                    ApplicationArea = All;
                }
                field("Move Creditor Member"; Rec."Move Creditor Member")
                {
                    ApplicationArea = All;
                }
                field("Edit User SetUp"; Rec."Edit User SetUp")
                {
                    ApplicationArea = All;
                }
                field("Edit Product Factory"; Rec."Edit Product Factory")
                {
                    ApplicationArea = All;
                }
                field("Edit Member Categoty"; Rec."Edit Member Categoty")
                {
                    ApplicationArea = All;
                }
                field("Edit General Setups"; Rec."Edit General Setups")
                {
                    ApplicationArea = All;
                }
                field("HR Special"; Rec."HR Special")
                {
                    ApplicationArea = All;
                }
                field("Edit Member Status"; Rec."Edit Member Status")
                {
                    ApplicationArea = All;
                }
                field("View Next of Kin"; Rec."View Next of Kin")
                {
                    ApplicationArea = All;

                }
                field("Edit Workplan"; Rec."Edit Workplan")
                {
                    ApplicationArea = All;
                }
                field("View Staff A/c"; Rec."View Staff A/c")
                {
                    ApplicationArea = All;
                }
                field("Post Bank Rec"; Rec."Post Bank Rec")
                {
                    ApplicationArea = All;
                }
                field("Post Store Requisition"; Rec."Post Store Requisition")
                {
                    ApplicationArea = All;
                }
                field("Run Xml Ports"; Rec."Run Xml Ports")
                {
                    ApplicationArea = All;
                }
                field("View Post POS"; Rec."View Post POS")
                {
                    ApplicationArea = All;
                }
                field("BoardRoom Booking"; Rec."BoardRoom Booking")
                {
                    ApplicationArea = All;
                }
                field("General Setups"; Rec."General Setups")
                {
                    ApplicationArea = All;
                }
                field("Finance Setups"; Rec."Finance Setups")
                {
                    ApplicationArea = All;
                }
                field("Run Depreciation"; Rec."Run Depreciation")
                {
                    ApplicationArea = All;
                }
                field("Edit Deceased Members"; Rec."Edit Deceased Members")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    trigger OnOpenPage()
    var
        Status: Record "Status Change Permissions";
    begin
        Status.Reset();
        Status.SetRange("User ID", UserId);
        if Status.Find('-') then
            Status.TestField("General Setups", true)
        else
            Message('Permissiom Error');
    end;
}

