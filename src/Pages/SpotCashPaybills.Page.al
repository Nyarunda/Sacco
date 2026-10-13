Page 50469 "SpotCash Paybills"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "SPotcash Transactions";
    SourceTableView = where("Transaction Type" = filter(Paybill | "Loan Repayment"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(requestid; Rec.request_id)
                {
                    ApplicationArea = Basic;
                }
                field(ReferenceNo; Rec."Reference No.")
                {
                    ApplicationArea = Basic;
                }
                field(accountnumber; Rec.account_number)
                {
                    ApplicationArea = Basic;
                }
                field(description; Rec.description)
                {
                    ApplicationArea = Basic;
                }
                field(amount; Rec.amount)
                {
                    ApplicationArea = Basic;
                }
                field(craccount; Rec.cr_account)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(NeedsChange; Rec."Needs Change")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(InterestPaid; Rec."Interest Paid")
                {
                    ApplicationArea = Basic;
                }
                field(PrincipalPaid; Rec."Principal Paid")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(phoneno; Rec.phone_no)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(Failed; Rec.Failed)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Update Paybill")
            {
                ApplicationArea = Basic;
                RunObject = Page "Spotcash Update Paybill ID";
                RunPageLink = request_id = field(request_id);
            }

            action("Set/Reset Needs Change")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to mark/unmark this transaction as needs change?') then begin

                        if Rec."Needs Change" then
                            Rec."Needs Change" := false
                        else
                            Rec."Needs Change" := true;
                        Rec.Modify;
                    end;
                end;
            }

            action("Post Transaction")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                    Spot: COdeunit "SpotCash Mbanking";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to post this transaction?') then begin
                        Spot.PostMobileTransaction(Rec.request_id);
                    end;
                end;
            }
        }
    }


}

