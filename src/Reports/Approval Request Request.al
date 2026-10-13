report 50043 "Approval Request Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Approval Request Report.rdlc';

    dataset
    {
        dataitem("Approval Entry"; "Approval Entry")
        {
            RequestFilterFields = "Sender ID", "Approver ID", Status;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Picture; CI.Picture)
            {
            }
            column(TableID_ApprovalEntry; "Approval Entry"."Table ID")
            {
            }
            column(DocumentType_ApprovalEntry; "Approval Entry"."Document Type")
            {
            }
            column(DocumentNo_ApprovalEntry; "Approval Entry"."Document No.")
            {
            }
            column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
            {
            }
            column(ApprovalCode_ApprovalEntry; "Approval Entry"."Approval Code")
            {
            }
            column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
            {
            }
            column(SalespersPurchCode_ApprovalEntry; "Approval Entry"."Salespers./Purch. Code")
            {
            }
            column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
            {
            }
            column(Status_ApprovalEntry; "Approval Entry".Status)
            {
            }
            column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
            {
            }
            column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
            {
            }
            column(LastModifiedByUserID_ApprovalEntry; "Approval Entry"."Last Modified By User ID")
            {
            }
            column(Comment_ApprovalEntry; "Approval Entry".Comment)
            {
            }
            column(DueDate_ApprovalEntry; "Approval Entry"."Due Date")
            {
            }
            column(Amount_ApprovalEntry; "Approval Entry".Amount)
            {
            }
            column(AmountLCY_ApprovalEntry; "Approval Entry"."Amount (LCY)")
            {
            }
            column(CurrencyCode_ApprovalEntry; "Approval Entry"."Currency Code")
            {
            }
            column(ApprovalType_ApprovalEntry; "Approval Entry"."Approval Type")
            {
            }
            column(LimitType_ApprovalEntry; "Approval Entry"."Limit Type")
            {
            }
            column(AvailableCreditLimitLCY_ApprovalEntry; "Approval Entry"."Available Credit Limit (LCY)")
            {
            }
            column(PendingApprovals_ApprovalEntry; "Approval Entry"."Pending Approvals")
            {
            }
            column(DelegationDateFormula_ApprovalEntry; "Approval Entry"."Delegation Date Formula")
            {
            }
            column(NumberofApprovedRequests_ApprovalEntry; "Approval Entry"."Number of Approved Requests")
            {
            }
            column(NumberofRejectedRequests_ApprovalEntry; "Approval Entry"."Number of Rejected Requests")
            {
            }
            column(EntryNo_ApprovalEntry; "Approval Entry"."Entry No.")
            {
            }
            column(WorkflowStepInstanceID_ApprovalEntry; "Approval Entry"."Workflow Step Instance ID")
            {
            }
            column(RelatedtoChange_ApprovalEntry; "Approval Entry"."Related to Change")
            {
            }

            trigger OnAfterGetRecord()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE(UserSetup."User ID", USERID);
                IF UserSetup.FIND('-') THEN BEGIN
                    IF UserSetup."Approval Administrator" = FALSE THEN
                        ERROR('You have no rights')
                END
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.RESET;
        CI.GET;
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        HR_Leave_ApplicationCaptionLbl: Label 'HR Leave Application';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CI: Record "Company Information";
        UserSetup: Record "User Setup";
        Objemp: Record Members;
}

