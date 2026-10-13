page 50548 "User Permissions"
{
    ApplicationArea = All;
    Caption = 'User Permissions';
    PageType = Card;
    SourceTable = "User Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Allow Bank to Bank Trans"; Rec."Allow Bank to Bank Trans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Bank to Bank Trans field.';
                }
                field("HOD CSD"; Rec."HOD CSD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allows the user to approve member exit notices at HOD stage.';
                    Visible = true;
                }
                field("HOD Credit"; Rec."HOD Credit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allows the user to view and approve member exit notices at the HOD Credit stage.';
                    Visible = true;
                }
                /*        field("Allow Deferral Posting From";Rec."Allow Deferral Posting From")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the earliest date on which the user is allowed to post deferrals to the company.';
                        }
                        field("Allow Deferral Posting To";Rec."Allow Deferral Posting To")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the last date on which the user is allowed to post deferrals to the company.';
                        }
                        field("Allow FA Posting From";Rec."Allow FA Posting From")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Allow FA Posting From field.';
                        }
                        field("Allow FA Posting To";Rec."Allow FA Posting To")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Allow FA Posting To field.';
                        }
                        field("Allow Posting From";Rec."Allow Posting From")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the earliest date on which the user is allowed to post to the company.';
                        }
                        field("Allow Posting To";Rec."Allow Posting To")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the last date on which the user is allowed to post to the company.';
                        }
                        field("Approval Administrator";Rec."Approval Administrator")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the user who has rights to unblock approval workflows, for example, by delegating approval requests to new substitute approvers and deleting overdue approval requests.';
                        }
                        field("Approver ID";Rec."Approver ID")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the user ID of the person who must approve records that are made by the user in the User ID field before the record can be released.';
                        }
                        field("Board Account";Rec."Board Account")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Board Account field.';
                        }
                        field("Branch Manager";Rec."Branch Manager")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Branch Manager field.';
                        }
                        field("CashRec Journal Batch";Rec."CashRec Journal Batch")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the CashRec Journal Batch field.';
                        }
                        field("CashRec Journal Template";Rec."CashRec Journal Template")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the CashRec Journal Template field.';
                        }*/
                field("Credit Setups"; Rec."Credit Setups")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Setups field.';
                }
                /* field("Default Payment Bank";Rec."Default Payment Bank")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Default Payment Bank field.';
                 }
                 field("Default Petty Cash Bank";Rec."Default Petty Cash Bank")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Default Petty Cash Bank field.';
                 }
                 field("Default Receipt Bank";Rec."Default Receipt Bank")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Default Receipt Bank field.';
                 }
                 field("Disable SMS";Rec."Disable SMS")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Disable SMS field.';
                 }
                 field("E-Mail";Rec."E-Mail")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies the email address of the approver that you can use if you want to send approval mail notifications.';
                 }*/
                field("File Movement Admin"; Rec."File Movement Admin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Movement Admin field.';
                }

                /*  field("General Journal Batch";Rec."General Journal Batch")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the General Journal Batch field.';
                  }
                  field("General Journal Template";Rec."General Journal Template")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the General Journal Template field.';
                  }
                  field("General Setups";Rec."General Setups")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the General Setups field.';
                  }
                  field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                  }
                  field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                  }
                  field("Imprest Account";Rec."Imprest Account")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Imprest Account field.';
                  }
                  field("License Type";Rec."License Type")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the License Type field.';
                  }
                  field(MBanking;Rec.MBanking)
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the MBanking field.';
                  }
                  field("Max. Open Documents";Rec."Max. Open Documents")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Max. Open Documents field.';
                  }
                  field("Member No.";Rec."Member No.")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Member No. field.';
                  }
                  field("Payment Journal Batch";Rec."Payment Journal Batch")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Payment Journal Batch field.';
                  }
                  field("Payment Journal Template";Rec."Payment Journal Template")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Payment Journal Template field.';
                  }*/
                field(Payroll; Rec.Payroll)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll field.';
                }
                /*  field("Phone No.";Rec."Phone No.")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the user''s phone number.';
                  }
                  field("Purchase Amount Approval Limit";Rec."Purchase Amount Approval Limit")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                  }
                  field("Purchase Resp. Ctr. Filter";Rec."Purchase Resp. Ctr. Filter")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the code for the responsibility center to which you want to assign the user.';
                  }
                  field("Register Time";Rec."Register Time")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies if you want to register time for this user. This is based on the time spent from when the user logs in to when the user logs out.';
                  }
                  field("Request Amount Approval Limit";Rec."Request Amount Approval Limit")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                  }
                  field("Sales Amount Approval Limit";Rec."Sales Amount Approval Limit")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                  }
                  field("Sales Resp. Ctr. Filter";Rec."Sales Resp. Ctr. Filter")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the code for the responsibility center to which you want to assign the user.';
                  }
                  field("Salespers./Purch. Code";Rec."Salespers./Purch. Code")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the salesperson or purchaser code that relates to the User ID field.';
                  }*/
                //end
                field("Savings Setups"; Rec."Savings Setups")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savings Setups field.';
                }
                /*  field("Service Resp. Ctr. Filter";Rec."Service Resp. Ctr. Filter")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the code for the responsibility center you want to assign to the user. The user will only be able to see service documents for the responsibility center specified in the field. This responsibility center will also be the default responsibility center when the user creates new service documents.';
                  }
                  field("Staff Account";Rec."Staff Account")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Staff Account field.';
                  }
                  field("Staff No";Rec."Staff No")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the Staff No field.';
                  }
                  field(Substitute;Rec.Substitute)
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the User ID of the user who acts as a substitute for the original approver.';
                  }
                  field(SystemCreatedAt;Rec.SystemCreatedAt)
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                  }
                  field(SystemCreatedBy;Rec.SystemCreatedBy)
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                  }
                  field(SystemId;Rec.SystemId)
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the SystemId field.';
                  }
                  field(SystemModifiedAt;Rec.SystemModifiedAt)
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                  }
                  field(SystemModifiedBy;Rec.SystemModifiedBy)
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                  }
                  field("Time Sheet Admin.";Rec."Time Sheet Admin.")
                  {
                      ApplicationArea = All;
                      ToolTip = 'Specifies if the user can edit, change, and delete time sheets.';
                  }*/
                field("Unlimited Purchase Approval"; Rec."Unlimited Purchase Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the user on this line is allowed to approve purchase records with no maximum amount. If you select this check box, then you cannot fill the Purchase Amount Approval Limit field.';
                }
                field("Unlimited Request Approval"; Rec."Unlimited Request Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the user on this line can approve all purchase quotes regardless of their amount. If you select this check box, then you cannot fill the Request Amount Approval Limit field.';
                }
                field("Unlimited Sales Approval"; Rec."Unlimited Sales Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the user on this line is allowed to approve sales records with no maximum amount. If you select this check box, then you cannot fill the Sales Amount Approval Limit field.';
                }
                /* field("Use POS Printer";Rec."Use POS Printer")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Use POS Printer field.';
                 }*/

                field("View Board Accounts"; Rec."View Board Accounts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the View Board Accounts field.';
                }
                field("View Staff Accounts"; Rec."View Staff Accounts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the View Staff Accounts field.';
                }
                field("Finance Setups"; Rec."Finance Setups")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Setups field.';
                }
                field("De-Link ATM"; Rec."De-Link ATM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Setups field.';
                }
                field("Update Debt Collector"; Rec."Update Debt Collector")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Setups field.';
                }
                field("Overpay Loan"; Rec."Overpay Loan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Setups field.';
                }
                field("Generate Penalty"; Rec."Generate Penalty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Setups field.';
                }
            }
            group(FOSA)
            {
                field(Teller; Rec.Teller)
                {
                    ApplicationArea = All;
                }
                field(Treasury; Rec.Treasury)
                {
                    ApplicationArea = All;
                }
                field("Salary processing"; Rec."Salary processing")
                {
                    ApplicationArea = All;
                }
                field("Overdraft Management"; Rec."Overdraft Management")
                {
                    ApplicationArea = All;
                }
                field("STO processing"; Rec."STO processing")
                {
                    ApplicationArea = All;
                }
                field("Fixed Asset"; Rec."Fixed Asset")
                {
                    ApplicationArea = All;
                }
                field("FOSA Interest"; Rec."FOSA Interest")
                {
                    ApplicationArea = All;
                }
                field("Dividend Processing"; Rec."Dividend Processing")
                {
                    ApplicationArea = All;
                }
                field("Cheque management"; Rec."Cheque mangemennt")
                {
                    ApplicationArea = All;
                }
                field("View Purchase Requsition"; Rec."View Purchase Requsition")
                {
                    ApplicationArea = All;
                }
                field("Account Transfer"; Rec."Account Transfer")
                {
                    ApplicationArea = All;
                }
                field("Fixed Deposit"; Rec."Fixed Deposit")
                {
                    ApplicationArea = All;
                }
            }
            group(BOSA)
            {

                field("Post Loan"; Rec."Post Loan")
                {
                    ApplicationArea = All;
                }
                field("Finance Approval"; Rec."Finance Approval")
                {
                    ApplicationArea = All;
                }
                field("Disbursement Approval"; Rec."Disbursement Approval")
                {
                    ApplicationArea = All;
                }
                field("View Banks"; Rec."View Banks")
                {
                    ApplicationArea = All;
                }
                field("Member Statement"; Rec."Member Statement")
                {
                    ApplicationArea = All;
                }
                field("Create Member"; Rec."Create Member")
                {
                    ApplicationArea = All;
                }
                field(Reports; Rec.Reports)
                {
                    ApplicationArea = All;
                }
                field("Member Exit"; Rec."Member Exit")
                {
                    ApplicationArea = All;
                }
                field("BBF Claim"; Rec."BBF Claim")
                {
                }
                field("Create Loan"; Rec."Create Loan")
                {
                    ApplicationArea = All;
                }
                field("Appraise Loan"; Rec."Appraise Loan")
                {
                    ApplicationArea = All;
                }
                field("Loan Changes"; Rec."Loan Changes")
                {
                    ApplicationArea = All;
                }
                field("Member Changes"; Rec."Member Changes")
                {
                    ApplicationArea = All;
                }
                field("Security Subtitution"; Rec."Security Subtitution")
                {
                    ApplicationArea = All;
                }
                field("Collateral Reg"; Rec."Collateral Reg")
                {
                    ApplicationArea = All;
                }
                field(Checkoff; Rec.Checkoff)
                {
                }
                field(Advice; Rec.Advice)
                {
                }
                field("SASRA Report"; Rec."SASRA Report")
                {
                    ApplicationArea = All;
                }
                field("Loan Recovery"; Rec."Loan Recovery")
                {
                    ApplicationArea = All;
                }
                field(CRB; Rec.CRB)
                {
                    ApplicationArea = All;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
                field(Vendor; Rec.Vendor)
                {
                    ApplicationArea = All;
                }
                field(Reconciliation; Rec.Reconciliation)
                {
                    ApplicationArea = All;
                }
                field("View Payment Journal"; Rec."View Payment Journal")
                {
                    ApplicationArea = All;
                }
                field("View Chart of Acount"; Rec."View Chart of Acount")
                {
                    ApplicationArea = All;
                }
                field("Edit Chart of Accounts"; Rec."Edit Chart of Accounts")
                {
                    ApplicationArea = All;
                }
                field("Edit Bank Accounts"; Rec."Edit Bank Accounts")
                {
                    ApplicationArea = All;
                }
                field("Account Schedule"; Rec."Account Schedule")
                {
                    ApplicationArea = All;
                }
                field("View RFQ"; Rec."View RFQ")
                {
                    ApplicationArea = All;
                }
                field("Create Receipt"; Rec."Create Receipt")
                {
                    ApplicationArea = All;
                }
                field("Create Normal PV"; Rec."Create Normal PV")
                {
                    ApplicationArea = All;
                }
                field("Create Staff PV"; Rec."Create Staff PV")
                {
                    ApplicationArea = All;
                }
                field("Create Petty Cash"; Rec."Create Petty Cash")
                {
                    ApplicationArea = All;
                }
                field("Create Bank Transfer"; Rec."Create Bank Transfer")
                {
                    ApplicationArea = All;
                }
                field("Create Imprest"; Rec."Create Imprest")
                {
                    ApplicationArea = All;
                }
                field("Bill Interest"; Rec."Bill Interest")
                {
                    ApplicationArea = All;
                }
                field("View Board P9"; Rec."View Board P9")
                {
                    ApplicationArea = All;
                }
                field("Create Customer Account"; Rec."Create Customer Account")
                {
                    ApplicationArea = All;
                }
                field("Allow overdrawal"; Rec."Allow overdrawal")
                {
                    ApplicationArea = All;
                }
                field("Re-Open Collateral"; Rec."Re-Open Collateral")
                {
                    ApplicationArea = All;
                }
                field("Sacco Categorization"; Rec."Sacco Categorization")
                {
                    ApplicationArea = All;
                }
                field(store; Rec.store)
                {
                    ApplicationArea = All;
                }
                field("FOSA Interest Endyear"; Rec."FOSA Interest Endyear")
                {
                    ApplicationArea = All;
                }
                field("View Special Accounts"; Rec."View Special Accounts")
                {
                    ApplicationArea = All;
                }
                field("View Next of Kin"; Rec."View Next of Kin")
                {
                    ApplicationArea = All;
                }
            }
            group(HR)
            {
                field("View HR"; Rec."View HR")
                {
                    ApplicationArea = All;
                }
                field("View Payroll"; Rec."View Payroll")
                {
                    ApplicationArea = All;
                }
                field("View Employee "; Rec."View Employee ")
                {
                    ApplicationArea = All;
                }
            }
            group(ADMIN)
            {
                field("Receive Notifications"; Rec."Receive Notifications")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this user should receive process notifications for their responsibility center.';
                }
                field("Can Close Cases"; Rec."Can Close Cases")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user can close cases in the system. If you select this check box, then the user can close cases; otherwise, the user cannot close cases.';
                }
                field("System Admin"; Rec."System Admin")
                {
                    ApplicationArea = All;
                }
                field("Administration Setups"; Rec."Administration Setups")
                {
                    ApplicationArea = All;
                }
                field("Update Transaction Charges"; Rec."Update Transaction Charges")
                {
                    ApplicationArea = All;
                }
                field("Capture AGM"; Rec."Capture AGM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Update Transaction Charges field.';
                }
                field("Config. Packages"; Rec."Config. Packages")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Allows the user to open configuration packages.';
                }
                field("View Find Entries"; Rec."View Find Entries")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Allows the user to open Find Entries and view related posted entries.';
                }
                field("User Settings"; Rec."User Settings")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Allows the user to open User Settings.';
                }
                field("Post Mid-Month Salary"; Rec."Post Mid-Month Salary")
                {
                    ApplicationArea = Basic;
                }
                field("Reverse Transactions"; Rec."Reverse Transactions")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Posting)
            {
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                    ApplicationArea = All;
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                    ApplicationArea = All;
                }
                field("Change Allow Posting From"; Rec."Change Allow Posting From")
                {
                    ApplicationArea = All;
                }
                field("Approval Reset Time"; Rec."Approval Reset Time")
                {
                    ApplicationArea = All;
                }
                field("G/L Direct Posting"; Rec."G/L Direct Posting")
                {
                    ApplicationArea = All;
                }
                field("By Pass Direct Posting"; Rec."By Pass Direct Posting")
                {
                    ApplicationArea = All;
                }
                field(Backdate; Rec.Backdate)
                {
                    ApplicationArea = All;
                }
                field("Ledger Entries"; Rec."Edit Ledger Entries")
                {
                    ApplicationArea = All;
                }
                field("Edit GL Entries"; Rec."Edit GL Entries")
                {
                    ApplicationArea = All;
                }
                field("Skip Overdrawal Check"; Rec."Skip Overdrawal Check")
                {
                    ApplicationArea = All;
                }
                field("Reverse Interest"; Rec."Reverse Interest")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Reverse Interest field.';
                }
            }
            group(EDMS)
            {
                field("Upload File"; Rec."Upload File")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Upload File field.';
                }
                field("Overwrite Upload File"; Rec."Overwrite Upload File")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Update Overwrite Upload File field.';
                }
            }
            group("DELETE Controls")
            {
                field("Delete Chart of Accounts"; Rec."Delete Chart of Accounts")
                {
                    ApplicationArea = All;
                }
                field("Delete Customer"; Rec."Delete Customer")
                {
                    ApplicationArea = All;
                }
                field("Delete Vendor"; Rec."Delete Vendor")
                {
                    ApplicationArea = All;
                }
            }

        }

    }


    trigger OnInit()
    begin
        RestrictAccess;
        RequireEditUserSetupPermission;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        RequireEditUserSetupPermission();
        exit(true);
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Administration Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Administration Setups"');
    end;

    local procedure RequireEditUserSetupPermission()
    var
        StatusChangePermissions: Record "Status Change Permissions";
    begin
        StatusChangePermissions.Reset();
        StatusChangePermissions.SetRange("User ID", UserId);
        StatusChangePermissions.SetRange("Edit User SetUp", true);
        if not StatusChangePermissions.FindFirst() then
            Error('You do not have the following permission: "Edit User SetUp"');
    end;

}
