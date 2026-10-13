pageextension 50929 "Super Admin Staff Loans Ext" extends "Super Admin Role Center"
{
    layout
    {
        addlast(rolecenter)
        {
            part(StaffLoanActivities; "Staff Loan Activities_")
            {
                ApplicationArea = All;
                Caption = 'Staff Loans';
            }
        }
    }

    actions
    {
        addlast(Action13)
        {
            group(StaffLoans)
            {
                Caption = 'Staff Loans';

                action("Staff Loan Applications")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Staff Loan Applications List';
                    Image = Loaner;
                    RunObject = Page StaffAppraisalApplication;
                }

                action("Staff Appraisal Application List")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Staff Appraisal Application List';
                    Image = List;
                    RunObject = Page "Staff Appraisal List";
                }
                action("Completed Staff Loan Appraisal")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Completed Staff Loan Appraisal';
                    Image = History;
                    RunObject = Page "Completed Salary Appraisal";
                }
                action("Staff Loans Approved")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Staff Appraisal Approved';
                    Image = Approve;
                    RunObject = Page "Staff Loans Approved List";
                }
                action("Staff Loans Pending Approval")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Staff Loans Pending Approval';
                    Image = SendApprovalRequest;
                    RunObject = Page "Staff Loan Pending Approval_";
                }


                action("Staff Loans Rejected")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Staff Loans Rejected';
                    Image = Reject;
                    RunObject = Page "Staff Loan Rejected List_";
                }

                action("Staff Loans Pending Disbursement")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Staff Loans Pending Disbursement';
                    Image = Payment;
                    RunObject = Page "Staff Loan Pending Disbur._";
                    RunPageView = where(Status = const(Approved));
                }

                action("Posted Staff Loans")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Posted Staff Loans';
                    Image = PostedOrder;
                    RunObject = Page "Loan Posted List";
                    RunPageView = where( "Appraisal Type" = filter(Staff));

                }
            }
        }
    }
}
