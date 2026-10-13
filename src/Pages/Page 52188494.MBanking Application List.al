
Page 50157 "MBanking Application List"
{
    ApplicationArea = Basic;
    CardPageID = "MBanking Applications";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "MBanking Applications";
    SourceTableView = where("App Status" = filter(<> Approved));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentSerialNo; Rec."Document Serial No")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerIDNo; Rec."Customer ID No")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerName; Rec."Customer Name")
                {
                    ApplicationArea = Basic;
                }
                field(MPESAMobileNo; Rec."MPESA Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(MPESACorporateNo; Rec."MPESA Corporate No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field(RejectionReason; Rec."Rejection Reason")
                {
                    ApplicationArea = Basic;
                }
                field(DateApproved; Rec."Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field(TimeApproved; Rec."Time Approved")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedBy; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field(DateRejected; Rec."Date Rejected")
                {
                    ApplicationArea = Basic;
                }
                field(TimeRejected; Rec."Time Rejected")
                {
                    ApplicationArea = Basic;
                }
                field(RejectedBy; Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field(SentToServer; Rec."Sent To Server")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("1stApprovalBy"; Rec."1st Approval By")
                {
                    ApplicationArea = Basic;
                }
                field(Date1stApproval; Rec."Date 1st Approval")
                {
                    ApplicationArea = Basic;
                }
                field(TimeFirstApproval; Rec."Time First Approval")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawalLimitAmount; Rec."Withdrawal Limit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationType; Rec."Application Type")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationNo; Rec."Application No")
                {
                    ApplicationArea = Basic;
                }
                field(Changed; Rec.Changed)
                {
                    ApplicationArea = Basic;
                }
                field(DateChanged; Rec."Date Changed")
                {
                    ApplicationArea = Basic;
                }
                field(TimeChanged; Rec."Time Changed")
                {
                    ApplicationArea = Basic;
                }
                field(ChangedBy; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field(OldTelephoneNo; Rec."Old Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field(Iagreeinformationistrue; Rec."I agree information is true")
                {
                    ApplicationArea = Basic;
                }
                field(AppStatus; Rec."App Status")
                {
                    ApplicationArea = Basic;
                }
                field(VirtualRegistration; Rec."Virtual Registration")
                {
                    ApplicationArea = Basic;
                }
                field(MembershipNo; Rec."Membership No")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Delinked; Rec.Delinked)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

