Page 50518 "Approved Agents List"
{
    CardPageID = "Agent Approved Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Agent Applications";
    SourceTableView = where("Approval Status" = const(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AgentCode; Rec."Agent Code")
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(MobileNo; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalStatus; Rec."Approval Status")
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
                field(WithdrawalLimitCode; Rec."Withdrawal Limit Code")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawalLimitAmount; Rec."Withdrawal Limit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = Basic;
                }
                field(NameoftheProposedAgent; Rec."Name of the Proposed Agent")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofBusiness; Rec."Type of Business")
                {
                    ApplicationArea = Basic;
                }
                field(PlaceofBusiness; Rec."Place of Business")
                {
                    ApplicationArea = Basic;
                }
                field(BusinessWorkExperience; Rec."Business/Work Experience")
                {
                    ApplicationArea = Basic;
                }
                field(NameofBanker; Rec."Name of Banker")
                {
                    ApplicationArea = Basic;
                }
                field(PINKRA; Rec."PIN(KRA)")
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic;
                }
                field(NewApps; Rec.NewApps)
                {
                    ApplicationArea = Basic;
                }
                field(CommAccount; Rec."Comm Account")
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

